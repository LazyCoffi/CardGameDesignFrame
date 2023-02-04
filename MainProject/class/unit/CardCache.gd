extends Node

var ScriptTree = TypeUnit.type("ScriptTree")
var Function = TypeUnit.type("Function")
var CategoryTree = TypeUnit.type("CategoryTree")

class CacheNode:
	var template_name
	var card_type
	var card_template
	var copy_count
	var revise_function

	func _init():
		copy_count = 0
	
	# template_name
	func getTemplateName():
		return template_name
	
	func setTemplateName(template_name_):
		template_name = template_name_

	# card_type
	func getCardType():
		return card_type
	
	func setCardType(card_type_):
		card_type = card_type_

	# card_template
	func getCard(card_name):
		copy_count += 1
		var card = card_template.copy()
		card.setCardName(card_name)

		return revise(card)
	
	func getCardWithDefaultName():
		copy_count += 1
		var card_name = template_name + str(copy_count)
		var card = card_template.copy()
		card.setCardName(card_name)

		return revise(card)
	
	func getCategory():
		return card_template.getCategory()
	
	func setCardTemplate(card_template_):
		card_template = card_template_
	
	# copy_cound
	func getCopyCount():
		return copy_count
	
	# revise_function
	func revise(card):
		return revise_function.exec([card])

	func getReviseFunction():
		return revise_function
	
	func setReviseFunction(revise_function_):
		revise_function = revise_function_
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("template_name", template_name)
		script_tree.addAttr("card_type", card_type)
		script_tree.addObject("card_template", card_template)
		script_tree.addAttr("copy_count", copy_count)
		script_tree.addObject("revise_function", revise_function)

		return script_tree

	func loadScript(script_tree):
		template_name = script_tree.getStr("template_name")
		card_type = script_tree.getStr("card_type")	
		var param_type = TypeUnit.type(card_type)
		card_template = script_tree.getObject("card_template", param_type)
		copy_count = script_tree.getInt("copy_count")
		revise_function = script_tree.getObject("revise_function", Function)

var category_tree
var table
	
func _init():
	category_tree = CategoryTree.new()
	table = {}

	__initScript()

# table
func getCard(template_name, card_name):
	return table[template_name].getCard(card_name)

func getCardWithDefaultName(template_name):
	return table[template_name].getCardWithDefaultName()

func addTemplate(card_type, card_template, revise_function, index_list):
	var node = CacheNode.new()
	node.setTemplateName(card_template.getTemplateName())
	node.setCardType(card_type)
	node.setCardTemplate(card_template)
	node.setReviseFunction(revise_function)

	table[node.getTemplateName()] = node

	category_tree.addEntry(index_list, node.getTemplateName())

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("category_tree", category_tree)
	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	category_tree = script_tree.getObject("category_tree", CategoryTree)
	table = script_tree.getObjectDict("table", CacheNode)

func __initScript():
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/system/card_templates.json")
	loadScript(script_tree)
