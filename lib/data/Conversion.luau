--!strict

const AbstractElement = require("./element/AbstractElement")
const Element = require("./element/Element")
const Property = require("./property/Property")
const Attribute = require("./property/Attribute")
const Custom = require("./property/Custom")
const CustomEncoder = require("../encoder/CustomEncoder")
const CustomDecoder = require("../decoder/CustomDecoder")

const WebContentAbstractElement = AbstractElement.New<<Frame>>(
	"WebContent",
	{
		Property.New("title", "Name", "string"),
		Property.New("background", "BackgroundColor3", "Color3"),
		Attribute.New("description", "string"),
		Attribute.New("favicon", "number"),
		Attribute.New("thumbnail_id", "number"),
		Attribute.New("thumbnail", "string"),
		Custom.New(
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
		BorderSizePixel = 0,
		ZIndex = 0,
	},
	{
		description = "",
		favicon = 0,
		thumbnail_id = 0,
		thumbnail = "",
	}
)

const RootAbstractElement = AbstractElement.New<<Instance>>(
	"Root",
	{
		Property.New("alias", "Name", "string"),
		Attribute.New("class", "string"),
		Attribute.New("globalid", "string"),
		Custom.New(
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

const GuiAbstractElement = AbstractElement.New<<GuiObject>>(
	"Gui",
	{
		Property.New("anchor", "AnchorPoint", "Vector2"),
		Property.New("background_color", "BackgroundColor3", "Color3"),
		Property.New("background_transparency", "BackgroundTransparency", "number"),
		Property.New("canvas", "ClipsDescendants", "boolean"),
		Property.New("position", "Position", "UDim2"),
		Property.New("visible", "Visible", "boolean"),
		Property.New("z_index", "ZIndex", "number"),
		Attribute.New("tooltip", "string"),
		Custom.New(
			"size",
			CustomEncoder.Abstract.Gui.size,
			CustomDecoder.Abstract.Gui.size
		),
		Custom.New(
			"height",
			CustomEncoder.Abstract.Gui.height,
			CustomDecoder.Abstract.Gui.height
		),
		Custom.New(
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

const TextAbstractElement = AbstractElement.New<<TextLabel>>(
	"Text",
	{
		Property.New("align_x", "TextXAlignment", "TextXAlignment"),
		Property.New("align_y", "TextYAlignment", "TextYAlignment"),
		Property.New("truncate", "TextTruncate", "TextTruncate"),
		Property.New("line_height", "LineHeight", "number"),
		Property.New("rich", "RichText", "boolean"),
		Property.New("text", "Text", "string"),
		Property.New("wrap", "TextWrapped", "boolean"),
		Property.New("font_color", "TextColor3", "Color3"),
		Property.New("font_transparency", "TextTransparency", "number"),
		Custom.New(
			"font",
			CustomEncoder.Abstract.Text.font,
			CustomDecoder.Abstract.Text.font
		),
		Custom.New(
			"font_style",
			CustomEncoder.Abstract.Text.font_style,
			CustomDecoder.Abstract.Text.font_style
		),
		Custom.New(
			"font_weight",
			CustomEncoder.Abstract.Text.font_weight,
			CustomDecoder.Abstract.Text.font_weight
		),
		Custom.New(
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
		FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
	},
	{
		class = "TextElement",
	},
	GuiAbstractElement
)

const ImageAbstractElement = AbstractElement.New<<ImageLabel>>(
	"Image",
	{
		Property.New("image", "Image", "string"),
		Property.New("image_color", "ImageColor3", "Color3"),
		Property.New("image_transparency", "ImageTransparency", "number"),
		Property.New("resample_mode", "ResampleMode", "ResamplerMode"),
		Property.New("scale_type", "ScaleType", "ScaleType"),
		Property.New("tile_size", "TileSize", "UDim2"),
		Property.New("slice_center", "SliceCenter", "Rect"),
		Property.New("slice_scale", "SliceScale", "number"),
		Attribute.New("image_id", "number"),
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

const GuiButtonAbstractElement = AbstractElement.New<<TextButton>>(
	"GuiButton",
	{
		Property.New("auto_color", "AutoButtonColor", "boolean"),
	},
	{
		Name = "Button",
	},
	{
		class = "ButtonElement",
	},
	GuiAbstractElement
)

const LinkButtonAbstractElement = AbstractElement.New<<TextButton>>(
	"LinkButton",
	{
		Attribute.New("href", "string"),
		Attribute.New("new_tab", "boolean"),
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

const GridStyleAbstractElement = AbstractElement.New<<UIGridStyleLayout>>(
	"GridStyle",
	{
		Property.New("alignment_horizontal", "HorizontalAlignment", "HorizontalAlignment"),
		Property.New("alignment_vertical", "VerticalAlignment", "VerticalAlignment"),
		Property.New("sort", "SortOrder", "SortOrder"),
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

const FrameElement = Element.New<<Frame>>(
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

const ScrollingFrameElement = Element.New<<ScrollingFrame>>(
	"ScrollingFrame",
	"ScrollingFrame",
	{
		Property.New("scrollbar_color", "ScrollBarImageColor3", "Color3"),
		Property.New("scrollbar_thickness", "ScrollBarThickness", "number"),
		Property.New("scrollbar_transparency", "ScrollBarImageTransparency", "number"),
		Custom.New(
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

const TextLabelElement = Element.New<<TextLabel>>(
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

const TextBoxElement = Element.New<<TextBox>>(
	"TextBox",
	"TextBox",
	{
		Property.New("editable", "TextEditable", "boolean"),
		Property.New("multiline", "MultiLine", "boolean"),
		Property.New("placeholder", "PlaceholderText", "string"),
		Property.New("placeholder_color", "PlaceholderColor3", "Color3"),
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

const TextButtonElement = Element.New<<TextButton>>(
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

const LinkButtonElement = Element.New<<TextButton>>(
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

const DonationButtonElement = Element.New<<TextButton>>(
	"TextButton?donation",
	"TextButton",
	{
		Attribute.New("product", "string"),
		Attribute.New("product_type", "InfoType"),
		Attribute.New("thanks_href", "string"),
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

const TransferButtonElement = Element.New<<TextButton>>(
	"TextButton?transfer",
	"TextButton",
	{
		Attribute.New("robux_amount", "number"),
		Attribute.New("transfer_id", "number"),
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

const AvatarItemButtonElement = Element.New<<TextButton>>(
	"TextButton?avataritem",
	"TextButton",
	{
		Attribute.New("product", "number"),
		Attribute.New("product_type", "InfoType"),
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

const ImageLabelElement = Element.New<<ImageLabel>>(
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

const ImageButtonElement = Element.New<<ImageButton>>(
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

const ImageLinkButtonElement = Element.New<<ImageButton>>(
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

const FolderElement = Element.New<<Folder>>(
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

const UIAspectRatioConstraintElement = Element.New<<UIAspectRatioConstraint>>(
	"UIAspectRatioConstraint",
	"UIAspectRatioConstraint",
	{
		Property.New("ratio", "AspectRatio", "number"),
	},
	{
		Name = "Aspect Ratio",
	},
	{
		class = "UIAspectRatioConstraint",
	},
	RootAbstractElement
)

const UISizeConstraintElement = Element.New<<UISizeConstraint>>(
	"UISizeConstraint",
	"UISizeConstraint",
	{
		Property.New("max_size", "MaxSize", "Vector2"),
		Property.New("min_size", "MinSize", "Vector2"),
	},
	{
		Name = "Constraint",
	},
	{
		class = "UISizeConstraint",
	},
	RootAbstractElement
)

const UICornerElement = Element.New<<UICorner>>(
	"UICorner",
	"UICorner",
	{
		Property.New("radius", "CornerRadius", "UDim"),
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

const UIGradientElement = Element.New<<UIGradient>>(
	"UIGradient",
	"UIGradient",
	{
		Property.New("gradient_color", "Color", "ColorSequence"),
		Property.New("gradient_offset", "Offset", "Vector2"),
		Property.New("gradient_transparency", "Transparency", "NumberSequence"),
		Property.New("rotation", "Rotation", "number"),
	},
	{
		Name = "Gradient",
	},
	{
		class = "UIGradient",
	},
	RootAbstractElement
)

const UIGridLayoutElement = Element.New<<UIGridLayout>>(
	"UIGridLayout",
	"UIGridLayout",
	{
		Property.New("padding", "CellPadding", "UDim"),
		Property.New("size", "Size", "UDim2"),
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

const UIListLayoutElement = Element.New<<UIListLayout>>(
	"UIListLayout",
	"UIListLayout",
	{
		Property.New("direction", "FillDirection", "FillDirection"),
		Property.New("padding", "Padding", "UDim"),
		Property.New("wrap_list", "Wraps", "boolean"),
	},
	{
		Name = "List",
	},
	{
		class = "UIListLayout",
	},
	GridStyleAbstractElement
)

const UIPaddingElement = Element.New<<UIPadding>>(
	"UIPadding",
	"UIPadding",
	{
		Property.New("bottom", "PaddingBottom", "UDim"),
		Property.New("left", "PaddingLeft", "UDim"),
		Property.New("right", "PaddingRight", "UDim"),
		Property.New("top", "PaddingTop", "UDim"),
	},
	{
		Name = "Padding",
	},
	{
		class = "UIPadding",
	},
	RootAbstractElement
)

const UIStrokeElement = Element.New<<UIStroke>>(
	"UIStroke",
	"UIStroke",
	{
		Property.New("stroke_color", "Color", "Color3"),
		Property.New("stroke_mode", "ApplyStrokeMode", "ApplyStrokeMode"),
		Property.New("stroke_offset", "BorderOffset", "UDim"),
		Property.New("stroke_position", "BorderStrokePosition", "BorderStrokePosition"),
		Property.New("stroke_thickness", "Thickness", "number"),
		Property.New("stroke_transparency", "Transparency", "number"),
		Property.New("stroke_type", "LineJoinMode", "LineJoinMode"),
		Property.New("z_index", "ZIndex", "number"),
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

const UIFlexItemElement = Element.New<<UIFlexItem>>(
	"UIFlexItem",
	"UIFlexItem",
	{
		Property.New("flex_mode", "FlexMode", "UIFlexMode"),
		Property.New("alignment_item_line", "ItemLineAlignment", "ItemLineAlignment"),
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
