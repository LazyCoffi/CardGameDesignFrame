extends Node
class_name ArchiveRender

var ComponentPack = TypeUnit.type("ComponentPack")

var scene_ref

var load_button			# TextureButton
var delete_button		# TextureButton
var back_button			# TextureButton
var next_button			# TextureButton
var previous_button		# TextureButton
var archive_card_list	# TextureButton_Array
var create_text			# Label
var create_time_text	# Label
var update_text			# Label
var update_time_text	# Label

func _init():
	load_button = null
	delete_button = null
	back_button = null
	next_button = null
	previous_button = null
	archive_card_list = []
	create_text = null
	create_time_text = null
	update_text = null
	update_time_text = null

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func service():
	return scene_ref.service()

func renderBackground():
	var scene_name = scene().getSceneName()
	var background = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("ArchiveBackground").texture = background

func renderMenuRect():
	var scene_name = scene().getSceneName()
	var menu_rect = ResourceUnit.loadRes(scene_name, scene_name, "menu_rect")
	scene().get_node("ArchiveMenuRect").texture = menu_rect

func renderArchiveOperRect():
	if not model().hasSelectedArchive():
		clearArchiveOperRect()
		return

	renderLoadButton()
	renderDeleteButton()
	renderArchiveInfo()

func clearArchiveOperRect():
	clearLoadButton()
	clearDeleteButton()
	clearArchiveInfo()

func getLoadButton():
	return load_button

func renderLoadButton():
	if load_button != null:
		return

	var load_btn = TextureButton.new()

	var BUTTON_RECT_SIZE = Vector2(210, 90)
	var LOADBUTTON_POSITION = Vector2(39, 450)

	load_btn.rect_position = LOADBUTTON_POSITION
	load_btn.rect_size = BUTTON_RECT_SIZE
	load_btn.expand = true

	var scene_name = scene().getSceneName()
	var texture_normal = ResourceUnit.loadRes(scene_name, "LoadButton",  "texture_normal")
	var texture_hover = ResourceUnit.loadRes(scene_name, "LoadButton",  "texture_hover")

	load_btn.texture_normal = texture_normal
	load_btn.texture_hover = texture_hover

	var LABEL_RECT_SIZE = Vector2(180, 72)
	var LABEL_POSITION = Vector2(15, 9)
	var LABEL_TEXT = "读取"

	var load_label = Label.new()

	load_label.name = "LOAD_TEXT"
	load_label.align = Label.ALIGN_CENTER
	load_label.valign = Label.VALIGN_CENTER

	load_label.rect_size = LABEL_RECT_SIZE
	load_label.rect_position = LABEL_POSITION
	load_label.text = LABEL_TEXT

	var font = ResourceUnit.loadRes(scene_name, "LoadText", "font") 
	var font_color = ResourceUnit.loadRes(scene_name, "LoadText", "font_color")
		
	load_label.add_font_override("font", font)
	load_label.add_color_override("font_color", font_color)

	load_btn.add_child(load_label)
	scene().get_node("ArchiveOperRect").add_child(load_btn)

	load_button = ComponentPack.new("__loadButton", load_btn)

func clearLoadButton():
	if load_button != null:
		scene().get_node("ArchiveOperRect").remove_child(load_button.getComponent())
		load_button = null

func getDeleteButton():
	return delete_button

func renderDeleteButton():
	if delete_button != null:
		return

	var delete_btn = TextureButton.new()

	var BUTTON_RECT_SIZE = Vector2(210, 90)
	var DELETEBUTTON_POSITION = Vector2(39, 570)

	delete_btn.rect_position = DELETEBUTTON_POSITION
	delete_btn.rect_size = BUTTON_RECT_SIZE
	delete_btn.expand = true

	var scene_name = scene().getSceneName()
	var texture_normal = ResourceUnit.loadRes(scene_name, "DeleteButton",  "texture_normal")
	var texture_hover = ResourceUnit.loadRes(scene_name, "DeleteButton",  "texture_hover")

	delete_btn.texture_normal = texture_normal
	delete_btn.texture_hover = texture_hover

	var LABEL_RECT_SIZE = Vector2(180, 72)
	var LABEL_POSITION = Vector2(15, 9)
	var LABEL_TEXT = "删除"

	var delete_label = Label.new()

	delete_label.name = "DELETE_TEXT"
	delete_label.align = Label.ALIGN_CENTER
	delete_label.valign = Label.VALIGN_CENTER
	delete_label.rect_size = LABEL_RECT_SIZE
	delete_label.rect_position = LABEL_POSITION
	delete_label.text = LABEL_TEXT

	var font = ResourceUnit.deleteRes(scene_name, "DeleteText", "font") 
	var font_color = ResourceUnit.deleteRes(scene_name, "DeleteText", "font_color")
		
	delete_label.add_font_override("font", font)
	delete_label.add_color_override("font_color", font_color)

	delete_btn.add_child(delete_label)
	scene().get_node("ArchiveOperRect").add_child(delete_btn)

	delete_button = ComponentPack.new("__deleteButton", delete_btn)

func clearDeleteButton():
	if delete_button != null:
		scene().get_node("ArchiveOperRect").remove_child(delete_button.getComponent())
		delete_button = null

func getBackButton():
	return back_button

func renderBackButton():
	if back_button != null:
		return

	var back_btn = TextureButton.new()

	var BUTTON_RECT_SIZE = Vector2(210, 90)
	var BACKBUTTON_POSITION = Vector2(39, 720)

	back_btn.rect_position = BACKBUTTON_POSITION
	back_btn.rect_size = BUTTON_RECT_SIZE
	back_btn.expand = true

	var scene_name = scene().getSceneName()
	var texture_normal = ResourceUnit.loadRes(scene_name, "BackButton",  "texture_normal")
	var texture_hover = ResourceUnit.loadRes(scene_name, "BackButton",  "texture_hover")

	back_btn.texture_normal = texture_normal
	back_btn.texture_hover = texture_hover
		
	var LABEL_RECT_SIZE = Vector2(180, 72)
	var LABEL_POSITION = Vector2(15, 9)
	var LABEL_TEXT = "返回"

	var back_label = Label.new()

	back_label.name = "BACK_TEXT"
	back_label.align = Label.ALIGN_CENTER
	back_label.valign = Label.VALIGN_CENTER
	back_label.rect_size = LABEL_RECT_SIZE
	back_label.rect_position = LABEL_POSITION
	back_label.text = LABEL_TEXT

	var font = ResourceUnit.loadRes(scene_name, "BackText", "font") 
	var font_color = ResourceUnit.loadRes(scene_name, "BackText", "font_color")
		
	back_label.add_font_override("font", font)
	back_label.add_color_override("font_color", font_color)

	back_btn.add_child(back_label)
	scene().get_node("ArchiveOperRect").add_child(back_btn)

	back_button = ComponentPack.new("__backButton", back_btn)

func clearBackButton():
	if back_button != null:
		scene().get_node("ArchiveOperRect").remove_child(back_button.getComponent())
		back_button = null

func getNextButton():
	return next_button

func renderNextButton():
	if next_button != null:
		return
	
	var next_btn = TextureButton.new()

	var SWITCH_RECT_SIZE = Vector2(128, 56)
	var NEXT_BUTTON_POSITION = Vector2(1032, 792)

	next_btn.rect_position = NEXT_BUTTON_POSITION
	next_btn.rect_size = SWITCH_RECT_SIZE
	next_btn.expand = true

	var scene_name = scene().getSceneName()
	var texture_normal = ResourceUnit.loadRes(scene_name, "NextButton",  "texture_normal")

	next_btn.texture_normal = texture_normal

	scene().get_node("ArchiveListRect").add_child(next_btn)

	next_button = ComponentPack.new("__nextButton", next_btn)

func clearNextButton():
	if next_button != null:
		scene().get_node("ArchiveListRect").remove_child(next_button.getComponent())
		next_button = null

func getPreviousButton():
	return previous_button

func renderPreviousButton():
	if previous_button != null:
		return
	
	var previous_btn = TextureButton.new()

	var SWITCH_RECT_SIZE = Vector2(128, 56)
	var PREVIOUS_BUTTON_POSITION = Vector2(72, 792)

	previous_btn.rect_position = PREVIOUS_BUTTON_POSITION
	previous_btn.rect_size = SWITCH_RECT_SIZE
	previous_btn.expand = true

	var scene_name = scene().getSceneName()
	var texture_normal = ResourceUnit.loadRes(scene_name, "PreviousButton",  "texture_normal")

	previous_btn.texture_normal = texture_normal

	scene().get_node("ArchiveListRect").add_child(previous_btn)

	previous_button = ComponentPack.new("__previousButton", previous_btn)

func clearPreviousButton():
	if previous_button != null:
		scene().get_node("ArchiveListRect").remove_child(previous_button.getComponent())
		previous_button = null

func getArchiveCardList():
	return archive_card_list

func renderArchiveCard():
	var current_archive_list = service().getCurrentArchiveList()

	if archive_card_list.empty():
		var CARD_RECT_SIZE = Vector2(360, 720)
		var CARD_POSITION = [
			Vector2(48, 56),
			Vector2(440, 56),
			Vector2(832, 56)
		]
		var TEXT_RECT_SIZE = Vector2(296, 72)
		var TEXT_POSITION = Vector2(32, 600)

		for index in range(model().getMaxArchiveNum()):
			var archive_card = TextureButton.new()
			archive_card.rect_size = CARD_RECT_SIZE 
			archive_card.rect_position = CARD_POSITION[index]
			archive_card.expand = true

			var text_label = Label.new()
			text_label.align = Label.ALIGN_CENTER
			text_label.valign = Label.VALIGN_CENTER
			text_label.name = "CardText"
			text_label.rect_size = TEXT_RECT_SIZE
			text_label.rect_position = TEXT_POSITION

			archive_card.add_child(text_label)
			scene().get_node("ArchiveListRect").add_child(archive_card)

			var component_pack = ComponentPack.new("__archiveCard" + str(index), archive_card)
			component_pack.setKey(index)
			archive_card_list.append(component_pack)
	
	var archive_num = current_archive_list.size()

	for index in range(archive_num):
		var component_pack = archive_card_list[index]
		var archive_card = component_pack.getComponent()

		var scene_name = scene().getSceneName()
		var texture = ResourceUnit.loadRes(scene_name, "ArchiveCard", "active_card")
		archive_card.normal_texture = texture

		var text_label = archive_card.get_node("CardText")
		var font = ResourceUnit.loadRes(scene_name, "CardText", "font")
		var font_color = ResourceUnit.loadRes(scene_name, "CardText", "font_color")

		text_label.add_font_override("font", font)
		text_label.add_color_override("font_color", font_color)

		var archive = current_archive_list[index]
		text_label.text = archive.getArchiveName()

	for index in range(archive_num, model().getMaxArchiveNum()):
		var component_pack = archive_card_list[index]
		var archive_card = component_pack.getComponent()

		var scene_name = scene().getSceneName()
		var texture = ResourceUnit.loadRes(scene_name, "ArchiveCard", "empty_card")
		archive_card.texture_normal = texture

		var text_label = archive_card.get_node("CardText")
		var font = ResourceUnit.loadRes(scene_name, "CardText", "font")
		var font_color = ResourceUnit.loadRes(scene_name, "CardText", "font_color")

		text_label.add_font_override("font", font)
		text_label.add_color_override("font_color", font_color)
		text_label.text = "空档案"

func renderArchiveInfo():
	if create_text == null:
		var create_label = Label.new()

		var CREATE_RECT_SIZE = Vector2(150, 40)
		var CREATE_POSITION = Vector2(45, 25)
		var CREATE_TEXT = "创建时间"

		create_label.rect_size = CREATE_RECT_SIZE
		create_label.rect_position = CREATE_POSITION
		
		var scene_name = scene().getSceneName()
		var font = ResourceUnit.loadRes(scene_name, "CreateText", "font") 
		var font_color = ResourceUnit.loadRes(scene_name, "CreateText", "font_color")
		
		create_label.add_font_override("font", font)
		create_label.add_color_override("font_color", font_color)
		create_label.text = CREATE_TEXT
			
		scene().get_node("ArchiveInfoRect").add_child(create_label)

		create_text = ComponentPack.new("__createText", create_label)
	
	if update_text == null:
		var update_label = Label.new()

		var UPDATE_RECT_SIZE = Vector2(150, 40)
		var UPDATE_POSITION = Vector2(45, 25)
		var UPDATE_TEXT = "创建时间"

		update_label.rect_size = UPDATE_RECT_SIZE
		update_label.rect_position = UPDATE_POSITION
		
		var scene_name = scene().getSceneName()
		var font = ResourceUnit.loadRes(scene_name, "UpdateText", "font") 
		var font_color = ResourceUnit.loadRes(scene_name, "UpdateText", "font_color")
		
		update_label.add_font_override("font", font)
		update_label.add_color_override("font_color", font_color)
		update_label.text = UPDATE_TEXT

		scene().get_node("ArchiveInfoRect").add_child(update_label)

		update_text = ComponentPack.new("__updateText", update_label)

	if create_time_text == null:
		var create_time_label = Label.new()

		var CREATE_TIME_RECT_SIZE = Vector2(150, 40)
		var CREATE_TIME_POSITION = Vector2(45, 25)

		create_time_label.rect_size = CREATE_TIME_RECT_SIZE
		create_time_label.rect_position = CREATE_TIME_POSITION
		
		var scene_name = scene().getSceneName()
		var font = ResourceUnit.loadRes(scene_name, "CreateTimeText", "font") 
		var font_color = ResourceUnit.loadRes(scene_name, "CreateTimeText", "font_color")
		
		create_time_label.add_font_override("font", font)
		create_time_label.add_color_override("font_color", font_color)

		scene().get_node("ArchiveInfoRect").add_child(create_time_label)

		create_time_text = ComponentPack.new("__createTimeText", create_time_label)
	
	if update_time_text == null:
		var update_time_label = Label.new()

		var UPDATE_TIME_RECT_SIZE = Vector2(150, 40)
		var UPDATE_TIME_POSITION = Vector2(45, 25)

		update_time_label.rect_size = UPDATE_TIME_RECT_SIZE
		update_time_label.rect_position = UPDATE_TIME_POSITION
		
		var scene_name = scene().getSceneName()
		var font = ResourceUnit.loadRes(scene_name, "UpdateTimeText", "font") 
		var font_color = ResourceUnit.loadRes(scene_name, "UpdateTimeText", "font_color")
		
		update_time_label.add_font_override("font", font)
		update_time_label.add_color_override("font_color", font_color)

		scene().get_node("ArchiveInfoRect").add_child(update_time_label)
	
		update_time_text = ComponentPack.new("__updateTimeText", update_time_label)

	var archive = model().getSelectedArchive()

	var create_time_str = archive.getCreateTimeStr()
	create_time_text.getComponent().text = create_time_str

	var update_time_str = archive.getLastSaveTimeStr()
	update_time_text.getComponent().text = update_time_str

	renderLoadButton()
	renderDeleteButton()

func clearArchiveInfo():
	if create_text != null:
		scene().get_node("ArchiveInfoRect").remove_child(create_text.getComponent())
		create_text = null

	if create_time_text != null:
		scene().get_node("ArchiveInfoRect").remove_child(create_time_text.getComponent())
		create_time_text = null

	if update_text != null:
		scene().get_node("ArchiveInfoRect").remove_child(update_text.getComponent())
		update_text = null

	if update_time_text != null:
		scene().get_node("ArchiveInfoRect").remove_child(update_time_text.getComponent())
		update_time_text = null
