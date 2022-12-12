extends Node
class_name BaseFunction

func IncreaseIntAttr(card, attr_name, val):
	Exception.assert(card.attr.has(attr_name))
	Exception.assert(val is int)
	Exception.assert(card.attr.getAttr(attr_name) is int)

func DecreaseIntAttr(card, attr_name, val):
	pass
