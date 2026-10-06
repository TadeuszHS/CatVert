--!strict

const Vide = require("../../../packages/vide")
const Themes = require("../../../app/Themes")
const Fonts = require("../../style/Fonts")
const Types = require("../../../util/Types")

const create = Vide.create

type SourceOrValue<T> = Types.SourceOrValue<T>
type ThemeLookup = Themes.DerivedTheme
type FontInfo = Fonts.FontInfo

const theme = Themes.GetDerivedTheme()

const function Text(props: {
    read Text: SourceOrValue<string>,
    read Font: FontInfo,
    read TextXAlignment: Enum.TextXAlignment,
    read TextYAlignment: Enum.TextYAlignment,
    read LayoutOrder: SourceOrValue<number>,
})
    return create "TextLabel" {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        Text = props.Text,
        TextColor3 = theme.TextColor,
        TextXAlignment = props.TextXAlignment,
        TextYAlignment = props.TextYAlignment,
        FontFace = props.Font.Font,
        TextSize = props.Font.Size,
        LayoutOrder = props.LayoutOrder,
    }
end

return Text
