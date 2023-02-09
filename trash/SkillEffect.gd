extends Node

func active(effect, params):
	assert(params is Array)
	return self.callv(effect, params)

##TODO:

static func demoEffect():
	pass
