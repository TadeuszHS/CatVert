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
const function determineStructureType(decoded: JSONTable): StructureType?
	Logger.withStatus("Decoding").withProcess("DetermineStructureType").withArgs(decoded)

	if typeof(decoded.webcontent) == "table" then
		return "WebContent"
	elseif typeof(decoded[1]) == "table" then
		return "ElementGroup"
	end

	return Logger.event("Error", "Unable to determine StructureType")
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
const function apply(element_def: Element, element: UnknownElement, inst: Instance): Instance
	for catweb_index, property in element_def.properties do
		if element[catweb_index] == nil then
			Logger.withStatus("Decoding")
				.withProcess("Apply")
				.withArgs(element_def, element, inst, catweb_index, property)
				.event("Info", "Skipping due to property being nil in Element")
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

			Logger.withStatus("Decoding")
				.withProcess("ApplyProperty")
				.withArgs(element_def, element, inst, catweb_index, property)
		elseif property.class == "Attribute" then
			success = pcall(function()
				inst:SetAttribute(property.catweb_index, TypeDecoder[property.value_type](element[catweb_index]))
			end)

			Logger.withStatus("Decoding")
				.withProcess("ApplyAttribute")
				.withArgs(element_def, element, inst, catweb_index, property)
		elseif property.class == "Custom" then
			success = pcall(function()
				property.decode(element, inst, Decoder.decodeElement)
			end)

			Logger.withStatus("Decoding")
				.withProcess("ApplyCustom")
				.withArgs(element_def, element, inst, catweb_index, property)
		end

		Logger.eventAssert(success, "Warn", "Unable to apply property to Instance")
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
function Decoder.decodeElement(element: UnknownElement): Instance?
	const class = TypeDecoder.string(element.class) :: ElementClassNames
	const element_def = Conversion.Element[class]

	Logger.withStatus("Decoding").withProcess("CreateInstance").withArgs(element, class, element_def)
	if not element_def then
		return Logger.event("Warn", "Unsupported class")
	end

	const inst = Defaults.new(class)
	return apply(element_def, element, inst)
end

--[=[
	Decodes CatWeb WebContent to a Frame.

	@within Decoder
	@param element WebContentAbstractElement
	@return Frame
]=]
function Decoder.decodeWebContent(element: WebContentAbstractElement): Frame
	const inst = Defaults.new("WebContent")
	return apply(Conversion.Abstract.WebContent, element, inst) :: Frame
end

--[=[
	Decodes an ElementGroup to an array of Roblox Instances.

	@within Decoder
	@param elements ElementGroup
	@return { Instance }
]=]
function Decoder.decodeElementGroup(elements: ElementGroup): { Instance }
	const instances = {}

	for i, element in elements do
		const inst = Decoder.decodeElement(element)

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
function Decoder.decodeJSON(json: string): Frame | { Instance }
	Logger.withStatus("Decoding").withProcess("JSONTranscode").withArgs(json)

	const success, decoded = pcall(function()
		return HttpService:JSONDecode(json) :: JSONUnknown
	end)

	Logger.eventAssert(success, "Error", "HttpService failed to decode JSON, this is likely due to a syntax error")
	Logger.eventAssert(typeof(decoded) == "table", "Error", "Expected to decode table")

	const structure_type = determineStructureType(decoded)

	if structure_type == "WebContent" then
		return Decoder.decodeWebContent(decoded)
	end

	return Decoder.decodeElementGroup(decoded)
end

return table.freeze(Decoder)
