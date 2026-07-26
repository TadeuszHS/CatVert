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
	description: string?,
	favicon: string?,
	thumbnail_id: string?,
	webcontent: { UnknownElement }?,
	title: string?,
	background: string?,
	thumbanil: string?,
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
	alias: string?,
	class: string,
	children: { UnknownElement }?,
	globalid: string,
}
--[=[
	Abstract JSON Element for all CatWeb Gui Elements.
	@since 1.2.0
]=]
export type GuiAbstractElement = {
	anchor: string?,
	background_color: string?,
	background_transparency: string?,
	canvas: string?,
	position: string?,
	rotation: string?,
	size: string?,
	height: string?,
	width: string?,
	tooltip: string?,
	visible: string?,
	z_index: string?,
}
--[=[
	Abstract JSON Element for all CatWeb Text Elements.
	@since 1.2.0
]=]
export type TextAbstractElement = GuiAbstractElement & {
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
export type ImageAbstractElement = GuiAbstractElement & {
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
	Abstract JSON Element for all CatWeb Button Elements.
	@since 1.2.0
]=]
export type GuiButtonAbstractElement = GuiAbstractElement & {
	auto_color: string?,
}
--[=[
	Abstract JSON Element for all CatWeb Link Elements.
	@since 1.2.0
]=]
export type LinkButtonAbstractElement = GuiButtonAbstractElement & {
	href: string?,
	new_tab: string?,
}
--[=[
	Abstract JSON Element for all CatWeb Grid Styling Elements.
	@since 1.3.0
]=]
export type GridStyleAbstractElement = RootAbstractElement & {
	alignment_horizontal: string?,
	alignment_vertical: string?,
	sort: string?,
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
	canvassize: string?,
	scrollbar_color: string?,
	scrollbar_thickness: string?,
	scrollbar_transparency: string?,
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
	editable: string?,
	multiline: string?,
	placeholder: string?,
	placeholder_color: string?,
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
	product: string?,
	product_type: string?,
	thanks_href: string?,
}
--[=[
	CatWeb Transfer Element.
	@since 2.17.3.0
]=]
export type TransferButtonElement = TextButtonElement & {
	robux_amount: string?,
	transfer_id: string?,
}
--[=[
	CatWeb Avatar Item Element.
	@since 2.17.3.0
]=]
export type AvatarItemButtonElement = TextButtonElement & {
	product: string?,
	product_type: string?,
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
	ratio: string?,
}
--[=[
	CatWeb Constraint Element.
	@since 1.7.0
]=]
export type UISizeConstraintElement = RootAbstractElement & {
	max_size: string?,
	min_size: string?,
}
--[=[
	CatWeb Corner Element.
	@since 1.3.0
]=]
export type UICornerElement = RootAbstractElement & {
	radius: string?,
}
--[=[
	CatWeb Gradient Element.
	@since 2.10.0
]=]
export type UIGradientElement = RootAbstractElement & {
	gradient_color: string?,
	gradient_offset: string?,
	gradient_transparency: string?,
	rotation: string?,
}
--[=[
	CatWeb Grid Element.
	@since 1.3.0
]=]
export type UIGridLayoutElement = GridStyleAbstractElement & {
	padding: string?,
	size: string?,
}
--[=[
	CatWeb List Element.
	@since 1.3.0
]=]
export type UIListLayoutElement = GridStyleAbstractElement & {
	direction: string?,
	padding: string?,
	wrap_list: string?,
}
--[=[
	CatWeb Padding Element.
	@since 1.2.0
]=]
export type UIPaddingElement = RootAbstractElement & {
	bottom: string?,
	left: string?,
	right: string?,
	top: string?,
}
--[=[
	CatWeb Outline Element.
	@since 1.3.0
]=]
export type UIStrokeElement = RootAbstractElement & {
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
export type UIFlexItemElement = RootAbstractElement & {
	flex_mode: string?,
	alignment_item_line: string?,
}

return table.freeze({})
