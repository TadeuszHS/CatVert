--!strict

const Structure = require("./Structure")
const AbstractElementData = require("./AbstractElementData")

type ElementClassNames = Structure.ElementClassNames
type PropertyList = AbstractElementData.PropertyList
type PropertyMap = AbstractElementData.PropertyMap
type DefaultsMap = AbstractElementData.DefaultsMap
type InstancePropertyMap<I> = AbstractElementData.InstancePropertyMap<I>
type AbstractElementData = AbstractElementData.AbstractElementData

export type ElementData = AbstractElementData & {
    read roblox_class: string,
}

const ElementData = {}

function ElementData.new<I>(
    catweb_class: ElementClassNames,
    roblox_class: index<I, "ClassName">,
    properties: PropertyList,
    default_props: InstancePropertyMap<I>,
    default_attr: DefaultsMap,
    ...: ElementData | AbstractElementData
): ElementData
    const self = {
        class = catweb_class,
        roblox_class = roblox_class,
        properties = {},
        default_props = {},
        default_attr = {},
        abstract = false,
    }

    AbstractElementData.inherit(self, ...)

    const property_map = AbstractElementData.propertyListToMap(properties)
    AbstractElementData.putPropertiesAndDefaults(self, property_map, default_props, default_attr)

    return AbstractElementData.finalize(self) :: ElementData
end

return table.freeze(ElementData)
