--!strict

--[=[
	Representation of all possible types that can be decoded by `HttpService:JsonDecode`.
]=]
export type JSONUnknown = string | number | boolean | nil | JSONTable
--[=[
	Representation of all possible tables types that can be decoded by `HttpService:JsonDecode`.
]=]
export type JSONTable = { [string | number]: JSONUnknown }

--[=[
	Utility type to represent an Element with string indexed properties of a `JSONUnknown` type.
]=]
export type UnknownElement = BaseElement & {
	[string]: JSONUnknown,
}

--[=[
	Abstract JSON Element for all CatWeb Elements.
	@since 1.2.0
]=]
export type BaseElement = {
	alias: string?,
	class: string,
	children: { UnknownElement }?,
	globalid: string,
}
--[=[
	Abstract JSON Element for all CatWeb Gui Elements.
	@since 1.2.0
]=]
export type BaseGuiElement = {
	anchor: string?,
	background_color: string?,
	background_transparency: string?,
	canvas: string?,
	position: string?,
	rotation: string?,
	size: string?,
	tooltip: string?,
	visible: string?,
	z_index: string?,
}
--[=[
	Abstract JSON Element for all CatWeb Text Elements.
	@since 1.2.0
]=]
export type BaseTextElement = BaseGuiElement & {
	align_x: string?,
	align_y: string?,
	font: string?,
	font_color: string?,
	font_size: string?,
	font_style: string?,
	font_transparency: string?,
	font_weight: string?,
	line_height: string?,
	rich: string?,
	text: string?,
	truncate: string?,
	wrap: string?,
}
--[=[
	Abstract JSON Element for all CatWeb Image Elements.
	@since 1.2.0
]=]
export type BaseImageElement = BaseGuiElement & {
	image: string?,
	image_color: string?,
	image_id: string?,
	image_transparency: string?,
	resample_mode: string?,
	scale_type: string?,
	slice_center: string?,
	slice_scale: string?,
}
--[=[
	Abstract JSON Element for all CatWeb Link Elements.
	@since 1.2.0
]=]
export type BaseLinkElement = BaseGuiElement & {
	href: string?,
	new_tab: string?,
}

--[=[
	CatWeb Frame Element.
	@since 1.2.0
]=]
export type FrameElement = BaseGuiElement
--[=[
	CatWeb ScrollableFrame Element.
	@since 1.3.0
]=]
export type ScrollableFrameElement = BaseGuiElement & {
	canvassize: string?,
	scrollbar_color: string?,
	scrollbar_thickness: string?,
	scrollbar_transparency: string?,
}

--[=[
	CatWeb Text Element.
	@since 1.2.0
]=]
export type TextElement = BaseTextElement
--[=[
	CatWeb Input Element.
	@since 1.2.0
]=]
export type InputElement = BaseTextElement & {
	editable: string?,
	multiline: string?,
	placeholder: string?,
	placeholder_color: string?,
}
--[=[
	CatWeb Button Element.
	@since 1.2.0
]=]
export type ButtonElement = BaseTextElement & {
	auto_color: string?,
}
--[=[
	CatWeb Link Element.
	@since 1.2.0
]=]
export type LinkElement = ButtonElement & {
	href: string?,
	new_tab: string?,
}

--[=[
	CatWeb DonationButton Element.
	@deprecated As of 2.17.3.0 due to [Roblox updates](https://devforum.roblox.com/t/disabling-cross-game-sales-of-passes-and-dev-products-and-introducing-the-transfers-api/4618396)
	in favor of the Transfers API, use {@link TransferButtonElement} or {@link AvatarItemButtonElement} instead.
	@since 1.2.0
]=]
export type DonationButtonElement = ButtonElement & {
	product: string?,
	product_type: string?,
	thanks_href: string?,
}
--[=[
	CatWeb TransferButton Element.
	@since 2.17.3.0
]=]
export type TransferButtonElement = ButtonElement & {
	robux_amount: string?,
	transfer_id: string?,
}
--[=[
	CatWeb AvatarItem Element.
	@since 2.17.3.0
]=]
export type AvatarItemButtonElement = ButtonElement & {
	product: string?,
	product_type: string?,
}

--[=[
	CatWeb Image Element.
	@since 1.2.0
]=]
export type ImageElement = BaseImageElement
--[=[
	CatWeb Image Button Element.
	@since 2.18.0.0
]=]
export type ImageButtonElement = BaseImageElement
--[=[
	CatWeb Image Link Element.
	@since 2.18.0.0
]=]
export type ImageLinkElement = BaseImageElement & BaseLinkElement

--[=[
	CatWeb Folder Element.
	@since 2.8.0
]=]
export type FolderElement = BaseElement

--[=[
	CatWeb AspectRatio Element.
	@since 1.7.0
]=]
export type AspectRatioElement = BaseElement & {
	ratio: string?,
}
--[=[
	CatWeb Constraint Element.
	@since 1.7.0
]=]
export type ConstraintElement = BaseElement & {
	max_size: string?,
	min_size: string?,
}
--[=[
	CatWeb Corner Element.
	@since 1.3.0
]=]
export type CornerElement = BaseElement & {
	radius: string?,
}
--[=[
	CatWeb Gradient Element.
	@since 2.10.0
]=]
export type GradientElement = BaseElement & {
	gradient_color: string?,
	gradient_offset: string?,
	gradient_transparency: string?,
	rotation: string?,
}
--[=[
	CatWeb Grid Element.
	@since 1.3.0
]=]
export type GridElement = BaseElement & {
	alignment_horizontal: string?,
	alignment_vertical: string?,
	padding: string?,
	size: string?,
	sort: string?,
}
--[=[
	CatWeb List Element.
	@since 1.3.0
]=]
export type ListElement = BaseElement & {
	alignment_horizontal: string?,
	alignment_vertical: string?,
	direction: string?,
	padding: string?,
	sort: string?,
	wrap_list: string?,
}
--[=[
	CatWeb Padding Element.
	@since 1.2.0
]=]
export type PaddingElement = BaseElement & {
	bottom: string?,
	left: string?,
	right: string?,
	top: string?,
}
--[=[
	CatWeb Outline Element.
	@since 1.3.0
]=]
export type OutlineElement = BaseElement & {
	stroke_color: string?,
	stroke_mode: string?,
	stroke_offset: string?,
	stroke_position: string?,
	stroke_sizing_mode: string?,
	stroke_thickness: string?,
	stroke_transparency: string?,
	stroke_type: string?,
	z_index: string?,
}
--[=[
	CatWeb Flex Item Element.
	@since 2.18.0.0
]=]
export type FlexItemElement = BaseElement & {
	flex_mode: string?,
	alignment_item_line: string?,
}

--[=[
	Describes a kind of property for type elimination and type handling.
]=]
export type PropertyKind = "Property" | "Attribute" | "Custom"

--[=[
	The base of all properties in ElementInfo.
]=]
type BasePropertyInfo = {
	kind: PropertyKind,
	catweb_index: string,
	default: unknown,
}
--[=[
	CatWeb Element property that has a 1:1 value representation as an indexed property in a Roblox Instance.
]=]
export type PropertyInfo = BasePropertyInfo & {
	roblox_index: string,
	valueType: string,
}
--[=[
	CatWeb Element property that does not have any equivalent representation in a Roblox Instance,
	instead being represented as a Roblox Instance attribute.
	This is typically used for representing behavior that is unique to CatWeb.
]=]
export type AttributePropertyInfo = BasePropertyInfo & {
	valueType: string,
}
--[=[
	CatWeb Element property that has a complex representation as some kind of value in a Roblox Instance.
	This is typically used for representing CatWeb Element properties that have side effects on other Roblox Instance properties.
]=]
export type CustomPropertyInfo = BasePropertyInfo

--[=[
	Data type that contains all data required for a conversion between Roblox Instances and CatWeb Elements.
]=]
export type ElementInfo = {
	roblox_class: string,
	catweb_class: string,
	is_creatable: boolean,
	inherit: ElementInfo?,
	properties: { [string]: PropertyInfo | AttributePropertyInfo | CustomPropertyInfo },
}

--[=[
	Representation of all enums in CatWeb.
]=]
export type CatWebEnums =
	"ApplyStrokeMode"
	| "BorderStrokePosition"
	| "FillDirection"
	| "Font"
	| "FontStyle"
	| "FontWeight"
	| "HorizontalAlignment"
	| "LineJoinMode"
	| "ResamplerMode"
	| "ScaleType"
	| "SortOrder"
	| "StrokeSizingMode"
	| "TextTruncate"
	| "TextXAlignment"
	| "TextYAlignment"
	| "VerticalAlignment"
	| "UIFlexMode"
	| "ItemLineAlignment"
--[=[
	Representation of all named types in CatWeb.
]=]
export type CatWebTypes =
	"boolean"
	| "number"
	| "string"
	| "Color3"
	| "table"
	| "UDim"
	| "UDim2"
	| "Vector2"
	| "Rect"
	| "ColorSequence"
	| "NumberSequence"
	| CatWebEnums

--[=[
	Indexer of CatWeb Enums with their value being their corresponding Roblox equivalent.
]=]
const EnumMap = table.freeze({
	ApplyStrokeMode = Enum.ApplyStrokeMode,
	BorderStrokePosition = Enum.BorderStrokePosition,
	FillDirection = Enum.FillDirection,
	Font = Enum.Font,
	FontStyle = Enum.FontStyle,
	FontWeight = Enum.FontWeight,
	HorizontalAlignment = Enum.HorizontalAlignment,
	LineJoinMode = Enum.LineJoinMode,
	ResamplerMode = Enum.ResamplerMode,
	ScaleType = Enum.ScaleType,
	SortOrder = Enum.SortOrder,
	StrokeSizingMode = Enum.StrokeSizingMode,
	TextTruncate = Enum.TextTruncate,
	TextXAlignment = Enum.TextXAlignment,
	TextYAlignment = Enum.TextYAlignment,
	VerticalAlignment = Enum.VerticalAlignment,
    UIFlexMode = Enum.UIFlexMode,
    ItemLineAlignment = Enum.ItemLineAlignment,
})

return table.freeze({EnumMap = EnumMap})
