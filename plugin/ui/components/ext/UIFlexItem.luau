--!nonstrict

const Vide = require("../../../packages/vide")
const Types = require("../../../util/Types")

const create = Vide.create

type SourceOrValue<T> = Types.SourceOrValue<T>

const function UIFlexItem(props: {
    read FlexMode: SourceOrValue<Enum.UIFlexMode>?,
    read ItemLineAlignment: SourceOrValue<Enum.ItemLineAlignment>?,
    read GrowRatio: SourceOrValue<number>?,
    read ShrinkRatio: SourceOrValue<number>?,
})
    return (create "UIFlexItem" {
        FlexMode = props.FlexMode,
        ItemLineAlignment = props.ItemLineAlignment,
        GrowRatio = props.GrowRatio,
        ShrinkRatio = props.ShrinkRatio,
    }) :: UIFlexItem
end

return UIFlexItem
