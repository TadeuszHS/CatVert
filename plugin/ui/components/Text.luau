--!strict

const Vide = require("../../packages/vide")
const Themes = require("../../app/Themes")
const Fonts = require("../style/Fonts")
const Types = require("../../util/Types")

const create = Vide.create

type SourceOrValue<T> = Types.SourceOrValue<T>
type ThemeLookup = Themes.ThemeLookup
type FontView = Fonts.FontView

const theme = Themes.GetTheme() :: () -> ThemeLookup

const function Text(props: {
    read Text: SourceOrValue<string>,
    read Font: FontView,
    read LayoutOrder: SourceOrValue<number>,
})
    table.freeze(props)

    return create "TextLabel" {
        AnchorPoint = Vector2.new(0.5, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundTransparency = 1,
        TextColor3 = theme().TextColor,
        FontFace = props.Font.Font,
        TextSize = props.Font.Size,

        LayoutOrder = props.LayoutOrder,
        Text = props.Text,
    }
end

return Text
