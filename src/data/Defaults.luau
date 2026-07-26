--!strict

const Conversion = require("../data/Conversion")
const Structure = require("../data/Structure")

type ElementClassNames = Structure.ElementClassNames

export type DefaultClassNames = ElementClassNames | "WebContent"

const function build(roblox_class: string, default_props: { [string]: unknown }, default_attr: { [string]: unknown }): Instance
    const inst = Instance.new(roblox_class)

    for roblox_index, value in default_props do
        (inst :: any)[roblox_index] = value
    end

    for catweb_index, value in default_attr do
        inst:SetAttribute(catweb_index, value)
    end

    return inst
end

const defaults: { [DefaultClassNames]: Instance } = {
    WebContent = build("Frame", Conversion.Abstract.WebContent.default_props, Conversion.Abstract.WebContent.default_attr),
}

for class, element in Conversion.Element :: { [ElementClassNames]: any } do
    defaults[class] = build(element.roblox_class, element.default_props, element.default_attr)
end

table.freeze(defaults)

const Defaults = {}

function Defaults.new(class: DefaultClassNames): Instance
    const default_instance = defaults[class]
    assert(default_instance, `CatVert: no default Instance exists for class "{class}"`)

    return default_instance:Clone()
end

return table.freeze(Defaults)
