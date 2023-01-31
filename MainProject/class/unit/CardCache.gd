extends Node

var ScriptTree = TypeUnit.type("ScriptTree")

class CacheNode:
	var template_name
	var card_type
	var card_template
	var copy_count

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

		return card
	
	func getCardWithDefaultName():
		copy_count += 1
		var card_name = template_name + str(copy_count)
		var card = card_template.copy()
		card.setCardName(card_name)

		return [card_name, card]
	
	func getCategory():
		return card_template.getCategory()
	
	func setCardTemplate(card_template_):
		card_template = card_template_
	
	# copy_cound
	func getCopyCount():
		return copy_count
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("template_name", template_name)
		script_tree.addAttr("card_type", card_type)
		script_tree.addObject("card_template", card_template)
		script_tree.addAttr("copy_count", copy_count)

		return script_tree

	func loadScript(script_tree):
		template_name = script_tree.getStr("template_name")
		card_type = script_tree.getStr("card_type")	
		var param_type = TypeUnit.type(card_type)
		card_template = script_tree.getObject("card_template", param_type)
		copy_count = script_tree.getInt("copy_count")

var table
	
func _init():
	table = {}

# table
func getCard(category, template_name, card_name):
	var node = __getNode(category, template_name)

	return node.getCard(card_name)

func getCardWithDefaultName(category, template_name):
	var node = __getNode(category, template_name)

	return node.getCardWithDefaultName()

func addTemplate(template_name, card_type, card_template):
	var node = CacheNode.new()
	node.setTemplateName(template_name)
	node.setCardType(card_type)
	node.setCardTemplate(card_template)

	__insertNode(node)

func setTable(table_):
	table = table_

func pack():
	var script_tree = ScriptTree.new()

	var flat_table = __getFlatTable(table)
	script_tree.addObjectArray("table", flat_table)

	return script_tree

func loadScript(script_tree):
	var flat_table = script_tree.getObjectArray("table", CacheNode)
	table = __constructTable(flat_table)

func __initScript():
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/system/cardTemplates.json")
	loadScript(script_tree)

func __getNode(category, template_name):
	var dict = table

	for index in category.getCategory():
		Exception.assert(dict.has(index))
		dict = dict[index]
	
	Exception.assert(dict.has(template_name))
	return dict[template_name]

func __insertNode(node):
	var category = node.getCategory()
	var template_name = node.getTemplateName()

	var dict = table
	for index in category.getCategory():
		if not dict.has(index):
			dict[index] = {}

		dict = dict[index]
	
	dict[template_name] = node

func __getFlatTable(u):
	var ret = []

	for node in u.values():
		if not node is Dictionary:
			ret.append(node)
		else:
			ret.append_array(__getFlatTable(node))
	
	return ret

func __constructTable(flat_table):
	var ret = {}
	for node in flat_table:
		var category = node.getCategory().getCategory()
		var dict = ret
		for index in category:
			if not dict.has(index):
				dict[index] = {}
			dict = dict[index]

		dict[node.getTemplateName()] = node

	return ret
