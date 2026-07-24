--!strict

const Structure = require("../Structure")
const AbstractElement = require("./AbstractElement")

type ElementClassNames = Structure.ElementClassNames
type PropertyList = AbstractElement.PropertyList
type PropertyMap = AbstractElement.PropertyMap
type DefaultsMap = AbstractElement.DefaultsMap
type InstancePropertyMap<I> = AbstractElement.InstancePropertyMap<I>
type AbstractElement = AbstractElement.AbstractElement

export type Element = AbstractElement & {
    read roblox_class: string,
}

const Element = {}

function Element.new<I>(
    catweb_class: ElementClassNames,
    roblox_class: index<I, "ClassName">,
    properties: PropertyList,
    default_props: InstancePropertyMap<I>,
    default_attr: DefaultsMap,
    ...: Element | AbstractElement
): Element
    const self = {
        class = catweb_class,
        roblox_class = roblox_class,
        properties = {},
        default_props = {},
        default_attr = {},
        abstract = false,
    }

    AbstractElement.inherit(self, ...)

    const property_map = AbstractElement.propertyListToMap(properties)
    AbstractElement.putPropertiesAndDefaults(self, property_map, default_props, default_attr)

    return AbstractElement.finalize(self) :: Element
end

return table.freeze(Element)
