--!strict

const Vide = require("../../../packages/vide")
const Themes = require("../../../app/Themes")
const Lerp = require("../../style/Lerp")
const Types = require("../../../util/Types")

const create = Vide.create
const source = Vide.source

type Source<T> = Vide.Source<T>
type SourceOrValue<T> = Types.SourceOrValue<T>
type Theme = Themes.Theme
type Lerp = Lerp.Lerp

const theme = Themes.GetDerivedTheme()

const function PushButton(props: {
    read Size: SourceOrValue<UDim2>?,
    read AnchorPoint: SourceOrValue<Vector2>?,

    read ButtonColor: "BackgroundColor" | "PrimaryColor" | SourceOrValue<Color3>,
    read BackgroundTransparency: SourceOrValue<number>?,

    read Text: SourceOrValue<string>,
    read FontFace: SourceOrValue<Font>?,
    read TextSize: SourceOrValue<number>?,
    read TextColor: SourceOrValue<Color3>?,

    read Activated: () -> () | (InputObject, number) -> (),

    read LayoutOrder: SourceOrValue<number>,
}, ...: Instance)
    const lerp: Source<Lerp> = source(Lerp.None)

    return create "TextButton" {
        Size = props.Size or UDim2.new(1, 0, 0, 40),
        AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0),

        Text = props.Text,
        FontFace = props.FontFace,
        TextSize = props.TextSize,
        TextColor3 = props.TextColor or theme.TextColor,

        AutoButtonColor = false,
        BackgroundColor3 = function()
            const c = 
                if typeof(props.ButtonColor) == "Color3" then
                    props.ButtonColor
                elseif typeof(props.ButtonColor) == "function" then
                    props.ButtonColor()
                else theme.Get()[props.ButtonColor]
            const l = lerp()
            
            return c:Lerp(l.Color(), l.Alpha)
        end,

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

        Activated = props.Activated :: (InputObject, number) -> (),

        LayoutOrder = props.LayoutOrder,

        ...
    }
end

return PushButton
