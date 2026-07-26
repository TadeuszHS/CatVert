--!strict

const Types = require("../Types")
const Structure = require("../Structure")
const Property = require("./Property")

type CatWebTypes = Types.CatWebTypes
type JSONUnknown = Structure.JSONUnknown
type UnknownElement = Structure.UnknownElement
type PropertyClassNames = Property.PropertyClassNames

--[=[
	Function for encoding a custom relationship of properties from Roblox Instances to CatWeb Elements.

	@param element UnknownElement -- The Element that is in the proccess of being encoded.
	@param inst Instance -- The Instance that the Element is being encoded from.
	@param inst_to_element (Instance) -> UnknownElement -- Converts and creates a new Element from an Instance.
]=]
export type CustomEncodeFunction = (UnknownElement, Instance, (Instance) -> UnknownElement) -> ()
--[=[
	Function for decoding a custom relationship of properties from CatWeb Elements to Roblox Instances.

	@param element UnknownElement -- The Element that is being decoded from.
	@param inst Instance -- The Instance that data is being applied to from the Element.
	@param element_to_inst (UnknownElement) -> Instance -- Converts and creates a new Instance from an Element.
]=]
export type CustomDecodeFunction = (UnknownElement, Instance, (UnknownElement) -> Instance) -> ()
--[=[
	A property with custom-defined encoding and decoding behavior.
]=]
export type CustomTranscodable = {
	read encode: CustomEncodeFunction,
	read decode: CustomDecodeFunction,
}
--[=[
	Representation of complex relationship between a CatWeb Element property and a Roblox Instance.
	This is typically used for CatWeb properties that:
		* Split one Roblox Instance property into multiple CatWeb Element properties.
		* Or, have one CatWeb Element property represent multiple Roblox Instance properties.
]=]
export type Custom = CustomTranscodable & {
	read class: PropertyClassNames,
	read catweb_index: string,
}

const Custom = {}

--[=[
	Constructor for the Custom data type.

	@param catweb_index string
	@param encode CustomEncodeFunction
	@param decode CustomDecodeFunction
	@return Custom
]=]
function Custom.new(catweb_index: string, encode: CustomEncodeFunction, decode: CustomDecodeFunction): Custom
	return table.freeze({
		class = "Custom" :: PropertyClassNames,
		catweb_index = catweb_index,
		encode = encode,
		decode = decode,
	})
end

return table.freeze(Custom)
