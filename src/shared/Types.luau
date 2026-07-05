export type JSONUnknown = string | number | boolean | nil | JSONTable
export type JSONTable = { [string | number]: JSONUnknown }

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
