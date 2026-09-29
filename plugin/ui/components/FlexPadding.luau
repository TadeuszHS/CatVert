--!strict

const Vide = require("../../packages/vide")
const Types = require("../../util/Types")

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
        
        (create "UIFlexItem" {
            FlexMode = Enum.UIFlexMode.Fill,
        }) :: UIFlexItem,
    }
end

return FlexPadding
