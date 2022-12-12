extends Node
class_name EquipmentCard

var info
var attr
var require

var EquipmentInfo = load("res://class/EquipmentInfo.gd")
var EquipmentAttr = load("res://class/EquipmentAttr.gd")
var EquipmentRequire = load("res://class/EquipmentRequire.gd")

func pack():
	var data_pack = {}
	data_pack["info"] = info.pack()
	data_pack["attr"] = attr.pack()
	data_pack["require"] = require.pack()
	
	return data_pack

func loadResource():
	info.loadAvator()
	attr.loadSkills()

func loadPack(data_pack):
	assert(data_pack is Dictionary)
	
	info = EquipmentInfo.new()
	info.loadPack(data_pack["info"])
	attr = EquipmentAttr.new()
	attr.loadPack(data_pack["attr"])
	require = EquipmentRequire.new()
	require.loadPack(data_pack["require"])
