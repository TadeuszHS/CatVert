--!strict

assert(plugin, "Expected to run as plugin.")

require("./packages/vide").root(function(destroy: () -> ())
	require("./App").Initialize(plugin)
end)
