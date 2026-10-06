--!strict

export type FontInfo = {
    Font: Font,
    Size: number,
}
export type FontInfoMap = { [string]: FontInfo }

const Fonts: FontInfoMap = {
    Header = {
        Font = Font.fromName("SourceSansPro", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        Size = 16,
    },
    SubHeader = {
        Font = Font.fromName("SourceSansPro", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        Size = 14,
    },
    Body = {
        Font = Font.fromName("SourceSansPro", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        Size = 14,
    },
}

return Fonts
