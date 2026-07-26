--!strict

const HttpService = game:GetService("HttpService")
const Logger = require("../util/Logger")
const Types = require("../data/Types")
const Structure = require("../data/Structure")
const EnumMap = require("../data/EnumMap")

type JSONUnknown = Structure.JSONUnknown
type JSONTable = Structure.JSONTable
type CatWebTypes = Types.CatWebTypes
type CatWebEnums = Types.CatWebEnums

--[=[
	Checks if the keypoint array is valid for being an argument of a sequence.

	Keypoints are only valid if they:
		* Have a minimum of two keypoints.
		* Have a maximum of twenty keypoints.
		* Have keypoints with 0 and 1 for time.
		* Keypoints in the array are ordered in non-descending time value order.
	
	@param t { ColorSequenceKeypoint} | { NumberSequenceKeypoint }
	@return boolean
]=]
const function isValidKeypointArray(t: { ColorSequenceKeypoint } | { NumberSequenceKeypoint }): boolean
	const size = #t

	if size < 2 or size > 21 then
		return false
	end

	if t[1].Time ~= 0 or t[size].Time ~= 1 then
		return false
	end

	for i = 2, size do
		if t[i].Time < t[i - 1].Time then
			return false
		end
	end

	return true
end

--[=[
	Decodes a JSON-encoded sequence to a two-dimensional array of strings.
	If decoding fails or the structure is incorrect, it will return nil.

	The returned value typically represents:
	```
	{
		{
			[1]: Value,
			[2]: Time,
		}
	}
	```
	@param j JSONUnknown
	@return { { string } }?
]=]
const function sequenceJSON(j: JSONUnknown): { { string } }?
	const success, decoded = pcall(function()
		return HttpService:JSONDecode(j :: any) :: { { string } }
	end)

	if not success or typeof(decoded) ~= "table" then
		Logger.event("Warn", "Expected to decode JSONTable from string")
		return nil
	end

	for i, keypoint in decoded do
		if typeof(i) ~= "number" then
			return nil
		elseif typeof(keypoint) ~= "table" then
			return nil
		end

		for k, x in keypoint do
			if typeof(k) ~= "number" then
				return nil
			elseif typeof(x) ~= "string" then
				return nil
			end
		end
	end

	return decoded
end

--[=[
	Decodes a JSON-encoded sequence into a typed sequence value.

	Parses each keypoint's value and time, validates the resulting array,
	and constructs the final sequence. If any keypoint is invalid or the
	array fails validation, it will return nil.

	@param v JSONUnknown
	@param parse (string) -> T?
	@param new_keypoint (time: number, value: T) -> K
	@param new_sequence ({ K }) -> S
	@return S?
]=]
const function decodeSequence<T, K, S>(
	v: JSONUnknown,
	decode: (string) -> T,
	new_keypoint: (time: number, value: T, ...any) -> K,
	new_sequence: ({ K }) -> S
): S?
	const decoded = sequenceJSON(v)
	if not decoded then
		return nil
	end

	const points = {}
	for i, point in decoded do
		const value = decode(point[1])
		const time = tonumber(point[2])
		if not value or not time then
			return nil
		end
		points[i] = new_keypoint(time, value)
	end

	if isValidKeypointArray(points) then
		return new_sequence(points)
	end
	return nil
end

--[=[
	Converts numbers separated by commas into a tuple of numbers.
	If tonumber fails on a value, that value will be nil.

	@param t JSONUnknown
	@return (...number?)
]=]
const function numberTuple(t: JSONUnknown): ...number?
	if typeof(t) ~= "string" then
		Logger.event("Warn", "Expected to decode Tuple<Number> from string")
		return
	end

	const values = t:split(",")
	const result: { number? } = {}
	for i, v in values do
		result[i] = tonumber(v)
	end
	return table.unpack(result)
end

--[=[
	Returns the EnumItem of the same name from the given Enum.
	If no match is found, it will return nil.

	@param item_name string
	@param of Enum
	@return EnumItem?
]=]
const function enumItem(item_name: JSONUnknown?, of: Enum): EnumItem?
	if typeof(item_name) ~= "string" then
		Logger.event("Warn", "Expected to decode EnumItem from string")
		return nil
	end

	for _, v in of:GetEnumItems() do
		if v.Name == item_name then
			return v
		end
	end

	Logger.event("Warn", "Unable to find EnumItem from string")
	return nil
end

const TypeDecoder = {}

--[=[
	Decodes a boolean from a JSONUnknown value.
	Returns true or false if represented as a string, otherwise nil.

	@param v JSONUnknown
	@return boolean
]=]
function TypeDecoder.boolean(v: JSONUnknown): boolean?
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	if typeof(v) ~= "string" then
		Logger.event("Warn", "Expected to decode boolean from string")
		return nil
	elseif v == "true" then
		return true
	elseif v == "false" then
		return false
	end

	Logger.event("Warn", "Expected value to be either \"true\" or \"false\"")
	return nil
end

--[=[
	Decodes a number from a JSONUnknown value.
	If the value cannot be converted, it will return nil.

	@param v JSONUnknown
	@return number?
]=]
function TypeDecoder.number(v: JSONUnknown): number?
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	if typeof(v) ~= "string" then
		Logger.event("Warn", "Expected to decode number from string")
		return nil
	end

	return tonumber(v)
end

--[=[
	Decodes a string from a JSONUnknown value via tostring.

	@param v JSONUnknown
	@return string
]=]
function TypeDecoder.string(v: JSONUnknown): string?
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	if typeof(v) ~= "string" then
		Logger.event("Warn", "Expected to decode string from string")
		return nil
	end

	return tostring(v)
end

--[=[
	Decodes a table from a JSONUnknown value.
	If the value is not a table, it will return nil.

	@param v JSONUnknown
	@return JSONTable?
]=]
function TypeDecoder.table(v: JSONUnknown): JSONTable?
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	if typeof(v) ~= "table" then
		Logger.event("Warn", "Expected to decode table from table")
		return nil
	end

	return v
end

--[=[
	Decodes a Color3 from a hex string.
	If the value is not a valid hex color, it will return nil.

	@param v JSONUnknown
	@return Color3?
]=]
function TypeDecoder.Color3(v: JSONUnknown): Color3?
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	if typeof(v) ~= "string" then
		Logger.event("Warn", "Expected to decode Color3 from string")
		return nil
	end

	const result = select(2, pcall(Color3.fromHex, v :: string))

	if not result then
		Logger.event("Warn", "Unable to decode to Color3")
	end

	return result
end

--[=[
	Decodes a Vector2 from a comma-separated string of numbers.

	@param v JSONUnknown
	@return Vector2
]=]
function TypeDecoder.Vector2(v: JSONUnknown): Vector2
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	const x, y = numberTuple(v)

	return Vector2.new(x, y)
end

--[=[
	Decodes a UDim from a comma-separated string of numbers.

	@param v JSONUnknown
	@return UDim
]=]
function TypeDecoder.UDim(v: JSONUnknown): UDim
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	const scale, offset = numberTuple(v)

	return UDim.new(scale, offset)
end

--[=[
	Decodes a UDim2 from a string matching the pattern `{x, y}, {x, y}`.

	@param v JSONUnknown
	@return UDim2
]=]
function TypeDecoder.UDim2(v: JSONUnknown): UDim2
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	if typeof(v) ~= "string" then
		Logger.event("Warn", "Expected to decode UDim2 from string")
		return UDim2.new()
	end

	const values = { v:match("{?%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*}?%s*,%s*{?%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*}?") }
	const result: { number } = {}
	for i, value in values do
		result[i] = TypeDecoder.number(value) or 0
	end

	const x_scale, x_offset, y_scale, y_offset = table.unpack(result)
	return UDim2.new(x_scale, x_offset, y_scale, y_offset)
end

--[=[
	Decodes a Rect from a comma-separated string of numbers.

	@param v JSONUnknown
	@return Rect
]=]
function TypeDecoder.Rect(v: JSONUnknown): Rect
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	const minX, minY, maxX, maxY = numberTuple(v)

	return Rect.new(minX :: number, minY :: number, maxX :: number, maxY :: number)
end

--[=[
	Decodes a ColorSequence from a JSON-encoded keypoint array.
	If the value is invalid or keypoints fail validation, it will return nil.

	@param v JSONUnknown
	@return ColorSequence?
]=]
function TypeDecoder.ColorSequence(v: JSONUnknown): ColorSequence?
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	return decodeSequence(v, TypeDecoder.Color3 :: (string) -> Color3, ColorSequenceKeypoint.new, ColorSequence.new)
end

--[=[
	Decodes a NumberSequence from a JSON-encoded keypoint array.
	If the value is invalid or keypoints fail validation, it will return nil.

	@param v JSONUnknown
	@return NumberSequence?
]=]
function TypeDecoder.NumberSequence(v: JSONUnknown): NumberSequence?
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	return decodeSequence(v, tonumber :: (string) -> number, NumberSequenceKeypoint.new, NumberSequence.new)
end

--[=[
	Decodes Enum.AutomaticSize from a JSON-encoded string.
	If the value is invalid, it will return nil.
	Enum.AutomaticSize.None has no representation in the encoded format, and is what nil can be inferred as.

	@param v JSONUnknown
	@return Enum.AutomaticSize?
]=]
function TypeDecoder.AutomaticSize(v: JSONUnknown): Enum.AutomaticSize?
	Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v)

	const decoded_size = TypeDecoder.string(v)

	if decoded_size == "auto" then
		return Enum.AutomaticSize.XY
	elseif decoded_size == "auto_x" then
		return Enum.AutomaticSize.X
	elseif decoded_size == "auto_y" then
		return Enum.AutomaticSize.Y
	end

	return nil
end

for name, enum in EnumMap :: { [CatWebEnums]: Enum } do
	TypeDecoder[name] = function(v: JSONUnknown?): EnumItem?
		Logger.withStatus("Decoding").withProcess("TypeConversion").withArgs(v, name, enum)

		return enumItem(v, enum)
	end
end

return table.freeze(TypeDecoder :: typeof(TypeDecoder))
