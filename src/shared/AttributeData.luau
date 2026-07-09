--!strict

const Types = require("./Types")
const PropertyData = require("./PropertyData")

type CatWebTypes = Types.CatWebTypes
type PropertyClassNames = PropertyData.PropertyClassNames

export type AttributeData = {
    read class: PropertyClassNames,
    read catweb_index: string,
    read value_type: CatWebTypes,
}

const AttributeData = {}

function AttributeData.new(catweb_index: string, value_type: CatWebTypes): AttributeData
    return table.freeze({
        class = "Attribute" :: PropertyClassNames,
        catweb_index = catweb_index,
        value_type = value_type,
    })
end

return table.freeze(AttributeData)
