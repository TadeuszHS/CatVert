--!strict

const Vide = require("../../packages/vide")

const create = Vide.create

const function Page(...: Instance)
    return create "ScrollingFrame" {
        Size = UDim2.new(1, -30, 1, -50),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Position = UDim2.new(0.5, 0, 1, -15),
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        
        create "UIListLayout" {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
        },

        ...
    }
end

return Page
