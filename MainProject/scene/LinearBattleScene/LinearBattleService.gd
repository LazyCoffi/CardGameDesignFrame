extends "res://scene/BaseService.gd"
class_name LinearBattleService

func getOwnCharacterTeam():
	return model().getOwnCharacterTeam()

func getEnemyCharacterTeam():
	return model().getEnemyCharacterTeam()

func getOwnCharacterNum():
	return model().getOwnCharacterNum()

func isOwnTeamEmpty():
	return model().getOwnCharacterNum() == 0

func findOwnCharacter(card_name):
	var own_team = model().getOwnCharacterTeam()
	for index in range(own_team.size()):
		var character = own_team[index]
		if character.getCardName() == card_name:
			return index
	
	return null

func getEnemyCharacterNum():
	return model().getEnemyCharacterNum()

func isEnemyTeamEmpty():
	return model().getEnemyCharacterNum() == 0

func findEnemyCharacter(card_name):
	var enemy_team = model().getEnemyCharacterTeam()
	for index in range(enemy_team.size()):
		var character = enemy_team[index]
		if character.getCardName() == card_name:
			return index
	
	return null

func initOwnCharacterTeam():
	model().deployOwnTeam()

func initEnemyCharacterTeam():
	model().deployEnemyTeam()

func getOppositeTeam(character_card):
	var own_team = getOwnCharacterTeam()
	for character in own_team:
		if character.getCardName() == character_card.getCardName():
			return getEnemyCharacterTeam()
	
	return own_team

func getActionCharacter():
	return model().getActionCharacter()

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
	var hand_cards_upper = int(model().getHandCardsUpper())

	draw_num = min(hand_cards_upper - action_character.getHandCardsNum(), draw_num) 

	action_character.drawHandCards(action_character.getCardPile(), draw_num)

func isActionHandCardsEmpty():
	return model().getActionCharacter().isHandCardsEmpty()

func isAiAction():
	return model().getActionCharacter().aiIsActionCondition(scene().getSceneName())

func aiChooseCard():
	return model().getActionCharacter().aiChooseCardFunction(scene().getSceneName())

func aiChooseTarget():
	return model().getActionCharacter().aiChooseTargetFunction(scene().getSceneName())

func playChosenHandCardAt(target_card_name):
	var action_character = model().getActionCharacter()
	var target_character_card = model().getCharacterByName(target_card_name)
	var scene_name = scene().getSceneName()
	var card_pile = action_character.getCardPile()

	action_character.playHandCardByName([target_character_card, action_character, scene_name], card_pile, model().getChosenHandCardName())

func getCharacterByName(character_name):
	return model().getCharacterByName(character_name)

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
func addCharacter(character_card):
	model().orderBucketAdd(character_card)

func delCharacter(character_card):
	model().orderBucketDel(character_card.getCardName())

	var own_team = model().getOwnCharacterTeam()
	var i = 0
	while i < own_team.size():
		if own_team[i].getCardName() == character_card.getCardName():
			own_team.remove(i)
			return
	
	var enemy_team = model().getEnemyCharacterTeam()
	var j = 0
	while j < enemy_team.size():
		if enemy_team[i].getCardName() == character_card.getCardName():
			enemy_team.remove(i)
			return

func isActionCharacterExist():
	var action_character = model().getActionCharacter()

	var own_team = model().getOwnCharacterTeam()
	for character in own_team:
		if character.getCardName() == action_character.getCardName():
			return true

	var enemy_team = model().getEnemyCharacterTeam()
	for character in enemy_team:
		if character.getCardName() == action_character.getCardName():
			return true

	return false

func isVictory():
	return model().isVictoryCondition(scene().getSceneName())

func isFail():
	return model().isFailCondition(scene().getSceneName())

func removeDeadCharacter():
	var own_team = model().getOwnCharacterTeam()
	var i = 0
	while i < own_team.size():
		if model().isDeadCondition(own_team[i], scene().getSceneName()):
			model().orderBucketDel(own_team[i].getCardName())
			own_team.remove(i)
		else:
			i += 1
	
	var enemy_team = model().getEnemyCharacterTeam()
	var j = 0
	while j < enemy_team.size():
		if model().isDeadCondition(enemy_team[j], scene().getSceneName()):
			model().orderBucketDel(enemy_team[j].getCardName())
			enemy_team.remove(j)
		else:
			j += 1

func actionCharacterPassiveDiscard():
	var action_character = model().getActionCharacter()
	var card_pile = action_character.getCardPile()
	action_character.passiveDiscard(card_pile)

func subMenu():
	model().subMenuFunction(scene())

func victory():
	model().victoryFunction(scene())

func fail():
	model().failFunction(scene())

func nextRoundPrepare():
	actionCharacterPassiveDiscard()
	model().resetActionCharacter()
	model().orderBucketWalk()

func beforeRound():
	var character = getActionCharacter()
	var scene_name = scene().getSceneName()

	model().beforeRoundFunction(character, scene_name)

func afterRound():
	var character = getActionCharacter()
	var scene_name = scene().getSceneName()

	model().afterRoundFunction(character, scene_name)

func getActionHandCardByName(card_name):
	return model().getActionHandCardByName(card_name)
