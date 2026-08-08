--!strict

const Vide = require("../../packages/vide")
const Button = require("./Button")
const Fonts = require("../style/Fonts")
const Types = require("../Types")

const create = Vide.create

type Source<T> = Vide.Source<T>
export type SourceOrValue<T> = Types.SourceOrValue<T>

const function OvalButton(props: {
    Text: SourceOrValue<string>,
    Activated: () -> (),
    LayoutOrder: SourceOrValue<number>,
})
    return Button({
        ButtonColor = "PrimaryColor",

        Text = props.Text,
        Activated = props.Activated,
        LayoutOrder = props.LayoutOrder,

        FontFace = Fonts.Header.Font,
        TextSize = Fonts.Header.Size,
    },  
        create "UICorner" {
            CornerRadius = UDim.new(0.5, 0),
        }
    )
end

return OvalButton
