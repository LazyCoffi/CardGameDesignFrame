extends "res://scene/BaseRender.gd"
class_name LinearBattleRender

var own_team_list				# ComponentPack_Array
var enemy_team_list				# ComponentPack_Array
var hand_card_list				# ComponentPack_Array
var action_character_mark		# ComponentPack
var chosen_character_mark		# ComponentPack
var next_round_button			# ComponentPack
var background					# ComponentPack
var sub_menu_entry_button		# ComponentPack

var state_list_cache			# Dict
var view_state					# Dict
var card_view_rect				# TextureRect
var card_attr_frame				# TextureRect
var attr_entry_list				# Array
var attr_next_button			# TextureButton
var attr_pre_button				# TextureButton
var card_introduction			# RichTextLabel

func _init():
	own_team_list = []
	enemy_team_list = []
	hand_card_list = []
	action_character_mark = null
	chosen_character_mark = null
	next_round_button = null
	state_list_cache = {}
	attr_entry_list = []
	view_state = {
		"key" : null,
		"visiable" : false,
		"page" : 1,
		"card" : null
	}

func tween():
	return scene().get_node("Tween")

# background
func renderBackground():
	var bg = scene().get_node("LinearBattleBackground")
	var texture = ResourceUnit.loadRes(sceneName(), sceneName(), "background")
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
	var scene_name = sceneName()
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

func getNextRoundButtonRef():
	return scene().get_node("NextRoundButton")

func renderNextRoundButton():
	var texture = ResourceUnit.loadRes("linear_battle", "linear_battle", "next_round_button")
	var texture_hover = ResourceUnit.loadRes("linear_battle", "linear_battle", "next_round_button_hover")
	var next_round = getNextRoundButtonRef()
	next_round.texture_normal = texture
	next_round.texture_hover = texture_hover

	var next_round_text = scene().get_node("NextRoundButton/NextRoundButtonText")
	var font = ResourceUnit.loadRes(sceneName(), "NextRoundButtonText", "font")
	var font_color = ResourceUnit.loadRes(sceneName(), "NextRoundButtonText", "font_color")
	var text = ResourceUnit.loadRes(sceneName(), "NextRoundButtonText", "font_text")
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

func __getOwnTeamPositionList():
	var character_num = model().getOwnCharacterNum()

	if character_num <= 0:
		return []

	var frame_size = model().getCharacterCardFrameSize()
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

	var frame_size = model().getCharacterCardFrameSize()
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
	var rect_size = model().getCharacterCardRectSize()
	var frame_size = model().getCharacterCardFrameSize()
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
			var frame_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "character_card_frame") 
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
	var rect_size = model().getCharacterCardRectSize()
	var frame_size = model().getCharacterCardFrameSize()
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
			var frame_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "character_card_frame") 
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

func renderChooseHandCardAnime(component_key):
	var component_pack = __getHandCard(component_key)
	chooseHandCardAnime(component_pack)

func chooseHandCardAnime(component_pack):
	var component = component_pack.getComponent()
	var move_gap = model().getChooseMoveGap()
	var rect_position = component.rect_position
	var next_rect_position = Vector2(rect_position[0], rect_position[1] - move_gap)

	tween().interpolate_property(component,
								 "rect_position",
								 null,
								 next_rect_position,
								 0.5,
								 Tween.TRANS_LINEAR,
								 Tween.EASE_IN_OUT
								 )
	tween().start()
	tween().interpolate_callback(self, 0.5, "__chooseHandCardAnimeCallBack", component, next_rect_position)

func __chooseHandCardAnimeCallBack(component, next_rect_position):
	component.rect_position = next_rect_position

func renderCancelHandCardAnime(component_key):
	var component_pack = __getHandCard(component_key)
	cancelHandCardAnime(component_pack)

func cancelHandCardAnime(component_pack):
	var component = component_pack.getComponent()
	var move_gap = model().getChooseMoveGap()
	var rect_position = component.rect_position
	var next_rect_position = Vector2(rect_position[0], rect_position[1] + move_gap)

	tween().interpolate_property(component,
								 "rect_position",
								 null,
								 next_rect_position,
								 0.5,
								 Tween.TRANS_LINEAR,
								 Tween.EASE_IN_OUT
								 )
	tween().start()
	tween().interpolate_callback(self, 0.5, "__cancelHandCardAnimeCallBack", component, next_rect_position)

func __cancelHandCardAnimeCallBack(component, next_rect_position):
	component.rect_position = next_rect_position

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

	var frame_rect_size = model().getCharacterCardFrameSize()
	rect_position[1] += frame_rect_size[1]

	if action_character_mark == null:
		var texture = ResourceUnit.loadRes(sceneName(), sceneName(), "action_character_mark")
		var rect_size = model().getCharacterMarkRectSize()
		var mark_texture_rect = TextureRect.new()
		mark_texture_rect.texture = texture
		mark_texture_rect.rect_position = rect_position
		mark_texture_rect.rect_size = rect_size

		scene().add_child(mark_texture_rect)

		var component_pack = ComponentPack.new("__action_character_mark", mark_texture_rect)
		action_character_mark = component_pack
	else:
		action_character_mark.getComponent().rect_position = rect_position

func clearActionCharacterMark():
	scene().remove_child(action_character_mark.getComponent())
	action_character_mark = null

## setCurHandCardsRect
func __getHandCardRectPositionList(card_num):
	var rect_size = model().getHandCardFrameSize()
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
	var rect_size = model().getHandCardRectSize()
	var frame_size = model().getHandCardFrameSize()
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
			
			var frame_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "hand_card_frame")
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

	return model().getCharacterCardFrameSize()

# setBackground
func getBackground():
	return scene().get_node("LinearBattleBackground")

func setBackground():
	var scene_name = sceneName()
	var bg = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("LinearBattleBackground").texture = bg

# preview
func connectView():
	var view_rect = getViewRectRef()
	__dfsConnectView(view_rect)
	
func __dfsConnectView(component):
	var component_pack = ComponentPack.new("__viewRect", component)
	component_pack.connectTo(self, "mouse_entered", "cardViewHook")
	component_pack.connectTo(self, "mouse_exited", "cardViewHook")

	for index in range(component.get_child_count()):
		var child = component.get_child(index)
		__dfsConnectView(child)

func connectCardState(component_pack):
	if not component_pack.isConnected("mouse_entered"):
		component_pack.connectTo(self, "mouse_entered", "cardViewHook")

	if not component_pack.isConnected("mouse_exited"):
		component_pack.connectTo(self, "mouse_exited", "cardViewHook")

func cardViewHook(component_key):
	var component
	if component_key == "__viewRect":
		component = getViewRectRef()
	else:
		var component_pack = __getComponentPackByName(component_key)
		component = component_pack.getComponent()
		
	var view_rect = getViewRectRef()

	if __isMouseInRect(component) or __isMouseInRect(view_rect):
		showCardView(component_key)
	else:
		hideCardView(component_key)

func __isMouseInRect(component):
	var component_rect = component.rect_size
	var mouse_position = component.get_local_mouse_position()

	return Rect2(Vector2(), component_rect).has_point(mouse_position)

func __isViewVisiable():
	return view_state["visiable"]

func __getViewKey():
	return view_state["key"]

func __setViewStateKey(component_key):
	view_state["key"] = component_key

func __resetViewStateKey():
	view_state["key"] = null

func __setViewStateVisiable():
	view_state["visiable"] = true

func __setViewStateInvisiable():
	view_state["visiable"] = false

func __getViewPageIndex():
	return view_state["page"]

func __setViewPageIndex(page):
	view_state["page"] = page

func __resetViewPage():
	view_state["page"] = 1

func __addViewPage(arr_size):
	var page_index = __getViewPageIndex()
	var page_size = model().getCardAttrListSize()

	if page_size * page_index < arr_size:
		__setViewPageIndex(page_index + 1)
	else:
		__setViewPageIndex(page_index)
	
	__updateAttrListEntry()
	
func __subViewPage():
	var page_index = __getViewPageIndex()
	__setViewPageIndex(max(page_index - 1, 1))

	__updateAttrListEntry()

func __getViewStateCard():
	return view_state["card"]

func __setViewStateCard(card):
	view_state["card"] = card

func __resetViewStateCard():
	view_state["card"] = null

func getViewRectRef():
	card_view_rect.set_as_toplevel(true)
	return card_view_rect

func getAttrFrameRef():
	return card_attr_frame

func getIntroductionTextRef():
	return card_introduction

func getAttrNextButton():
	return attr_next_button

func getAttrPreButton():
	return attr_pre_button

func renderViewRect():
	var view_rect = TextureRect.new()
	var view_rect_size = Vector2(model().getViewRectSize()[0], model().getViewRectSize()[1])
	view_rect.rect_size = view_rect_size

	var view_frame_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "view_frame")
	view_rect.texture = view_frame_texture

	view_rect.add_child(__renderAttrFrame())
	view_rect.add_child(__renderIntroductionFrame())

	view_rect.hide()
	scene().add_child(view_rect)

	card_view_rect = view_rect

func __renderAttrEntry(index_attr, entry_index):
	var attr_frame = getAttrFrameRef()
	var attr_frame_size = model().getAttrRectSize()

	var entry = TextureRect.new()
	attr_frame.add_child(entry)

	var entry_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "view_attr_entry")
	entry.texture = entry_texture

	var font = ResourceUnit.loadRes(sceneName(), sceneName(), "view_attr_font")
	var font_color = ResourceUnit.loadRes(sceneName(), sceneName(), "view_attr_font_color")

	var entry_head = Label.new()

	var entry_head_size = model().getAttrEntryHeadSize()
	entry_head.align = Label.ALIGN_CENTER
	entry_head.valign = Label.VALIGN_CENTER
	entry_head.rect_size = entry_head_size
	entry_head.add_font_override("font", font)
	entry_head.add_color_override("font_color", font_color)
	entry_head.text = str(index_attr[0])

	entry.add_child(entry_head)

	var entry_content = Label.new()

	var entry_content_size = model().getAttrEntryContentSize()
	entry_content.valign = Label.VALIGN_CENTER
	entry_content.rect_size = entry_content_size
	entry_content.rect_position = Vector2(entry_head_size[0], 0)
	entry_content.text = str(index_attr[1])
	entry_content.add_font_override("font", font)
	entry_content.add_color_override("font_color", font_color)

	entry.add_child(entry_content)
	
	var y_margin = model().getAttrEntryYMargin()
	var entry_page_size = model().getCardAttrListSize()

	var entry_x = (attr_frame_size[0] - 	\
				  entry_head_size[0] - 		\
				  entry_content_size[0]) / 	\
				  2
	var entry_y = y_margin +							\
				  (entry_index % entry_page_size) *		\
				  entry_head_size[1]					\

	entry.rect_position = Vector2(entry_x, entry_y)

	return entry

func __renderAttrFrame():
	var view_rect_size = model().getViewRectSize()

	var attr_frame = TextureRect.new()

	var attr_rect_size = model().getAttrRectSize()
	var attr_rect_position = Vector2((view_rect_size[0] / 2 - attr_rect_size[0]) / 2, (view_rect_size[1] - attr_rect_size[1]) / 2)

	attr_frame.rect_size = attr_rect_size
	attr_frame.rect_position = attr_rect_position

	var attr_frame_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "attr_frame")
	attr_frame.texture = attr_frame_texture

	card_attr_frame = attr_frame

	var button_rect_size = model().getAttrButtonSize()

	var x_margin = model().getAttrEntryXMargin()
	var y_margin = model().getAttrEntryYMargin()

	var next_button = TextureButton.new()
	var next_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "attr_next_button")
	next_button.texture_normal = next_texture
	next_button.rect_size = button_rect_size
	var next_button_position = Vector2(attr_rect_size[0] - x_margin - button_rect_size[0], attr_rect_size[1] - y_margin - button_rect_size[1])

	next_button.rect_size = button_rect_size
	next_button.rect_position = next_button_position

	attr_next_button = next_button
	attr_frame.add_child(next_button)

	var pre_button = TextureButton.new()
	var pre_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "attr_pre_button")
	pre_button.texture_normal = pre_texture
	pre_button.rect_size = button_rect_size
	var pre_button_position = Vector2(x_margin, attr_rect_size[1] - y_margin - button_rect_size[1])
	pre_button.rect_size = button_rect_size
	pre_button.rect_position = pre_button_position

	attr_pre_button = pre_button
	attr_frame.add_child(pre_button)

	return attr_frame

func __renderIntroductionFrame():
	var view_rect_size = model().getViewRectSize()
	var introduction_rect_size = Vector2(model().getIntroductionRectSize()[0], model().getIntroductionRectSize()[1]) 

	var font = ResourceUnit.loadRes(sceneName(), sceneName(), "view_introduction_font")
	var font_color = ResourceUnit.loadRes(sceneName(), sceneName(), "view_introduction_font_color")

	var introduction_rect_position = Vector2(view_rect_size[0] / 2 + (view_rect_size[0] / 2 - introduction_rect_size[0]) / 2, (view_rect_size[1] - introduction_rect_size[1]) / 2)

	var introduction_frame = TextureRect.new()
	introduction_frame.rect_size = introduction_rect_size
	introduction_frame.rect_position = introduction_rect_position

	var introduction_frame_texture = ResourceUnit.loadRes(sceneName(), sceneName(), "introduction_frame")
	introduction_frame.texture = introduction_frame_texture

	var introduction_text = RichTextLabel.new()
	var introduction_text_size = model().getIntroductionTextSize()

	introduction_text.rect_size = introduction_text_size
	introduction_text.rect_position = Vector2((introduction_rect_size[0] - introduction_text_size[0]) / 2, (introduction_rect_size[1] - introduction_text_size[1]) / 2)

	introduction_text.push_font(font)
	introduction_text.push_color(font_color)

	introduction_frame.add_child(introduction_text)
	card_introduction = introduction_text

	return introduction_frame

func __updateAttrListEntry():
	var card_attr = __getViewStateCard().getCardAttr()
	var page_index = __getViewPageIndex()
	var page_size = model().getCardAttrListSize()
	var index_attr_list = card_attr.getIndexAttrList()

	for attr_entry in attr_entry_list:
		card_attr_frame.remove_child(attr_entry)

	attr_entry_list.clear()

	var head = (page_index - 1) * page_size
	var tail = min(page_index * page_size, index_attr_list.size())
	for index in range(head, tail):
		var index_attr = index_attr_list[index]
		var attr_entry = __renderAttrEntry(index_attr, index)
		attr_entry_list.append(attr_entry)

func __updateAttrList():
	var card_attr = __getViewStateCard().getCardAttr()
	var index_attr_list = card_attr.getIndexAttrList()

	var next_button = getAttrNextButton()
	if not next_button.is_connected("pressed", self, "__addViewPage"):
		next_button.connect("pressed", self, "__addViewPage", [index_attr_list.size()])

	var pre_button = getAttrPreButton()
	if not pre_button.is_connected("pressed", self, "__subViewPage"):
		pre_button.connect("pressed", self, "__subViewPage")

	__updateAttrListEntry()
		
func __updateIntroduction():
	var introduction_text = __getViewStateCard().getIntroduction()
	var introduction = getIntroductionTextRef()
	var font = ResourceUnit.loadRes(sceneName(), sceneName(), "view_introduction_font")
	var font_color = ResourceUnit.loadRes(sceneName(), sceneName(), "view_introduction_font_color")
	introduction.clear()
	introduction.push_font(font)
	introduction.push_color(font_color)
	introduction.add_text(introduction_text)

func __updateCardView():
	var key = __getViewKey()

	var card = model().getCharacterByName(key)
	if card == null:
		card = model().getActionHandCardByName(key)

	__setViewStateCard(card)
	__updateAttrList()
	__updateIntroduction()

func __setViewRectPosition(component_key):
	var component_pack = __getComponentPackByName(component_key)
	var view_rect = getViewRectRef()
	var component = component_pack.getComponent()
	var rect_position = component.rect_position
	var rect_size = component.rect_size
	var view_rect_size = view_rect.rect_size

	var view_position = Vector2()

	if rect_position[0] - view_rect_size[0] < 0:
		view_position[0] = rect_position[0] + rect_size[0]
	else:
		view_position[0] = rect_position[0] - view_rect_size[0]
	
	if rect_position[1] + rect_size[1] - view_rect_size[1] < 0:
		view_position[1] = rect_position[1]
	else:
		view_position[1] = rect_position[1] + rect_size[1] - view_rect_size[1]
	
	view_rect.rect_position = view_position

func __showCardView():
	var view_rect = getViewRectRef()
	view_rect.show()

func showCardView(component_key):
	if component_key == "__viewRect":
		return
	
	if __getViewKey() != null:
		return
	
	if __isViewVisiable():
		return
	
	## config state
	__setViewStateKey(component_key)
	__setViewStateVisiable()
	__resetViewPage()
	
	# render
	__setViewRectPosition(component_key)
	__updateCardView()

	# show
	__showCardView()

func __hideCardView():
	var view_rect = getViewRectRef()
	view_rect.hide()

func hideCardView(component_key):
	if component_key != "__viewRect" and component_key != __getViewKey():
		return

	if not __isViewVisiable():
		return

	__setViewStateInvisiable()
	__resetViewStateKey()
	__resetViewStateCard()

	var next_button = getAttrNextButton()
	if next_button.is_connected("pressed", self, "__addViewPage"):
		next_button.disconnect("pressed", self, "__addViewPage")

	var pre_button = getAttrPreButton()
	if pre_button.is_connected("pressed", self, "__subViewPage"):
		pre_button.disconnect("pressed", self, "__subViewPage")

	__hideCardView()
	
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
