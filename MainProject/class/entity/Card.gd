extends Node
class_name Card

var Attr = TypeUnit.type("Attr")
var ScriptTree = TypeUnit.type("ScriptTree")
var Function = TypeUnit.type("Function")
var HyperFunction = TypeUnit.type("HyperFunction")

var card_name 				# String
var avator_name				# String
var introduction			# String
var template_name			# String
var card_attr				# Attr

func _init():
	card_name = ""
	avator_name = ""
	introduction = ""
	template_name = ""
	card_attr = Attr.new()

func copy():
	var ret = TypeUnit.type("Card").new()
	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()

	return ret

# card_name
func getCardName():
	return card_name

func setCardName(card_name_):
	card_name = card_name_

# avator_name
func getAvatorName():
	return avator_name

func setAvatorName(avator_name_):
	avator_name = avator_name_

# introduction
func getIntroduction():
	return introduction

func setIntroduction(introduction_):
	introduction = introduction_

# template_name
func getTemplateName():
	return template_name

func setTemplateName(template_name_):
	template_name = template_name_

# attr
func getAttr(attr_name):
	return card_attr.getAttr(attr_name)

func getAttrList():
	return card_attr.getAttrList()

func getAttrIndexList():
	return card_attr.getIndexList()

func getAttrFullIndexList():
	return card_attr.getFullIndexList()

func addAttr(attr_node):
	card_attr.addAttr(attr_node)

func setAttr(attr_name, attr):
	card_attr.setAttr(attr_name, attr)

func delAttr(attr_name):
	return card_attr.delAttr(attr_name)

func setCardAttr(card_attr_):
	card_attr = card_attr_

func getCardAttr():
	return card_attr

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("card_name", card_name)
	script_tree.addAttr("avator_name", avator_name)
	script_tree.addAttr("introduction", introduction)
	script_tree.addAttr("template_name", template_name)
	script_tree.addObject("card_attr", card_attr)
	
	return script_tree

func loadScript(script_tree):
	card_name = script_tree.getStr("card_name")
	avator_name = script_tree.getStr("avator_name")
	introduction = script_tree.getStr("introduction")
	template_name = script_tree.getStr("template_name")
	card_attr = script_tree.getObject("card_attr", Attr)
