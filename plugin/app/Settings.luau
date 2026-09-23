--!strict

const Settings = {}
const data_key = "CatVert"
local plugin: Plugin
local data: { [string]: unknown } = {}

function Settings.initialize(plgn: Plugin): ()
    plugin = plgn
    data = plugin:GetSetting(data_key)
end

function Settings.Save(): ()
    plugin:SetSetting(data_key, data)
end

function Settings.GetSetting<T>(key: string): T
    return data[key]
end

function Settings.GetStudioTheme(): StudioTheme
    return settings().Studio.Theme
end

function Settings.SetSetting<T>(key: string, value: T): T 
    data[key] = value
    return value
end

function Settings.SetSettingAndSave<T>(key: string, value: T): T
    Settings.SetSetting(key, value)
    Settings.Save()
    return value
end

return table.freeze(Settings)
