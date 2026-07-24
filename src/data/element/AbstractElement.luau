--!strict

const Structure = require("../Structure")
const Property = require("../property/Property")
const Attribute = require("../property/Attribute")
const Custom = require("../property/Custom")

type AbstractElementClassNames = Structure.AbstractElementClassNames
type Property = Property.Property
type Attribute = Attribute.Attribute
type Custom = Custom.Custom

export type PropertyMap = { [string]: Property | Attribute | Custom }
export type PropertyList = { Property | Attribute | Custom }
export type DefaultsMap = { [string]: unknown }
export type InstancePropertyMap<I> = { [keyof<I>]: unknown } 

export type AbstractElement = {
    read class: string,
    read properties: typeof(table.freeze({} :: PropertyMap)),
    read default_props: typeof(table.freeze({} :: DefaultsMap)),
    read default_attr: typeof(table.freeze({} :: DefaultsMap)),
    read abstract: boolean,
}

const AbstractElement = {}

function AbstractElement.new<I>(
    class: AbstractElementClassNames,
    properties: PropertyList,
    default_props: InstancePropertyMap<I>,
    default_attr: DefaultsMap,
    ...: AbstractElement
): AbstractElement
    const self = {
        class = class,
        properties = {},
        default_props = {},
        default_attr = {},
        abstract = true,
    }

    AbstractElement.inherit(self, ...)

    const property_map = AbstractElement.propertyListToMap(properties)
    AbstractElement.putPropertiesAndDefaults(self, property_map, default_props, default_attr)
    
    return AbstractElement.finalize(self)
end

function AbstractElement.propertyListToMap(properties: PropertyList): PropertyMap
    const property_map: PropertyMap = {}

    for _, property in properties do
        property_map[property.catweb_index] = property
    end

    return property_map
end

function AbstractElement.finalize(self: AbstractElement): AbstractElement
    table.freeze(self.properties)
    table.freeze(self.default_props)
    table.freeze(self.default_attr)
    return table.freeze(self)
end

function AbstractElement.putPropertiesAndDefaults<I>(
    to: AbstractElement,
    properties: PropertyMap,
    default_props: DefaultsMap | InstancePropertyMap<I>,
    default_attr: DefaultsMap
): AbstractElement
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

function AbstractElement.inherit(to: AbstractElement, ...: AbstractElement): AbstractElement
    for _, parent in { ... } do
        AbstractElement.putPropertiesAndDefaults(to, parent.properties, parent.default_props, parent.default_attr)
    end

    return to
end

return table.freeze(AbstractElement)
