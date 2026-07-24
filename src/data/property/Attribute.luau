--!strict

const Types = require("../Types")
const Property = require("./Property")

type CatWebTypes = Types.CatWebTypes
type PropertyClassNames = Property.PropertyClassNames

export type Attribute = {
    read class: PropertyClassNames,
    read catweb_index: string,
    read value_type: CatWebTypes,
}

const Attribute = {}

function Attribute.new(catweb_index: string, value_type: CatWebTypes): Attribute
    return table.freeze({
        class = "Attribute" :: PropertyClassNames,
        catweb_index = catweb_index,
        value_type = value_type,
    })
end

return table.freeze(Attribute)
