extends Node
class_name EquipmentExtraAttr

var attr setget setAttr
var rev_attr setget setRevAttr 

func setAttr(attr_):
	assert(attr_ is String)
	
	if attr != null:
		return
	
	attr = attr_
	rev_attr = "rev_" + attr_

func setRevAttr(attr_):
	return

func active(params):
	assert(params is Array)
	return self.callv(attr, params)

func deactive(params):
	assert(params is Array)
	return self.callv(rev_attr, params)

## TODO: 添加静态函数

static func demoAttr(equipment_card):
	pass
