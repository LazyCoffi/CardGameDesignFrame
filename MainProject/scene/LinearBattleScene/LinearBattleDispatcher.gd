extends Node
class_name LinearBattleDispatcher

## Dispatcher将以信号的方式推进流程，即上一步骤结束后，发送进行下一步骤的信号，根据信号决定执行的时机

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func render():
	return scene_ref.render()

func service():
	return scene_ref.service()

func launch():
	battleInit()

func battleInit():
	initCharacter()
	initNextTurnButton()
	roundBegin()

func initNextTurnButton():
	render().renderNextTurnButton()
	createRouteToNextTurn()

func initCharacter():
	service().initOwnCharacterTeam()
	service().initEnemyCharacterTeam()
	service().initOrderBucket()
	render().renderOwnTeam()
	render().renderEnemyTeam()

func setActionCharacter():
	service().setActionCharacter()
	render().renderActionCharacterMark()

func setHandCards():
	service().drawHandCards()
	render().renderHandCards()

func roundBegin():
	setActionCharacter()
	render().renderActionCharacterMark()
	setHandCards()

	createRouteToChooseHandCard()

func createRouteToChooseHandCard():
	var optional_hand_card_list = render().getOptionalHandCardList()
	for component_pack in optional_hand_card_list:
		__createRoute(component_pack, "pressed", "chooseHandCard")

func destroyRouteFromChooseHandCard():
	var hand_card_list = render().getHandCardList()
	for component_pack in hand_card_list:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "chooseHandCard")

func chooseHandCard(component_key):
	destroyRouteFromChooseHandCard()
	destroyRouteToNextTurn()

	service().setChosenHandCard(component_key)
	render().renderChosenHandCardMark(component_key)
	# renderOptionalTargetMark

	createRouteToCancelHandCard(component_key)
	createRouteToChooseTargetCard()

func createRouteToCancelHandCard(component_key):
	var hand_card_list = render().getHandCardList()
	for component_pack in hand_card_list:
		if component_pack.getKey() == component_key:
			__createRoute(component_pack, "pressed", "cancelHandCard")

func destroyRouteFromCancelHandCard():
	var hand_card_list = render().getHandCardList()
	for component_pack in hand_card_list:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "cancelHandCard")

func cancelHandCard(_component_key):
	destroyRouteFromChooseTargetCard()
	destroyRouteFromCancelHandCard()

	render().clearChosenHandCardMark()
	# clearOptionalTargetMark
	service().resetChosenHandCard()

	createRouteToChooseHandCard()
	createRouteToNextTurn()
	
func createRouteToChooseTargetCard():
	var optional_target_list = render().getOptionalTargetList()
	for component_pack in optional_target_list:
		__createRoute(component_pack, "pressed", "chooseTargetCard")
	
func destroyRouteFromChooseTargetCard():
	var own_team = render().getOwnTeamList()
	for component_pack in own_team:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "chooseTargetCard")

	var enemy_team = render().getEnemyTeamList()
	for component_pack in enemy_team:
		if component_pack.isConnected("pressed"):
			__destroyRoute(component_pack, "pressed", "chooseTargetCard")

func chooseTargetCard(component_key):
	destroyRouteFromChooseTargetCard()
	destroyRouteFromCancelHandCard()

	__playHandCard(component_key)
	__handleHandCardAfterPlay()
	__removeDeadCharacter()

	if service().isBattleOver():
		battlerOver()
	else:
		createRouteToChooseHandCard()
		createRouteToNextTurn()

func battlerOver():
	service().battleOver()

func __playHandCard(component_key):
	service().playChosenHandCardAt(component_key)

func __handleHandCardAfterPlay():
	service().resetChosenHandCard()
	render().clearChosenHandCardMark()
	render().renderHandCards()

func __removeDeadCharacter():
	service().removeDeadCharacter()
	render().renderOwnTeam()
	render().renderEnemyTeam()

func createRouteToNextTurn():
	var component_pack = render().getNextTurnButton()
	__createRoute(component_pack, "pressed", "nextTurn")

func destroyRouteToNextTurn():
	var component_pack = render().getNextTurnButton()
	__destroyRoute(component_pack, "pressed", "nextTurn")

func nextTurn(_component_key):
	service().nextTurnPrepare()
	render().clearHandCards()

	roundBegin()

func __createRoute(component_pack, component_signal, target_func):
	Exception.assert(not component_pack.isConnected(component_signal))
	component_pack.connectTo(self, component_signal, target_func)

func __destroyRoute(component_pack, component_signal, target_func):
	Exception.assert(component_pack.isConnected(component_signal))
	component_pack.disconnectFrom(self, component_signal, target_func)
