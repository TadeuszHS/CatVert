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
export type DefaultsMap = { [string]: unknown }
export type InstancePropertyMap<I> = { [keyof<I>]: unknown } 

export type AbstractElementData = {
    read class: string,
    read properties: typeof(table.freeze({} :: PropertyMap)),
    read default_props: typeof(table.freeze({} :: DefaultsMap)),
    read default_attr: typeof(table.freeze({} :: DefaultsMap)),
    read abstract: boolean,
}

const AbstractElementData = {}

function AbstractElementData.new<I>(
    class: AbstractElementClassNames,
    properties: PropertyList,
    default_props: InstancePropertyMap<I>,
    default_attr: DefaultsMap,
    ...: AbstractElementData
): AbstractElementData
    const self = {
        class = class,
        properties = {},
        default_props = {},
        default_attr = {},
        abstract = true,
    }

    AbstractElementData.inherit(self, ...)

    const property_map = AbstractElementData.propertyListToMap(properties)
    AbstractElementData.putPropertiesAndDefaults(self, property_map, default_props, default_attr)
    
    return AbstractElementData.finalize(self)
end

function AbstractElementData.propertyListToMap(properties: PropertyList): PropertyMap
    const property_map: PropertyMap = {}

    for _, property in properties do
        property_map[property.catweb_index] = property
    end

    return property_map
end

function AbstractElementData.finalize(self: AbstractElementData): AbstractElementData
    table.freeze(self.properties)
    table.freeze(self.default_props)
    table.freeze(self.default_attr)
    return table.freeze(self)
end

function AbstractElementData.putPropertiesAndDefaults<I>(
    to: AbstractElementData,
    properties: PropertyMap,
    default_props: DefaultsMap | InstancePropertyMap<I>,
    default_attr: DefaultsMap
): AbstractElementData
    for catweb_index, property in properties do
        to.properties[catweb_index] = property
    end
    for inst_index, value in default_props do
        to.default_props[inst_index] = value
    end
    for catweb_index, value in default_attr do
        to.default_attr[catweb_index] = value
    end

    return to
end

function AbstractElementData.inherit(to: AbstractElementData, ...: AbstractElementData): AbstractElementData
    for _, parent in { ... } do
        AbstractElementData.putPropertiesAndDefaults(to, parent.properties, parent.default_props, parent.default_attr)
    end

    return to
end

return table.freeze(AbstractElementData)
