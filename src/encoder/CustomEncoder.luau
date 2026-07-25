--!strict

const Structure = require("../data/Structure")
const Custom = require("../data/property/Custom")
const TypeEncoder = require("./TypeEncoder")

type UnknownElement = Structure.UnknownElement
type RootAbstractElement = Structure.RootAbstractElement
type GuiAbstractElement = Structure.GuiAbstractElement
type TextAbstractElement = Structure.TextAbstractElement
type ScrollingFrameElement = Structure.ScrollingFrameElement
type CustomEncodeFunction = Custom.CustomEncodeFunction

const CustomEncoder = table.freeze({
    Abstract = table.freeze({
        Root = table.freeze({
            children = function(element: RootAbstractElement, inst: Instance, inst_to_element: (Instance) -> UnknownElement)
                element.children = {}
                for _, inst_child in inst:GetChildren() do
                    table.insert(element.children :: { UnknownElement }, inst_to_element(inst_child))
                end
            end :: CustomEncodeFunction,
        }),

        Gui = table.freeze({
            size = function(element: GuiAbstractElement, inst: GuiObject, _)
                const auto_size = TypeEncoder.AutomaticSize(inst.AutomaticSize)

                element.size = auto_size or TypeEncoder.UDim2(inst.Size)
            end :: CustomEncodeFunction,

            height = function(element: GuiAbstractElement, inst: GuiObject, _)
                if inst.AutomaticSize == Enum.AutomaticSize.X then
                    element.height = TypeEncoder.UDim(inst.Size.Y)
                end
            end :: CustomEncodeFunction,

            width = function(element: GuiAbstractElement, inst: GuiObject, _)
                if inst.AutomaticSize == Enum.AutomaticSize.Y then
                    element.width = TypeEncoder.UDim(inst.Size.X)
                end
            end :: CustomEncodeFunction,
        }),

        Text = table.freeze({
            font = function(element: TextAbstractElement, inst: TextLabel, _)
                element.font = TypeEncoder.string(inst.FontFace.Family)
            end :: CustomEncodeFunction,

            font_style = function(element: TextAbstractElement, inst: TextLabel, _)
                element.font_style = TypeEncoder.FontStyle(inst.FontFace.Style)
            end :: CustomEncodeFunction,

            font_weight = function(element: TextAbstractElement, inst: TextLabel, _)
                element.font_weight = TypeEncoder.FontWeight(inst.FontFace.Weight)
            end :: CustomEncodeFunction,

            font_size = function(element: TextAbstractElement, inst: TextLabel, _)
                if inst.TextScaled then
                    element.font_size = TypeEncoder.string("scaled")
                else
                    element.font_size = TypeEncoder.number(inst.TextSize)
                end
            end :: CustomEncodeFunction,
        }),
    }),

    Element = table.freeze({
        ScrollingFrame = table.freeze({
            canvassize = function(element: ScrollingFrameElement, inst: ScrollingFrame, _)
                const auto_size = TypeEncoder.AutomaticSize(inst.AutomaticCanvasSize)

                element.canvassize = auto_size or TypeEncoder.UDim2(inst.CanvasSize)
            end :: CustomEncodeFunction,
        }),
    })
})

return CustomEncoder
