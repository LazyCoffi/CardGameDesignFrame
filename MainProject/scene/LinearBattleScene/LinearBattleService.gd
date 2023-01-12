extends Node
class_name LinearBattleService

var __scene_ref
var __model_ref

class CharacterRectPack:
	var rect_name
	var rect

func setRef(scene):
	__scene_ref = scene
	__model_ref = scene.model()

func initCharacterRect():
	var rect_size_arr = __model_ref.getSettingAttr("character_card_rect_size")
	var rect_size = Vector2(rect_size_arr[0], rect_size_arr[1])
	var group_num = __model_ref.getGroupNum()
	var rect_position = __getCharacterCardPosition(group_num)

	var character_groups = __model_ref.getCharacterGroups()
	var character_rect_groups = [[], []]
	for i in 2:
		var j = 0
		for card_name in character_groups.keys():
			var character_rect = TextureRect.new()
			var avator_name = character_groups[card_name].getAvatorName()
			var texture = ResourceUnit.loadTexture(card_name, card_name, avator_name)
			character_rect.texture = texture
			character_rect.rect_size = rect_size
			var rect_pos_arr = rect_position[i][j]
			j += 1
			var rect_pos = Vector2(rect_pos_arr[0], rect_pos_arr[1])
			character_rect.rect_position = rect_pos
			__scene_ref.add_child(character_rect)
			
			var character_rect_pack = CharacterRectPack.new()
			character_rect_pack.rect_name = card_name
			character_rect_pack.rect = character_rect
			character_rect_groups[i].append(character_rect_pack)
		
	__model_ref.setCharacterRectGroups(character_rect_groups)

func initCharacterCardGroup():
	var scene_pack = __model_ref.getScenePack()
	var character_deal_filter = __model_ref.getCharacterDealFilter()
	var character_cards = character_deal_filter.exec([scene_pack["init_character_cards"]])
	__model_ref.setCardGroup(character_cards[0], character_cards[1])

func setBackground():
	var scene_name = __scene_ref.getSceneName()
	var bg = ResourceUnit.loadTexture(scene_name, scene_name, "background")
	__scene_ref.get_node("LinearBattleBackground").texture = bg

func setCurCharacterCard(cur_character_card):
	__model_ref.setCurCharacterCard(cur_character_card)

func getCurCharacterCard():
	return __model_ref.popCurRoundCard()

func markCurCharacter(character_card):
	# TODO: 在当前出牌者位置设置标记
	pass

func newCurHandCards():
	var cur_character_card = __model_ref.getCurCharacterCard()
	var cur_character_name = cur_character_card.getCardName()
	var cur_hand_cards_num = __model_ref.getHandCardsNum(cur_character_name)
	var hand_cards_upper = __model_ref.getSettingAttr("hand_cards_upper")
	return cur_character_card.getCards(max(hand_cards_upper - cur_hand_cards_num, 0))

func addCurHandCards(new_hand_cards):
	var cur_character_name = __model_ref.getCurCharacterCard().getCardName()
	__model_ref.addHandCards(cur_character_name, new_hand_cards)

func setCurHandCardsRect():
	var cur_character_name = __model_ref.getCurCharacterCard().getCardName()
	var cur_hand_cards = __model_ref.getHandCards(cur_character_name)
	var rect_size_arr = __model_ref.getSettingAttr("hand_card_rect_size")
	var rect_size = Vector2(rect_size_arr[0], rect_size_arr[1])
	var rect_position = __getHandCardRectPosition(cur_hand_cards.size(), rect_size)

	var index = 0
	for hand_card in cur_hand_cards:
		var card_rect = TextureRect.new()

		card_rect.rect_size = rect_size

		var card_name = hand_card.getCardName()
		var avator_name = hand_card.getAvatorName()
		var texture = ResourceUnit.getTexture(card_name, card_name, avator_name)
		card_rect.texture = texture

		var rect_pos_arr = rect_position[index]
		var rect_pos = Vector2D(rect_pos_arr[0], rect_pos_arr[1])
		card_rect.rect_position = rect_pos

		__scene_ref.add_child(card_rect)


func __getCharacterCardRectPosition(group_num):
	var screen_size = GlobalSetting.getAttr("screen_size")
	var width = screen_size[0]
	var height = screen_size[1]

	var v_pos = MathUnit.toInt(height * 0.4)
	var h_half = MathUnit.toInt(width * 0.5)

	var ret = [[], []]
	var gap = MathUnit.toInt(h_half / group_num[i])
	for index in range(group_num[0]):
		ret[0].append([(index + 1) * gap, v_pos])
	for index in range(group_num[1]):
		ret[1].append([half + (index + 1) * gap, v_pos])
	return ret

func __getHandCardRectPosition(card_num, rect_size):
	var screen_size = GlobalSetting.getAttr("screen_size")
	var width = screen_size[0]
	var height = screen_size[1]

	var rect_width = rect_size[0]

	var v_pos = height * 0.2
	var h_margin = MathUnit.toInt((width - rect_width * card_num) / 2)

	var ret = []
	for index in range(card_num):
		ret.append([h_margin + index * rect_width, v_pos])
	
	return ret
