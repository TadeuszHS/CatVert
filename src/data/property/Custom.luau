--!strict

const Types = require("../Types")
const Structure = require("../Structure")
const Property = require("./Property")

type CatWebTypes = Types.CatWebTypes
type JSONUnknown = Structure.JSONUnknown
type UnknownElement = Structure.UnknownElement
type PropertyClassNames = Property.PropertyClassNames

export type CustomEncodeFunction = (UnknownElement, Instance, (Instance) -> UnknownElement) -> ()
export type CustomDecodeFunction = (UnknownElement, Instance, (UnknownElement) -> Instance) -> ()
export type CustomTranscodable = {
    read encode: CustomEncodeFunction,
    read decode: CustomDecodeFunction,
}
export type Custom = CustomTranscodable & {
    read class: PropertyClassNames,
    read catweb_index: string,
}

const Custom = {}

function Custom.new(catweb_index: string, encode: CustomEncodeFunction, decode: CustomDecodeFunction): Custom
    return table.freeze({
        class = "Custom" :: PropertyClassNames,
        catweb_index = catweb_index,
        encode = encode,
        decode = decode,
    })
end

return table.freeze(Custom)
