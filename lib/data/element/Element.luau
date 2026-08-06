--!strict

const Structure = require("../Structure")
const AbstractElement = require("./AbstractElement")

type ElementClassNames = Structure.ElementClassNames
type PropertyList = AbstractElement.PropertyList
type PropertyMap = AbstractElement.PropertyMap
type DefaultsMap = AbstractElement.DefaultsMap
type InstancePropertyMap<I> = AbstractElement.InstancePropertyMap<I>
type AbstractElement = AbstractElement.AbstractElement

--[=[
	Element is a data type that represents all of the mapping of behavior 
	between a CatWeb Element and a Roblox Instance.

	@interface Element
]=]
export type Element = AbstractElement & {
	read roblox_class: string,
}

--[=[
	@class Element
	@private
]=]
const Element = {}

--[=[
	Constructor for AbstractElement data type.
	Inheritance executes from left to right, meaning the right hand side will override the left hand side.

	@within Element
	@param catweb_class ElementClassNames
	@param roblox_class index<I, "ClassName">
	@param properties PropertyList
	@param default_props InstancePropertyMap<I>
	@param default_attr DefaultsMap
	@param ...: Element | AbstractElement -- (Abstract) Element(s) to inherit from.
]=]
function Element.New<I>(
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

	AbstractElement.Inherit(self, ...)

	const property_map = AbstractElement.PropertyListToMap(properties)
	AbstractElement.PutPropertiesAndDefaults(self, property_map, default_props, default_attr)

	return AbstractElement.Finalize(self) :: Element
end

return table.freeze(Element)
