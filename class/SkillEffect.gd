extends Node
class_name SkillEffect

var effect setget setEffect

func setEffect(effect_):
	assert(effect_ is String)
	effect = effect_

func active(params):
	assert(params is Array)
	return self.callv(effect, params)

##TODO:

static func demoEffect():
	pass
