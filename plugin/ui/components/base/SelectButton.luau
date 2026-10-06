--!strict

const Vide = require("../../../packages/vide")
const Themes = require("../../../app/Themes")
const Lerp = require("../../style/Lerp")
const Types = require("../../../util/Types")

const create = Vide.create
const source = Vide.source

type Source<T> = Vide.Source<T>
type SourceOrValue<T> = Types.SourceOrValue<T>

type ThemeLookup = Themes.DerivedTheme
type Lerp = Lerp.Lerp

const theme = Themes.GetDerivedTheme()

const function SelectButton(props: {
    read Size: SourceOrValue<UDim2>?,
    read AnchorPoint: SourceOrValue<Vector2>?,

    read ButtonColor: "BackgroundColor" | "PrimaryColor" | SourceOrValue<Color3>,
    read BackgroundTransparency: SourceOrValue<number>?,

    read Text: SourceOrValue<string>,
    read FontFace: SourceOrValue<Font>?,
    read TextSize: SourceOrValue<number>?,

    read Value: Source<boolean>,
    read Selected: (boolean) -> () | () -> () | (boolean, InputObject, number) -> (),

    read LayoutOrder: SourceOrValue<number>,
}, ...: Instance)
    const lerp: Source<Lerp> = source(Lerp.None)

    return create "TextButton" {
        Size = props.Size or UDim2.new(1, 0, 0, 40),
        AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0),
        
        Text = props.Text,
        FontFace = props.FontFace,
        TextSize = props.TextSize,
        TextColor3 = theme.TextColor,

        AutoButtonColor = false,

        MouseEnter = function()
            if not props.Value() then
                lerp(Lerp.Illuminate)
            end
        end,
        MouseLeave = function()
            if not props.Value() then
                lerp(Lerp.None)
            end
        end,
        MouseButton1Down = function()
            lerp(Lerp.Selected)
        end,

        Activated = function(input_obj, click_count)
            (props.Selected :: (boolean, InputObject, number) -> ())(props.Value(), input_obj, click_count)
        end,

        ...
    }
end

return SelectButton
