# CatVert

CatVert is a Luau library that converts between Roblox Instances and CatWeb structured JSON.

## Usage

### Encoding: Roblox Instances to CatWeb JSON

Encoding of a container frame representing WebContent:

```lua
local CatVert = require(game.ReplicatedStorage.CatVert)

local webContentFrame: Frame = workspace.MyWebContent
local success, json = pcall(CatVert.JSONEncode, webContentFrame)
```

You can also encode a flat array of Instances representing an ElementGroup:

```lua
local elements: { Instance } = {
	workspace.Button1,
	workspace.Label1,
	workspace.Image1,
}

local success, json = pcall(CatVert.JSONEncode, elements)
```

### Decoding: CatWeb JSON to Roblox Instances

```lua
local CatVert = require(game.ReplicatedStorage.CatVert)

local json = "..."
local success, result = pcall(CatVert.JSONDecode, json)
```

## Plugin Branch

Work is being done on a proper Roblox Studio plugin for CatVert. Any help is appreciated.

## Contributing

Issues and pull reequests are welcome. Please report any inaccuracies in the library.
