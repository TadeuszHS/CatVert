--!strict

export type FontInfo = {
    Font: Font,
    Size: number,
}
export type FontView = typeof(table.freeze({} :: FontInfo))

const Fonts = table.freeze({
    Header = table.freeze({
        Font = Font.fromName("SourceSansPro", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        Size = 16,
    }),
    SubHeader = table.freeze({
        Font = Font.fromName("SourceSansPro", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        Size = 14,
    }),
    Body = table.freeze({
        Font = Font.fromName("SourceSansPro", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        Size = 14,
    }),
})

return Fonts
