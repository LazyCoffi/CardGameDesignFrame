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
	render().initCharacterRect()

func setCurCharacterCard():
	service().initOrderBucket()
	service().setCurCharacterCard()
	render().markCurCharacter()

func setCurHandCards():
	var new_hand_cards = service().newCurHandCards()
	service().addCurHandCards(new_hand_cards)
	service().setCurHandCardsRect()

func sceneComponentInit():
	initCharacterCards()
	setCurCharacterCard()
	# setCurHandCards()
