--!strict

const Structure = require("../data/Structure")
const Custom = require("../data/property/Custom")
const TypeEncoder = require("./TypeEncoder")

type UnknownElement = Structure.UnknownElement
type BaseElement = Structure.BaseElement
type BaseGuiElement = Structure.BaseGuiElement
type BaseTextElement = Structure.BaseTextElement
type ScrollableFrameElement = Structure.ScrollableFrameElement
type CustomEncodeFunction = Custom.CustomEncodeFunction

const CustomEncoder = table.freeze({
    BaseElement = table.freeze({
        children = function(element: BaseElement, inst: Instance, inst_to_element: (Instance) -> UnknownElement)
            element.children = {}
            for _, inst_child in inst:GetChildren() do
                table.insert(element.children :: { UnknownElement }, inst_to_element(inst_child))
            end
        end :: CustomEncodeFunction,
    }),
    BaseGuiElement = table.freeze({
        size = function(element: BaseGuiElement, inst: GuiObject, _)
            if inst.AutomaticSize == Enum.AutomaticSize.XY then
                element.size = TypeEncoder.string("auto")
            elseif inst.AutomaticSize == Enum.AutomaticSize.X then
                element.size = TypeEncoder.string("auto_x")
            elseif inst.AutomaticSize == Enum.AutomaticSize.Y then
                element.size = TypeEncoder.string("auto_y")
            else
                element.size = TypeEncoder.UDim2(inst.Size)
            end
        end :: CustomEncodeFunction,
        height = function(element: BaseGuiElement, inst: GuiObject, _)
            if inst.AutomaticSize == Enum.AutomaticSize.X then
                element.height = TypeEncoder.UDim(inst.Size.Y)
            end
        end :: CustomEncodeFunction,
        width = function(element: BaseGuiElement, inst: GuiObject, _)
            if inst.AutomaticSize == Enum.AutomaticSize.Y then
                element.width = TypeEncoder.UDim(inst.Size.X)
            end
        end :: CustomEncodeFunction,
    }),
    BaseTextElement = table.freeze({
        font = function(element: BaseTextElement, inst: TextLabel, _)
            element.font = TypeEncoder.string(inst.FontFace.Family)
        end :: CustomEncodeFunction,
        font_style = function(element: BaseTextElement, inst: TextLabel, _)
            element.font_style = TypeEncoder.FontStyle(inst.FontFace.Style)
        end :: CustomEncodeFunction,
        font_weight = function(element: BaseTextElement, inst: TextLabel, _)
            element.font_weight = TypeEncoder.FontWeight(inst.FontFace.Weight)
        end :: CustomEncodeFunction,
        font_size = function(element: BaseTextElement, inst: TextLabel, _)
            if inst.TextScaled then
                element.font_size = TypeEncoder.string("scaled")
            else
                element.font_size = TypeEncoder.number(inst.TextSize)
            end
        end :: CustomEncodeFunction,
    }),
    ScrollableFrameElement = table.freeze({
        canvassize = function(element: ScrollableFrameElement, inst: ScrollingFrame, _)
            if inst.AutomaticCanvasSize == Enum.AutomaticSize.XY then
                element.canvassize = "auto"
            elseif inst.AutomaticCanvasSize == Enum.AutomaticSize.X then
                element.canvassize = "auto_x"
            elseif inst.AutomaticCanvasSize == Enum.AutomaticSize.Y then
                element.canvassize = "auto_y"
            else
                element.canvassize = TypeEncoder.UDim2(inst.CanvasSize)
            end
        end :: CustomEncodeFunction,
    }),
})

return CustomEncoder
