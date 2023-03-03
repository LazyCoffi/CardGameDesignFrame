extends Node
class_name CardTemplate

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
func createCard(card_name):
	copy_count += 1
	var card = card_template.copy()
	card.setCardName(card_name)

	return revise(card)

func createCardWithDefaultName():
	copy_count += 1
	var card_name = template_name + str(copy_count)
	var card = card_template.copy()
	card.setCardName(card_name)

	return revise(card)

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

