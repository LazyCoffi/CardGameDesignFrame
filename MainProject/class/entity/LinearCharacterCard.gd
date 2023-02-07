extends "res://class/entity/CharacterCard.gd"
class_name LinearCharacterCard

var CardPile = TypeUnit.type("CardPile")
var LinearSkillCard = TypeUnit.type("LinearSkillCard")

var card_pile 			# CardPile

func _init():
	hand_card_slot.setParamType(LinearSkillCard)
	card_pile = CardPile.new()
	card_pile.setParamType(LinearSkillCard)

func copy():
	var ret = TypeUnit.type("LinearCharacterCard").new()

	ret.card_name = card_name
	ret.avator_name = avator_name
	ret.introduction = introduction
	ret.template_name = template_name
	ret.card_attr = card_attr.copy()

	ret.equipment_set = {}
	for key in equipment_set.keys():
		ret.equipment_set[key] = equipment_set[key].copy()
	ret.buff_set = {}
	for key in buff_set:
		ret.buff_set[key] = buff_set[key].copy()

	ret.card_pile = card_pile.copy() 

	return ret

# card_pile
func peekCardPile():
	return card_pile.getCardPile()

func peekTrashPile():
	return card_pile.getTrashPile()

func pileRandomOn():
	card_pile.randomOn()

func pileRandomOff():
	card_pile.randomOff()

func dealCards(num):
	return card_pile.deal(num)

func dealTrashCards(num):
	return card_pile.dealTrash(num)

func drawCardFront(card):
	card_pile.pushFront(card)

func drawCardBack(card):
	card_pile.pushBack(card)

func drawTrashCardFront(card):
	card_pile.pushTrashFront(card)

func drawTrashCardBack(card):
	card_pile.pushTrashBack(card)

func shufflePile():
	card_pile.shufflePile()

func shuffleTrash():
	card_pile.shuffleTrash()

func pack():
	var script_tree = .pack()

	script_tree.addTypeObject("hand_card_slot", hand_card_slot)
	script_tree.addTypeObject("card_pile", card_pile)

	return script_tree

func loadScript(script_tree):
	.loadScript(script_tree)
	hand_card_slot = script_tree.getTypeObject("hand_card_slot", HandCardSlot, LinearSkillCard)
	card_pile = script_tree.getTypeObject("card_pile", CardPile, LinearSkillCard)
