--!strict

const Types = require("../Types")

type CatWebTypes = Types.CatWebTypes

export type PropertyClassNames = "Property" | "Attribute" | "Custom"

--[=[
	Representation of a direct relationship between a CatWeb Element property and a Roblox Instance property.

	@interface Property
]=]
export type Property = {
	read class: PropertyClassNames,
	read catweb_index: string,
	read roblox_index: string,
	read value_type: CatWebTypes,
}

--[=[
	@class Property
	@private
]=]
const Property = {}

--[=[
	Constructor for the Property data type.

	@within Property
	@param catweb_index string,
	@param roblox_index string,
	@param value_type CatWebTypes
	@return Property
]=]
function Property.New(catweb_index: string, roblox_index: string, value_type: CatWebTypes): Property
	return table.freeze({
		class = "Property" :: PropertyClassNames,
		catweb_index = catweb_index,
		roblox_index = roblox_index,
		value_type = value_type,
	})
end

return table.freeze(Property)
