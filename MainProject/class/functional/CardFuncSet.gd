extends "res://class/functional/FuncSet.gd"
class_name CardFuncSet

func _init():
	__initFuncForm()

func getCard(template_name, card_name): 
	return CardCache.getCard(template_name, card_name)

func getCardWithDefaultName(template_name):
	return CardCache.getCardWithDefaultName(template_name)

func extractAttr(first):
	return first.getCardAttr()

func __initFuncForm():
	addFuncForm("getCard", "Card", ["String", "String"])
	addFuncForm("getCardWithDefaultName", "Card", ["String"])
	addFuncForm("extractAttr", "Attr", ["Card"])
