extends Node
class_name LinearBattleService

var DictArray = TypeUnit.type("DictArray")

var scene_ref
var model_ref

func setRef(scene):
	scene_ref = scene
	model_ref = scene.model()

func initCharacterCardGroup():
	model_ref.setCharacterGroup(model_ref.dealCharacter())

func refillOrderQueue():
	var order_queue = model_ref.getOrderQueue()
	order_queue.clear()
	var character_groups = model_ref.getCharacterGroups()
	for index in 2:
		for card in character_groups[index].values():
			order_queue.append(card, model_ref.getOrder(card))

func setCurCharacterCard(cur_character_card):
	model_ref.setCurCharacterCard(cur_character_card)

func popCurCharacterCard():
	return model_ref.popCurRoundCard()

func markCurCharacter(character_card):
	# TODO: 在当前出牌者位置设置标记
	pass

func genCurHandCards():
	var cur_hand_cards_num = model_ref.getCurHandCardsNum()
	var hand_cards_upper = model_ref.getSettingAttr("hand_cards_upper")
	var card_num = max(hand_cards_upper - cur_hand_cards_num, 0)
	return model_ref.getCharacterGroups().getCards(card_num)

func addCurHandCards(hand_cards):
	var cur_hand_cards = model_ref.getCurHandCards()
	cur_hand_cards.append_array(model_ref.getCurCharacterName(), hand_cards)
