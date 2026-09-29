--!strict

const Vide = require("./packages/vide")
const Themes = require("./app/Themes")
const Import = require("./ui/pages/Import")

const create = Vide.create

const App = {}

local plugin: Plugin

function App.initialize(plgn: Plugin)
    plugin = plgn

    const toolbar = plugin:CreateToolbar("CatVert")
    const button = toolbar:CreateButton("CatVert", "CatVert", "", "CatVert")
    const window = plugin:CreateDockWidgetPluginGuiAsync(
        "CatVert",
        DockWidgetPluginGuiInfo.new(
            Enum.InitialDockState.Float,
            false,
            false,
            500,
            500,
            100,
            100
        )
    )
    window.Name = "CatVert"


    button.Click:Connect(function()
        window.Enabled = not window.Enabled
    end)

    button.Enabled = true
end

return table.freeze(App)
