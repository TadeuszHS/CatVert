--!strict

const LogService = game:GetService("LogService")
const CatVertState = require("./CatVertState")

type CatVertState = CatVertState.CatVertState
type Status = CatVertState.Status
type Process = CatVertState.Process

export type EventType = "Info" | "Warn" | "Error"
export type Event = {
	read status: Status,
	read process: Process,
	read args: { unknown },
	read type: EventType,
	read message: string,
	read time: number,
}

const state = CatVertState.new("Initializing", "None")
const logs: { Event } = {}
const kIgnoreInfo = true

const Logger = {}

function Logger.withStatus(status: Status): typeof(Logger)
	state.status = status

	return Logger
end

function Logger.withProcess(process: Process): typeof(Logger)
	state.process = process

	return Logger
end

function Logger.withArgs(...: unknown): typeof(Logger)
	state.args = { ... }

	return Logger
end

function Logger.event(type: EventType, message: string): nil
	if type == "Info" and kIgnoreInfo then
		return nil
	end

	const time = os.clock()
	const event = table.clone(state) :: any
	event.type = type
	event.message = message
	event.time = time

	logs[time] = table.freeze(event)

	if type == "Error" then
		LogService:Error(`[{event.status}]: {type}: {message}: \{args\}`, event)
	elseif type == "Warn" then
		LogService:Warn(`[{event.status}]: {type}: {message}: \{args\}`, event)
	elseif type == "Info" then
		LogService:Info(`[{event.status}]: {type}: {message}: \{args\}`, event)
	end

	return nil
end

function Logger.eventAssert(condition: boolean, type: EventType, message: string): nil
	if condition then
		return nil
	end

	return Logger.event(type, message)
end

function Logger.getEvents(): { Event }
	return logs
end

function Logger.getMostRecentEvent(): Event
	return logs[table.maxn(logs)]
end

return table.freeze(Logger)
