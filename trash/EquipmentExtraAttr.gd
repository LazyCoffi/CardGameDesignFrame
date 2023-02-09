extends Node

func active(attr, params):
	assert(attr is String)
	assert(params is Array)
	return self.callv(attr, params)

## TODO: 添加静态函数

static func demoAttr(equipment_card):
	pass
