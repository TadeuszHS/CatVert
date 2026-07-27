--!strict

export type Status = "Initializing" | "Ready" | "Decoding" | "Encoding"
export type Process =
	| "None"
	| "BuildDefaults"
	| "JSONTranscode"
	| "DetermineStructureType"
	| "TypeConversion"
	| "Apply"
	| "ApplyProperty"
	| "ApplyAttribute"
	| "ApplyCustom"
	| "CreateInstance"
	| "CreateElement"
	| "CreateWebContent"

--[=[
	Data type represents the current or previous state of CatVert.

	@interface CatVertState
]=]
export type CatVertState = {
	status: Status,
	process: Process,
	args: { unknown },
}

--[=[
	@class CatVertState
	@private
]=]
const CatVertState = {}

--[=[
	Constructor for the CatVertState data type.

	@within CatVertState
	@param status Status
	@param process Process
	@param ... unknown
	@return CatVertState
]=]
function CatVertState.new(status: Status, process: Process, ...: unknown): CatVertState
	return {
		status = status,
		process = process,
		args = { ... },
	}
end

return table.freeze(CatVertState)
