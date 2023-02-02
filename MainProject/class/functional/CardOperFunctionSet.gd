extends "res://class/functional/FunctionalSet.gd"
class_name CardOperFunctionSet

func _init():
	__initFuncForm()

func getCard(template_name, card_name): 
	return CardCache.getCard(template_name, card_name)

func getCardWithDefaultName(template_name):
	return CardCache.getCardWithDefaultName(template_name)

func __initFuncForm():
	addFuncForm("getCard", "Card", ["String", "String"])
	addFuncForm("getCardWithDefaultName", "Card", ["String"])
