--!strict

const Vide = require("../../packages/vide")
const Types = require("../../util/Types")
const UIFlexItem = require("./ext/UIFlexItem")

const create = Vide.create

type SourceOrValue<T> = Types.SourceOrValue<T>

const function FlexPadding(props: {
    read LayoutOrder: SourceOrValue<number>
})
    return create "Frame" {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        LayoutOrder = props.LayoutOrder,
        
        UIFlexItem {
            FlexMode = Enum.UIFlexMode.Fill,
        }
    }
end

return FlexPadding
