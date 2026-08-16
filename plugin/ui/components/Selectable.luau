--!strict

const Vide = require("../../packages/vide")
const Themes = require("../../app/Themes")
const Lerp = require("../style/Lerp")
const SubHeader = require("./SubHeader")
const Types = require("../../util/Types")

const create = Vide.create
const source = Vide.source
const derive = Vide.derive

type Source<T> = Vide.Source<T>
type SourceOrValue<T> = Types.SourceOrValue<T>

type ThemeLookup = Themes.ThemeLookup
type LerpView = Lerp.LerpView

const theme = Themes.GetTheme() :: () -> ThemeLookup

const con_color = derive(function()
    return theme().TextColor
end)

const function Selectable(props: {
    read Value: Source<boolean>,
    read Image: SourceOrValue<string>,
    read Text: SourceOrValue<string>,
    read Selected: (boolean) -> () | () -> () | (boolean, InputObject, number) -> (),
    read LayoutOrder: SourceOrValue<number>,
})
    table.freeze(props)
    const lerp: Source<LerpView> = source(Lerp.None)

    return create "TextButton" {
        Size = UDim2.new(1, 0, 0, 35),
        AnchorPoint = Vector2.new(0.5, 0),
        Text = "",
        AutoButtonColor = false,
        BackgroundColor3 = function()
            const l: LerpView = 
                if props.Value() then
                    lerp(Lerp.Selected)
                else lerp()
            return theme().BackgroundColor:Lerp(l.Color, l.Alpha)
        end,

        MouseEnter = function()
            if not props.Value() then
                lerp(Lerp.Selecting)
            end
        end,
        MouseLeave = function()
            if not props.Value() then
                lerp(Lerp.None)
            end
        end,
        MouseButton1Down = function()
            lerp(Lerp.Selected)
        end,
        Activated = function(input_obj, click_count)
            (props.Selected :: (boolean, InputObject, number) -> ())(props.Value(), input_obj, click_count)
        end,
        
        LayoutOrder = props.LayoutOrder,
        
        create "ImageLabel" {
            Size = UDim2.fromOffset(16, 16),

            BackgroundTransparency = 1,

            Image = props.Image,
            ImageColor3 = con_color,
            ScaleType = Enum.ScaleType.Fit,

            LayoutOrder = 0,
        },
        SubHeader {
            Text = props.Text,
            LayoutOrder = 1,
        },
        create "UICorner" {},
        (create "UIPadding" {
            PaddingBottom = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
        }) :: UIPadding,
        create "UIListLayout" {
            Padding = UDim.new(0, 8),
            VerticalAlignment = Enum.VerticalAlignment.Center,
            FillDirection = Enum.FillDirection.Horizontal,
        },
    }
end

return Selectable
