--!strict

const Structure = require("./Structure")
const AbstractElementData = require("./AbstractElementData")

type ElementClassNames = Structure.ElementClassNames
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
    properties: PropertyMap,
    overrides: OverrideMap,
    ...: ElementData | AbstractElementData
): ElementData
    return table.freeze({
        class = element_class,
        roblox_class = roblox_class,
        properties = table.freeze(properties),
        overrides = table.freeze(overrides),
        inherit = table.freeze({...}),
        abstract = false,
    })
end

return table.freeze(ElementData)
