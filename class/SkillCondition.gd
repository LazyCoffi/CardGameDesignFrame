extends Node

func active(condition, params):
	assert(params is Array)
	return self.callv(condition, params)
	
##TODO:

static func trueCondition():
	return true
