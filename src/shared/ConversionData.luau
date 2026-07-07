--!strict

const AbstractElementData = require("./AbstractElementData")
const ElementData = require("./ElementData")
const PropertyData = require("./PropertyData")
const AttributeData = require("./AttributeData")
const CustomData = require("./CustomData")

type AbstractElementData = AbstractElementData.AbstractElementData
type ElementData = ElementData.ElementData

const BaseElement = AbstractElementData.new("BaseElement", {
    PropertyData.new("alias", "Name", "string", "BaseElement"),
    AttributeData.new("class", "string", "BaseElement"),
    AttributeData.new("globalid", "string", ""),
    CustomData.new("children"),
}, {})

const BaseGuiElement = AbstractElementData.new("BaseGuiElement", {
    PropertyData.new("anchor", "AnchorPoint", "Vector2", Vector2.zero),
    PropertyData.new("background_color", "BackgroundColor3", "Color3", Color3.fromHex("c8c8c8")),
    PropertyData.new("background_transparency", "BackgroundTransparency", "number", 0),
    PropertyData.new("canvas", "ClipsDescendants", "boolean", false),
    PropertyData.new("position", "Position", "UDim2", UDim2.fromScale(0, 0)),
    PropertyData.new("rotation", "Rotation", "number", 0),
    PropertyData.new("visible", "Visible", "boolean", true),
    PropertyData.new("z_index", "ZIndex", "number", 0),
    AttributeData.new("tooltip", "string", ""),
    CustomData.new("size"),
}, {
    alias = "BaseGuiElement",
    class = "BaseGuiElement",
}, BaseElement)

const BaseTextElement = AbstractElementData.new("BaseTextElement", {
    PropertyData.new("align_x", "TextXAlignment", "TextXAlignment", Enum.TextXAlignment.Center),
    PropertyData.new("align_y", "TextYAlignment", "TextYAlignment", Enum.TextYAlignment.Center),
    PropertyData.new("font_color", "TextColor3", "Color3", Color3.fromHex("000000")),
    PropertyData.new("font_transparency", "TextTransparency", "number", 0),
    PropertyData.new("line_height", "LineHeight", "number", 1),
    PropertyData.new("rich", "RichText", "boolean", false),
    PropertyData.new("text", "Text", "string", "Text"),
    PropertyData.new("truncate", "TextTruncate", "TextTruncate", Enum.TextTruncate.AtEnd),
    PropertyData.new("wrap", "TextWrapped", "boolean", true),
    CustomData.new("font_size"),
    CustomData.new("font"),
    CustomData.new("font_style"),
    CustomData.new("font_weight"),
}, {
    alias = "BaseTextElement",
    class = "BaseTextElement",
    background_color = Color3.fromHex("ffffff"),
    background_transparency = 1,
    font_size = "scaled",
}, BaseGuiElement)

const BaseImageElement = AbstractElementData.new("BaseImageElement", {
    PropertyData.new("image", "Image", "string", "rbxassetid://70877710889686"),
    PropertyData.new("image_color", "ImageColor3", "Color3", Color3.fromHex("ffffff")),
    PropertyData.new("image_transparency", "ImageTransparency", "number", 0),
    PropertyData.new("resample_mode", "ResampleMode", "ResamplerMode", Enum.ResamplerMode.Default),
    PropertyData.new("scale_type", "ScaleType", "ScaleType", Enum.ScaleType.Stretch),
    PropertyData.new("slice_center", "SliceCenter", "Rect", Rect.new(0, 0, 0, 0)),
    PropertyData.new("slice_scale", "SliceScale", "number", 1),
    AttributeData.new("image_id", "number")
}, {
    alias = "BaseImageElement",
    class = "BaseImageElement",
    background_color = Color3.fromHex("ffffff"),
}, BaseGuiElement)

const BaseLinkElement = AbstractElementData.new("BaseLinkElement", {
    AttributeData.new("href", "string", "example.rbx"),
    AttributeData.new("new_tab", "boolean", false),
}, {
    alias = "BaseLinkElement",
    class = "BaseLinkElement",
}, BaseGuiElement)

const FrameElement = ElementData.new("Frame", "Frame", {}, {
    alias = "Frame",
    class = "Frame",
}, BaseGuiElement)

const ScrollableFrameElement = ElementData.new("ScrollingFrame", "ScrollingFrame", {
    PropertyData.new("scrollbar_color", "ScrollBarImageColor3", "Color3", Color3.fromHex("000000")),
    PropertyData.new("scrollbar_thickness", "ScrollBarThickness", "number", 12),
    PropertyData.new("scrollbar_transparency", "ScrollBarImageTransparency", "number", 0),
    CustomData.new("canvassize"),
}, {
    alias = "Scrollable Frame",
    class = "ScrollingFrame",
}, BaseGuiElement)

const TextElement = ElementData.new("TextLabel", "TextLabel", {}, {
    alias = "Text",
    class = "TextLabel"
}, BaseTextElement)

const InputElement = ElementData.new("TextBox", "TextBox", {
    PropertyData.new("editable", "TextEditable", "boolean", true),
    PropertyData.new("multiline", "MultiLine", "boolean", false),
    PropertyData.new("placeholder", "PlaceholderText", "string", "Input"),
    PropertyData.new("placeholder_color", "PlaceholderColor3", "Color3", Color3.fromHex("b2b2b2")),
}, {
    alias = "Input",
    class = "TextBox",
    background_transparency = 0,
    background_color = Color3.fromHex("c8c8c8"),
    
    text = "",
}, BaseTextElement)

const ButtonElement = ElementData.new("TextButton", "TextButton", {
    PropertyData.new("auto_color", "AutoButtonColor", "boolean", true),
}, {
    alias = "Button",
    class = "TextButton",
    background_color = Color3.fromHex("4e9bff"),
    text = "Button",
}, BaseTextElement)

const LinkElement = ElementData.new("TextButton?link", "TextButton", {}, {
    alias = "Link",
    class = "TextButton?link",
    background_transparency = 0,
    background_color = Color3.fromHex("ffffff"),
    font_color = Color3.fromHex("4e9bff"),
    text = "Link"
}, BaseLinkElement, BaseTextElement)

const DonationElement = ElementData.new("TextButton?donation", "TextButton", {
    AttributeData.new("product", "number", 0),
    AttributeData.new("product_type", "InfoType", Enum.InfoType.GamePass),
    AttributeData.new("thanks_href", "string", ""),
}, {
    alias = "Donation",
    class = "TextButton?donation",
    background_transparency = 0,
    background_color = Color3.fromHex("68de5b"),
    text = "Donation",
}, ButtonElement)

const TransferElement = ElementData.new("TextButton?transfer", "TextButton", {
    AttributeData.new("robux_amount", "number", 50),
    AttributeData.new("transfer_id", "number", 0),
}, {
    alias = "Donation",
    class = "TextButton?transfer",
    background_transparency = 0,
    background_color = Color3.fromHex("68de5b"),
    text = "Donation",
}, ButtonElement)

const AvatarItemElement = ElementData.new("TextButton?avataritem", "TextButton", {
    AttributeData.new("product", "number", 0),
    AttributeData.new("product_type", "InfoType", Enum.InfoType.Asset),
}, {
    alias = "Avatar Item",
    class = "TextButton?avataritem",
    background_transparency = 0,
    background_color = Color3.fromHex("68de5b"),
    text = "Avatar Item",
}, ButtonElement)

const ImageElement = ElementData.new("ImageLabel", "ImageLabel", {}, {
    alias = "Image",
    class = "ImageLabel",
}, BaseImageElement)

const ImageButtonElement = ElementData.new("ImageButton", "ImageButton", {}, {
    alias = "Image Button",
    class = "ImageButton",
}, BaseImageElement)

const ImageLinkElement = ElementData.new("ImageButton?link", "ImageButton", {}, {
    alias = "Image Link",
    class = "ImageButton?link"
}, ImageButtonElement, BaseLinkElement)

const FolderElement = ElementData.new("Folder", "Folder", {}, {
    alias = "Folder",
    class = "Folder",
}, BaseElement)

const AspectRatioElement = ElementData.new("UIAspectRatioConstraint", "UIAspectRatioConstraint", {
    PropertyData.new("ratio", "AspectRatio", "number", 1)
}, {
    alias = "Aspect Ratio",
    class = "UIAspectRatioConstraint",
}, BaseElement)

const ConstraintElement = ElementData.new("UISizeConstraint", "UISizeConstraint", {
    PropertyData.new("max_size", "MaxSize", "UDim", UDim.new(math.huge, math.huge)),
    PropertyData.new("min_size", "MinSize", "UDim", UDim.new(0, 0)),
}, {
    alias = "Constraint",
    class = "UISizeConstraint",
}, BaseElement)

const CornerElement = ElementData.new("UICorner", "UICorner", {
    PropertyData.new("radius", "Radius", "UDim", UDim.new(0.1, 0))
}, {
    alias = "Corner",
    class = "UICorner",
}, BaseElement)

const GradientElement = ElementData.new("UIGradient", "UIGradient", {
    PropertyData.new("gradient_color", "Color", "ColorSequence", ColorSequence.new(Color3.fromHex("ffffff"))),
    PropertyData.new("gradient_transparency", "Transparency", "NumberSequence", NumberSequence.new(0)),
    PropertyData.new("gradient_offset", "Offset", "UDim", UDim.new(0,0)),
    PropertyData.new("rotation", "Rotation", "number", 0),
}, {
    alias = "Gradient",
    class = "UIGradient",
}, BaseElement)

const GridElement = ElementData.new("UIGridLayout", "UIGridLayout", {
    PropertyData.new("alignment_horizontal", "HorizontalAlignment", "HorizontalAlignment", Enum.HorizontalAlignment.Left),
    PropertyData.new("alignment_vertical", "VerticalAlignment", "VerticalAlignment", Enum.VerticalAlignment.Top),
    PropertyData.new("sort", "SortOrder", "SortOrder", Enum.SortOrder.LayoutOrder),
    PropertyData.new("padding", "CellPadding", "UDim", UDim.new(0,0)),
    PropertyData.new("size", "CellSize", "UDim2", UDim2.fromScale(0.2, 0.2)),
}, {
    alias = "Grid",
    class = "UIGridLayout",
}, BaseElement)

const ListElement = ElementData.new("UIListLayout", "UIListLayout", {
    PropertyData.new("alignment_horizontal", "HorizontalAlignment", "HorizontalAlignment", Enum.HorizontalAlignment.Left),
    PropertyData.new("alignment_vertical", "VerticalAlignment", "VerticalAlignment", Enum.VerticalAlignment.Top),
    PropertyData.new("direction", "FillDirection", "FillDirection", Enum.FillDirection.Vertical),
    PropertyData.new("sort", "SortOrder", "SortOrder", Enum.SortOrder.LayoutOrder),
    PropertyData.new("padding", "Padding", "UDim", UDim.new(0,0)),
    PropertyData.new("wrap_list", "Wraps", "boolean", false),
}, {
    alias = "List",
    class = "UIListLayout",
}, BaseElement)

const PaddingElement = ElementData.new("UIPadding", "UIPadding", {
    PropertyData.new("bottom", "PaddingBottom", "UDim", UDim.new(0,0)),
    PropertyData.new("left", "PaddingLeft", "UDim", UDim.new(0,0)),
    PropertyData.new("right", "PaddingRight", "UDim", UDim.new(0,0)),
    PropertyData.new("top", "PaddingTop", "UDim", UDim.new(0,0)),
}, {
    alias = "Padding",
    class = "UIPadding",
}, BaseElement)

const OutlineElement = ElementData.new("UIStroke", "UIStroke", {
    PropertyData.new("stroke_mode", "ApplyStrokeMode", "ApplyStrokeMode", Enum.ApplyStrokeMode.Border),
    PropertyData.new("stroke_position", "BorderStrokePosition", "BorderStrokePosition", Enum.BorderStrokePosition.Outer),
    PropertyData.new("stroke_sizing_mode", "StrokeSizingMode", "StrokeSizingMode", Enum.StrokeSizingMode.FixedSize),
    PropertyData.new("stroke_type", "LineJoinMode", "LineJoinMode", Enum.LineJoinMode.Round),
    PropertyData.new("stroke_color", "Color", "Color3", Color3.fromHex("000000")),
    PropertyData.new("stroke_offset", "BorderOffset", "UDim", UDim.new(0,0)),
    PropertyData.new("stroke_thickness", "Thickness", "number", 1),
    PropertyData.new("stroke_transparency", "Transparency", "number", 0),
    PropertyData.new("z_index", "ZIndex", "number", 0),
}, {
    alias = "Outline",
    class = "UIStroke",
}, BaseElement)

const FlexItemElement = ElementData.new("UIFlexItem", "UIFlexItem", {
    PropertyData.new("flex_mode", "FlexMode", "UIFlexMode", Enum.UIFlexMode.None),
    PropertyData.new("alignment_item_line", "ItemLineAlignment", "ItemLineAlignment", Enum.ItemLineAlignment.Automatic),
}, {
    alias = "Flex Item",
    class = "UIFlexItem",
}, BaseElement)

return table.freeze({
    AbstractElementData = table.freeze({
        BaseElement = BaseElement,
        BaseGuiElement = BaseGuiElement,
        BaseTextElement = BaseTextElement,
        BaseImageElement = BaseImageElement,
        BaseLinkElement = BaseLinkElement,
    }),
    ElementData = table.freeze({
        FrameElement = FrameElement,
        ScrollableFrameElement = ScrollableFrameElement,
        TextElement = TextElement,
        InputElement = InputElement,
        ButtonElement = ButtonElement,
        LinkElement = LinkElement,
        DonationElement = DonationElement,
        TransferElement = TransferElement,
        AvatarItemElement = AvatarItemElement,
        ImageElement = ImageElement,
        ImageButtonElement = ImageButtonElement,
        ImageLinkElement = ImageLinkElement,
        FolderElement = FolderElement,
        AspectRatioElement = AspectRatioElement,
        ConstraintElement = ConstraintElement,
        CornerElement = CornerElement,
        GradientElement = GradientElement,
        GridElement = GridElement,
        ListElement = ListElement,
        PaddingElement = PaddingElement,
        OutlineElement = OutlineElement,
        FlexItemElement = FlexItemElement,
    }),
})
