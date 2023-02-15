extends "res://class/functional/CardFuncSet.gd"
class_name CharacterCardFuncSet

func _init():
	._init()
	__initFuncForm()

func getHandCardsNum(first):
	return first.getHandCardsNum()

func peekHandCards(first):
	return first.peekHandCards()

func peekHandCardAt(first, second):
	return first.peekHandCardAt(second)

func peekHandCardByName(first, second):
	return first.peekHandCardByName(second)

func drawHandCards(first, second, third):
	first.drawHandCards(second, third)

	return first

func passiveDiscard(first, second):
	first.passiveDiscard(second)

	return first

func positiveDiscardAt(first, second, third):
	first.positiveDiscardAt(second, third)

	return first

func addBuff(first, second):
	first.addBuff(second)

	return first

func peekBuffSet(first):
	return first.peekBuffSet()

func equip(first, second):
	first.equip(second)

	return first

func unequip(first, second):
	first.unequip(second)

	return first

func __initFuncForm():
	addFuncForm("getHandCardsNum", "int", ["CharacterCard"])
	addFuncForm("peekHandCards", "Array", ["CharacterCard"])
	addFuncForm("peekHandCardAt", "SkillCard", ["CharacterCard", "int"])
	addFuncForm("peekHandCardByName", "SkillCard", ["CharacterCard", "String"])
	addFuncForm("drawHandCards", "CharacterCard", ["CharacterCard", "CardPile", "int"])
	addFuncForm("positiveDiscardAt", "CharacterCard", ["CharacterCard", "CardPile", "int"])
	addFuncForm("passiveDiscard", "CharacterCard", ["CharacterCard", "CardPile"]) 
	addFuncForm("addBuff", "CharacterCard", ["CharacterCard", "BuffCard"])
	addFuncForm("peekBuffSet", "Array", ["CharacterCard"])
	addFuncForm("equip", "CharacterCard", ["CharacterCard", "EquipmentCard"])
	addFuncForm("unequip", "CharacterCard", ["CharacterCard", "String"])
