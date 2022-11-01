extends Node
class_name EquipmentInfo

var e_name setget setName
var introduction setget setIntroduction
var avator_name setget setAvatorName
var avator

func setName(e_name_):
	if e_name != null:
		return
	e_name = e_name_
	
func setIntroduction(introduction_):
	if introduction != null:
		return
	introduction = introduction_
	
func setAvatorName(avator_name_):
	if avator_name_ != null:
		return
	avator_name = avator_name_


func pack():
	var data_pack = {}
	data_pack["e_name"] = e_name
	data_pack["introduction"] = introduction
	data_pack["avator_name"] = avator_name
	
	return data_pack

func loadAvator():
	avator = ResourceTool.loadImage(avator_name)

func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	e_name = data_pack["e_name"]
	introduction = data_pack["introduction"]
	avator = data_pack["avator"]
