--!strict

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

return table.freeze({})
