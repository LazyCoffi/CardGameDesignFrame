extends "res://class/functional/CardConditionSet.gd"
class_name CharacterCardConditionSet

func _init():
	._init()
	__initFuncForm()

func isHandCardsEmpty(first):
	return first.isHandCardsEmpty()

func __initFuncForm():
	addFuncForm("isHandCardsEmpty", "bool", ["CharacterCard"])
