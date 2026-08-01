--!strict

--[=[
	Representation of all possible types that can be decoded by `HttpService:JSONDecode`.
]=]
export type JSONUnknown = string | number | boolean | nil | JSONTable
--[=[
	Representation of all possible tables types that can be decoded by `HttpService:JSONDecode`.
]=]
export type JSONTable = { [string | number]: JSONUnknown }

--[=[
	Representation of non creatable helper Element Classes.
]=]
export type AbstractElementClassNames =
	"WebContent"
	| "Root"
	| "Gui"
	| "GuiButton"
	| "Text"
	| "Image"
	| "LinkButton"
	| "GridStyle"
--[=[
	Representation of all real CatWeb Element Classes.
]=]
export type ElementClassNames =
	"Folder"
	| "Frame"
	| "ImageLabel"
	| "ImageButton"
	| "ImageButton?link"
	| "TextLabel"
	| "TextBox"
	| "TextButton"
	| "TextButton?link"
	| "TextButton?donation"
	| "TextButton?transfer"
	| "TextButton?avataritem"
	| "ScrollingFrame"
	| "UIStroke"
	| "UICorner"
	| "UIListLayout"
	| "UIGridLayout"
	| "UIAspectRatioConstraint"
	| "UISizeConstraint"
	| "UIGradient"
	| "UIPadding"
	| "UIFlexItem"
	| "script"

--[=[
	Utility type to represent an Element with string indexed properties of a `JSONUnknown` type.
]=]
export type UnknownElement = RootAbstractElement & {
	[string]: JSONUnknown,
}

--[=[
	CatWeb exports in two distinct structures which are:
		* WebContent
		* ElementGroup
]=]
export type StructureType = "WebContent" | "ElementGroup"
--[=[
	Represents a Page in CatWeb.
	@since 1.2.0
]=]
export type WebContentAbstractElement = {
	description: JSONUnknown,
	favicon: JSONUnknown,
	thumbnail_id: JSONUnknown,
	webcontent: JSONUnknown,
	title: JSONUnknown,
	background: JSONUnknown,
	thumbanil: JSONUnknown,
}
--[=[
	Represents an array of Elements in CatWeb
	@since 1.2.0
]=]
export type ElementGroup = { UnknownElement }

--[=[
	Abstract JSON Element for all CatWeb Elements.
	@since 1.2.0
]=]
export type RootAbstractElement = {
	alias: JSONUnknown,
	class: JSONUnknown,
	children: JSONUnknown,
	globalid: JSONUnknown,
}
--[=[
	Abstract JSON Element for all CatWeb Gui Elements.
	@since 1.2.0
]=]
export type GuiAbstractElement = {
	anchor: JSONUnknown,
	background_color: JSONUnknown,
	background_transparency: JSONUnknown,
	canvas: JSONUnknown,
	position: JSONUnknown,
	rotation: JSONUnknown,
	size: JSONUnknown,
	height: JSONUnknown,
	width: JSONUnknown,
	tooltip: JSONUnknown,
	visible: JSONUnknown,
	z_index: JSONUnknown,
}
--[=[
	Abstract JSON Element for all CatWeb Text Elements.
	@since 1.2.0
]=]
export type TextAbstractElement = GuiAbstractElement & {
	align_x: JSONUnknown,
	align_y: JSONUnknown,
	font: JSONUnknown,
	font_color: JSONUnknown,
	font_size: JSONUnknown,
	font_style: JSONUnknown,
	font_transparency: JSONUnknown,
	font_weight: JSONUnknown,
	line_height: JSONUnknown,
	rich: JSONUnknown,
	text: JSONUnknown,
	truncate: JSONUnknown,
	wrap: JSONUnknown,
}
--[=[
	Abstract JSON Element for all CatWeb Image Elements.
	@since 1.2.0
]=]
export type ImageAbstractElement = GuiAbstractElement & {
	image: JSONUnknown,
	image_color: JSONUnknown,
	image_id: JSONUnknown,
	image_transparency: JSONUnknown,
	resample_mode: JSONUnknown,
	scale_type: JSONUnknown,
	tile_size: JSONUnknown,
	slice_center: JSONUnknown,
	slice_scale: JSONUnknown,
}
--[=[
	Abstract JSON Element for all CatWeb Button Elements.
	@since 1.2.0
]=]
export type GuiButtonAbstractElement = GuiAbstractElement & {
	auto_color: JSONUnknown,
}
--[=[
	Abstract JSON Element for all CatWeb Link Elements.
	@since 1.2.0
]=]
export type LinkButtonAbstractElement = GuiButtonAbstractElement & {
	href: JSONUnknown,
	new_tab: JSONUnknown,
}
--[=[
	Abstract JSON Element for all CatWeb Grid Styling Elements.
	@since 1.3.0
]=]
export type GridStyleAbstractElement = RootAbstractElement & {
	alignment_horizontal: JSONUnknown,
	alignment_vertical: JSONUnknown,
	sort: JSONUnknown,
}

--[=[
	CatWeb Frame Element.
	@since 1.2.0
]=]
export type FrameElement = GuiAbstractElement
--[=[
	CatWeb ScrollableFrame Element.
	@since 1.3.0
]=]
export type ScrollingFrameElement = GuiAbstractElement & {
	canvassize: JSONUnknown,
	scrollbar_color: JSONUnknown,
	scrollbar_thickness: JSONUnknown,
	scrollbar_transparency: JSONUnknown,
}
--[=[
	CatWeb Text Element.
	@since 1.2.0
]=]
export type TextLabelElement = TextAbstractElement
--[=[
	CatWeb Input Element.
	@since 1.2.0
]=]
export type TextBoxElement = TextAbstractElement & {
	editable: JSONUnknown,
	multiline: JSONUnknown,
	placeholder: JSONUnknown,
	placeholder_color: JSONUnknown,
}
--[=[
	CatWeb Button Element.
	@since 1.2.0
]=]
export type TextButtonElement = TextAbstractElement & GuiButtonAbstractElement
--[=[
	CatWeb Link Element.
	@since 1.2.0
]=]
export type LinkButtonElement = TextAbstractElement & LinkButtonAbstractElement
--[=[
	CatWeb Donation Element.
	@deprecated As of 2.17.3.0 due to
	[Roblox updates](https://devforum.roblox.com/t/disabling-cross-game-sales-of-passes-and-dev-products-and-introducing-the-transfers-api/4618396)
	in favor of the Transfers API, use TransferElement or AvatarItemElement instead.
	@since 1.2.0
]=]
export type DonationButtonElement = TextButtonElement & {
	product: JSONUnknown,
	product_type: JSONUnknown,
	thanks_href: JSONUnknown,
}
--[=[
	CatWeb Transfer Element.
	@since 2.17.3.0
]=]
export type TransferButtonElement = TextButtonElement & {
	robux_amount: JSONUnknown,
	transfer_id: JSONUnknown,
}
--[=[
	CatWeb Avatar Item Element.
	@since 2.17.3.0
]=]
export type AvatarItemButtonElement = TextButtonElement & {
	product: JSONUnknown,
	product_type: JSONUnknown,
}
--[=[
	CatWeb Image Element.
	@since 1.2.0
]=]
export type ImageLabelElement = ImageAbstractElement
--[=[
	CatWeb Image Button Element.
	@since 2.18.0.0
]=]
export type ImageButtonElement = ImageAbstractElement & GuiButtonAbstractElement
--[=[
	CatWeb Image Link Element.
	@since 2.18.0.0
]=]
export type ImageLinkButtonElement = ImageAbstractElement & LinkButtonAbstractElement
--[=[
	CatWeb Folder Element.
	@since 2.8.0
]=]
export type FolderElement = RootAbstractElement

--[=[
	CatWeb AspectRatio Element.
	@since 1.7.0
]=]
export type UIAspectRatioConstraintElement = RootAbstractElement & {
	ratio: JSONUnknown,
}
--[=[
	CatWeb Constraint Element.
	@since 1.7.0
]=]
export type UISizeConstraintElement = RootAbstractElement & {
	max_size: JSONUnknown,
	min_size: JSONUnknown,
}
--[=[
	CatWeb Corner Element.
	@since 1.3.0
]=]
export type UICornerElement = RootAbstractElement & {
	radius: JSONUnknown,
}
--[=[
	CatWeb Gradient Element.
	@since 2.10.0
]=]
export type UIGradientElement = RootAbstractElement & {
	gradient_color: JSONUnknown,
	gradient_offset: JSONUnknown,
	gradient_transparency: JSONUnknown,
	rotation: JSONUnknown,
}
--[=[
	CatWeb Grid Element.
	@since 1.3.0
]=]
export type UIGridLayoutElement = GridStyleAbstractElement & {
	padding: JSONUnknown,
	size: JSONUnknown,
}
--[=[
	CatWeb List Element.
	@since 1.3.0
]=]
export type UIListLayoutElement = GridStyleAbstractElement & {
	direction: JSONUnknown,
	padding: JSONUnknown,
	wrap_list: JSONUnknown,
}
--[=[
	CatWeb Padding Element.
	@since 1.2.0
]=]
export type UIPaddingElement = RootAbstractElement & {
	bottom: JSONUnknown,
	left: JSONUnknown,
	right: JSONUnknown,
	top: JSONUnknown,
}
--[=[
	CatWeb Outline Element.
	@since 1.3.0
]=]
export type UIStrokeElement = RootAbstractElement & {
	stroke_color: JSONUnknown,
	stroke_mode: JSONUnknown,
	stroke_offset: JSONUnknown,
	stroke_position: JSONUnknown,
	stroke_sizing_mode: JSONUnknown,
	stroke_thickness: JSONUnknown,
	stroke_transparency: JSONUnknown,
	stroke_type: JSONUnknown,
	z_index: JSONUnknown,
}
--[=[
	CatWeb Flex Item Element.
	@since 2.18.0.0
]=]
export type UIFlexItemElement = RootAbstractElement & {
	flex_mode: JSONUnknown,
	alignment_item_line: JSONUnknown,
}

return table.freeze({})
