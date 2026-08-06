--!strict

const Vide = require("../packages/vide")
const Theme = require("../ui/style/Theme")
const Settings = require("./Settings")

const source = Vide.source
const derive = Vide.derive

type Source<T> = Vide.Source<T>
type Theme = Theme.Theme
type ThemeViewMap = Theme.ThemeViewMap
type Mode = Theme.Mode

export type ThemeView = Theme.ThemeView
export type ThemeLookup = Theme.ThemeLookup
export type ThemeChangedSignal = (ThemeView) -> ()

const Themes = {}

const mode: Mode = if Settings.IsDarkModeEnabled() then "Dark" else "Light"
const user_themes: ThemeViewMap = 
    Settings.GetSetting<<ThemeViewMap>>("UserThemes")
    or Settings.SetSetting("UserThemes", {} :: ThemeViewMap)
local current_theme: Source<ThemeView> = 
    source(table.freeze(Settings.GetSetting<<Theme>>("CurrentTheme"))
    or Settings.SetSetting("CurrentTheme", (Theme :: ThemeViewMap)[mode]))
const derived: () -> ThemeView = derive(current_theme)

for _, theme in user_themes do
    table.freeze(theme)
end

function Themes.GetTheme(): () -> ThemeView
    return derived
end

function Themes.SetUserTheme(theme: Theme): ()
    table.freeze(theme)
    user_themes[theme.index] = theme :: ThemeView

    if current_theme().index == theme.index then
        current_theme(theme :: ThemeView)
    end
end

return table.freeze(Themes)
