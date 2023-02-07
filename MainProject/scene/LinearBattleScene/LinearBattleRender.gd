extends Node
class_name LinearBattleRender

var scene_ref

var character_rect_groups	# TextureRect_DictArray_Array
var hand_card_rect_group	# TextureRect_DictArray
var cur_mark_line

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func service():
	return scene_ref.service()

## initCharacterRect 
func __getCharacterCardRectPosition():
	var group_num = model().getCharacterGroupsNum()
	var rect_size = __getCharacterCardRectSize()
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]

	var v_pos = int(height * 0.4)
	var h_half = int(width * 0.5)

	var ret = [[], []]
	var gap = []
	var init_margin = []

	gap.append(int(h_half / group_num[0]))
	gap.append(int(h_half / group_num[1]))

	init_margin.append((gap[0] - rect_size[0]) / 2)
	init_margin.append(init_margin[0] + h_half)

	for index in range(group_num[0]):
		ret[0].append([index * gap[0] + init_margin[0], v_pos])
	for index in range(group_num[1]):
		ret[1].append([index * gap[1] + init_margin[1], v_pos])
	
	return ret

func initCharacterRect():
	var character_groups = model().getCharacterGroups()
	var rect_size = __getCharacterCardRectSize()
	var rect_position = __getCharacterCardRectPosition()
	character_rect_groups = [DictArray.new(), DictArray.new()]

	for i in 2:
		var j = 0
		for card_name in character_groups[i].keys():
			var avator_name = character_groups[i].get(card_name).getAvatorName()
			var texture = ResourceUnit.loadRes("global", "avator", avator_name)
			var rect_pos = Vector2(rect_position[i][j][0], rect_position[i][j][1])
			var character_rect = __buildTextureRect(texture, rect_pos, rect_size)
			scene().add_child(character_rect)
			character_rect_groups[i].append(card_name, character_rect)
			j += 1

func markCurCharacter():
	var texture = ResourceUnit.loadRes("global", "component", "underline")

	var index = service().getCurCharacterIndex()
	var pos = __getCharacterCardRectPosition()[index[0]][index[1]]
	var card_rect_size = __getCharacterCardRectSize()
	var position = Vector2(pos[0], pos[1] + card_rect_size[1])

	var rect_size = Vector2(card_rect_size[0], 20)

	var mark_rect = __buildTextureRect(texture, position, rect_size)

	if cur_mark_line != null:
		scene().remove_child(cur_mark_line)

	scene().add_child(mark_rect)
	cur_mark_line = mark_rect

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
	var cur_hand_cards = model().getCurHandCards()
	var rect_size = __getHandCardRectSize()
	var rect_position = __getHandCardRectPosition(cur_hand_cards.size(), rect_size)
	hand_card_rect_group = DictArray.new()

	var index = 0
	for hand_card in cur_hand_cards.values():
		var card_name = hand_card.getCardName()
		var avator_name = hand_card.getAvatorName()
		var texture = ResourceUnit.loadRes("global", "avator", avator_name)
		var rect_pos = Vector2(rect_position[index][0], rect_position[index][1])

		var hand_card_rect = __buildTextureRect(texture, rect_pos, rect_size)
		scene().add_child(hand_card_rect)

		hand_card_rect_group.append(card_name, hand_card_rect)

func __buildTextureRect(texture, rect_pos, rect_size):
	var card_rect = TextureRect.new()

	card_rect.texture = texture
	card_rect.expand = true
	card_rect.rect_size = rect_size
	print(card_rect.get_rect())
	card_rect.rect_position = rect_pos

	return card_rect

func __getCharacterCardRectSize():
	return Vector2(model().getSettingAttr("character_card_rect_size")[0], model().getSettingAttr("character_card_rect_size")[1])

func __getHandCardRectSize():
	return Vector2(model().getSettingAttr("hand_card_rect_size")[0], model().getSettingAttr("hand_card_rect_size")[1])

# setBackground
func setBackground():
	var scene_name = scene().getSceneName()
	var bg = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("LinearBattleBackground").texture = bg
