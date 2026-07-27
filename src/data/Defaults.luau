--!strict

const Logger = require("../util/Logger")
const Conversion = require("../data/Conversion")
const Structure = require("../data/Structure")

type ElementClassNames = Structure.ElementClassNames

export type DefaultClassNames = ElementClassNames | "WebContent"

--[=[
	@class Defaults
	@private
]=]
const Defaults = {}

--[=[
	Builds a default Roblox Instance to clone from.

	@within Defaults
	@private
	@param roblox_class string
	@param default_props { [string]: unknown }
	@param default_attr { [string]: unknown }
	@return Instance
]=]
const function build(
	roblox_class: string,
	default_props: { [string]: unknown },
	default_attr: { [string]: unknown }
): Instance
	Logger.withStatus("Initializing").withProcess("BuildDefaults").withArgs(roblox_class, default_props, default_attr)

	const inst = Instance.new(roblox_class)

	for roblox_index, value in default_props do
		(inst :: any)[roblox_index] = value
	end

	for catweb_index, value in default_attr do
		inst:SetAttribute(catweb_index, value)
	end

	return inst
end

--[=[
	Map of Roblox Instances to clone from.

	@within Defaults
	@private
	@readonly
	@prop defaults { [DefaultClassNames]: Instance }
]=]
const defaults: { [DefaultClassNames]: Instance } = {
	WebContent = build(
		"Frame",
		Conversion.Abstract.WebContent.default_props,
		Conversion.Abstract.WebContent.default_attr
	),
}

for class, element in Conversion.Element :: { [ElementClassNames]: any } do
	defaults[class] = build(element.roblox_class, element.default_props, element.default_attr)
end

table.freeze(defaults)

--[=[
	Returns a Roblox Instance clone of the given class name with specified default properties and attributes.

	@within Defaults
	@param class DefaultClassNames
	@return Instance
]=]
function Defaults.new(class: DefaultClassNames): Instance
	const default_instance = defaults[class]

	return default_instance:Clone()
end

return table.freeze(Defaults)
