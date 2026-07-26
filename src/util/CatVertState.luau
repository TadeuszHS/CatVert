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

export type CatVertState = {
	status: Status,
	process: Process,
	args: { unknown },
}

const CatVertState = {}

function CatVertState.new(status: Status, process: Process, ...: unknown): CatVertState
	return {
		status = status,
		process = process,
		args = { ... },
	}
end

return table.freeze(CatVertState)
