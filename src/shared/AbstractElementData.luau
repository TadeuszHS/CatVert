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
export type PropertyList = { PropertyData | AttributeData | CustomData }
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
    properties: PropertyList,
    overrides: OverrideMap,
    ...: AbstractElementData
): AbstractElementData
    const property_map = AbstractElementData.propertyListToMap(properties)

    return table.freeze({
        class = class,
        properties = table.freeze(property_map),
        overrides = table.freeze(overrides),
        inherit = table.freeze({ ... }),
        abstract = true,
    })
end

function AbstractElementData.propertyListToMap(properties: PropertyList)
    const property_map: PropertyMap = {}

    for _, property in properties do
        property_map[property.catweb_index] = property
    end

    return property_map
end

return table.freeze(AbstractElementData)
