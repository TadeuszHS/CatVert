--!strict

const Decoder = require("./decoder/Decoder")
const Encoder = require("./encoder/Encoder")

--[=[
	Library entry point for Catvert.

	@class CatVert
]=]
const CatVert = {}

--[=[
	Encodes a Roblox Instance Frame that represents WebContent or an array of 
	Roblox Instances representing an ElementGroup into CatWeb structured JSON.

	@within CatVert
	@error "Expected to encode Frame as WebContent"
	@error "Expected to encode Frame | { Instance }"
	@error "HttpService failed to encode JSON"
	@param data Frame | { Instance }
	@return string?
]=]
function CatVert.JSONEncode(data: Frame | { Instance }): string?
	return Encoder.encodeJSON(data)
end

--[=[
	Decodes a string containing CatWeb structured JSON into a Frame (WebContent) or array of Instances (Element Group).

	@within CatVert
	@error "HttpService failed to decode JSON, this is likely due to a syntax error"
	@error "Expected to decode table"
	@error "Unable to determine StructureType"
	@param json string
	@return Frame | { Instance }
]=]
function CatVert.JSONDecode(json: string): (Frame | { Instance })?
	return Decoder.decodeJSON(json)
end

return table.freeze(CatVert)
