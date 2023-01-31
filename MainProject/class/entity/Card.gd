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

# info
func getInfo():
	return info

func setInfo(info_):
	info = info_

func getCardName():
	return info.getCardName()

func setCardName(card_name):
	info.setCardName(card_name)

func getAvatorName():
	return info.getAvatorName()

# category
func getCategory():
	return category

func setCategory(category_):
	category = category_

# attr
func getAttr():
	return attr

func setAttr(attr_):
	attr = attr_

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
