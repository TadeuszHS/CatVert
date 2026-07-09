--!strict

const Types = require("./Types")
const Structure = require("./Structure")
const PropertyData = require("./PropertyData")

type CatWebTypes = Types.CatWebTypes
type JSONUnknown = Structure.JSONUnknown
type UnknownElement = Structure.UnknownElement
type PropertyClassNames = PropertyData.PropertyClassNames

export type CustomEncodeFunction = (UnknownElement, Instance, (Instance) -> UnknownElement) -> ()
export type CustomDecodeFunction = (UnknownElement, Instance, (UnknownElement) -> Instance) -> ()
export type CustomDataTranscodable = {
    read encode: CustomEncodeFunction,
    read decode: CustomDecodeFunction,
}
export type CustomData = CustomDataTranscodable & {
    read class: PropertyClassNames,
    read catweb_index: string,
}

const CustomData = {}

function CustomData.new(catweb_index: string, encode: CustomEncodeFunction, decode: CustomDecodeFunction): CustomData
    return table.freeze({
        class = "Custom" :: PropertyClassNames,
        catweb_index = catweb_index,
        encode = encode,
        decode = decode,
    })
end

return table.freeze(CustomData)
