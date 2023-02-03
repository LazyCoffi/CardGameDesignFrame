extends Node
class_name LinearBattleRender

var scene_ref
var model_ref

var character_rect_groups	# TextureRect_DictArray_Array
var hand_card_rect_group	# TextureRect_DictArray

func setRef(scene):
	scene_ref = scene
	model_ref = scene.model()

## initCharacterRect 
func __getCharacterCardRectPosition(group_num):
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]

	var v_pos = int(height * 0.4)
	var h_half = int(width * 0.5)

	var ret = [[], []]
	var gap = []
	gap.append(int(h_half / group_num[0]))
	gap.append(int(h_half / group_num[1]))
	for index in range(group_num[0]):
		ret[0].append([(index + 1) * gap[0], v_pos])
	for index in range(group_num[1]):
		ret[1].append([h_half + (index + 1) * gap[1], v_pos])

	return ret

func initCharacterRect():
	var rect_size = Vector2(model_ref.getSettingAttr("character_card_rect_size")[0], model_ref.getSettingAttr("character_card_rect_size")[1])
	var character_groups = model_ref.getCharacterGroups()
	var rect_position = __getCharacterCardRectPosition([character_groups[0].size(), character_groups[1].size()])
	character_rect_groups = [DictArray.new(), DictArray.new()]

	for i in 2:
		var j = 0
		for card_name in character_groups[i].keys():
			var avator_name = character_groups[i].get(card_name).getAvatorName()
			var texture = ResourceUnit.loadTexture(card_name, card_name, avator_name)
			var rect_pos = Vector2(rect_position[i][j][0], rect_position[i][j][1])
			var character_rect = __buildCardRect(texture, rect_pos, rect_size)
			scene_ref.add_child(character_rect)
			character_rect_groups[i].append(card_name, character_rect)
			j += 1


## setCurHandCardsRect
func __getHandCardRectPosition(card_num, rect_size):
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]
	var rect_width = rect_size[0]
	var v_pos = height * 0.2
	var h_margin = int((width - rect_width * card_num) / 2)

	var ret = []
	for index in range(card_num):
		ret.append([h_margin + index * rect_width, v_pos])
	
	return ret

func setCurHandCardRectGroup():
	var cur_hand_cards = model_ref.getCurHandCards()
	var rect_size = Vector2(model_ref.getSettingAttr("hand_card_rect_size")[0], model_ref.getSettingAttr("hand_card_rect_size")[1])
	var rect_position = __getHandCardRectPosition(cur_hand_cards.size(), rect_size)
	hand_card_rect_group = DictArray.new()

	var index = 0
	for hand_card in cur_hand_cards.values():
		var card_name = hand_card.getCardName()
		var avator_name = hand_card.getAvatorName()
		var texture = ResourceUnit.getTexture(card_name, card_name, avator_name)
		var rect_pos = Vector2(rect_position[index][0], rect_position[index][1])

		var hand_card_rect = __buildCardRect(texture, rect_pos, rect_size)
		scene_ref.add_child(hand_card_rect)

		hand_card_rect_group.append(card_name, hand_card_rect)

func __buildCardRect(texture, rect_pos, rect_size):
	var card_rect = TextureRect.new()

	card_rect.texture = texture
	card_rect.rect_size = rect_size
	card_rect.rect_position = rect_pos

	return card_rect

# setBackground
func setBackground():
	var scene_name = scene_ref.getSceneName()
	var bg = ResourceUnit.loadTexture(scene_name, scene_name, "background")
	scene_ref.get_node("LinearBattleBackground").texture = bg
