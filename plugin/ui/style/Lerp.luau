--!strict

const Vide = require("../../packages/vide")
const Themes = require("../../app/Themes")

const derive = Vide.derive

export type Lerp = {
    Color: () -> Color3,
    Alpha: number,
}
export type LerpMap = { [string]: Lerp }

const theme = Themes.GetDerivedTheme()

const mode_color = derive(function()
    return if Themes.IsThemeDark(theme.Get()) then
        Color3.fromHex("ffffff")
        else Color3.fromHex("000000")
end)

const Lerp = {
    None = {
        Color = function() 
            return Color3.fromHex("ffffff")
        end,
        Alpha = 0,
    },
    Hover = {
        Color = function()
            return Color3.fromHex("000000")
        end,
        Alpha = 0.175,
    },
    Pressed = {
        Color = function()
            return Color3.fromHex("000000")
        end,
        Alpha = 0.5,
    },
    Selecting = {
        Color = mode_color,
        Alpha = 0.05,
    },
    Selected = {
        Color = mode_color,
        Alpha = 0.1,
    },
    Illuminate = {
        Color = mode_color,
        Alpha = 0.745,
    },
    Faded = {
        Color = mode_color,
        Alpha = 0,
    },
}

return Lerp
