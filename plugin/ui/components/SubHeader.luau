--!strict

const Fonts = require("../style/Fonts")
const Types = require("../../util/Types")
const Text = require("./Text")

type SourceOrValue<T> = Types.SourceOrValue<T>

const function SubHeader(props: {
    read Text: SourceOrValue<string>,
    read LayoutOrder: SourceOrValue<number>,
})
    table.freeze(props)
    
    return Text {
        Text = props.Text,
        Font = Fonts.SubHeader,
        LayoutOrder = props.LayoutOrder,
    }
end

return SubHeader
