--!strict

const Vide = require("../../packages/vide")
const Themes = require("../../app/Themes")
const Fonts = require("../style/Fonts")
const Types = require("../../util/Types")
const SubHeader = require("./SubHeader")

const create = Vide.create

type SourceOrValue<T> = Types.SourceOrValue<T>
type FontView = Fonts.FontInfo

type DerivedTheme = Themes.DerivedTheme

const theme = Themes.GetDerivedTheme()

const function TextBox(props: {
    read Title: SourceOrValue<string>,
    read Placeholder: SourceOrValue<string>,
    read FocusLost: (string) -> (),
    read LayoutOrder: SourceOrValue<number>?,
})
    return create "Frame" {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,

        SubHeader {
            Text = props.Title,
            LayoutOrder = 1,
        },

        create "TextBox" {
            Size = UDim2.new(1, 0, 0, 40),

            BackgroundColor3 = theme.BackdropColor,

            PlaceholderText = props.Placeholder,
            TextColor3 = theme.TextColor,
            TextSize = Fonts.Body.Size,
            FontFace = Fonts.Body.Font,

            LayoutOrder = 2,

            create "UICorner" {
                CornerRadius = UDim.new(0.5, 0)
            },
        },

        create "UIListLayout" {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }
    }
end

return TextBox
