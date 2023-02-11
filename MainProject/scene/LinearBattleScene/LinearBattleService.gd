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

func getOwnCharacterNum():
	return model().getOwnCharacterNum()

func getEnemyCharacterNum():
	return model().getEnemyCharacterNum()

func initOwnCharacterTeam():
	model().deployOwnTeam()

func initEnemyCharacterTeam():
	model().deployEnemyTeam()

func getActionCharacterName():
	return model().getActionCharacterName()

func isOwnAction():
	var action_character = model().getActionCharacter()
	var own_team = model().getOwnCharacterTeam()
	for character_card in own_team:
		if action_character.getCardName() == character_card.getCardName():
			return true
	
	return false

func isEnemyAction():
	var action_character = model().getActionCharacter()
	var enemy_team = model().getEnemyCharacterTeam()
	for character_card in enemy_team:
		if action_character.getCardName() == character_card.getCardName():
			return true
	
	return false

func setActionCharacter():
	var order_bucket = model().getOrderBucket()
	var action_character = order_bucket.getParam()
	model().setActionCharacter(action_character)

func resetActionCharacter():
	model().resetActionCharacter()

func drawHandCards():
	var draw_num = model().getDrawNum(scene().getSceneName())
	var action_character = model().getActionCharacter()
	var hand_cards_upper = int(model().getSettingAttr("hand_cards_upper"))

	draw_num = min(hand_cards_upper - action_character.getHandCardsNum(), draw_num) 

	action_character.drawHandCards(action_character.getCardPile(), draw_num)

func playChosenHandCardAt(target_card_name):
	var action_character = model().getActionCharacter()
	var target_character_card = model().getCharacterByName(target_card_name)
	var scene_name = scene().getSceneName()
	var card_pile = action_character.getCardPile()

	action_character.playHandCardByName([target_character_card, action_character, scene_name], card_pile, model().getChosenHandCardName())

# order_bucket
func initOrderBucket():
	var order_bucket = model().getOrderBucket()

	var own_team = model().getOwnCharacterTeam()
	for card in own_team:
		order_bucket.append(card.getCardName(), card)
	
	var enemy_team = model().getEnemyCharacterTeam()
	for card in enemy_team:
		order_bucket.append(card.getCardName(), card)
	
	order_bucket.active()

# chosen_hand_card
func getChosenHandCard():
	return model().getChosenHandCard()

func getChosenHandCardName():
	return model().getChosenHandCardName()

func setChosenHandCard(chosen_hand_card_name):
	model().setChosenHandCardByName(chosen_hand_card_name)

func resetChosenHandCard():
	model().resetChosenHandCard()

# global_service
func isBattleOver():
	return model().isBattleOverCondition(scene().getSceneName())

func removeDeadCharacter():
	var own_team = model().getOwnCharacterTeam()
	var i = 0
	while i < own_team.size():
		if model().isDeadCondition(own_team[i], scene().getSceneName()):
			own_team.remove(i)
		else:
			i += 1
	
	var enemy_team = model().getEnemyCharacterTeam()
	var j = 0
	while j < enemy_team.size():
		if model().isDeadCondition(enemy_team[j], scene().getSceneName()):
			enemy_team.remove(j)
		else:
			j += 1

func actionCharacterPassiveDiscard():
	var action_character = model().getActionCharacter()
	var card_pile = action_character.getCardPile()
	action_character.passiveDiscard(card_pile)

func battleOver():
	scene().battleOverSwitch()

func nextTurnPrepare():
	actionCharacterPassiveDiscard()
	model().resetActionCharacter()
	model().orderBucketWalk()
