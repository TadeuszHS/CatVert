--!strict

const Fonts = require("../style/Fonts")
const Types = require("../../util/Types")
const Text = require("./base/Text")

type SourceOrValue<T> = Types.SourceOrValue<T>

const function SubHeader(props: {
    read Text: SourceOrValue<string>,
    read LayoutOrder: SourceOrValue<number>,
})
    return Text {
        Text = props.Text,
        Font = Fonts.SubHeader,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        LayoutOrder = props.LayoutOrder,
    }
end

return SubHeader
