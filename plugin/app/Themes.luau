--!strict

const Vide = require("../packages/vide")
const Theme = require("../ui/style/Theme")
const Settings = require("./Settings")

const source = Vide.source
const derive = Vide.derive

type Source<T> = Vide.Source<T>

export type Theme = Theme.Theme
export type ThemeLookup = Theme.ThemeLookup
type ThemeMap = Theme.ThemeMap
type Mode = Theme.Mode
export type DerivedTheme = {
    index: () -> string,
    BackdropColor: () -> Color3,
    BackgroundColor: () -> Color3,
    SurfaceColor: () -> Color3,
    PrimaryColor: () -> Color3,
    TextColor: () -> Color3,
    Get: () -> ThemeLookup
}

const Themes = {}

local current_theme: Source<Theme>
local derived_theme: () -> ThemeLookup
local derived_mode: () -> Mode
local _studio_theme_reactor: RBXScriptConnection

const function initalize()
    current_theme = source(
        Settings.GetSetting<<Theme>>("CurrentTheme")
        or Settings.SetSetting("CurrentTheme", Theme[Themes.GetStudioThemeMode()])
    )
    derived_theme = derive(function()
        return current_theme() :: ThemeLookup
    end)
    derived_mode = derive(function()
        return if Themes.IsThemeDark(current_theme())
            then "Dark" :: Mode
            else "Light" :: Mode
    end)
    _studio_theme_reactor = Settings.GetStudioSettings().ThemeChanged:Connect(function()
        const theme_index = current_theme().index
        if theme_index ~= "Light" and theme_index ~= "Dark" then
            return
        end

        Themes.SetTheme(Theme[Themes.GetStudioThemeMode()])
    end)
end

function Themes.IsColorDark(color: Color3): boolean
    return (color.R * 0.299 + color.G * 0.587 + color.B * 0.114) < 0.5
end

function Themes.IsThemeDark(theme: (Theme | ThemeLookup)?): boolean
    return if theme 
        then Themes.IsColorDark(theme.BackgroundColor)
        else Themes.IsColorDark(current_theme().BackgroundColor)
end

function Themes.GetStudioThemeMode(): Mode
    const studio_theme = Settings.GetStudioSettings().Theme

    return if Themes.IsColorDark(studio_theme:GetColor(Enum.StudioStyleGuideColor.MainBackground))
        then "Dark"
        else "Light"
end

function Themes.GetDerivedTheme(): DerivedTheme
    return {
        index = function()
            return derived_theme().index
        end,
        BackdropColor = function()
            return derived_theme().BackdropColor
        end,
        BackgroundColor = function()
            return derived_theme().BackgroundColor
        end,
        SurfaceColor = function()
            return derived_theme().SurfaceColor
        end,
        PrimaryColor = function()
            return derived_theme().PrimaryColor
        end,
        TextColor = function()
            return derived_theme().TextColor
        end,
        Get = function()
            return derived_theme()
        end
    }
end

function Themes.GetMode(): () -> Mode
    return derived_mode
end

function Themes.SetTheme(theme: Theme): ()
    if current_theme().index ~= theme.index then
        Settings.SetSetting("CurrentTheme", current_theme(theme))
    end
end

initalize()

return table.freeze(Themes)
