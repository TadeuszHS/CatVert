--!strict

const Types = require("./Types")
const PropertyData = require("./PropertyData")

type CatWebTypes = Types.CatWebTypes
type PropertyClassNames = PropertyData.PropertyClassNames

export type AttributeData = {
    read class: PropertyClassNames,
    read catweb_index: string,
    read value_type: CatWebTypes,
    read default: unknown,
}

const AttributeData = {}

function AttributeData.new(catweb_index: string, value_type: CatWebTypes, default: unknown): AttributeData
    return table.freeze({
        class = "Attribute" :: PropertyClassNames,
        catweb_index = catweb_index,
        value_type = value_type,
        default = default
    })
end

return table.freeze(AttributeData)
