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
    read Convert: (JSONUnknown, Instance) -> (),
}

const CustomData = {}

function CustomData.new(catweb_index: string, convert: (JSONUnknown, Instance) -> ()): CustomData
    return table.freeze({
        class = "Custom" :: PropertyClassNames,
        catweb_index = catweb_index,
        Convert = convert,
    })
end

return table.freeze(CustomData)
