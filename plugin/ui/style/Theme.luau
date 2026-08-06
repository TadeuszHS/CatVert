--!strict

export type Theme = {
	index: string,
	BackgroundColor: Color3,
	PrimaryColor: Color3,
	TextColor: Color3,
}
export type ThemeLookup = typeof(table.freeze({} :: {
	["BackgroundColor" | "PrimaryColor" | "TextColor"]: Color3
}))
export type ThemeView = typeof(table.freeze({} :: Theme))
export type ThemeViewMap = { [string]: ThemeView }
export type Mode = "Dark" | "Light"

const Theme = table.freeze({
	Dark = table.freeze({
		index = "Dark",
		BackgroundColor = Color3.fromHex("323232"),
		PrimaryColor = Color3.fromHex("2a91ff"),
		TextColor = Color3.fromHex("ffffff"),
	}),
})

return Theme
