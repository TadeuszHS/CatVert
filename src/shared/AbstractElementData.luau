--!strict

const Structure = require("./Structure")
const PropertyData = require("./PropertyData")
const AttributeData = require("./AttributeData")
const CustomData = require("./CustomData")

type AbstractElementClassNames = Structure.AbstractElementClassNames
type PropertyData = PropertyData.PropertyData
type AttributeData = AttributeData.AttributeData
type CustomData = CustomData.CustomData

export type PropertyMap = { [string]: PropertyData | AttributeData | CustomData }
export type OverrideMap = { [string]: unknown }

export type AbstractElementData = {
    read class: AbstractElementClassNames,
    read properties: typeof(table.freeze({} :: PropertyMap)),
    read overrides: typeof(table.freeze({} :: OverrideMap)),
    read inherit: typeof(table.freeze({} :: { AbstractElementData })),
    read abstract: boolean,
}

const AbstractElementData = {}

function AbstractElementData.new(
    class: AbstractElementClassNames,
    properties: PropertyMap,
    overrides: OverrideMap,
    ...: AbstractElementData
): AbstractElementData
    return table.freeze({
        class = class,
        properties = table.freeze(properties),
        overrides = table.freeze(overrides),
        inherit = table.freeze({ ... }),
        abstract = true,
    })
end

return table.freeze(AbstractElementData)
