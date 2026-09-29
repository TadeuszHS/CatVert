--!strict

assert(plugin, "Expected to run as plugin.")

require("./packages/vide").root(function(destroy: () -> ())
	require("./App").initialize(plugin)
end)
