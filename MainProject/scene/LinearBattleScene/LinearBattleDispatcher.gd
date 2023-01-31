extends Node
class_name LinearBattleDispatcher

## Dispatcher将以信号的方式推进流程，即上一步骤结束后，发送进行下一步骤的信号，根据信号决定执行的时机

var render_ref
var service_ref

func launch():
	sceneComponentInit()

func setRef(scene):
	render_ref = scene.render()
	service_ref = scene.service()

func initCharacterCards():
	service_ref.initCharacterCardGroup()
	render_ref.initCharacterRect()

func setCurCharacterCard():
	var cur_character_card = service_ref.getCurCharacterCard()
	service_ref.setCurCharacterCard(cur_character_card)
	service_ref.markCurCharacter(cur_character_card)

func setCurHandCards():
	var new_hand_cards = service_ref.newCurHandCards()
	service_ref.addCurHandCards(new_hand_cards)
	service_ref.setCurHandCardsRect()

func sceneComponentInit():
	initCharacterCards()
	setCurCharacterCard()
	setCurHandCards()
