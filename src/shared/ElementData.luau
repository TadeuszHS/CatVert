--!strict

const Structure = require("./Structure")
const AbstractElementData = require("./AbstractElementData")

type ElementClassNames = Structure.ElementClassNames
type PropertyList = AbstractElementData.PropertyList
type PropertyMap = AbstractElementData.PropertyMap
type OverrideMap = AbstractElementData.OverrideMap
type AbstractElementData = AbstractElementData.AbstractElementData

export type ElementData = {
    read class: ElementClassNames,
    read roblox_class: string,
    read properties: typeof(table.freeze({} :: PropertyMap)),
    read overrides: typeof(table.freeze({} :: OverrideMap)),
    read inherit: typeof(table.freeze({} :: { ElementData | AbstractElementData })),
    read abstract: boolean,
}

const ElementData = {}

function ElementData.new(
    element_class: ElementClassNames,
    roblox_class: string,
    properties: PropertyList,
    overrides: OverrideMap,
    ...: ElementData | AbstractElementData
): ElementData
    const property_map = AbstractElementData.propertyListToMap(properties)

    return table.freeze({
        class = element_class,
        roblox_class = roblox_class,
        properties = table.freeze(property_map),
        overrides = table.freeze(overrides),
        inherit = table.freeze({...}),
        abstract = false,
    })
end

return table.freeze(ElementData)
