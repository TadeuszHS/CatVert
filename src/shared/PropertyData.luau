--!strict

const Types = require("./Types")

type CatWebTypes = Types.CatWebTypes

export type PropertyClassNames = "Property" | "Attribute" | "Custom"

export type PropertyData = {
    read class: PropertyClassNames,
    read catweb_index: string,
    read roblox_index: string,
    read value_type: CatWebTypes,
}

const PropertyData = {}

function PropertyData.new(catweb_index: string, roblox_index: string, value_type: CatWebTypes): PropertyData
    return table.freeze({
        class = "Property" :: PropertyClassNames,
        catweb_index = catweb_index,
        roblox_index = roblox_index,
        value_type = value_type,
    })
end

return table.freeze(PropertyData)
