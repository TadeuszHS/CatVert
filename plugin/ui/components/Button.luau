--!strict

const Vide = require("../../packages/vide")
const Themes = require("../../app/Themes")
const Lerp = require("../style/Lerp")
const Types = require("../Types")

const create = Vide.create
const source = Vide.source
const derive = Vide.derive

type Source<T> = Vide.Source<T>
type SourceOrValue<T> = Types.SourceOrValue<T>

type ThemeLookup = Themes.ThemeLookup
type LerpView = Lerp.LerpView

const theme = Themes.GetTheme() :: () -> ThemeLookup

const function Button(props: {
    ButtonColor: "BackgroundColor" | "PrimaryColor" | SourceOrValue<Color3>,

    Text: SourceOrValue<string>,
    Activated: () -> (),
    LayoutOrder: SourceOrValue<number>,

    FontFace: SourceOrValue<Font>?,
    TextSize: SourceOrValue<number>?,
}, ...: Instance)
    const lerp: Source<LerpView> = source(Lerp.None)

    const bg_color: () -> Color3 = derive(function()
        const c = 
            if typeof(props.ButtonColor) == "Color3" then
                props.ButtonColor
            elseif typeof(props.ButtonColor) == "function" then
                props.ButtonColor()
            else theme()[props.ButtonColor]
        const l = lerp()
        
        return c:Lerp(l.Color, l.Alpha)
    end)

    return create "TextButton" {
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = bg_color,

        MouseEnter = function()
            lerp(Lerp.Hover)
        end,
        MouseLeave = function()
            lerp(Lerp.None)
        end,
        MouseButton1Down = function()
            lerp(Lerp.Pressed)
        end,
        MouseButton1Click = function()
            lerp(Lerp.Hover)
        end,

        Text = props.Text,
        Activated = props.Activated :: (InputObject, number) -> (),
        LayoutOrder = props.LayoutOrder,
        
        TextColor3 = derive(function()
            return theme().TextColor
        end),
        FontFace = props.FontFace,
        TextSize = props.TextSize,

        ...
    }
end

return Button
