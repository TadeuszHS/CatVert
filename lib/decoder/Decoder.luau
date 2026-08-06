--!nonstrict

const HttpService = game:GetService("HttpService")
const Logger = require("../util/Logger")
const Structure = require("../data/Structure")
const Conversion = require("../data/Conversion")
const TypeDecoder = require("./TypeDecoder")
const Defaults = require("../data/Defaults")
const Element = require("../data/element/Element")
const Property = require("../data/property/Property")

type JSONUnknown = Structure.JSONUnknown
type JSONTable = Structure.JSONTable
type UnknownElement = Structure.UnknownElement
type WebContentAbstractElement = Structure.WebContentAbstractElement
type ElementGroup = Structure.ElementGroup
type StructureType = Structure.StructureType
type ElementClassNames = Structure.ElementClassNames
type Element = Element.Element
type Property = Property.Property

--[=[
	@class Decoder
	@private
]=]
const Decoder = {}

--[=[
	Determines the structure type of a JSONTable, 

	@within Decoder
	@private
	@error "Unable to determine StructureType"
	@param decoded JSONTable
	@return StructureType?
]=]
const function DetermineStructureType(decoded: JSONTable): StructureType?
	Logger.WithStatus("Decoding").WithProcess("DetermineStructureType").WithArgs(decoded)

	if typeof(decoded.webcontent) == "table" then
		return "WebContent"
	elseif typeof(decoded[1]) == "table" then
		return "ElementGroup"
	end

	return Logger.Event("Error", "Unable to determine StructureType")
end

--[=[
	Applies CatWeb Element properties to a Roblox Instance using an Element definition.

	@within Decoder
	@private
	@param element_def Element
	@param element UnknownElement
	@param inst Instance
	@return Instance
]=]
const function Apply(element_def: Element, element: UnknownElement, inst: Instance): Instance
	for catweb_index, property in element_def.properties do
		if element[catweb_index] == nil then
			Logger.WithStatus("Decoding")
				.WithProcess("Apply")
				.WithArgs(element_def, element, inst, catweb_index, property)
				.Event("Info", "Skipping due to property being nil in Element")
			continue
		end

		local success

		if property.class == "Property" then
			success = pcall(function()
				const decoded = TypeDecoder[property.value_type](element[catweb_index])
				if decoded ~= nil then
					inst[property.roblox_index] = decoded
				end
			end)

			Logger.WithStatus("Decoding")
				.WithProcess("ApplyProperty")
				.WithArgs(element_def, element, inst, catweb_index, property)
		elseif property.class == "Attribute" then
			success = pcall(function()
				inst:SetAttribute(property.catweb_index, TypeDecoder[property.value_type](element[catweb_index]))
			end)

			Logger.WithStatus("Decoding")
				.WithProcess("ApplyAttribute")
				.WithArgs(element_def, element, inst, catweb_index, property)
		elseif property.class == "Custom" then
			success = pcall(function()
				property.decode(element, inst, Decoder.Element)
			end)

			Logger.WithStatus("Decoding")
				.WithProcess("ApplyCustom")
				.WithArgs(element_def, element, inst, catweb_index, property)
		end

		Logger.EventAssert(success, "Warn", "Unable to apply property to Instance")
	end

	return inst
end

--[=[
	Decodes a CatWeb Element to a Roblox Instance.
	Returns nil if an Element is unsupported.

	@within Decoder
	@param element UnknownElement
	@return Instance?
]=]
function Decoder.Element(element: UnknownElement): Instance?
	const class = TypeDecoder.string(element.class) :: ElementClassNames
	const element_def = Conversion.Element[class]

	Logger.WithStatus("Decoding").WithProcess("CreateInstance").WithArgs(element, class, element_def)
	if not element_def then
		return Logger.Event("Warn", "Unsupported class")
	end

	const inst = Defaults.New(class)
	return Apply(element_def, element, inst)
end

--[=[
	Decodes CatWeb WebContent to a Frame.

	@within Decoder
	@param element WebContentAbstractElement
	@return Frame
]=]
function Decoder.WebContent(element: WebContentAbstractElement): Frame
	const inst = Defaults.New("WebContent")
	return Apply(Conversion.Abstract.WebContent, element, inst) :: Frame
end

--[=[
	Decodes an ElementGroup to an array of Roblox Instances.

	@within Decoder
	@param elements ElementGroup
	@return { Instance }
]=]
function Decoder.ElementGroup(elements: ElementGroup): { Instance }
	const instances = {}

	for i, element in elements do
		const inst = Decoder.Element(element)

		if inst then
			table.insert(instances, inst)
		end
	end

	return instances
end

--[=[
	Decodes a string containing CatWeb structured JSON into a Frame (WebContent) or array of Instances (Element Group).

	@within Decoder
	@error "HttpService failed to decode JSON, this is likely due to a syntax error"
	@error "Expected to decode table"
	@error "Unable to determine StructureType"
	@param json string
	@return Frame | { Instance }
]=]
function Decoder.JSONDecode(json: string): Frame | { Instance }
	Logger.WithStatus("Decoding").WithProcess("JSONTranscode").WithArgs(json)

	const success, decoded = pcall(function()
		return HttpService:JSONDecode(json) :: JSONUnknown
	end)

	Logger.EventAssert(success, "Error", "HttpService failed to decode JSON, this is likely due to a syntax error")
	Logger.EventAssert(typeof(decoded) == "table", "Error", "Expected to decode table")

	const structure_type = DetermineStructureType(decoded)

	if structure_type == "WebContent" then
		return Decoder.WebContent(decoded)
	end

	return Decoder.ElementGroup(decoded)
end

return table.freeze(Decoder)
