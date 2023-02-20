extends Node
class_name LinearBattleRender

var Emitter = TypeUnit.type("Emitter")
var ComponentPack = TypeUnit.type("ComponentPack")
	
var scene_ref

var own_team_list				# ComponentPack_2DArray
var enemy_team_list				# ComponentPack_Array
var hand_card_list
var action_character_mark		# ComponentPack
var chosen_hand_card_mark		# ComponentPack
var chosen_character_mark		# ComponentPack
var next_round_button			# ComponentPack

func _init():
	own_team_list = []
	enemy_team_list = []
	hand_card_list = []
	action_character_mark = null
	chosen_hand_card_mark = null
	chosen_character_mark = null
	next_round_button = null

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

# own_team_list
func getOwnTeamList():
	return own_team_list

func clearOwnTeamList():
	own_team_list.clear()

# enemy_team_list
func getEnemyTeamList():
	return enemy_team_list

func clearEnemyTeamList():
	enemy_team_list.clear()

func getOptionalTargetList():
	var chosen_hand_card = model().getChosenHandCard()
	var scene_name = scene().getSceneName()
	var own_team = model().getOwnCharacterTeam()
	var enemy_team = model().getEnemyCharacterTeam()

	var ret = []

	var i = 0
	for character_card in own_team:
		if chosen_hand_card.isTargetCondition(character_card, scene_name):
			ret.append(own_team_list[i])

		i += 1
			
	var j = 0
	for character_card in enemy_team:
		if chosen_hand_card.isTargetCondition(character_card, scene_name):
			ret.append(enemy_team_list[j])

		j += 1

	return ret

# hand_card_button_group
func getHandCardList():
	return hand_card_list

func getOptionalHandCardList():
	var hand_cards = model().getActionHandCards()
	var optional_hand_card_list = []

	var i = 0
	for hand_card in hand_cards:
		if hand_card.isPositive():
			optional_hand_card_list.append(hand_card_list[i])

		i += 1
	
	return optional_hand_card_list

func clearHandCardList():
	# clearHandCardAnime
	hand_card_list.clear()

# action_character_mark
func getActionCharacterMark():
	return action_character_mark

# next_round_button
func getNextRoundButton():
	return next_round_button

func renderNextRoundButton():
	var texture = ResourceUnit.loadRes("linear_battle", "linear_battle", "next_round_button")
	var next_round = scene().get_node("NextRoundButton")
	next_round.texture_normal = texture

	# TODO: 添加按钮文字

	next_round_button = ComponentPack.new("__nextRoundButton", next_round)

func getChosenCharacterMark():
	return chosen_character_mark

func __getOwnTeamPositionList():
	var character_num = model().getOwnCharacterNum()

	if character_num <= 0:
		return []

	var rect_size = __getCharacterCardRectSize()
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]

	var v_pos = int(height * 0.4)
	var h_half = int(width * 0.5)

	var ret = []
	var gap = int(h_half / character_num)
	var init_margin = (gap - rect_size[0]) / 2

	for index in range(character_num):
		ret.append(Vector2(index * gap + init_margin, v_pos))

	return ret

func __getEnemyTeamPositionList():
	var character_num = model().getEnemyCharacterNum()

	if character_num <= 0:
		return []

	var rect_size = __getCharacterCardRectSize()
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]

	var v_pos = int(height * 0.4)
	var h_half = int(width * 0.5)

	var ret = []
	var gap = int(h_half / character_num)
	var init_margin = (gap - rect_size[0]) / 2

	for index in range(character_num):
		ret.append(Vector2(h_half + index * gap + init_margin, v_pos))

	return ret

func __findComponetPack(list, component_key):
	for component_pack in list:
		if component_pack.getKey() == component_key:
			return component_pack
	
	return null

func __delComponentPack(list, component_key):
	var i = 0
	while i < list.size():
		if list[i][0].getKey() == component_key:
			list.remove(i)
			return
		i += 1

func renderOwnTeam():
	var own_character_team = model().getOwnCharacterTeam()
	var rect_size = __getCharacterCardRectSize()
	var rect_position_list = __getOwnTeamPositionList()

	var list = []
	var insert_list = []
	var del_list = []
	var keep_list = []

	for component_pack in own_team_list:
		del_list.append([component_pack, component_pack.getComponent().rect_position])

	var i = 0
	for character_card in own_character_team:
		var component_key = character_card.getCardName()

		__delComponentPack(del_list, component_key)

		var component_pack = __findComponetPack(own_team_list, component_key)
		if component_pack == null:
			var avator_name = character_card.getAvatorName()
			var texture = ResourceUnit.loadRes("global", "avator", avator_name)
			var rect_position = rect_position_list[i]
			var character_button = TextureButton.new()
			character_button.expand = true
			character_button.texture_normal = texture
			character_button.rect_size = rect_size

			component_pack = ComponentPack.new(component_key, character_button)

			insert_list.append([component_pack, rect_position])
		else:
			keep_list.append([component_pack, rect_position_list[i]])

		list.append(component_pack)

		i += 1
	
	own_team_list = list

	for del_pack in del_list:
		#TODO: delCharacterAnime
		var component_pack = del_pack[0]
		var rect_position = del_pack[1]
		delAnime(component_pack, rect_position)
	
	for keep_pack in keep_list:
		var component_pack = keep_pack[0]
		var rect_position = keep_pack[1]

		moveAnime(component_pack, rect_position)
	
	for insert_pack in insert_list:
		var component_pack = insert_pack[0]
		var rect_position = insert_pack[1]

		insertAnime(component_pack, rect_position)

func clearOwnTeam():
	for component_pack in own_team_list:
		scene().remove_child(component_pack.getComponent())
	
	own_team_list.clear()

func renderEnemyTeam():
	var enemy_character_team = model().getEnemyCharacterTeam()
	var rect_size = __getCharacterCardRectSize()
	var rect_position_list = __getEnemyTeamPositionList()

	var list = []
	var insert_list = []
	var del_list = []
	var keep_list = []

	for component_pack in enemy_team_list:
		del_list.append([component_pack, component_pack.getComponent().rect_position])

	var i = 0
	for character_card in enemy_character_team:
		var component_key = character_card.getCardName()
		var component_pack = __findComponetPack(enemy_team_list, component_key)

		__delComponentPack(del_list, component_key)

		if component_pack == null:
			var avator_name = character_card.getAvatorName()
			var texture = ResourceUnit.loadRes("global", "avator", avator_name)
			var rect_position = rect_position_list[i]
			var character_button = TextureButton.new()
			character_button.expand = true
			character_button.texture_normal = texture
			character_button.rect_size = rect_size

			component_pack = ComponentPack.new(component_key, character_button)

			insert_list.append([component_pack, rect_position])
		else:
			keep_list.append([component_pack, rect_position_list[i]])

		list.append(component_pack)

		i += 1
	
	enemy_team_list = list


	for del_pack in del_list:
		#TODO: delCharacterAnime
		var component_pack = del_pack[0]
		var rect_position = del_pack[1]
		delAnime(component_pack, rect_position)
	
	for keep_pack in keep_list:
		var component_pack = keep_pack[0]
		var rect_position = keep_pack[1]
		moveAnime(component_pack, rect_position)
	
	for insert_pack in insert_list:
		var component_pack = insert_pack[0]
		var rect_position = insert_pack[1]
		insertAnime(component_pack, rect_position)
	
func clearEnemyTeam():
	for component_pack in enemy_team_list:
		scene().remove_child(component_pack.getComponent())
	
	enemy_team_list.clear()
	
func insertAnime(component_pack, final_rect_position):
	var component = component_pack.getComponent()

	var init_rect_position = final_rect_position
	init_rect_position[1] -= 80

	component.rect_position = init_rect_position
	scene().add_child(component_pack.getComponent())

	var tween = scene().get_node("Tween")
	tween.interpolate_property(component, 
							   "rect_position",
							   init_rect_position,
							   final_rect_position,
							   0.5,
							   Tween.TRANS_LINEAR,
							   Tween.EASE_IN_OUT
							   )
	
	tween.start()
	tween.interpolate_callback(self, 0.5, "__insertAnimeCallBack", component, final_rect_position)

func __insertAnimeCallBack(component, final_rect_position):
	component.rect_position = final_rect_position

func moveAnime(component_pack, next_rect_position):
	var component = component_pack.getComponent()

	var tween = scene().get_node("Tween")
	tween.interpolate_property(component, 
							   "rect_position",
							   null, 
							   next_rect_position,
							   0.5,
							   Tween.TRANS_LINEAR,
							   Tween.EASE_IN_OUT
							   )
	
	tween.start()
	tween.interpolate_callback(self, 0.5, "__moveAnimeCallBack", component, next_rect_position)

func __moveAnimeCallBack(component, next_rect_position):
	component.rect_position = next_rect_position

func delAnime(component_pack, init_rect_position):
	var component = component_pack.getComponent()

	var next_rect_position = init_rect_position
	next_rect_position[1] += 80
	
	var tween = scene().get_node("Tween")
	tween.interpolate_property(component, 
							   "rect_position",
							   init_rect_position, 
							   next_rect_position,
							   0.5,
							   Tween.TRANS_LINEAR,
							   Tween.EASE_IN_OUT
							   )
	
	tween.start()
	tween.interpolate_callback(self, 0.5, "__delAnimeCallBack", component)

func __delAnimeCallBack(component):
	scene().remove_child(component)

func renderActionCharacterMark():
	var action_character = model().getActionCharacter()

	var rect_position_list
	var team_list
	if service().isOwnAction():
		rect_position_list = __getOwnTeamPositionList()
		team_list = own_team_list
	elif service().isEnemyAction():
		rect_position_list = __getEnemyTeamPositionList()
		team_list = enemy_team_list
	else:
		Logger.error("Action character not exists!")
	
	var rect_position

	var i = 0
	for component_pack in team_list:
		if component_pack.getKey() == action_character.getCardName():
			rect_position = rect_position_list[i]

		i += 1

	var rect_size = __getCharacterCardRectSize()
	rect_position[1] += rect_size[1]

	if action_character_mark == null:
		var texture = ResourceUnit.loadRes("global", "component", "action_character_mark")
		
		var mark_texture_rect = TextureRect.new()
		mark_texture_rect.texture = texture
		mark_texture_rect.rect_position = rect_position
		mark_texture_rect.rect_size = rect_size

		scene().add_child(mark_texture_rect)

		var component_pack = ComponentPack.new("__action_character_mark", mark_texture_rect)
		action_character_mark = component_pack
	else:
		#TODO: actionCharacterMarkMoveAnime
		action_character_mark.getComponent().rect_position = rect_position

func clearActionCharacterMark():
	scene().remove_child(action_character_mark.getComponent())
	action_character_mark = null

func renderChosenHandCardMark(component_key):
	var hand_cards = model().getActionHandCards()
	var rect_position_list = __getHandCardRectPositionList(hand_cards.size())

	var i = 0
	for hand_card in hand_cards:
		if hand_card.getCardName() == component_key:
			var rect_position = rect_position_list[i]
			if chosen_hand_card_mark == null:
				var texture = ResourceUnit.loadRes("global", "component", "chosen_hand_card_mark")
				var mark_texture_rect = TextureRect.new()

				mark_texture_rect.texture = texture
				mark_texture_rect.rect_position = rect_position

				scene().add_child(mark_texture_rect)

				var component_pack = ComponentPack.new("__chosen_hand_card_mark", mark_texture_rect)
				chosen_hand_card_mark = component_pack
			else:
				# moveChosenHandCardMark
				chosen_hand_card_mark.getComponent().rect_position = rect_position

			return
		i += 1

func clearChosenHandCardMark():
	scene().remove_child(chosen_hand_card_mark.getComponent())
	chosen_hand_card_mark = null

## setCurHandCardsRect
func __getHandCardRectPositionList(card_num):
	var rect_size = __getHandCardRectSize()
	var width = GlobalSetting.getAttr("screen_size")[0]
	var height = GlobalSetting.getAttr("screen_size")[1]
	var rect_width = rect_size[0]
	var v_pos = height * 0.8
	var h_margin = int((width - rect_width * card_num) / 2)

	var ret = []
	for index in range(card_num):
		ret.append(Vector2(h_margin + index * rect_width, v_pos))
	
	return ret

func renderHandCards():
	var hand_cards = model().getActionHandCards()
	var rect_size = __getHandCardRectSize()
	var rect_position_list = __getHandCardRectPositionList(hand_cards.size())

	var list = []
	var del_list = []
	var keep_list = []
	var insert_list = []

	for component_pack in hand_card_list:
		del_list.append([component_pack, component_pack.getComponent().rect_position])

	var i = 0
	for hand_card in hand_cards:
		var component_key = hand_card.getCardName()
		__delComponentPack(del_list, component_key)

		var component_pack = __findComponetPack(hand_card_list, component_key)
		if component_pack == null:
			var avator_name = hand_card.getAvatorName()
			var texture = ResourceUnit.loadRes("global", "avator", avator_name)
			var rect_position = rect_position_list[i]

			var hand_card_button = TextureButton.new()
			hand_card_button.expand = true
			hand_card_button.texture_normal = texture
			hand_card_button.rect_size = rect_size
			
			component_pack = ComponentPack.new(hand_card.getCardName(), hand_card_button)
			insert_list.append([component_pack, rect_position])
		else:
			keep_list.append([component_pack, rect_position_list[i]])

		list.append(component_pack)

		i += 1

	for del_pack in del_list:
		var component_pack = del_pack[0]
		var rect_position = del_pack[1]
		delAnime(component_pack, rect_position)
	
	for keep_pack in keep_list:
		var component_pack = keep_pack[0]
		var rect_position = keep_pack[1]
		moveAnime(component_pack, rect_position)
	
	for insert_pack in insert_list:
		var component_pack = insert_pack[0]
		var rect_position = insert_pack[1]
		insertAnime(component_pack, rect_position)
	
	hand_card_list = list

func clearHandCards():
	for component_pack in hand_card_list:
		scene().remove_child(component_pack.getComponent())
	
	hand_card_list.clear()

func __getCharacterCardRectSize():
	return Vector2(model().getSettingAttr("character_card_rect_size")[0], model().getSettingAttr("character_card_rect_size")[1])

func __getHandCardRectSize():
	return Vector2(model().getSettingAttr("hand_card_rect_size")[0], model().getSettingAttr("hand_card_rect_size")[1])

# setBackground
func getBackground():
	return scene().get_node("LinearBattleBackground")

func setBackground():
	var scene_name = scene().getSceneName()
	var bg = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("LinearBattleBackground").texture = bg
