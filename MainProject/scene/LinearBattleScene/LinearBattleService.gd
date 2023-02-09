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
	var draw_num = model().getDrawCardsNum()
	var cur_character_card = model().getCurCharacterCard()
	var hand_cards_upper = int(model().getSettingAttr("hand_cards_upper"))
	draw_num = min(hand_cards_upper - cur_character_card.getHandCardsNum(), draw_num) 
	cur_character_card.drawHandCard(cur_character_card.getCardPile(), draw_num)

func playCurHandCardAt(hand_card_name, target_card_name):
	var source_character_card = model().getCurCharacterCard()
	var target_character_card = model().getCharacterByName(target_card_name)
	var scene_name = scene().getSceneName()
	var card_pile = source_character_card.getCardPile()
	source_character_card.playHandCardByName([source_character_card, target_character_card, scene_name], card_pile, hand_card_name)


