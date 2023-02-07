extends Node
class_name LinearBattleService

var DictArray = TypeUnit.type("DictArray")

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func initCharacterCardGroup():
	model().setCharacterGroups(model().dealCharacter())

func initOrderBucket():
	var order_bucket = model().getOrderBucket()
	var character_groups = model().getCharacterGroups()
	for index in 2:
		for card in character_groups[index].values():
			order_bucket.append(card.getCardName(), card)
	
	order_bucket.active()

func setCurCharacterCard():
	var order_bucket = model().getOrderBucket()
	model().setCurCharacterCard(order_bucket.getParam())

func getCurCharacterIndex():
	var cur_card_name = model().getCurCharacterName()
	var character_groups = model().getCharacterGroups()
	for i in 2:
		for j in character_groups[i].size():
			var card = character_groups[i].getAt(j)
			if cur_card_name == card.getCardName():
				return [i, j]

func popCurCharacterCard():
	return model().popCurRoundCard()

func drawCurHandCards():
	var draw_hand_cards_num = model().getDrawCardsNum()
	# var cur_hand_cards_num = model().get
	var hand_cards_upper = model().getSettingAttr("hand_cards_upper")

func addCurHandCards(hand_cards):
	var cur_hand_cards = model().getCurHandCards()
	cur_hand_cards.append_array(model().getCurCharacterName(), hand_cards)
