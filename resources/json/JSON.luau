--!strict

const dir: Folder = (script.Parent :: any).raw
const JSON: { [string]: string } = {}

for _, v in dir:GetChildren() do
    if v:IsA("StringValue") then
        JSON[v.Name] = v.Value
    end
end

return table.freeze(JSON)
