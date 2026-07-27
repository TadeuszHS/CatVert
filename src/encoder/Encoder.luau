--!nonstrict

const HttpService = game:GetService("HttpService")
const Logger = require("../util/Logger")
const Structure = require("../data/Structure")
const Conversion = require("../data/Conversion")
const TypeEncoder = require("./TypeEncoder")
const Element = require("../data/element/Element")
const Property = require("../data/property/Property")

type JSONTable = Structure.JSONTable
type UnknownElement = Structure.UnknownElement
type WebContentAbstractElement = Structure.WebContentAbstractElement
type ElementGroup = Structure.ElementGroup
type StructureType = Structure.StructureType
type ElementClassNames = Structure.ElementClassNames
type Element = Element.Element
type Property = Property.Property

--[=[
	@class Encoder
	@private
]=]
const Encoder = {}

--[=[
	Applies Roblox Instance properties to a CatWeb Instance using an Element definition.

	@within Encoder
	@private
	@param element_def Element
	@param inst Instance
	@param element UnknownElement
	@return UnknownElement
]=]
const function apply(element_def: Element, inst: Instance, element: UnknownElement): UnknownElement
	for catweb_index, property in element_def.properties do
		local success

		if property.class == "Property" then
			success = pcall(function()
				element[catweb_index] = TypeEncoder[property.value_type](inst[property.roblox_index])
			end)

			Logger.withStatus("Encoding")
				.withProcess("ApplyProperty")
				.withArgs(element_def, element, inst, catweb_index, property)
		elseif property.class == "Attribute" then
			success = pcall(function()
				element[catweb_index] = TypeEncoder[property.value_type](inst:GetAttribute(property.catweb_index))
			end)

			Logger.withStatus("Encoding")
				.withProcess("ApplyAttribute")
				.withArgs(element_def, element, inst, catweb_index, property)
		elseif property.class == "Custom" then
			success = pcall(function()
				property.encode(element, inst, Encoder.encodeElement)
			end)

			Logger.withStatus("Encoding")
				.withProcess("ApplyCustom")
				.withArgs(element_def, element, inst, catweb_index, property)
		end

		Logger.eventAssert(success, "Warn", "Unable to apply property to Element")
	end

	return element
end

--[=[
	Encodes a Roblox Instance to a CatWeb Element.
	Returns nil if the class is not supported.

	@within Encoder
	@param inst Instance
	@return UnknownElement?
]=]
function Encoder.encodeElement(inst: Instance): UnknownElement?
	Logger.withStatus("Encoding").withProcess("CreateElement").withArgs(inst)

	const class = inst:GetAttribute("class")
	const element_def = Conversion.Element[class]

	Logger.withArgs(inst, class, element_def)
	if not element_def then
		return Logger.event("Warn", "Unsupported class")
	end

	const element = {} :: UnknownElement
	return apply(element_def, inst, element)
end

--[=[
	Encodes a Roblox Instance to CatWeb WebContent.

	@within Encoder
	@param inst Frame
	@return WebContentAbstractElement
]=]
function Encoder.encodeWebContent(inst: Frame): WebContentAbstractElement
	const element = {} :: WebContentAbstractElement
	return apply(Conversion.Abstract.WebContent, inst, element)
end

--[=[
	Encodes an array of Roblox Instances into an ElementGroup.

	@within Encoder
	@param instances { Instance }
	@return ElementGroup
]=]
function Encoder.encodeElementGroup(instances: { Instance }): ElementGroup
	const elements = {}

	for _, inst in instances do
		const element = Encoder.encodeElement(inst)

		if element then
			table.insert(elements, element)
		end
	end

	return elements
end

--[=[
	Encodes a Roblox Instance Frame that represents WebContent or an array of 
	Roblox Instances representing an ElementGroup into CatWeb structured JSON.

	@within Encoder
	@error "Expected to encode Frame as WebContent"
	@error "Expected to encode Frame | { Instance }"
	@error "HttpService failed to encode JSON"
	@param data Frame | { Instance }
	@return string?
]=]
function Encoder.encodeJSON(data: Frame | { Instance }): string?
	Logger.withStatus("Encoding").withProcess("JSONTranscode").withArgs(data)

	local encoded: JSONTable

	if typeof(data) == "Instance" then
		if not data:IsA("Frame") then
			return Logger.event("Error", "Expected to encode Frame as WebContent")
		end
		encoded = Encoder.encodeWebContent(data)
	elseif typeof(data) == "table" then
		encoded = Encoder.encodeElementGroup(data)
	else
		return Logger.event("Error", "Expected to encode Frame | { Instance }")
	end

	const success, result = pcall(function()
		return HttpService:JSONEncode(encoded)
	end)

	Logger.withStatus("Encoding")
		.withProcess("JSONTranscode")
		.withArgs(data)
		.eventAssert(success, "Error", "HttpService failed to encode JSON")

	return result
end

return table.freeze(Encoder)
