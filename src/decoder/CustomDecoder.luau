--!strict
--[[
    TODO: Properly handle/notify of errors during decoding.
]]--

const Structure = require("../data/Structure")
const Custom = require("../data/property/Custom")
const TypeDecoder = require("./TypeDecoder")

type UnknownElement = Structure.UnknownElement
type BaseElement = Structure.BaseElement
type BaseGuiElement = Structure.BaseGuiElement
type BaseTextElement = Structure.BaseTextElement
type ScrollableFrameElement = Structure.ScrollableFrameElement
type CustomDecodeFunction = Custom.CustomDecodeFunction

const CustomDecoder = table.freeze({
    BaseElement = table.freeze({
        children = function(element: BaseElement, inst: Instance, element_to_inst: (UnknownElement) -> Instance)
            if not element.children then
                return
            end

            for _, element_child in element.children do
                element_to_inst(element_child).Parent = inst
            end
        end :: CustomDecodeFunction,
    }),
    BaseGuiElement = table.freeze({
        size = function(element: BaseGuiElement, inst: GuiObject, _)
            if TypeDecoder.string(element.size) == "auto" then
                inst.AutomaticSize = Enum.AutomaticSize.XY
            elseif TypeDecoder.string(element.size) == "auto_x" then
                inst.AutomaticSize = Enum.AutomaticSize.X
            elseif TypeDecoder.string(element.size) == "auto_y" then
                inst.AutomaticSize = Enum.AutomaticSize.Y
            else
                inst.Size = TypeDecoder.UDim2(element.size)
            end
        end :: CustomDecodeFunction,
        height = function(element: BaseGuiElement, inst: GuiObject, _)
            if TypeDecoder.string(element.size) == "auto_x" then
                inst.Size = UDim2.new(
                    UDim.new(inst.Size.X.Scale, inst.Size.X.Offset),
                    TypeDecoder.UDim(element.height)
                )
            end
        end :: CustomDecodeFunction,
        width = function(element: BaseGuiElement, inst: GuiObject, _)
            if TypeDecoder.string(element.size) == "auto_y" then
                inst.Size = UDim2.new(
                    TypeDecoder.UDim(element.width),
                    UDim.new(inst.Size.Y.Scale, inst.Size.Y.Offset)
                )
            end
        end :: CustomDecodeFunction,
    }),
    BaseTextElement = table.freeze({
        font = function(element: BaseTextElement, inst: TextLabel, _)
            const id = TypeDecoder.number(element.font)
            if id then
                inst.FontFace = Font.fromId(id, inst.FontFace.Weight, inst.FontFace.Style)
            else
                inst.FontFace = Font.fromName(TypeDecoder.string(element.font), inst.FontFace.Weight, inst.FontFace.Style)
            end
        end :: CustomDecodeFunction,
        font_style = function(element: BaseTextElement, inst: TextLabel, _)
            inst.FontFace = Font.new(inst.FontFace.Family, inst.FontFace.Weight, TypeDecoder.FontStyle(element.font_style))
        end :: CustomDecodeFunction,
        font_weight = function(element: BaseTextElement, inst: TextLabel, _)
            inst.FontFace = Font.new(inst.FontFace.Family, TypeDecoder.FontWeight(element.font_weight), inst.FontFace.Style)
        end :: CustomDecodeFunction,
        font_size = function(element: BaseTextElement, inst: TextLabel, _)
            if TypeDecoder.string(element.font_size) == "scaled" then
                inst.TextScaled = true
            else
                inst.TextScaled = false
                inst.TextSize = TypeDecoder.number(element.font_size) or inst.TextSize
            end
        end :: CustomDecodeFunction,
    }),
    ScrollableFrameElement = table.freeze({
        canvassize = function(element: ScrollableFrameElement, inst: ScrollingFrame, _)
            if TypeDecoder.string(element.canvassize) == "auto" then
                inst.AutomaticCanvasSize = Enum.AutomaticSize.XY      
            elseif TypeDecoder.string(element.canvassize) == "auto_x" then
                inst.AutomaticCanvasSize = Enum.AutomaticSize.X
            elseif TypeDecoder.string(element.canvassize) == "auto_y" then
                inst.AutomaticCanvasSize = Enum.AutomaticSize.Y
            else
                inst.CanvasSize = TypeDecoder.UDim2(element.canvassize)
            end
        end :: CustomDecodeFunction,
    })
})

return CustomDecoder