--!strict

const Decoder = require("./decoder/Decoder")
const Encoder = require("./encoder/Encoder")

const CatVert = {}

function CatVert.JSONEncode(data: Instance | { Instance }): string?
	return Encoder.encodeJSON(data)
end

function CatVert.JSONDecode(json: string): (Instance | { Instance })?
	return Decoder.decodeJSON(json)
end

return table.freeze(CatVert)
