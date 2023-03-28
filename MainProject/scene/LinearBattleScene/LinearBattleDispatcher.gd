extends Node
class_name LinearBattleDispatcher

## Dispatcher将以信号的方式推进流程，即上一步骤结束后，发送进行下一步骤的信号，根据信号决定执行的时机

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func render():
	return scene().render()

func tween():
	return scene().get_node("Tween")

func service():
	return scene().service()

func player():
	return scene().get_node("AnimationPlayer")

func launch():
	battleInit()

func battleInit():
	initBackground()
	initSubMenuEntryButton()
	initNextRoundButton()
	initCharacter()
	initCardView()

func initBackground():
	render().renderBackground()

func initSubMenuEntryButton():
	render().renderSubMenuEntryButton()
	var sub_menu_entry_button = render().getSubMenuEntryButton().getComponent()
	sub_menu_entry_button.connect("pressed", service(), "subMenu")

func initNextRoundButton():
	render().renderNextRoundButton()

func initCharacter():
	service().initOwnCharacterTeam()
	service().initEnemyCharacterTeam()
	service().initOrderBucket()

	emitInitRenderCharacterSignal()

func initCardView():
	render().renderViewRect()
	render().connectView()

func emitInitRenderCharacterSignal():
	tween().connect("tween_all_completed", self, "receiveInitRenderCharacterSignal")

	render().renderOwnTeam()
	render().renderEnemyTeam()

func receiveInitRenderCharacterSignal():
	tween().disconnect("tween_all_completed", self, "receiveInitRenderCharacterSignal")
	
	setActionCharacter()

func setActionCharacter():
	service().setActionCharacter()
	render().renderActionCharacterMark()

	service().beforeRound()

	if service().isOwnAction():
		playerAction()
	elif service().isEnemyAction():
		aiAction()
	else:
		Logger.error("Action character not in any team!")
	
func playerAction():
	setHandCards()

func setHandCards():
	service().drawHandCards()

	emitInitRenderHandCardSignal()

func emitInitRenderHandCardSignal():
	tween().connect("tween_all_completed", self, "receiveInitRenderHandCardSignal")

	render().renderHandCards()

func receiveInitRenderHandCardSignal():
	tween().disconnect("tween_all_completed", self, "receiveInitRenderHandCardSignal")

	emitChooseHandCardSignal()
	emitNextRoundSignal()

# chooseHandCard
func emitChooseHandCardSignal():
	var optional_hand_card_list = render().getOptionalHandCardList()
	for component_pack in optional_hand_card_list:
		__createRoute(component_pack, "pressed", "receiveChooseHandCardSignal")

func receiveChooseHandCardSignal(component_key):
	var hand_card_list = render().getHandCardList()
	for component_pack in hand_card_list:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "receiveChooseHandCardSignal")
	
	var next_round_button = render().getNextRoundButton()
	if next_round_button.isConnected("pressed"):
		__destroyRoute(next_round_button, "pressed", "receiveNextRoundSignal")

	service().setChosenHandCard(component_key)

	emitChooseHandCardBeforeSignal(component_key)

func emitChooseHandCardBeforeSignal(component_key):
	tween().connect("tween_all_completed", self, "receiveChooseHandCardBeforeSignal", [component_key])
	render().renderChooseHandCardAnime(component_key)

func receiveChooseHandCardBeforeSignal(component_key):
	tween().disconnect("tween_all_completed", self, "receiveChooseHandCardBeforeSignal")

	chooseHandCard(component_key)

func chooseHandCard(component_key):
	emitChooseTargetCardSignal()
	emitCancelHandCardSignal(component_key)

# nextRound
func emitNextRoundSignal():
	var next_round_button = render().getNextRoundButton()
	__createRoute(next_round_button, "pressed", "receiveNextRoundSignal")

func receiveNextRoundSignal(_component_key):
	var next_round_button = render().getNextRoundButton()
	if next_round_button.isConnected("pressed"):
		__destroyRoute(next_round_button, "pressed", "receiveNextRoundSignal")
	
	nextRound()

func nextRound():
	service().afterRound()
	service().nextRoundPrepare()
	render().clearHandCards()

	setActionCharacter()

# chooseTargetCard
func chooseTargetCard(component_key):
	service().playChosenHandCardAt(component_key)

	playSound()

	emitPlaySkillAnimationSignal(component_key)

func playSound():
	var chosen_hand_card = service().getChosenHandCard()
	render().playSkillSound(chosen_hand_card)

func emitPlaySkillAnimationSignal(component_key):
	var chosen_target_card = service().getCharacterByName(component_key)
	var chosen_hand_card = service().getChosenHandCard()

	var animated_sprite = render().generateSkillAnimation(chosen_target_card, chosen_hand_card)

	if not animated_sprite.is_connected("animation_finished", self, "receivePlaySkillAnimationSignal"):
		animated_sprite.connect("animation_finished", self, "receivePlaySkillAnimationSignal", [animated_sprite])

	render().playSkillAnimation(animated_sprite)

func receivePlaySkillAnimationSignal(animated_sprite):
	render().recycleSkillAnimation(animated_sprite)
	playerAfterPlay()

func playerAfterPlay():
	service().resetChosenHandCard()

	emitAdjustHandCardSignal()

func emitAdjustHandCardSignal():
	tween().connect("tween_all_completed", self, "receiveAdjustHandCardSignal")

	render().renderHandCards()

func receiveAdjustHandCardSignal():
	tween().disconnect("tween_all_completed", self, "receiveAdjustHandCardSignal")

	adjustCharacter()

func adjustCharacter():
	service().removeDeadCharacter()

	emitAdjustCharacterSignal()

func emitAdjustCharacterSignal():
	tween().connect("tween_all_completed", self, "receiveAdjustCharacterSignal")

	render().renderOwnTeam()
	render().renderEnemyTeam()

func receiveAdjustCharacterSignal():
	tween().disconnect("tween_all_completed", self, "receiveAdjustCharacterSignal")

	checkIsBattleOver()

func checkIsBattleOver():
	if service().isVictory():
		victory()
	elif service().isFail():
		fail()
	else:
		emitChooseHandCardSignal()
		emitNextRoundSignal()

func emitChooseTargetCardSignal():
	var optional_target_list = render().getOptionalTargetList()
	for component_pack in optional_target_list:
		__createRoute(component_pack, "pressed", "receiveChooseTargetCardSignal")

func receiveChooseTargetCardSignal(component_key):
	var own_team = render().getOwnTeamList()
	for component_pack in own_team:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "receiveChooseTargetCardSignal")
	
	var enemy_team = render().getEnemyTeamList()
	for component_pack in enemy_team:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "receiveChooseTargetCardSignal")

	var hand_card_list = render().getHandCardList()
	for component_pack in hand_card_list:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "receiveCancelHandCardSignal")
	
	chooseTargetCard(component_key)

# cancelHandCard
func emitCancelHandCardSignal(component_key):
	var hand_card_list = render().getHandCardList()
	for component_pack in hand_card_list:
		if component_pack.getKey() == component_key:
			__createRoute(component_pack, "pressed", "receiveCancelHandCardSignal")

func receiveCancelHandCardSignal(component_key):
	var own_team = render().getOwnTeamList()
	for component_pack in own_team:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "receiveChooseTargetCardSignal")
	
	var enemy_team = render().getEnemyTeamList()
	for component_pack in enemy_team:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "receiveChooseTargetCardSignal")

	var hand_card_list = render().getHandCardList()
	for component_pack in hand_card_list:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "receiveCancelHandCardSignal")
	
	emitCancelHandCardBeforeSignal(component_key)

func emitCancelHandCardBeforeSignal(component_key):
	tween().connect("tween_all_completed", self, "receiveCancelHandCardBeforeSignal")
	render().renderCancelHandCardAnime(component_key)

func receiveCancelHandCardBeforeSignal():
	tween().disconnect("tween_all_completed", self, "receiveCancelHandCardBeforeSignal")

	cancelHandCard()

func cancelHandCard():
	service().resetChosenHandCard()

	emitChooseHandCardSignal()
	emitNextRoundSignal()

# ai

func aiAction():
	aiSetHandCard()

func aiSetHandCard():
	service().drawHandCards()
	aiPlayHandCard()

func aiPlayHandCard():
	if service().isActionHandCardsEmpty():
		aiCheckIsBattleOver()
		return
		
	if not service().isAiAction():
		aiCheckIsBattleOver()
		return

	var chosen_hand_card = service().aiChooseCard()
	var chosen_target_card = service().aiChooseTarget()
	var action_character = service().getActionCharacter()
	var card_pile = action_character.getCardPile()
	var scene_name = scene().getSceneName()

	if chosen_hand_card == null or chosen_target_card == null:
		aiCheckIsBattleOver()
		return

	if not chosen_hand_card.isOffensive():
		aiCheckIsBattleOver()
		return

	if not chosen_hand_card.isTargetCondition(chosen_target_card, scene_name):
		aiCheckIsBattleOver()
		return

	action_character.playHandCardByName([chosen_target_card, action_character, scene_name], card_pile, chosen_hand_card.getCardName())

	aiPlaySound(chosen_hand_card)

	emitAiPlaySkillAnimationSignal(chosen_target_card, chosen_hand_card)

func aiPlaySound(chosen_hand_card):
	render().playSkillSound(chosen_hand_card)

func emitAiPlaySkillAnimationSignal(chosen_target_card, chosen_hand_card):
	var animated_sprite = render().generateSkillAnimation(chosen_target_card, chosen_hand_card)

	if not animated_sprite.is_connected("animation_finished", self, "receiveAiPlaySkillAnimationSignal"):
		animated_sprite.connect("animation_finished", self, "receiveAiPlaySkillAnimationSignal", [animated_sprite])

	render().playSkillAnimation(animated_sprite)
 
func receiveAiPlaySkillAnimationSignal(animated_sprite):
	render().recycleSkillAnimation(animated_sprite)
	aiAfterPlay()

func aiAfterPlay():
	service().removeDeadCharacter()
	emitAiAdjustCharacterSignal()

func emitAiAdjustCharacterSignal():
	tween().connect("tween_all_completed", self, "receiveAiAdjustCharacterSignal")

	render().renderOwnTeam()
	render().renderEnemyTeam()

func receiveAiAdjustCharacterSignal():
	tween().disconnect("tween_all_completed", self, "receiveAiAdjustCharacterSignal")

	if service().isVictory():
		victory()
	elif service().isFail():
		fail()
	else:
		aiPlayHandCard()

func aiCheckIsBattleOver():
	if service().isVictory():
		victory()
	elif service().isFail():
		fail()
	else:
		aiNextRound()

func aiNextRound():
	service().afterRound()
	service().nextRoundPrepare()
	setActionCharacter()

# battleOver
func victory():
	service().victory()

func fail():
	service().fail()

func __createRoute(component_pack, component_signal, target_func):
	Logger.assert(not component_pack.isConnected(component_signal), "Component has connected!")
	component_pack.connectTo(self, component_signal, target_func)

func __destroyRoute(component_pack, component_signal, target_func):
	Logger.assert(component_pack.isConnected(component_signal), "Component hasn't connected yet!")
	component_pack.disconnectFrom(self, component_signal, target_func)
