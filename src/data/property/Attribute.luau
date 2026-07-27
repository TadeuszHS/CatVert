--!strict

const Types = require("../Types")
const Property = require("./Property")

type CatWebTypes = Types.CatWebTypes
type PropertyClassNames = Property.PropertyClassNames

--[=[
    Representation of a property that is exclusive to CatWeb and has no relation to Roblox Instance properties.
]=]
export type Attribute = {
	read class: PropertyClassNames,
	read catweb_index: string,
	read value_type: CatWebTypes,
}

--[=[
	@class Attribute
]=]
const Attribute = {}

--[=[
    Constructor for the Attribute data type.

	@within Attribute
    @param catweb_index string
    @param value_type CatWebTypes
    @return Attribute
]=]
function Attribute.new(catweb_index: string, value_type: CatWebTypes): Attribute
	return table.freeze({
		class = "Attribute" :: PropertyClassNames,
		catweb_index = catweb_index,
		value_type = value_type,
	})
end

return table.freeze(Attribute)
