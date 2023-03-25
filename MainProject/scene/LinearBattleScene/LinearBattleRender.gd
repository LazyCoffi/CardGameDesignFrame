extends Node
class_name LinearBattleRender

var Emitter = TypeUnit.type("Emitter")
var ComponentPack = TypeUnit.type("ComponentPack")
	
var scene_ref

var own_team_list				# ComponentPack_Array
var enemy_team_list				# ComponentPack_Array
var hand_card_list				# ComponentPack_Array
var action_character_mark		# ComponentPack
var chosen_hand_card_mark		# ComponentPack
var chosen_character_mark		# ComponentPack
var next_round_button			# ComponentPack
var background					# ComponentPack
var sub_menu_entry_button		# ComponentPack

var state_list_cache			# Dict

func _init():
	own_team_list = []
	enemy_team_list = []
	hand_card_list = []
	action_character_mark = null
	chosen_hand_card_mark = null
	chosen_character_mark = null
	next_round_button = null
	state_list_cache = {}

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

func tween():
	return scene().get_node("Tween")

# background
func renderBackground():
	var bg = scene().get_node("LinearBattleBackground")
	var texture = ResourceUnit.loadRes(scene().getSceneName(), scene().getSceneName(), "background")
	var rect_size = Vector2(GlobalSetting.getScreenSize()[0], GlobalSetting.getScreenSize()[1])
	var rect_position = Vector2(0, 0)

	bg.rect_size = rect_size
	bg.rect_position = rect_position
	bg.expand = true
	bg.texture = texture

	var component_pack = ComponentPack.new("__background", bg)
	background = component_pack

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
		if hand_card.isOffensive():
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
	var texture_hover = ResourceUnit.loadRes("linear_battle", "linear_battle", "next_round_button_hover")
	var next_round = scene().get_node("NextRoundButton")
	next_round.texture_normal = texture
	next_round.texture_hover = texture_hover

	var next_round_text = scene().get_node("NextRoundButton/NextRoundButtonText")
	var font = ResourceUnit.loadRes(scene().getSceneName(), "NextRoundButtonText", "font")
	var font_color = ResourceUnit.loadRes(scene().getSceneName(), "NextRoundButtonText", "font_color")
	var text = ResourceUnit.loadRes(scene().getSceneName(), "NextRoundButtonText", "font_text")
	next_round_text.add_font_override("font", font)
	next_round_text.add_color_override("font_color", font_color)
	next_round_text.text = text

	next_round_button = ComponentPack.new("__nextRoundButton", next_round)

# sub_menu_entry_button
func getSubMenuEntryButton():
	return sub_menu_entry_button

func renderSubMenuEntryButton():
	var texture = ResourceUnit.loadRes("linear_battle", "linear_battle", "sub_menu_entry_btn")
	var sub_menu_entry = scene().get_node("SubMenuEntryButton")

	sub_menu_entry.texture_normal = texture
	sub_menu_entry_button = ComponentPack.new("__subMenuEntryButton", sub_menu_entry)

func getChosenCharacterMark():
	return chosen_character_mark

func __getOwnTeamPositionList():
	var character_num = model().getOwnCharacterNum()

	if character_num <= 0:
		return []

	var frame_size = __getCharacterCardFrameSize()
	var width = GlobalSetting.getScreenSize()[0]
	var height = GlobalSetting.getScreenSize()[1]

	var v_pos = int((height - frame_size[1]) / 2)
	var h_half = int(width * 0.5)

	var ret = []
	var gap = int(h_half / character_num)
	var init_margin = (gap - frame_size[0]) / 2

	for index in range(character_num):
		ret.append(Vector2(index * gap + init_margin, v_pos))

	return ret

func __getEnemyTeamPositionList():
	var character_num = model().getEnemyCharacterNum()

	if character_num <= 0:
		return []

	var frame_size = __getCharacterCardFrameSize()
	var width = GlobalSetting.getScreenSize()[0]
	var height = GlobalSetting.getScreenSize()[1]

	var v_pos = int((height - frame_size[1]) / 2)
	var h_half = int(width * 0.5)

	var ret = []
	var gap = int(h_half / character_num)
	var init_margin = (gap - frame_size[0]) / 2

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
	var frame_size = __getCharacterCardFrameSize()
	var frame_position_list = __getOwnTeamPositionList()

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
			var frame_texture = ResourceUnit.loadRes(scene().getSceneName(), scene().getSceneName(), "character_card_frame") 
			var texture = ResourceUnit.loadRes("global", "avator", avator_name)
			var frame_position = frame_position_list[i]
			var character_frame = TextureButton.new()
			character_frame.expand = true
			character_frame.texture_normal = frame_texture
			character_frame.rect_size = frame_size

			var character_rect = TextureRect.new()
			character_rect.expand = true
			character_rect.texture = texture
			character_rect.rect_size = rect_size
			character_rect.rect_position = Vector2((frame_size[0] - rect_size[0]) / 2, (frame_size[1] - rect_size[1]) / 2)

			character_frame.add_child(character_rect)

			component_pack = ComponentPack.new(component_key, character_frame)

			insert_list.append([component_pack, frame_position])
		else:
			keep_list.append([component_pack, frame_position_list[i]])

		list.append(component_pack)
		connectCardState(component_pack)

		i += 1
	
	own_team_list = list

	for del_pack in del_list:
		#TODO: delCharacterAnime
		var component_pack = del_pack[0]
		var frame_position = del_pack[1]
		delAnime(component_pack, frame_position)
	
	for keep_pack in keep_list:
		var component_pack = keep_pack[0]
		var frame_position = keep_pack[1]

		moveAnime(component_pack, frame_position)
	
	for insert_pack in insert_list:
		var component_pack = insert_pack[0]
		var frame_position = insert_pack[1]

		insertAnime(component_pack, frame_position)

func clearOwnTeam():
	for component_pack in own_team_list:
		scene().remove_child(component_pack.getComponent())
	
	own_team_list.clear()

func renderEnemyTeam():
	var enemy_character_team = model().getEnemyCharacterTeam()
	var rect_size = __getCharacterCardRectSize()
	var frame_size = __getCharacterCardFrameSize()
	var frame_position_list = __getEnemyTeamPositionList()

	var list = []
	var insert_list = []
	var del_list = []
	var keep_list = []

	for component_pack in enemy_team_list:
		del_list.append([component_pack, component_pack.getComponent().rect_position])

	var i = 0
	for character_card in enemy_character_team:
		var component_key = character_card.getCardName()

		__delComponentPack(del_list, component_key)

		var component_pack = __findComponetPack(enemy_team_list, component_key)
		if component_pack == null:
			var avator_name = character_card.getAvatorName()
			var frame_texture = ResourceUnit.loadRes(scene().getSceneName(), scene().getSceneName(), "character_card_frame") 
			var texture = ResourceUnit.loadRes("global", "avator", avator_name)
			var frame_position = frame_position_list[i]
			var character_frame = TextureButton.new()
			character_frame.expand = true
			character_frame.texture_normal = frame_texture
			character_frame.rect_size = frame_size

			var character_rect = TextureRect.new()
			character_rect.expand = true
			character_rect.texture = texture
			character_rect.rect_size = rect_size
			character_rect.rect_position = Vector2((frame_size[0] - rect_size[0]) / 2, (frame_size[1] - rect_size[1]) / 2)

			character_frame.add_child(character_rect)

			component_pack = ComponentPack.new(component_key, character_frame)

			insert_list.append([component_pack, frame_position])
		else:
			keep_list.append([component_pack, frame_position_list[i]])

		list.append(component_pack)
		connectCardState(component_pack)

		i += 1
	
	enemy_team_list = list

	for del_pack in del_list:
		#TODO: delCharacterAnime
		var component_pack = del_pack[0]
		var frame_position = del_pack[1]
		delAnime(component_pack, frame_position)
	
	for keep_pack in keep_list:
		var component_pack = keep_pack[0]
		var frame_position = keep_pack[1]

		moveAnime(component_pack, frame_position)
	
	for insert_pack in insert_list:
		var component_pack = insert_pack[0]
		var frame_position = insert_pack[1]

		insertAnime(component_pack, frame_position)
	
func clearEnemyTeam():
	for component_pack in enemy_team_list:
		scene().remove_child(component_pack.getComponent())
	
	enemy_team_list.clear()
	
func insertAnime(component_pack, final_rect_position):
	var component = component_pack.getComponent()

	var init_rect_position = final_rect_position
	init_rect_position[1] -= 80

	scene().add_child(component_pack.getComponent())
	component.rect_position = init_rect_position

	tween().interpolate_property(component, 
							   "rect_position",
							   init_rect_position,
							   final_rect_position,
							   0.5,
							   Tween.TRANS_LINEAR,
							   Tween.EASE_IN_OUT
							   )
	
	tween().start()
	tween().interpolate_callback(self, 0.5, "__insertAnimeCallBack", component, final_rect_position)

func __insertAnimeCallBack(component, final_rect_position):
	component.rect_position = final_rect_position

func moveAnime(component_pack, next_rect_position):
	var component = component_pack.getComponent()

	tween().interpolate_property(component, 
							   "rect_position",
							   null, 
							   next_rect_position,
							   0.5,
							   Tween.TRANS_LINEAR,
							   Tween.EASE_IN_OUT
							   )
	
	tween().start()
	tween().interpolate_callback(self, 0.5, "__moveAnimeCallBack", component, next_rect_position)

func __moveAnimeCallBack(component, next_rect_position):
	component.rect_position = next_rect_position

func delAnime(component_pack, init_rect_position):
	var component = component_pack.getComponent()

	var next_rect_position = init_rect_position
	next_rect_position[1] += 80
	
	tween().interpolate_property(component, 
							   "rect_position",
							   init_rect_position, 
							   next_rect_position,
							   0.5,
							   Tween.TRANS_LINEAR,
							   Tween.EASE_IN_OUT
							   )
	
	tween().start()
	tween().interpolate_callback(self, 0.5, "__delAnimeCallBack", component)

func __delAnimeCallBack(component):
	scene().remove_child(component)

func generateSkillAnimation(chosen_target, chosen_hand_card):
	var animation_pack = chosen_hand_card.getAnimationPack() 
	var animated_sprite = __getAnimatedSprite(chosen_target.getCardName())
	scene().add_child(animated_sprite)

	var sprite_frame = SpriteFrames.new()
	animated_sprite.frames = sprite_frame

	sprite_frame.add_animation("skill")
	sprite_frame.set_animation_loop("skill", true)
	animated_sprite.animation = "skill"

	var gap = animation_pack.getGap()
	sprite_frame.set_animation_speed("skill", gap)

	for texture_path in animation_pack.getTexturePathList():
		var texture = load(texture_path)
		sprite_frame.add_frame("skill", texture)
	
	return animated_sprite

func playSkillAnimation(animated_sprite):
	animated_sprite.play("skill")

func recycleSkillAnimation(animated_sprite):
	scene().remove_child(animated_sprite)

func __getAnimatedSprite(card_name):
	var animated_sprite = AnimatedSprite.new()
	var card_rect_size = model().getCharacterCardRectSize()

	var card_rect_position
	var card_index = service().findOwnCharacter(card_name)
	if card_index != null:
		var own_position_list = __getOwnTeamPositionList()
		card_rect_position = own_position_list[card_index]
	
	card_index = service().findEnemyCharacter(card_name)
	if card_index != null:
		var enemy_position_list = __getEnemyTeamPositionList()
		card_rect_position = enemy_position_list[card_index]
 
	card_rect_position[0] += card_rect_size[0] / 2
	card_rect_position[1] += card_rect_size[1] / 2
	animated_sprite.position = card_rect_position

	return animated_sprite

func playSkillSound(chosen_hand_card):
	var audio_pack = chosen_hand_card.getAudioPack()
	AudioPlayer.playSound(audio_pack.getAudioPath())

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
	var rect_size = __getHandCardFrameSize()
	var width = GlobalSetting.getScreenSize()[0]
	var height = GlobalSetting.getScreenSize()[1]
	var rect_width = rect_size[0]
	var v_pos = height * 0.75
	var h_margin = int((width - rect_width * card_num) / 2)

	var ret = []
	for index in range(card_num):
		ret.append(Vector2(h_margin + index * rect_width, v_pos))
	
	return ret

func renderHandCards():
	var hand_cards = model().getActionHandCards()
	var rect_size = __getHandCardRectSize()
	var frame_size = __getHandCardFrameSize()
	var frame_position_list = __getHandCardRectPositionList(hand_cards.size())

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
			
			var frame_texture = ResourceUnit.loadRes(scene().getSceneName(), scene().getSceneName(), "hand_card_frame")
			var texture = ResourceUnit.loadRes("global", "avator", avator_name)
			var frame_position = frame_position_list[i]

			var hand_card_frame = TextureButton.new()
			hand_card_frame.rect_size = frame_size
			hand_card_frame.expand = true
			hand_card_frame.texture_normal = frame_texture

			var hand_card_rect = TextureRect.new()
			hand_card_rect.rect_size = rect_size
			hand_card_rect.expand = true
			hand_card_rect.texture = texture
			hand_card_rect.rect_position = Vector2((frame_size[0] - rect_size[0]) / 2, (frame_size[1] - rect_size[1]) / 2)

			hand_card_frame.add_child(hand_card_rect)
			
			component_pack = ComponentPack.new(hand_card.getCardName(), hand_card_frame)
			insert_list.append([component_pack, frame_position])
		else:
			keep_list.append([component_pack, frame_position_list[i]])

		list.append(component_pack)
		connectCardState(component_pack)

		i += 1

	for del_pack in del_list:
		var component_pack = del_pack[0]
		var frame_position = del_pack[1]
		delAnime(component_pack, frame_position)
	
	for keep_pack in keep_list:
		var component_pack = keep_pack[0]
		var frame_position = keep_pack[1]
		moveAnime(component_pack, frame_position)
	
	for insert_pack in insert_list:
		var component_pack = insert_pack[0]
		var frame_position = insert_pack[1]
		insertAnime(component_pack, frame_position)
	
	hand_card_list = list

func clearHandCards():
	for component_pack in hand_card_list:
		scene().remove_child(component_pack.getComponent())
	
	hand_card_list.clear()

func __getCharacterCardRectSize():
	return Vector2(model().getCharacterCardRectSize()[0], model().getCharacterCardRectSize()[1])

func __getCharacterCardFrameSize():
	return Vector2(model().getCharacterCardFrameSize()[0], model().getCharacterCardFrameSize()[1])

func __getHandCardRectSize():
	return Vector2(model().getHandCardRectSize()[0], model().getHandCardRectSize()[1])

func __getHandCardFrameSize():
	return Vector2(model().getHandCardFrameSize()[0], model().getHandCardFrameSize()[1])

# setBackground
func getBackground():
	return scene().get_node("LinearBattleBackground")

func setBackground():
	var scene_name = scene().getSceneName()
	var bg = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("LinearBattleBackground").texture = bg

# preview
func connectCardState(component_pack):
	if not component_pack.isConnected("mouse_entered"):
		component_pack.connectTo(self, "mouse_entered", "showCardState")

	if not component_pack.isConnected("mouse_exited"):
		component_pack.connectTo(self, "mouse_exited", "hideCardState")

func showCardState(component_key):
	var component_pack = __getComponentPackByName(component_key)

	var card_rect = component_pack.getComponent()

	var card_rect_size = card_rect.rect_size
	var card_rect_position = card_rect.rect_position

	var card
	card = service().getCharacterByName(component_key)
	if card == null:
		card = service().getActionHandCardByName(component_key)
	
	var card_attr = card.getCardAttr()
	var card_introduction = card.getIntroduction()

	var state_list = __getStateList(card_rect_size, card_rect_position, card_attr, card_introduction)

	state_list_cache[component_key] = state_list

func hideCardState(component_key):
	if state_list_cache.has(component_key):
		scene().remove_child(state_list_cache[component_key])
		state_list_cache.erase(component_key)

func __getStateList(card_rect_size, card_rect_position, card_attr, card_introduction):
	var state_rect_size = model().getCardStateRectSize()

	var state_rect_position = Vector2()

	if card_rect_position[0] - (state_rect_size[0] + state_rect_size[0]) > 0:
		state_rect_position[0] = card_rect_position[0] - state_rect_size[0] - 1
	else:
		state_rect_position[0] = card_rect_position[0] + card_rect_size[0] + 1
	
	if (card_rect_position[1] + card_rect_size[1]) - state_rect_size[1] > 0:
		state_rect_position[1] = (card_rect_position[1] + card_rect_size[1]) - state_rect_size[1]
	else:
		state_rect_position[1] = card_rect_position[1]
		
	var state_list = Tree.new()
	state_list.columns = 2
	scene().add_child(state_list)

	state_list.rect_position = Vector2(state_rect_position[0], state_rect_position[1])
	state_list.rect_size = Vector2(state_rect_size[0], state_rect_size[1])

	var root_node = state_list.create_item()
	root_node.set_text(0, "Card State")
	root_node.set_expand_right(0, true)

	var index_attr_list = card_attr.getIndexAttrList()
	
	for index_attr in index_attr_list:
		var node = state_list.create_item(root_node)
		node.set_text(0, str(index_attr[0]))
		node.set_text(1, str(index_attr[1]))
	
	var introduction_node = state_list.create_item(root_node)
	introduction_node.set_text(0, "Introduction")
	introduction_node.set_text(1, card_introduction)

	return state_list

func __getComponentPackByName(component_key):
	var ret
	
	ret = __getOwnTeamCharacter(component_key)
	if ret != null:
		return ret
	
	ret = __getEnemyTeamCharacter(component_key)
	if ret != null:
		return ret
	
	ret = __getHandCard(component_key)
	if ret != null:
		return ret

	return null

func __getOwnTeamCharacter(component_key):
	for character in own_team_list:
		if character.getKey() == component_key:
			return character
	
	return null

func __getEnemyTeamCharacter(component_key):
	for character in enemy_team_list:
		if character.getKey() == component_key:
			return character

	return null

func __getHandCard(component_key):
	for hand_card in hand_card_list:
		if hand_card.getKey() == component_key:
			return hand_card

	return null
