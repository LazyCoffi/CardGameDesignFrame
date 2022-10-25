extends Node
class_name SkillCondition

var condition

func setCondition(condition_):
	assert(condition_ is String)
	condition = condition_

func active(params):
	assert(params is Array)
	return self.callv(condition, params)
	
##TODO:

static func trueCondition():
	return true
