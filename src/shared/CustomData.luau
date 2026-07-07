--!strict

const Types = require("./Types")
const Structure = require("./Structure")
const PropertyData = require("./PropertyData")

type CatWebTypes = Types.CatWebTypes
type JSONUnknown = Structure.JSONUnknown
type PropertyClassNames = PropertyData.PropertyClassNames

export type CustomData = {
    read class: PropertyClassNames,
    read catweb_index: string,
}

const CustomData = {}

function CustomData.new(catweb_index: string): CustomData
    return table.freeze({
        class = "Custom" :: PropertyClassNames,
        catweb_index = catweb_index,
    })
end

return table.freeze(CustomData)
