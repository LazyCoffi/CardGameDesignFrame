extends "res://scene/BaseRender.gd"
class_name ArchiveRender

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

func getArchiveInfoRect():
	return scene().get_node("ArchiveOperRect/ArchiveInfoRect")

func renderBackground():
	var scene_name = scene().getSceneName()
	var background = ResourceUnit.loadRes(scene_name, scene_name, "background")
	scene().get_node("ArchiveBackground").texture = background

func renderMenuRect():
	var menu_rect = ResourceUnit.loadRes(sceneName(), sceneName(), "menu_rect")
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

	load_btn.rect_position = model().getLoadButtonPosition()
	load_btn.rect_size = model().getButtonRectSize()
	load_btn.expand = true

	var scene_name = scene().getSceneName()
	var texture_normal = ResourceUnit.loadRes(sceneName(), "LoadButton",  "texture_normal")

	load_btn.texture_normal = texture_normal

	var load_label = Label.new()

	load_label.name = "LOAD_TEXT"
	load_label.align = Label.ALIGN_CENTER
	load_label.valign = Label.VALIGN_CENTER

	load_label.rect_size = model().getLabelRectSize()
	load_label.rect_position = model().getLabelPosition()
	load_label.text = model().getLoadLabelText()

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

	delete_btn.rect_position = model().getDeleteButtonPosition()
	delete_btn.rect_size = model().getButtonRectSize()

	delete_btn.expand = true

	var scene_name = scene().getSceneName()
	var texture_normal = ResourceUnit.loadRes(scene_name, "DeleteButton",  "texture_normal")

	delete_btn.texture_normal = texture_normal

	var delete_label = Label.new()

	delete_label.name = "DELETE_TEXT"
	delete_label.align = Label.ALIGN_CENTER
	delete_label.valign = Label.VALIGN_CENTER
	delete_label.rect_size = model().getLabelRectSize()
	delete_label.rect_position = model().getLabelPosition()
	delete_label.text = model().getDeleteLabelText()

	var font = ResourceUnit.loadRes(scene_name, "DeleteText", "font") 
	var font_color = ResourceUnit.loadRes(scene_name, "DeleteText", "font_color")
		
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

	back_btn.rect_position = model().getBackButtonPosition()
	back_btn.rect_size = model().getButtonRectSize()
	back_btn.expand = true

	var scene_name = scene().getSceneName()
	var texture_normal = ResourceUnit.loadRes(scene_name, "BackButton",  "texture_normal")

	back_btn.texture_normal = texture_normal
		
	var back_label = Label.new()

	back_label.name = "BACK_TEXT"
	back_label.align = Label.ALIGN_CENTER
	back_label.valign = Label.VALIGN_CENTER
	back_label.rect_size = model().getLabelRectSize()
	back_label.rect_position = model().getLabelPosition()
	back_label.text = model().getBackLabelText()

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

	next_btn.rect_position = model().getNextButtonPosition()
	next_btn.rect_size = model().getSwitchRectSize()
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

	previous_btn.rect_position = model().getPreviousButtonPosition()
	previous_btn.rect_size = model().getSwitchRectSize()
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
		for index in range(model().getMaxArchiveNum()):
			var archive_card = TextureButton.new()
			archive_card.rect_size = model().getCardRectSize()
			archive_card.rect_position = model().getCardPositionList()[index]
			archive_card.expand = true

			var text_label = Label.new()
			text_label.align = Label.ALIGN_CENTER
			text_label.valign = Label.VALIGN_CENTER
			text_label.name = "CardText"
			text_label.rect_size = model().getCardTextRectSize()
			text_label.rect_position = model().getCardTextPosition()

			archive_card.add_child(text_label)
			scene().get_node("ArchiveListRect").add_child(archive_card)

			var component_pack = ComponentPack.new(index, archive_card)
			archive_card_list.append(component_pack)
	
	var archive_num = current_archive_list.size()

	for index in range(archive_num):
		var component_pack = archive_card_list[index]
		var archive_card = component_pack.getComponent()

		var scene_name = scene().getSceneName()
		var texture = ResourceUnit.loadRes(scene_name, "ArchiveCard", "active_card")
		archive_card.texture_normal = texture

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
		create_label.align = Label.ALIGN_CENTER
		create_label.valign = Label.VALIGN_CENTER

		create_label.rect_size = model().getInfoLabelRectSize()
		create_label.rect_position = model().getInfoCreatePosition()
		
		var scene_name = scene().getSceneName()
		var font = ResourceUnit.loadRes(scene_name, "CreateText", "font") 
		var font_color = ResourceUnit.loadRes(scene_name, "CreateText", "font_color")
		
		create_label.add_font_override("font", font)
		create_label.add_color_override("font_color", font_color)
		create_label.text = model().getInfoCreateText()

		getArchiveInfoRect().add_child(create_label)

		create_text = ComponentPack.new("__createText", create_label)
	
	if update_text == null:
		var update_label = Label.new()
		update_label.align = Label.ALIGN_CENTER
		update_label.valign = Label.VALIGN_CENTER

		update_label.rect_size = model().getInfoLabelRectSize()
		update_label.rect_position = model().getInfoUpdatePosition()
		
		var scene_name = scene().getSceneName()
		var font = ResourceUnit.loadRes(scene_name, "UpdateText", "font") 
		var font_color = ResourceUnit.loadRes(scene_name, "UpdateText", "font_color")
		
		update_label.add_font_override("font", font)
		update_label.add_color_override("font_color", font_color)
		update_label.text = model().getInfoUpdateText()

		getArchiveInfoRect().add_child(update_label)

		update_text = ComponentPack.new("__updateText", update_label)

	if create_time_text == null:
		var create_time_label = Label.new()
		create_time_label.valign = Label.VALIGN_CENTER

		create_time_label.rect_size = model().getInfoLabelRectSize()
		create_time_label.rect_position = model().getInfoCreateTimePosition()
		
		var scene_name = scene().getSceneName()
		var font = ResourceUnit.loadRes(scene_name, "CreateTimeText", "font") 
		var font_color = ResourceUnit.loadRes(scene_name, "CreateTimeText", "font_color")
		
		create_time_label.add_font_override("font", font)
		create_time_label.add_color_override("font_color", font_color)

		getArchiveInfoRect().add_child(create_time_label)

		create_time_text = ComponentPack.new("__createTimeText", create_time_label)
	
	if update_time_text == null:
		var update_time_label = Label.new()
		update_time_label.valign = Label.VALIGN_CENTER

		update_time_label.rect_size = model().getInfoLabelRectSize()
		update_time_label.rect_position = model().getInfoUpdateTimePosition()
		
		var scene_name = scene().getSceneName()
		var font = ResourceUnit.loadRes(scene_name, "UpdateTimeText", "font") 
		var font_color = ResourceUnit.loadRes(scene_name, "UpdateTimeText", "font_color")
		
		update_time_label.add_font_override("font", font)
		update_time_label.add_color_override("font_color", font_color)

		getArchiveInfoRect().add_child(update_time_label)
	
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
		getArchiveInfoRect().remove_child(create_text.getComponent())
		create_text = null

	if create_time_text != null:
		getArchiveInfoRect().remove_child(create_time_text.getComponent())
		create_time_text = null

	if update_text != null:
		getArchiveInfoRect().remove_child(update_text.getComponent())
		update_text = null

	if update_time_text != null:
		getArchiveInfoRect().remove_child(update_time_text.getComponent())
		update_time_text = null
