--!nonstrict

const HttpService = game:GetService("HttpService")
const Logger = require("../util/Logger")
const Structure = require("../data/Structure")
const Conversion = require("../data/Conversion")
const TypeEncoder = require("./TypeEncoder")
const AbstractElement = require("../data/element/AbstractElement")
const Property = require("../data/property/Property")

type JSONTable = Structure.JSONTable
type UnknownElement = Structure.UnknownElement
type ElementGroup = Structure.ElementGroup
type StructureType = Structure.StructureType
type ElementClassNames = Structure.ElementClassNames
type AbstractElementType = AbstractElement.AbstractElement
type Property = Property.Property

const Encoder = {}

const function apply(element_def: AbstractElementType, inst: Instance, element: UnknownElement): UnknownElement
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

function Encoder.encodeElement(inst: Instance): UnknownElement?
	Logger.withStatus("Encoding").withProcess("CreateElement").withArgs(inst)

	const class = inst:GetAttribute("class")
	const element_def = Conversion.Element[class]

	Logger.withArgs(inst, class, element_def)
	if not element_def then
		return Logger.event("Warn", "Unsupported class")
	end
	
	const element: UnknownElement = {}
	return apply(element_def, inst, element)
end

function Encoder.encodeWebContent(inst: Instance): UnknownElement
	Logger.withStatus("Encoding").withProcess("CreateWebContent").withArgs(inst)

	const element: UnknownElement = {}
	return apply(Conversion.Abstract.WebContent, inst, element)
end

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

function Encoder.encodeJSON(data: Instance | { Instance }): string?
	Logger.withStatus("Encoding").withProcess("JSONTranscode").withArgs(data)

	local encoded: JSONTable

	if typeof(data) == "Instance" then
		encoded = Encoder.encodeWebContent(data)
	elseif typeof(data) == "table" then
		encoded = Encoder.encodeElementGroup(data)
	else
		return Logger.event("Error", "Expected to encode Instance | { Instance }")
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
