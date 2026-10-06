--!nonstrict

const Vide = require("../../../packages/vide")
const Types = require("../../../util/Types")

const create = Vide.create

type SourceOrValue<T> = Types.SourceOrValue<T>

const function UIPadding(props: {
    read PaddingBottom: SourceOrValue<UDim>?,
    read PaddingLeft: SourceOrValue<UDim>?,
    read PaddingRight: SourceOrValue<UDim>?,
    read PaddingTop: SourceOrValue<UDim>?,
})
    return (create "UIPadding" {
        PaddingBottom = props.PaddingBottom,
        PaddingLeft = props.PaddingLeft,
        PaddingRight = props.PaddingRight,
        PaddingTop = props.PaddingTop,
    }) :: UIPadding
end

return UIPadding
