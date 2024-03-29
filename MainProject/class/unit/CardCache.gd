extends Node

var ScriptTree = TypeUnit.type("ScriptTree")
var Function = TypeUnit.type("Function")
var CategoryTree = TypeUnit.type("CategoryTree")
var CardTemplate = TypeUnit.type("CardTemplate")

var table
	
func _init():
	table = {}

# table
func createCard(template_name, card_name):
	return table[template_name].createCard(card_name)

func createCardWithDefaultName(template_name):
	return table[template_name].createCardWithDefaultName()

func addTemplate(template):
	table[template.getTemplateName()] = template 

func delTemplate(template_name):
	table.erase(template_name)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectDict("table", table)

	return script_tree

func loadScript(script_tree):
	table = script_tree.getObjectDict("table", CardTemplate)

func initScript():
	var path = "res://scripts/system/card_templates.json"
	var file = File.new()
	if file.file_exists(path):
		var script_tree = ScriptTree.new()
		script_tree.loadFromJson(path)
		loadScript(script_tree)
