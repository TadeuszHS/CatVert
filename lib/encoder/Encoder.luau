--!strict

const HttpService = game:GetService("HttpService")
const Types = require("../data/Types")
const Logger = require("../util/Logger")
const Structure = require("../data/Structure")
const Conversion = require("../data/Conversion")
const TypeEncoder = require("./TypeEncoder") :: Lookup<CatWebTypes, (unknown) -> JSONUnknown>
const Element = require("../data/element/Element")
const Property = require("../data/property/Property")
const Attribute = require("../data/property/Attribute")
const Custom = require("../data/property/Custom")

type Lookup<K, V> = Types.Lookup<K, V>
type CatWebTypes = Types.CatWebTypes
type JSONUnknown = Structure.JSONUnknown
type JSONTable = Structure.JSONTable
type UnknownElement = Structure.UnknownElement
type WebContentAbstractElement = Structure.WebContentAbstractElement
type ElementGroup = Structure.ElementGroup
type StructureType = Structure.StructureType
type ElementClassNames = Structure.ElementClassNames
type Element = Element.Element
type Property = Property.Property
type Attribute = Attribute.Attribute
type Custom = Custom.Custom

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
	@param element UnknownElement
	@param inst Instance
	@return UnknownElement
]=]
const function Apply(element_def: Element, element: UnknownElement, inst: Instance): UnknownElement
	for catweb_index, property in element_def.properties do
		local success

		if property.class == "Property" then
			success = pcall(function()
				element[catweb_index] = TypeEncoder[(property :: Property).value_type]((inst :: any)[(property :: Property).roblox_index])
			end)

			Logger.WithStatus("Encoding")
				.WithProcess("ApplyProperty")
				.WithArgs(element_def, element, inst, catweb_index, property)
		elseif property.class == "Attribute" then
			success = pcall(function()
				element[catweb_index] = TypeEncoder[(property :: Attribute).value_type](inst:GetAttribute(property.catweb_index))
			end)

			Logger.WithStatus("Encoding")
				.WithProcess("ApplyAttribute")
				.WithArgs(element_def, element, inst, catweb_index, property)
		elseif property.class == "Custom" then
			success = pcall(function()
				(property :: Custom).encode(element, inst, Encoder.Element)
			end)

			Logger.WithStatus("Encoding")
				.WithProcess("ApplyCustom")
				.WithArgs(element_def, element, inst, catweb_index, property)
		end

		Logger.EventAssert(success, "Warn", "Unable to apply property to Element")
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
function Encoder.Element(inst: Instance): UnknownElement?
	Logger.WithStatus("Encoding").WithProcess("CreateElement").WithArgs(inst)

	const class = inst:GetAttribute("class") :: ElementClassNames
	const element_def = (Conversion.Element :: Lookup<ElementClassNames, Element>)[class]

	Logger.WithArgs(inst, class, element_def)
	if not element_def then
		return Logger.Event("Warn", "Unsupported class")
	end

	const element = {}
	return Apply(element_def, element, inst)
end

--[=[
	Encodes a Roblox Instance to CatWeb WebContent.

	@within Encoder
	@param inst Frame
	@return WebContentAbstractElement
]=]
function Encoder.WebContent(inst: Frame): WebContentAbstractElement
	const element = {}
	--WebContent is not actually an Element, only true for the purposes of this function.
	return Apply(Conversion.Abstract.WebContent :: Element, element, inst)
end

--[=[
	Encodes an array of Roblox Instances into an ElementGroup.

	@within Encoder
	@param instances { Instance }
	@return ElementGroup
]=]
function Encoder.ElementGroup(instances: { Instance }): ElementGroup
	const elements = {}

	for _, inst in instances do
		const element = Encoder.Element(inst)

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
function Encoder.JSONEncode(data: Frame | { Instance }): string?
	Logger.WithStatus("Encoding").WithProcess("JSONTranscode").WithArgs(data)

	local encoded: WebContentAbstractElement | ElementGroup

	if typeof(data) == "Instance" then
		if not data:IsA("Frame") then
			return Logger.Event("Error", "Expected to encode Frame as WebContent")
		end
		encoded = Encoder.WebContent(data)
	elseif typeof(data) == "table" then
		encoded = Encoder.ElementGroup(data)
	else
		return Logger.Event("Error", "Expected to encode Frame | { Instance }")
	end

	const success, result = pcall(function()
		return HttpService:JSONEncode(encoded)
	end)

	Logger.WithStatus("Encoding")
		.WithProcess("JSONTranscode")
		.WithArgs(data)
		.EventAssert(success, "Error", "HttpService failed to encode JSON")

	return result
end

return table.freeze(Encoder)
