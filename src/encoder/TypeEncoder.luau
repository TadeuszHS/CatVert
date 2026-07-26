--!strict

const HttpService = game:GetService("HttpService")
const Types = require("../data/Types")
const EnumMap = require("../data/EnumMap")

type CatWebEnums = Types.CatWebEnums

--[=[
	Encodes a Sequence into a JSON string.

	Each keypoint is serialized using the provided value encoder,
	and stored as a two-element array of its encoded value and time:
	```
	{
		{
			[1]: Value,
			[2]: Time,
		}
	}
	```
	@param sequence NumberSequence | ColorSequence
	@param encode_value (T) -> E
	@return string
]=]
const function fromSequence<T, E>(sequence: NumberSequence | ColorSequence, encode_value: (T) -> E): string
	const result = {}

	for i, point in sequence.Keypoints do
		const t: { number | E } = {}
		t[1] = encode_value(point.Value)
		t[2] = tostring(point.Time)
		result[i] = t
	end

	return HttpService:JSONEncode(result)
end

const TypeEncoder = {}

--[=[
	Encodes a boolean as a string.

	@param v boolean
	@return string
]=]
function TypeEncoder.boolean(v: boolean): string
	return tostring(v)
end

--[=[
	Encodes a number as a string.

	@param v number
	@return string
]=]
function TypeEncoder.number(v: number): string
	return tostring(v)
end

--[=[
	Encodes a string as a string.

	@param v string
	@return string
]=]
function TypeEncoder.string(v: string): string
	return v
end

--[=[
	Encodes a Color3 as a hex string.

	@param v Color3
	@return string
]=]
function TypeEncoder.Color3(v: Color3): string
	return "#" .. v:ToHex()
end

--[=[
	Encodes a UDim as a string.

	@param v UDim
	@return string
]=]
function TypeEncoder.UDim(v: UDim): string
	return tostring(v)
end

--[=[
	Encodes a UDim2 as a string.

	@param v UDim2
	@return string
]=]
function TypeEncoder.UDim2(v: UDim2): string
	return tostring(v)
end

--[=[
	Encodes a Vector2 as a string.

	@param v Vector2
	@return string
]=]
function TypeEncoder.Vector2(v: Vector2): string
	return tostring(v)
end

--[=[
	Encodes a Rect as a string.

	@param v Rect
	@return string
]=]
function TypeEncoder.Rect(v: Rect): string
	return tostring(v)
end

--[=[
	Encodes a ColorSequence as a JSON string.

	Each keypoint is stored as a two-element array of its value and time:
	```
	{
		{
			[1]: Value,
			[2]: Time,
		}
	}
	```
	@param v ColorSequence
	@return string
]=]
function TypeEncoder.ColorSequence(v: ColorSequence): string
	return fromSequence(v, function(v: Color3): string
		--intentional ommission of `#`, CatWeb does not use it on ColorSequences.
		return v:ToHex()
	end)
end

--[=[
	Encodes a NumberSequence as a JSON string.

	Each keypoint is stored as a two-element array of its value and time:
	```
	{
		{
			[1]: Value,
			[2]: Time,
		}
	}
	```
	@param v NumberSequence
	@return string
]=]
function TypeEncoder.NumberSequence(v: NumberSequence): string
	return fromSequence(v, function(x: number): string
		return tostring(x)
	end)
end

--[=[
	Encodes Enum.AutomaticSize as a JSON string.
	Enum.AutomaticSize.None is not representable in this encoded type and will return nil.

	@param v Enum.AutomaticSize
	@return string
]=]
function TypeEncoder.AutomaticSize(v: Enum.AutomaticSize): string?
	if v == Enum.AutomaticSize.XY then
		return "auto"
	elseif v == Enum.AutomaticSize.X then
		return "auto_x"
	elseif v == Enum.AutomaticSize.Y then
		return "auto_y"
	end

	return nil
end

for name, enum in EnumMap :: { [CatWebEnums]: Enum } do
	TypeEncoder[name] = function(v: EnumItem): string
		return v.Name
	end
end

return table.freeze(TypeEncoder :: typeof(TypeEncoder))
