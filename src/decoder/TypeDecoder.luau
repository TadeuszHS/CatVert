--!strict

const HttpService = game:GetService("HttpService")
const Types = require("../shared/Types")
const EnumMap = require("../shared/EnumMap")

type JSONUnknown = Types.JSONUnknown
type JSONTable = Types.JSONTable
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
	if #t < 2 or #t > 21 then
		return false
	end

	if t[1].Time ~= 0 or t[#t].Time ~= 1 then
		return false
	end

	for i = 2, #t do
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
    @param newKeypoint (time: number, value: T) -> K
    @param newSequence ({ K }) -> S
    @return S?
]=]
const function decodeSequence<T, K, S>(
	v: JSONUnknown,
	parse: (string) -> T,
	newKeypoint: (time: number, value: T, ...any) -> K,
	newSequence: ({ K }) -> S
): S?
	const decoded = sequenceJSON(v)
	if not decoded then
		return nil
	end

	const points = {}
	for i, point in decoded do
		const value = parse(point[1])
		const time = tonumber(point[2])
		if not value or not time then
			return nil
		end
		points[i] = newKeypoint(time, value)
	end

	if isValidKeypointArray(points) then
		return newSequence(points)
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

    @param itemName string
    @param of Enum
    @return EnumItem?
]=]
const function enumItem(itemName: string, of: Enum): EnumItem?
	for _, v in of:GetEnumItems() do
		if v.Name == itemName then
			return v
		end
	end

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
	if typeof(v) ~= "string" then
		return nil
	end

	return if v == "true" then true elseif v == "false" then false else nil
end

--[=[
    Decodes a number from a JSONUnknown value.
    If the value cannot be converted, it will return nil.

    @param v JSONUnknown
    @return number?
]=]
function TypeDecoder.number(v: JSONUnknown): number?
	return tonumber(v)
end

--[=[
    Decodes a string from a JSONUnknown value via tostring.

    @param v JSONUnknown
    @return string
]=]
function TypeDecoder.string(v: JSONUnknown): string
	return tostring(v)
end

--[=[
    Decodes a table from a JSONUnknown value.
    If the value is not a table, it will return nil.

    @param v JSONUnknown
    @return JSONTable?
]=]
function TypeDecoder.table(v: JSONUnknown): JSONTable?
	if typeof(v) ~= "table" then
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
	return select(2, pcall(Color3.fromHex, v :: string))
end

--[=[
    Decodes a Vector2 from a comma-separated string of numbers.

    @param v JSONUnknown
    @return Vector2
]=]
function TypeDecoder.Vector2(v: JSONUnknown): Vector2
	const x, y = numberTuple(v)
	return Vector2.new(x, y)
end

--[=[
    Decodes a UDim from a comma-separated string of numbers.

    @param v JSONUnknown
    @return UDim
]=]
function TypeDecoder.UDim(v: JSONUnknown): UDim
	const scale, offset = numberTuple(v)
	return UDim.new(scale, offset)
end

--[=[
    Decodes a UDim2 from a string matching the pattern `{x, y}, {x, y}`.

    @param v JSONUnknown
    @return UDim2
]=]
function TypeDecoder.UDim2(v: JSONUnknown): UDim2
	if typeof(v) ~= "string" then
		return UDim2.new()
	end

	const values = { v:match("{?%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*}?%s*,%s*{?%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*}?") }
	const result: { number } = {}
	for i, value in values do
		result[i] = tonumber(value) or 0
	end

	const xScale, xOffset, yScale, yOffset = table.unpack(result)
	return UDim2.new(xScale, xOffset, yScale, yOffset)
end

--[=[
    Decodes a Rect from a comma-separated string of numbers.

    @param v JSONUnknown
    @return Rect
]=]
function TypeDecoder.Rect(v: JSONUnknown): Rect
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
	return decodeSequence(v, TypeDecoder.Color3 :: (string) -> Color3, ColorSequenceKeypoint.new, ColorSequence.new)
end

--[=[
    Decodes a NumberSequence from a JSON-encoded keypoint array.
    If the value is invalid or keypoints fail validation, it will return nil.

    @param v JSONUnknown
    @return NumberSequence?
]=]
function TypeDecoder.NumberSequence(v: JSONUnknown): NumberSequence?
	return decodeSequence(v, tonumber :: (string) -> number, NumberSequenceKeypoint.new, NumberSequence.new)
end

for name, enum in EnumMap :: { [CatWebEnums]: Enum } do
	TypeDecoder[name] = function(v: string): EnumItem?
		return enumItem(v, enum)
	end
end

return table.freeze(TypeDecoder :: typeof(TypeDecoder))
