extends "res://class/entity/CardPile.gd"
class_name BattleSkillCardPile

var ScriptTree = load("res://class/entity/ScriptTree.gd")
var BattleSkillCard = load("res://class/entity/BattleSkillCard.gd") 
var Filter = load("res://class/functionalSystem/Filter.gd")

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObjectArray("card_pile", card_pile)
	script_tree.addObjectArray("trash_pile", trash_pile)
	script_tree.addAttr("is_random", is_random)
	script_tree.addObject("pop_num_filter", pop_num_filter)

	return script_tree

func loadScript(script_tree):
	script_tree.loadObjectArray("card_pile", BattleSkillCard)
	script_tree.loadObjectArray("trash_pile", BattleSkillCard)
	script_tree.loadAttr("is_random")
	script_tree.loadObject("pop_num_filter", Filter)
	
