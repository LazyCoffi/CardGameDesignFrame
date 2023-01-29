extends Node
class_name Card

var Category = TypeUnit.type("Category")
var Info = TypeUnit.type("Info")
var Attr = TypeUnit.type("Attr")
var LocalFunction = TypeUnit.type("LocalFunction")
var ScriptTree = TypeUnit.type("ScriptTree")
var Filter = TypeUnit.type("Filter")

var category				# Category
var info 					# Info
var attr					# Attr

func _init():
	category = Category.new()
	info = Info.new()
	attr = Attr.new()

func copy():
	var ret = TypeUnit.type("Card").new()
	ret.category = category.copy()
	ret.info = info.copy()
	ret.attr = attr.copy()

	return ret

func getCardName():
	return info.getCardName()

func getAvatorName():
	return info.getAvatorName()

func getCategory():
	return category

func getInfo():
	return info

func getAttr():
	return attr

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("category", category)
	script_tree.addObject("info", info)
	script_tree.addObject("attr", attr)
	
	return script_tree

func loadScript(script_tree):
	category = script_tree.getObject("category", Category)
	info = script_tree.getObject("info", Info)
	attr = script_tree.getObject("attr", Attr)
