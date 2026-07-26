--!nonstrict

const HttpService = game:GetService("HttpService")
const Structure = require("../data/Structure")
const Conversion = require("../data/Conversion")
const TypeDecoder = require("./TypeDecoder")
const Defaults = require("../data/Defaults")
const AbstractElement = require("../data/element/AbstractElement")
const Property = require("../data/property/Property")

type JSONTable = Structure.JSONTable
type UnknownElement = Structure.UnknownElement
type ElementGroup = Structure.ElementGroup
type StructureType = Structure.StructureType
type ElementClassNames = Structure.ElementClassNames
type AbstractElementType = AbstractElement.AbstractElement
type Property = Property.Property

const function getStructureType(decoded: JSONTable): StructureType
    if decoded.webcontent ~= nil then
        return "WebContent"
    end

    return "ElementGroup"
end

const Decoder = {}

const function applyElement(element_def: AbstractElementType, element: UnknownElement, inst: Instance): Instance
    for catweb_index, property in element_def.properties do
        if element[catweb_index] == nil then
            continue
        end

        if property.class == "Property" then
            (inst :: any)[property.roblox_index] = TypeDecoder[property.value_type](element[catweb_index])
        elseif property.class == "Attribute" then
            inst:SetAttribute(property.catweb_index, TypeDecoder[property.value_type](element[catweb_index]))
        elseif property.class == "Custom" then
            property.decode(element, inst, Decoder.decodeElement)
        end
    end

    return inst
end

function Decoder.decodeElement(element: UnknownElement): Instance
    const class = TypeDecoder.string(element.class) :: ElementClassNames
    const element_def = Conversion.Element[class]
    if not element_def then
        warn(`unsupported class {class}`)
    end

    const inst = Defaults.new(class)
    return applyElement(element_def, element, inst)
end

function Decoder.decodeWebContent(element: UnknownElement): Instance
    const inst = Defaults.new("WebContent")
    return applyElement(Conversion.Abstract.WebContent, element, inst)
end

function Decoder.decodeElementGroup(elements: ElementGroup): { Instance }
    const instances = {}

    for i, element in elements do
        instances[i] = Decoder.decodeElement(element)
    end

    return instances
end

function Decoder.decode(json: string): Instance | { Instance }
    const decoded = HttpService:JSONDecode(json) :: JSONTable
    const structure_type = getStructureType(decoded)

    if structure_type == "WebContent" then
        return Decoder.decodeWebContent(decoded)
    end

    return Decoder.decodeElementGroup(decoded :: ElementGroup)
end

return table.freeze(Decoder)
