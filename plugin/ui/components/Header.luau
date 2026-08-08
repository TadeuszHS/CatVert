--!strict

const Vide = require("../../packages/vide")
const Themes = require("../../app/Themes")
const Fonts = require("../style/Fonts")
const Types = require("../Types")

const create = Vide.create

type SourceOrValue<T> = Types.SourceOrValue<T>
type ThemeLookup = Themes.ThemeLookup

const theme = Themes.GetTheme() :: () -> ThemeLookup

const function Header(props: {
    Text: SourceOrValue<string>,
    LayoutOrder: SourceOrValue<number>,
})
    return create "TextLabel" {
        AnchorPoint = Vector2.new(0.5, 0),
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        TextColor3 = theme().TextColor,
        FontFace = Fonts.Header.Font,
        TextSize = Fonts.Header.Size,

        LayoutOrder = props.LayoutOrder,
        Text = props.Text,
    }
end

return Header
