extends Node
class_name LinearBattleDispatcher

## Dispatcher将以信号的方式推进流程，即上一步骤结束后，发送进行下一步骤的信号，根据信号决定执行的时机

var scene_ref

func launch():
	sceneComponentInit()

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func render():
	return scene_ref.render()

func service():
	return scene_ref.service()

func initCharacterCards():
	service().initCharacterCardGroup()
	render().renderCharacter()

func setCurCharacterCard():
	service().initOrderBucket()
	service().setCurCharacterCard()
	render().markCurCharacter()

func setCurHandCards():
	service().drawCurHandCards()
	render().renderCurHandCard()

func sceneComponentInit():
	initCharacterCards()
	setCurCharacterCard()
	setCurHandCards()
	createRoutesToChooseHandCard()

func createRoutesToChooseHandCard():
	var hand_card_group = render().getHandCardButtonGroup()
	for component_pack in hand_card_group:
		__createRoute(component_pack, "pressed", "chooseHandCard")

func destroyRoutesFromChooseHandCard():
	var hand_card_group = render().getHandCardButtonGroup()
	for component_pack in hand_card_group:
		__destroyRoute(component_pack, "pressed", "chooseHandCard")

func chooseHandCard(component_key):
	destroyRoutesFromChooseHandCard()
	createRouteToCancelHandCard(component_key)
	createRouteToChooseTargetCard()
	
func createRouteToCancelHandCard(component_key):
	var hand_card_group = render().getHandCardButtonGroup()
	for component_pack in hand_card_group:
		if component_pack.getKey() == component_key:
			__createRoute(component_pack, "pressed", "cancelHandCard")

func cancelHandCard():
	pass

func createRouteToChooseTargetCard():
	var enemy_character_group = render().getCharacterButtonGroup(1)
	for component_pack in enemy_character_group:
		__createRoute(component_pack, "pressed", "chooseTargetCard")

func chooseTargetCard():
	pass

func __createRoute(component_pack, component_signal, target_func):
	component_pack.connectTo(self, component_signal, target_func)

func __destroyRoute(component_pack, component_signal, target_func):
	component_pack.disconnectFrom(self, component_signal, target_func)
