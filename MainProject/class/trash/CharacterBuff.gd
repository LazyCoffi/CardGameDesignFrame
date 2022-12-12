extends Node

func active(buff, params):
	assert(buff is String)
	assert(params is Array)
	return self.callv(buff, params)

## TODO:
static func demoBuff():
	pass
