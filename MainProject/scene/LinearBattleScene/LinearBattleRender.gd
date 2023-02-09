extends Node
class_name LinearBattleRender

var Emitter = TypeUnit.type("Emitter")

class ComponentPack:
	var key
	var component
	var connection_table

	func _init():
		key = ""
		component = null
		connection_table = {}
	
	func getKey():
		return key
	
	func getComponent():
		return component

	func setKey(key_):
		key = key_
	
	func setComponent(component_):
		component = component_
	
	func connectTo(entity, component_signal, target_func):
		var emitter = Emitter.new()
		emitter.setParam(key)
		emitter.connectTo(entity, target_func)
		Exception.assert(not connection_table.has(component_signal))
		component.connect(component_signal, emitter, emitter.emitFuncName())
		connection_table[component_signal] = emitter
	
	func disconnectFrom(entity, component_signal, target_func):
		Exception.assert(connection_table.has(component_signal))
		var emitter = connection_table[component_signal]
		component.disconnect(component_signal, emitter, emitter.emitFuncName())
		emitter.disconnectFrom(entity, target_func)
		connection_table.erase(component_signal)
	
	func isConnected(component_signal):
		return connection_table.has(component_signal)

var scene_ref

var character_button_groups		# ComponentPack_2DArray
var hand_card_button_group		# ComponentPack_Array
var cur_character_mark			# ComponentPack
var chosen_hand_card_mark		# ComponentPack
var chosen_character_mark		# ComponentPack

func _init():
	character_button_groups = [[], []]
	hand_card_button_group = []
	cur_character_mark = null
	chosen_character_mark = null

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func service():
	return scene_ref.service()

func dispatcher():
	return scene_ref.dispatcher()

# character_button_groups
func getCharacterButtonGroup(index):
	return character_button_groups[index]

func getCharacterButtonGroups():
	return character_button_groups

# hand_card_button_group
func getHandCardButtonGroup():
	return hand_card_button_group

func getCurCharacterMarkLine():
	return cur_character_mark

func __getChosenCharacterMarkLine():
	return chosen_character_mark
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

func renderCharacter():
	var character_groups = model().getCharacterGroups()
	var rect_size = __getCharacterCardRectSize()
	var rect_position = __getCharacterCardRectPosition()

	for i in 2:
		var j = 0
		for card_name in character_groups[i].keys():
			var avator_name = character_groups[i].get(card_name).getAvatorName()
			var texture = ResourceUnit.loadRes("global", "avator", avator_name)
			var rect_pos = Vector2(rect_position[i][j][0], rect_position[i][j][1])
			var character_button = __buildTextureButton(texture, rect_pos, rect_size)
			scene().add_child(character_button)

			var component_pack = __buildComponentPack(card_name, character_button)
			character_button_groups[i].append(component_pack)
			j += 1

func markCurCharacter():
	var index = service().getCurCharacterIndex()
	var pos = __getCharacterCardRectPosition()[index[0]][index[1]]
	var card_rect_size = __getCharacterCardRectSize()

	var texture = ResourceUnit.loadRes("global", "component", "underline")
	var position = Vector2(pos[0], pos[1] + card_rect_size[1])
	var rect_size = Vector2(card_rect_size[0], 20)

	var mark_rect = __buildTextureRect(texture, position, rect_size)

	if cur_character_mark != null:
		scene().remove_child(cur_character_mark.getComponent())

	scene().add_child(mark_rect)

	var component_pack = __buildComponentPack("__mark_rect", mark_rect)
	cur_character_mark = component_pack

## setCurHandCardsRect
func __getHandCardRectPosition(card_num):
	var rect_size = __getHandCardRectSize()
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]
	var rect_width = rect_size[0]
	var v_pos = height * 0.8
	var h_margin = int((width - rect_width * card_num) / 2)

	var ret = []
	for index in range(card_num):
		ret.append([h_margin + index * rect_width, v_pos])
	
	return ret

func renderCurHandCard():
	var cur_character_card = model().getCurCharacterCard()
	var cur_hand_cards = cur_character_card.peekHandCards()
	var rect_size = __getHandCardRectSize()
	var rect_position = __getHandCardRectPosition(cur_hand_cards.size())
	hand_card_button_group = []

	var index = 0
	for hand_card in cur_hand_cards:
		var avator_name = hand_card.getAvatorName()
		var texture = ResourceUnit.loadRes("global", "avator", avator_name)
		var rect_pos = Vector2(rect_position[index][0], rect_position[index][1])

		var hand_card_button = __buildTextureButton(texture, rect_pos, rect_size)
		scene().add_child(hand_card_button)

		var component_pack = __buildComponentPack(hand_card.getCardName(), hand_card_button)
		hand_card_button_group.append(component_pack)
		index += 1

func __buildTextureRect(texture, rect_pos, rect_size):
	var card_rect = TextureRect.new()

	card_rect.texture = texture
	card_rect.expand = true
	card_rect.rect_size = rect_size
	print(card_rect.get_rect())
	card_rect.rect_position = rect_pos

	return card_rect

func __buildTextureButton(texture, rect_pos, rect_size):
	var card_rect = TextureButton.new()

	card_rect.texture_normal = texture
	card_rect.expand = true
	card_rect.rect_size = rect_size
	card_rect.rect_position = rect_pos

	return card_rect

func __buildComponentPack(key, component):
	var component_pack = ComponentPack.new()
	component_pack.setKey(key)
	component_pack.setComponent(component)

	return component_pack

func __getCharacterCardRectSize():
	return Vector2(model().getSettingAttr("character_card_rect_size")[0], model().getSettingAttr("character_card_rect_size")[1])

func __getHandCardRectSize():
	return Vector2(model().getSettingAttr("hand_card_rect_size")[0], model().getSettingAttr("hand_card_rect_size")[1])

# setBackground
func setBackground():
	var scene_name = scene().getSceneName()
	var bg = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("LinearBattleBackground").texture = bg
