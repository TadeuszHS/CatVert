--!strict

const Structure = require("../data/Structure")
const Custom = require("../data/property/Custom")
const TypeDecoder = require("./TypeDecoder")

type UnknownElement = Structure.UnknownElement
type WebContentAbstractElement = Structure.WebContentAbstractElement
type RootAbstractElement = Structure.RootAbstractElement
type GuiAbstractElement = Structure.GuiAbstractElement
type TextAbstractElement = Structure.TextAbstractElement
type ScrollingFrameElement = Structure.ScrollingFrameElement
type CustomDecodeFunction = Custom.CustomDecodeFunction

const CustomDecoder = table.freeze({
	Abstract = table.freeze({
		WebContent = table.freeze({
			webcontent = function(
				element: WebContentAbstractElement,
				inst: Instance,
				element_to_inst: (UnknownElement) -> Instance?
			): ()
				if typeof(element.webcontent) ~= "table" then
					return
				end

				for _, element_child in element.webcontent do
					const inst_child = element_to_inst(element_child)
					
					if inst_child then
						inst_child.Parent = inst
					end
				end
			end :: CustomDecodeFunction,
		}),

		Root = table.freeze({
			children = function(
				element: RootAbstractElement,
				inst: Instance,
				element_to_inst: (UnknownElement) -> Instance?
			): ()
				if typeof(element.children) ~= "table" then
					return
				end

				for _, element_child in element.children do
					const inst_child = element_to_inst(element_child)
					
					if inst_child then
						inst_child.Parent = inst
					end
				end
			end :: CustomDecodeFunction,
		}),

		Gui = table.freeze({
			size = function(element: GuiAbstractElement, inst: GuiObject, _): ()
				const auto_size = TypeDecoder.AutomaticSize(element.size)

				if auto_size then
					inst.AutomaticSize = auto_size
					
					if auto_size == Enum.AutomaticSize.XY then
						inst.Size = UDim2.fromScale(0, 0)
					elseif auto_size == Enum.AutomaticSize.X then
						inst.Size = UDim2.new(UDim.new(0, 0), inst.Size.Y)
					elseif auto_size == Enum.AutomaticSize.Y then
						inst.Size = UDim2.new(inst.Size.X, UDim.new(0, 0))
					end
				else
					inst.Size = TypeDecoder.UDim2(element.size)
				end
			end :: CustomDecodeFunction,

			height = function(element: GuiAbstractElement, inst: GuiObject, _): ()
				if TypeDecoder.AutomaticSize(element.size) == Enum.AutomaticSize.X then
					inst.Size =
						UDim2.new(UDim.new(0, 0), TypeDecoder.UDim(element.height))
				end
			end :: CustomDecodeFunction,

			width = function(element: GuiAbstractElement, inst: GuiObject, _): ()
				if TypeDecoder.AutomaticSize(element.size) == Enum.AutomaticSize.Y then
					inst.Size =
						UDim2.new(TypeDecoder.UDim(element.width), UDim.new(0, 0))
				end
			end :: CustomDecodeFunction,
		}),

		Text = table.freeze({
			font = function(element: TextAbstractElement, inst: TextLabel, _): ()
				const id = TypeDecoder.number(element.font)
				local prev_weight = inst.FontFace.Weight
				local prev_style = inst.FontFace.Style

				if id then
					inst.FontFace = Font.fromId(id, prev_weight, prev_style)
				else
					const enum_font = Font.fromEnum(TypeDecoder.Font(element.font) :: Enum.Font)

					if enum_font.Weight ~= Enum.FontWeight.Regular then
						prev_weight = enum_font.Weight
					elseif enum_font.Style ~= Enum.FontStyle.Normal then
						prev_style = enum_font.Style
					end

					inst.FontFace = Font.new(enum_font.Family, prev_weight, prev_style)
				end
			end :: CustomDecodeFunction,

			font_style = function(element: TextAbstractElement, inst: TextLabel, _): ()
				inst.FontFace =
					Font.new(inst.FontFace.Family, inst.FontFace.Weight, TypeDecoder.FontStyle(element.font_style))
			end :: CustomDecodeFunction,

			font_weight = function(element: TextAbstractElement, inst: TextLabel, _): ()
				inst.FontFace =
					Font.new(inst.FontFace.Family, TypeDecoder.FontWeight(element.font_weight), inst.FontFace.Style)
			end :: CustomDecodeFunction,

			font_size = function(element: TextAbstractElement, inst: TextLabel, _): ()
				if TypeDecoder.string(element.font_size) == "scaled" then
					inst.TextScaled = true
				else
					inst.TextScaled = false
					inst.TextSize = TypeDecoder.number(element.font_size) or inst.TextSize
				end
			end :: CustomDecodeFunction,
		}),
	}),

	Element = table.freeze({
		ScrollingFrame = table.freeze({
			canvassize = function(element: ScrollingFrameElement, inst: ScrollingFrame, _): ()
				const auto_size = TypeDecoder.AutomaticSize(element.canvassize)

				if auto_size then
					inst.AutomaticCanvasSize = auto_size
				else
					inst.CanvasSize = TypeDecoder.UDim2(element.canvassize)
				end
			end :: CustomDecodeFunction,
		}),
	}),
})

return CustomDecoder
