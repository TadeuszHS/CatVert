--!strict

const AbstractElement = require("./element/AbstractElement")
const Element = require("./element/Element")
const Property = require("./property/Property")
const Attribute = require("./property/Attribute")
const Custom = require("./property/Custom")
const CustomEncoder = require("../encoder/CustomEncoder")
const CustomDecoder = require("../decoder/CustomDecoder")

const WebContentAbstractElement = AbstractElement.new<<Frame>>(
	"WebContent",
	{
		Property.new("title", "Name", "string"),
		Property.new("background", "BackgroundColor3", "Color3"),
		Attribute.new("description", "string"),
		Attribute.new("favicon", "number"),
		Attribute.new("thumbnail_id", "number"),
		Attribute.new("thumbnail", "string"),
		Custom.new(
			"webcontent",
			CustomEncoder.Abstract.WebContent.webcontent,
			CustomDecoder.Abstract.WebContent.webcontent
		)
	},
	{
		Name = "webcontent",
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromHex("ffffff"),
		ZIndex = 0,
	},
	{
		description = "",
		favicon = 0,
		thumbnail_id = 0,
		thumbnail = "",
	}
)

const RootAbstractElement = AbstractElement.new<<Instance>>(
	"Root",
	{
		Property.new("alias", "Name", "string"),
		Attribute.new("class", "string"),
		Attribute.new("globalid", "string"),
		Custom.new(
			"children",
			CustomEncoder.Abstract.Root.children,
			CustomDecoder.Abstract.Root.children
		),
	},
	{
		Name = "Element",
	},
	{
		class = "Element",
		globalid = "",
	}
)

const GuiAbstractElement = AbstractElement.new<<GuiObject>>(
	"Gui",
	{
		Property.new("anchor", "AnchorPoint", "Vector2"),
		Property.new("background_color", "BackgroundColor3", "Color3"),
		Property.new("background_transparency", "BackgroundTransparency", "number"),
		Property.new("canvas", "ClipsDescendants", "boolean"),
		Property.new("position", "Position", "UDim2"),
		Property.new("visible", "Visible", "boolean"),
		Property.new("z_index", "ZIndex", "number"),
		Attribute.new("tooltip", "string"),
		Custom.new(
			"size",
			CustomEncoder.Abstract.Gui.size,
			CustomDecoder.Abstract.Gui.size
		),
		Custom.new(
			"height",
			CustomEncoder.Abstract.Gui.height,
			CustomDecoder.Abstract.Gui.height
		),
		Custom.new(
			"width",
			CustomEncoder.Abstract.Gui.width,
			CustomDecoder.Abstract.Gui.width
		),
	},
	{
		Name = "Gui",
		Size = UDim2.fromScale(0.1, 0.1),
		BackgroundColor3 = Color3.fromHex("c8c8c8"),
		BorderSizePixel = 0,
		ZIndex = 0,
	},
	{
		class = "GuiElement",
		tooltip = "",
	},
	RootAbstractElement
)

const TextAbstractElement = AbstractElement.new<<TextLabel>>(
	"Text",
	{
		Property.new("align_x", "TextXAlignment", "TextXAlignment"),
		Property.new("align_y", "TextYAlignment", "TextYAlignment"),
		Property.new("truncate", "TextTruncate", "TextTruncate"),
		Property.new("line_height", "LineHeight", "number"),
		Property.new("rich", "RichText", "boolean"),
		Property.new("text", "Text", "string"),
		Property.new("wrap", "TextWrapped", "boolean"),
		Property.new("font_color", "TextColor3", "Color3"),
		Property.new("font_transparency", "TextTransparency", "number"),
		Custom.new(
			"font",
			CustomEncoder.Abstract.Text.font,
			CustomDecoder.Abstract.Text.font
		),
		Custom.new(
			"font_style",
			CustomEncoder.Abstract.Text.font_style,
			CustomDecoder.Abstract.Text.font_style
		),
		Custom.new(
			"font_weight",
			CustomEncoder.Abstract.Text.font_weight,
			CustomDecoder.Abstract.Text.font_weight
		),
		Custom.new(
			"font_size",
			CustomEncoder.Abstract.Text.font_size,
			CustomDecoder.Abstract.Text.font_size
		),
	},
	{
		Name = "Text",
		BackgroundColor3 = Color3.fromHex("ffffff"),
		TextColor3 = Color3.fromHex("000000"),
		Text = "Text",
		TextScaled = true,
		TextTruncate = Enum.TextTruncate.AtEnd,
		FontFace = Font.fromName("SourceSans", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
	},
	{
		class = "TextElement",
	},
	GuiAbstractElement
)

const ImageAbstractElement = AbstractElement.new<<ImageLabel>>(
	"Image",
	{
		Property.new("image", "Image", "string"),
		Property.new("image_color", "ImageColor3", "Color3"),
		Property.new("image_transparency", "ImageTransparency", "number"),
		Property.new("resample_mode", "ResamplerMode", "ResamplerMode"),
		Property.new("scale_type", "ScaleType", "ScaleType"),
		Property.new("slice_center", "SliceCenter", "Rect"),
		Property.new("slice_scale", "SliceScale", "number"),
		Attribute.new("image_id", "number"),
	},
	{
		Name = "Image",
		BackgroundColor3 = Color3.fromHex("ffffff"),
		ImageColor3 = Color3.fromHex("ffffff"),
		Image = "rbxassetid://70877710889686",
	},
	{
		class = "ImageElement",
		image_id = 107783162934966,
	},
	GuiAbstractElement
)

const GuiButtonAbstractElement = AbstractElement.new<<TextButton>>(
	"GuiButton",
	{
		Property.new("auto_color", "AutoButtonColor", "boolean"),
	},
	{
		Name = "Button",
	},
	{
		class = "ButtonElement",
	},
	GuiAbstractElement
)

const LinkButtonAbstractElement = AbstractElement.new<<TextButton>>(
	"LinkButton",
	{
		Attribute.new("href", "string"),
		Attribute.new("new_tab", "boolean"),
	},
	{
		Name = "Link",
	},
	{
		class = "LinkElement",
		href = "example.rbx",
		new_tab = false,
	},
	GuiButtonAbstractElement
)

const GridStyleAbstractElement = AbstractElement.new<<UIGridStyleLayout>>(
	"GridStyle",
	{
		Property.new("alignment_horizontal", "HorizontalAlignment", "HorizontalAlignment"),
		Property.new("alignment_vertical", "VerticalAlignment", "VerticalAlignment"),
		Property.new("sort", "SortOrder", "SortOrder"),
	},
	{
		Name = "GridStyle",
		SortOrder = Enum.SortOrder.LayoutOrder,
	},
	{
		class = "GridStyleElement",
	},
	RootAbstractElement
)

const FrameElement = Element.new<<Frame>>(
	"Frame",
	"Frame",
	{},
	{
		Name = "Frame"
	},
	{
		class = "Frame",
	},
	GuiAbstractElement
)

const ScrollingFrameElement = Element.new<<ScrollingFrame>>(
	"ScrollingFrame",
	"ScrollingFrame",
	{
		Property.new("scrollbar_color", "ScrollBarImageColor3", "Color3"),
		Property.new("scrollbar_thickness", "ScrollBarThickness", "number"),
		Property.new("scrollbar_transparency", "ScrollBarImageTransparency", "number"),
		Custom.new(
			"canvassize",
			CustomEncoder.Element.ScrollingFrame.canvassize,
			CustomDecoder.Element.ScrollingFrame.canvassize
		),
	},
	{
		Name = "Scrollable Frame",
		ScrollBarImageColor3 = Color3.fromHex("000000"),
	},
	{
		class = "ScrollingFrame",
	},
	GuiAbstractElement
)

const TextLabelElement = Element.new<<TextLabel>>(
	"TextLabel",
	"TextLabel",
	{},
	{
		BackgroundTransparency = 1,
	},
	{
		class = "TextLabel"
	},
	TextAbstractElement
)

const TextBoxElement = Element.new<<TextBox>>(
	"TextBox",
	"TextBox",
	{
		Property.new("editable", "TextEditable", "boolean"),
		Property.new("multiline", "MultiLine", "boolean"),
		Property.new("placeholder", "PlaceholderText", "string"),
		Property.new("placeholder_color", "PlaceholderColor3", "Color3"),
	},
	{
		Name = "Input",
		Text = "",
		PlaceholderText = "Input",
		PlaceholderColor3 = Color3.fromHex("b2b2b2"),
		BackgroundColor3 = Color3.fromHex("c8c8c8"),
	},
	{
		class = "TextBox"
	},
	TextAbstractElement
)

const TextButtonElement = Element.new<<TextButton>>(
	"TextButton",
	"TextButton",
	{},
	{
		Name = "Button",
		Text = "Button",
		BackgroundColor3 = Color3.fromHex("#4e9bff"),
	},
	{
		class = "TextButton"
	},
	TextAbstractElement,
	GuiButtonAbstractElement
)

const LinkButtonElement = Element.new<<TextButton>>(
	"TextButton?link",
	"TextButton",
	{},
	{
		Name = "Link",
		Text = "Link",
		TextColor3 = Color3.fromHex("4e9bff"),
	},
	{
		class = "TextButton?link"
	},
	TextAbstractElement,
	LinkButtonAbstractElement
)

const DonationButtonElement = Element.new<<TextButton>>(
	"TextButton?donation",
	"TextButton",
	{
		Attribute.new("product", "string"),
		Attribute.new("product_type", "InfoType"),
		Attribute.new("thanks_href", "string"),
	},
	{
		Name = "Donation",
		Text = "Donation",
		BackgroundColor3 = Color3.fromHex("68de5b"),
	},
	{
		class = "TextButton?donation",
		product = 0,
		product_type = Enum.InfoType.Asset,
		thanks_href = "",
	},
	GuiButtonAbstractElement
)

const TransferButtonElement = Element.new<<TextButton>>(
	"TextButton?transfer",
	"TextButton",
	{
		Attribute.new("robux_amount", "number"),
		Attribute.new("transfer_id", "number"),
	},
	{
		Name = "Donation",
		Text = "Donation",
		BackgroundColor3 = Color3.fromHex("68de5b"),
	},
	{
		class = "TextButton?transfer",
		robux_amount = 50,
		transfer_id = 0,
	},
	GuiButtonAbstractElement
)

const AvatarItemButtonElement = Element.new<<TextButton>>(
	"TextButton?avataritem",
	"TextButton",
	{
		Attribute.new("product", "number"),
		Attribute.new("product_type", "InfoType"),
	},
	{
		Name = "Avatar Item",
		Text = "Avatar Item",
		BackgroundColor3 = Color3.fromHex("68de5b"),
	},
	{
		class = "TextButton?avataritem",
		product = 0,
		product_type = Enum.InfoType.Asset,
	},
	GuiButtonAbstractElement
)

const ImageLabelElement = Element.new<<ImageLabel>>(
	"ImageLabel",
	"ImageLabel",
	{},
	{
		Name = "Image"
	},
	{
		class = "ImageLabel",
	},
	ImageAbstractElement
)

const ImageButtonElement = Element.new<<ImageButton>>(
	"ImageButton",
	"ImageButton",
	{},
	{
		Name = "Image Button"
	},
	{
		class = "ImageButton",
	},
	ImageAbstractElement,
	GuiButtonAbstractElement
)

const ImageLinkButtonElement = Element.new<<ImageButton>>(
	"ImageButton?link",
	"ImageButton",
	{},
	{
		Name = "Image Link"
	},
	{
		class = "ImageButton?link",
	},
	ImageAbstractElement,
	LinkButtonAbstractElement
)

const FolderElement = Element.new<<Folder>>(
	"Folder",
	"Folder",
	{},
	{
		Name = "Folder",
	},
	{
		class = "Folder",
	},
	RootAbstractElement
)

const UIAspectRatioConstraintElement = Element.new<<UIAspectRatioConstraint>>(
	"UIAspectRatioConstraint",
	"UIAspectRatioConstraint",
	{
		Property.new("ratio", "AspectRatio", "number"),
	},
	{
		Name = "Aspect Ratio",
	},
	{
		class = "UIAspectRatioConstraint",
	},
	RootAbstractElement
)

const UISizeConstraintElement = Element.new<<UISizeConstraint>>(
	"UISizeConstraint",
	"UISizeConstraint",
	{
		Property.new("max_size", "MaxSize", "Vector2"),
		Property.new("min_size", "MinSize", "Vector2"),
	},
	{
		Name = "Constraint",
	},
	{
		class = "UISizeConstraint",
	},
	RootAbstractElement
)

const UICornerElement = Element.new<<UICorner>>(
	"UICorner",
	"UICorner",
	{
		Property.new("radius", "Radius", "UDim"),
	},
	{
		Name = "Corner",
		CornerRadius = UDim.new(0.1, 0),
	},
	{
		class = "UICorner",
	},
	RootAbstractElement
)

const UIGradientElement = Element.new<<UIGradient>>(
	"UIGradient",
	"UIGradient",
	{
		Property.new("gradient_color", "Color", "ColorSequence"),
		Property.new("gradient_offset", "Offset", "Vector2"),
		Property.new("gradient_transparency", "Transparency", "NumberSequence"),
		Property.new("rotation", "Rotation", "number"),
	},
	{
		Name = "Gradient",
	},
	{
		class = "UIGradient",
	},
	RootAbstractElement
)

const UIGridLayoutElement = Element.new<<UIGridLayout>>(
	"UIGridLayout",
	"UIGridLayout",
	{
		Property.new("padding", "CellPadding", "UDim"),
		Property.new("size", "Size", "UDim2"),
	},
	{
		Name = "Grid",
		CellPadding = UDim2.fromScale(0, 0),
		CellSize = UDim2.fromScale(0.2, 0.2),
	},
	{
		class = "UIGridLayout",
	},
	GridStyleAbstractElement
)

const UIListLayoutElement = Element.new<<UIListLayout>>(
	"UIListLayout",
	"UIListLayout",
	{
		Property.new("direction", "FillDirection", "FillDirection"),
		Property.new("padding", "Padding", "UDim"),
		Property.new("wrap_list", "Wraps", "boolean"),
	},
	{
		Name = "List",
	},
	{
		class = "UIListLayout",
	},
	GridStyleAbstractElement
)

const UIPaddingElement = Element.new<<UIPadding>>(
	"UIPadding",
	"UIPadding",
	{
		Property.new("bottom", "PaddingBottom", "UDim"),
		Property.new("left", "PaddingLeft", "UDim"),
		Property.new("right", "PaddingTop", "UDim"),
		Property.new("bottom", "PaddingBottom", "UDim"),
	},
	{
		Name = "Padding",
	},
	{
		class = "UIPadding",
	},
	RootAbstractElement
)

const UIStrokeElement = Element.new<<UIStroke>>(
	"UIStroke",
	"UIStroke",
	{
		Property.new("stroke_color", "Color", "Color3"),
		Property.new("stroke_mode", "ApplyStrokeMode", "ApplyStrokeMode"),
		Property.new("stroke_offset", "BorderOffset", "UDim"),
		Property.new("stroke_position", "BorderStrokePosition", "BorderStrokePosition"),
		Property.new("stroke_thickness", "Thickness", "number"),
		Property.new("stroke_transparency", "Transparency", "number"),
		Property.new("stroke_type", "LineJoinMode", "LineJoinMode"),
		Property.new("z_index", "ZIndex", "number"),
	},
	{
		Name = "Outline",
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		ZIndex = 0,
	},
	{
		class = "UIStroke",
	},
	RootAbstractElement
)

const UIFlexItemElement = Element.new<<UIFlexItem>>(
	"UIFlexItem",
	"UIFlexItem",
	{
		Property.new("flex_mode", "FlexMode", "UIFlexMode"),
		Property.new("alignment_item_line", "ItemLineAlignment", "ItemLineAlignment"),
	},
	{
		Name = "Flex Item",
	},
	{
		class = "UIFlexItem",
	},
	RootAbstractElement
)

return table.freeze({
	Abstract = table.freeze({
		WebContent = WebContentAbstractElement,
		Root = RootAbstractElement,
		Gui = GuiAbstractElement,
		Text = TextAbstractElement,
		Image = ImageAbstractElement,
		GuiButton = GuiButtonAbstractElement,
		LinkButton = LinkButtonAbstractElement,
		GridStyle = GridStyleAbstractElement,
	}),
	Element = table.freeze({
		Frame = FrameElement,
		ScrollingFrame = ScrollingFrameElement,
		TextLabel = TextLabelElement,
		TextBox = TextBoxElement,
		TextButton = TextButtonElement,
		["TextButton?link"] = LinkButtonElement,
		["TextButton?donation"] = DonationButtonElement,
		["TextButton?transfer"] = TransferButtonElement,
		["TextButton?avataritem"] = AvatarItemButtonElement,
		ImageLabel = ImageLabelElement,
		ImageButton = ImageButtonElement,
		["ImageButton?link"] = ImageLinkButtonElement,
		Folder = FolderElement,
		UIAspectRatioConstraint = UIAspectRatioConstraintElement,
		UISizeConstraint = UISizeConstraintElement,
		UICorner = UICornerElement,
		UIGradient = UIGradientElement,
		UIGridLayout = UIGridLayoutElement,
		UIListLayout = UIListLayoutElement,
		UIPadding = UIPaddingElement,
		UIStroke = UIStrokeElement,
		UIFlexItem = UIFlexItemElement,
	})
})
