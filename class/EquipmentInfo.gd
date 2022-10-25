extends Node
class_name EquipmentInfo

var e_name setget setName
var introduction setget setIntroduction
var avator setget setAvator

func setName(e_name_):
	if e_name != null:
		return
	e_name = e_name_
	
func setIntroduction(introduction_):
	if introduction != null:
		return
	introduction = introduction_
	
func setAvator(avator_):
	if avator != null:
		return
	avator = avator_
	
func loadData(data_pack):
	#TODO
	pass

func pack():
	#TODO
	pass
