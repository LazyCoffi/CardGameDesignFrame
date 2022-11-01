extends Node
class_name ItemInfo

var i_name
var introduction
var avator_name
var avator

func setName(i_name_):
	i_name = i_name_

func setIntroduction(introduction_):
	introduction = introduction_

func setAvatorName(avator_name_):
	if avator_name_ != null:
		return
	avator_name_ = avator_name_

func pack():
	var data_pack = {}
	data_pack["i_name"] = i_name
	data_pack["introduction"] = introduction
	data_pack["avator"] = avator
	
	return data_pack

func loadAvator():
	avator = ResourceTool.loadImage(avator_name)

func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	i_name = data_pack["i_name"]
	introduction = data_pack["introduction"]
	avator = data_pack["avator"]
