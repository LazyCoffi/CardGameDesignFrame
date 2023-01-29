extends Node
class_name LinearBattleService

var DictArray = load("res://class/entity/DictArray.gd")

var __scene_ref
var __model_ref

func setRef(scene):
	__scene_ref = scene
	__model_ref = scene.model()

## initCharacterRect 
func __getCharacterCardRectPosition(group_num):
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]

	var v_pos = MathUnit.toInt(height * 0.4)
	var h_half = MathUnit.toInt(width * 0.5)

	var ret = [[], []]
	var gap = []
	gap.append(MathUnit.toInt(h_half / group_num[0]))
	gap.append(MathUnit.toInt(h_half / group_num[1]))
	for index in range(group_num[0]):
		ret[0].append([(index + 1) * gap[0], v_pos])
	for index in range(group_num[1]):
		ret[1].append([h_half + (index + 1) * gap[1], v_pos])

	return ret

func initCharacterRect():
	var rect_size = Vector2(__model_ref.getSettingAttr("character_card_rect_size")[0], __model_ref.getSettingAttr("character_card_rect_size")[1])
	var character_groups = __model_ref.getCharacterGroups()
	var rect_position = __getCharacterCardRectPosition([character_groups[0].size(), character_groups[1].size()])
	var character_rect_groups = [DictArray.new(), DictArray.new()]

	for i in 2:
		var j = 0
		for card_name in character_groups[i].keys():
			var avator_name = character_groups[i].get(card_name).getAvatorName()
			var texture = ResourceUnit.loadTexture(card_name, card_name, avator_name)
			var rect_pos = Vector2(rect_position[i][j][0], rect_position[i][j][1])
			var character_rect = __buildCardRect(texture, rect_pos, rect_size)
			__scene_ref.add_child(character_rect)
			character_rect_groups[i].append(card_name, character_rect)
			j += 1

	__model_ref.setCharacterRectGroups(character_rect_groups)

func initCharacterCardGroup():
	__model_ref.setCharacterGroup(__model_ref.dealCharacter())

func refillOrderQueue():
	var order_queue = __model_ref.getOrderQueue()
	order_queue.clear()
	var character_groups = __model_ref.getCharacterGroups()
	for index in 2:
		for card in character_groups[index].values():
			order_queue.append(card, __model_ref.getOrder(card))

func setBackground():
	var scene_name = __scene_ref.getSceneName()
	var bg = ResourceUnit.loadTexture(scene_name, scene_name, "background")
	__scene_ref.get_node("LinearBattleBackground").texture = bg

func setCurCharacterCard(cur_character_card):
	__model_ref.setCurCharacterCard(cur_character_card)

func popCurCharacterCard():
	return __model_ref.popCurRoundCard()

func markCurCharacter(character_card):
	# TODO: 在当前出牌者位置设置标记
	pass

func genCurHandCards():
	var cur_hand_cards_num = __model_ref.getCurHandCardsNum()
	var hand_cards_upper = __model_ref.getSettingAttr("hand_cards_upper")
	var card_num = max(hand_cards_upper - cur_hand_cards_num, 0)
	return __model_ref.getCharacterGroups().getCards(card_num)

func addCurHandCards(hand_cards):
	var cur_hand_cards = __model_ref.getCurHandCards()
	cur_hand_cards.append_array(__model_ref.getCurCharacterName(), hand_cards)

## setCurHandCardsRect
func __getHandCardRectPosition(card_num, rect_size):
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]
	var rect_width = rect_size[0]
	var v_pos = height * 0.2
	var h_margin = MathUnit.toInt((width - rect_width * card_num) / 2)

	var ret = []
	for index in range(card_num):
		ret.append([h_margin + index * rect_width, v_pos])
	
	return ret

func setCurHandCardRectGroup():
	var cur_hand_cards = __model_ref.getCurHandCards()
	var rect_size = Vector2(__model_ref.getSettingAttr("hand_card_rect_size")[0], __model_ref.getSettingAttr("hand_card_rect_size")[1])
	var rect_position = __getHandCardRectPosition(cur_hand_cards.size(), rect_size)
	var hand_card_rect_group = DictArray.new()

	var index = 0
	for hand_card in cur_hand_cards.values():
		var card_name = hand_card.getCardName()
		var avator_name = hand_card.getAvatorName()
		var texture = ResourceUnit.getTexture(card_name, card_name, avator_name)
		var rect_pos = Vector2(rect_position[index][0], rect_position[index][1])

		var hand_card_rect = __buildCardRect(texture, rect_pos, rect_size)
		__scene_ref.add_child(hand_card_rect)

		hand_card_rect_group.append(card_name, hand_card_rect)

	__model_ref.setHandCardRectGroup(hand_card_rect_group)

func __buildCardRect(texture, rect_pos, rect_size):
	var card_rect = TextureRect.new()

	card_rect.texture = texture
	card_rect.rect_size = rect_size
	card_rect.rect_position = rect_pos

	return card_rect
