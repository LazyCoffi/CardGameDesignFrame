extends "res://class/functional/FuncSet.gd"
class_name CardFuncSet

func _init():
	__initFuncForm()

func createCard(template_name, card_name): 
	return CardCache.createCard(template_name, card_name)

func createCardWithDefaultName(template_name):
	return CardCache.createCardWithDefaultName(template_name)

func extractAttr(first):
	return first.getCardAttr()

func extractIntroduction(first):
	return first.getIntroduction()

func extractTemplateName(first):
	return first.getTemplateName()

func __initFuncForm():
	addFuncForm("createCard", "Card", ["String", "String"])
	addFuncForm("createCardWithDefaultName", "Card", ["String"])
	addFuncForm("extractAttr", "Attr", ["Card"])
	addFuncForm("extractIntroduction", "String", ["Card"])
	addFuncForm("extractTemplateName", "String", ["Card"])
