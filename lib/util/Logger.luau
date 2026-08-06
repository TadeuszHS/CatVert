--!strict

const LogService = game:GetService("LogService")
const CatVertState = require("./CatVertState")

type CatVertState = CatVertState.CatVertState
type Status = CatVertState.Status
type Process = CatVertState.Process

--[=[
	A type of Event.
]=]
export type EventType = "Info" | "Warn" | "Error"
--[=[
	A logged Event.

	@interface Event
]=]
export type Event = {
	read status: Status,
	read process: Process,
	read args: { unknown },
	read type: EventType,
	read message: string,
	read time: number,
}

--[=[
	Simple singleton logging utility for logging events within CatVert.

	@class Logger
	@private
]=]
const Logger = {}

--[=[
	@within Logger
	@prop state CatVertState
]=]
const state = CatVertState.New("Initializing", "None")
--[=[
	An array of Events ordered by `os.clock()`.

	@within Logger
	@prop logs { Event }
]=]
const logs: { Event } = {}
--[=[
	Information logging is often a nuisance for most users.

	@type boolean
	@private
]=]
const ignore_info = true

--[=[
	Sets the current status to the given status logging insights.
	Logger is returned for chaining.

	@within Logger
	@param status Status
	@return Logger
]=]
function Logger.WithStatus(status: Status): typeof(Logger)
	state.status = status

	return Logger
end

--[=[
	Sets the current process to the given process for logging insights.
	Logger is returned for chaining.

	@within Logger
	@param process Process
	@return Logger
]=]
function Logger.WithProcess(process: Process): typeof(Logger)
	state.process = process

	return Logger
end

--[=[
	Sets the current args to the given args for logging insights.
	Logger is returned for chaining.

	@within Logger
	@param ... unknown
	@return Logger
]=]
function Logger.WithArgs(...: unknown): typeof(Logger)
	state.args = { ... }

	return Logger
end

--[=[
	Logs an event.

	@within Logger
	@error "Error" -- If the given EventType is "Error".
	@param type EventType
	@param message string
	@return nil
]=]
function Logger.Event(type: EventType, message: string): nil
	if type == "Info" and ignore_info then
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

--[=[
	Logs an event only if the condition is falsy.
	
	@within Logger
	@error "Error" -- Throws an error if the condition is falsy and the given EventType is "Error".
	@param condition boolean
	@param type EventType
	@param message string
	@return nil
]=]
function Logger.EventAssert(condition: unknown, type: EventType, message: string): nil
	if condition then
		return nil
	end

	return Logger.Event(type, message)
end

--[=[
	Gets an array of all events, ordered by `os.clock()`.

	@within Logger
	@return { Event }
]=]
function Logger.GetEvents(): { Event }
	return logs
end

--[=[
	Gets the most recent Event, or nil if nothing has been logged.

	@within Logger
	@return Event?
]=]
function Logger.GetMostRecentEvent(): Event?
	return logs[table.maxn(logs)]
end

return table.freeze(Logger)
