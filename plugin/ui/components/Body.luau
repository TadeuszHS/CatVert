--!strict

const Fonts = require("../style/Fonts")
const Types = require("../../util/Types")
const Text = require("./Text")

type SourceOrValue<T> = Types.SourceOrValue<T>

const function Body(props: {
    read Text: SourceOrValue<string>,
    read LayoutOrder: SourceOrValue<number>,
})
    table.freeze(props)
    
    return Text {
        Text = props.Text,
        Font = Fonts.Body,
        LayoutOrder = props.LayoutOrder,
    }
end

return Body
