--!strict

const Vide = require("../../packages/vide")
const PushButton = require("./base/PushButton")
const Fonts = require("../style/Fonts")
const Types = require("../../util/Types")

const create = Vide.create

type Source<T> = Vide.Source<T>
export type SourceOrValue<T> = Types.SourceOrValue<T>

const function OvalButton(props: {
    read Text: SourceOrValue<string>,
    read Activated: () -> (),
    read LayoutOrder: SourceOrValue<number>,
})
    return PushButton({
        ButtonColor = "PrimaryColor",

        Text = props.Text,
        FontFace = Fonts.Header.Font,
        TextSize = Fonts.Header.Size,
        TextColor = Color3.fromHex("ffffff"),

        Activated = props.Activated,

        LayoutOrder = props.LayoutOrder,
    },  
        create "UICorner" {
            CornerRadius = UDim.new(0.5, 0),
        }
    )
end

return OvalButton
