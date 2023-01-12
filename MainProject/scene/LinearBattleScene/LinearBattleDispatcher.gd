extends Node
class_name LinearBattleDispatcher

## Dispatcher将以信号的方式推进流程，即上一步骤结束后，发送进行下一步骤的信号，根据信号决定执行的时机

var __service_ref

func run():
	sceneComponentInit()

func setRef(scene):
	__service_ref = scene.service()

func initCharacterCards():
	__service_ref.initCharacterCardGroup()
	__service_ref.initCharacterRect()

func setCurCharacterCard():
	var cur_character_card = __service_ref.getCurCharacterCard()
	__service_ref.setCurCharacterCard(cur_character_card)
	__service_ref.markCurCharacter(cur_character_card)

func setCurHandCards():
	var new_hand_cards = __service_ref.newCurHandCards()
	__service_ref.addCurHandCards(new_hand_cards)
	__service_ref.setCurHandCardsRect()

func sceneComponentInit():
	initCharacterCards()
	setCurCharacterCard()
	setCurHandCards()
