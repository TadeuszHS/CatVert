--!strict

export type Lerp = {
    Color: Color3,
    Alpha: number,
}
export type LerpView = typeof(table.freeze({} :: Lerp))

const Lerp = table.freeze({
    None = table.freeze({
        Color = Color3.fromHex("000000"),
        Alpha = 0,
    }),
    Hover = table.freeze({
        Color = Color3.fromHex("000000"),
        Alpha = 0.175,
    }),
    Pressed = table.freeze({
        Color = Color3.fromHex("000000"),
        Alpha = 0.5,
    }),
    Selecting = table.freeze({
        Color = Color3.fromHex("000000"),
        Alpha = 0 ,--Placeholder
    }),
    Selected = table.freeze({
        Color = Color3.fromHex("000000"),
        Alpha = 0, --Placeholder
    })
})

return Lerp
