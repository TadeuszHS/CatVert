--!strict

const AbstractElement = require("./element/AbstractElement")
const Element = require("./element/Element")
const Property = require("./property/Property")
const Attribute = require("./property/Attribute")
const Custom = require("./property/Custom")
const CustomEncoder = require("../encoder/CustomEncoder")
const CustomDecoder = require("../decoder/CustomDecoder")

const BaseElement = AbstractElement.new<<Instance>>(
    "BaseElement",
    {
        Property.new("alias", "Name", "string"),
        Attribute.new("class", "string"),
        Attribute.new("globalid", "string"),
        Custom.new(
            "children",
            CustomEncoder.BaseElement.children,
            CustomDecoder.BaseElement.children
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

const BaseGuiElement = AbstractElement.new<<GuiObject>>(
    "BaseGuiElement",
    {
        Property.new("anchor", "AnchorPoint", "Vector2"),
        Property.new("background_color", "BackgroundColor3", "Color3"),
        Property.new("background_transparency", "BackgroundTransparency", "boolean"),
        Property.new("canvas", "ClipsDescendants", "boolean"),
        Property.new("position", "Position", "UDim2"),
        Property.new("visible", "Visible", "boolean"),
        Property.new("z_index", "ZIndex", "number"),
        Attribute.new("tooltip", "string"),
        Custom.new(
            "size",
            CustomEncoder.BaseElement.children,
            CustomDecoder.BaseGuiElement.size
        ),
        Custom.new(
            "height",
            CustomEncoder.BaseGuiElement.height,
            CustomDecoder.BaseGuiElement.height
        ),
        Custom.new(
            "width",
            CustomEncoder.BaseGuiElement.width,
            CustomDecoder.BaseGuiElement.width
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
    BaseElement
)

const BaseTextElement = AbstractElement.new<<TextLabel>>(
    "BaseTextElement",
    {
        Property.new("align_x", "TextXAlignment", "TextXAlignment"),
        Property.new("align_y", "TextYAlignment", "TextYAlignment"),
        Property.new("truncate", "TextTruncate", "TextTruncate"),
        Property.new("line_height", "LineHeight", "number"),
        Property.new("rich", "RichText", "boolean"),
        Property.new("text", "Text", "string"),
        Property.new("wrap", "TextWrapped", "boolean"),
        Property.new("font_color", "TextColor3", "Color3"),
        Property.new("font_transparency", "TextTransparency", "boolean"),
        Custom.new(
            "font",
            CustomEncoder.BaseTextElement.font,
            CustomDecoder.BaseTextElement.font
        ),
        Custom.new(
            "font_style",
            CustomEncoder.BaseTextElement.font_style,
            CustomDecoder.BaseTextElement.font_style
        ),
        Custom.new(
            "font_weight",
            CustomEncoder.BaseTextElement.font_weight,
            CustomDecoder.BaseTextElement.font_weight
        ),
        Custom.new(
            "font_size",
            CustomEncoder.BaseTextElement.font_size,
            CustomDecoder.BaseTextElement.font_size
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
    BaseGuiElement
)

const BaseImageElement = AbstractElement.new<<ImageLabel>>(
    "BaseImageElement",
    {
        Property.new("image", "Image", "string"),
        Property.new("image_color", "ImageColor3", "Color3"),
        Property.new("image_transparency", "ImageTransparency", "boolean"),
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
    BaseGuiElement
)

const BaseButtonElement = AbstractElement.new<<TextButton>>(
    "BaseButtonElement",
    {
        Property.new("auto_color", "AutomaticColor", "boolean"),
    },
    {
        Name = "Button",
    },
    {
        class = "ButtonElement",
    },
    BaseGuiElement
)

const BaseLinkElement = AbstractElement.new<<TextButton>>(
    "BaseLinkElement",
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
    BaseButtonElement
)

const BaseGridStyleElement = AbstractElement.new<<UIGridStyleLayout>>(
    "BaseLinkElement",
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
    BaseElement
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
    BaseGuiElement
)

const ScrollableFrameElement = Element.new<<ScrollingFrame>>(
    "ScrollingFrame",
    "ScrollingFrame",
    {
        Property.new("scrollbar_color", "ScrollBarImageColor3", "Color3"),
        Property.new("scrollbar_thickness", "ScrollBarThickness", "number"),
        Property.new("scrollbar_transparency", "ScrollBarImageTransparency", "number"),
        Custom.new(
            "canvassize",
            CustomEncoder.ScrollableFrameElement.canvassize,
            CustomDecoder.ScrollableFrameElement.canvassize
        ),
    },
    {
        Name = "Scrollable Frame",
        ScrollBarImageColor3 = Color3.fromHex("000000"),
    },
    {
        class = "ScrollingFrame",
    },
    BaseGuiElement
)

const TextElement = Element.new<<TextLabel>>(
    "TextLabel",
    "Textlabel",
    {},
    {
        BackgroundTransparency = 1,
    },
    {
        class = "TextLabel"
    },
    BaseTextElement
)

const InputElement = Element.new<<TextBox>>(
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
        PlaceholderTextColor = Color3.fromHex("b2b2b2"),
        BackgroundColor3 = Color3.fromHex("c8c8c8"),
    },
    {
        class = "TextBox"
    },
    BaseTextElement
)

const ButtonElement = Element.new<<TextButton>>(
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
    BaseTextElement,
    BaseButtonElement
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
    BaseTextElement,
    BaseLinkElement
)

const DonationElement = Element.new<<TextButton>>(
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
    BaseButtonElement
)

const TransferElement = Element.new<<TextButton>>(
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
    BaseButtonElement
)

const AvatarItemElement = Element.new<<TextButton>>(
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
    BaseButtonElement
)

const ImageElement = Element.new<<ImageLabel>>(
    "ImageLabel",
    "ImageLabel",
    {},
    {
        Name = "Image"
    },
    {
        class = "ImageLabel",
    },
    BaseImageElement
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
    BaseImageElement,
    BaseButtonElement
)

const ImageLinkElement = Element.new<<ImageButton>>(
    "ImageButton",
    "ImageButton?link",
    {},
    {
        Name = "Image Link"
    },
    {
        class = "ImageButton?link",
    },
    BaseImageElement,
    BaseLinkElement
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
    BaseElement
)

const AspectRatioElement = Element.new<<UIAspectRatioConstraint>>(
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
    BaseElement
)

const ConstraintElement = Element.new<<UISizeConstraint>>(
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
    BaseElement
)

const CornerElement = Element.new<<UICorner>>(
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
    BaseElement
)

const GradientElement = Element.new<<UIGradient>>(
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
    BaseElement
)

const GridElement = Element.new<<UIGridLayout>>(
    "UIGridLayout",
    "UIGridLayout",
    {
        Property.new("padding", "CellPadding", "UDim"),
        Property.new("size", "Size", "UDim2"),
    },
    {
        Name = "Grid",
        CellPadding = UDim.new(0, 0),
        CellSize = UDim2.fromScale(0.2, 0.2),
    },
    {
        class = "UIGridLayout",
    },
    BaseGridStyleElement
)

const ListElement = Element.new<<UIListLayout>>(
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
    BaseGridStyleElement
)

const PaddingElement = Element.new<<UIPadding>>(
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
    BaseElement
)

const OutlineElement = Element.new<<UIStroke>>(
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
    BaseElement
)

const FlexItemElement = Element.new<<UIFlexItem>>(
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
    BaseElement
)

return table.freeze({
    Abstract = table.freeze({
        BaseElement = BaseElement,
        BaseGuiElement = BaseGuiElement,
        BaseTextElement = BaseTextElement,
        BaseImageElement = BaseImageElement,
        BaseButtonElement = BaseButtonElement,
        BaseLinkElement = BaseLinkElement,
        BaseGridStyleElement = BaseGridStyleElement,
    }),
    Element = table.freeze({
        FrameElement = FrameElement,
        ScrollableFrameElement = ScrollableFrameElement,
        TextElement = TextElement,
        InputElement = InputElement,
        ButtonElement = ButtonElement,
        LinkButtonElement = LinkButtonElement,
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
    })
})
