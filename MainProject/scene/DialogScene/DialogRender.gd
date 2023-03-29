extends "res://scene/BaseRender.gd"
class_name DialogRender

var dialog_frame		# ComponentPack
var dialog_title		# ComponentPack
var dialog_pic			# ComponentPack
var dialog_info			# ComponentPack
var dialog_option_frame	# ComponentPack
var dialog_option_list	# ComponentPack_Array

func _init():
	dialog_frame = null
	dialog_title = null
	dialog_pic = null
	dialog_info = null
	dialog_option_list = []

func getDialogFrame():
	return dialog_frame

func renderDialogFrame():
	var frame = TextureRect.new()
	
	var rect_size = model().getDialogFrameRectSize()
	var rect_position = model().getDialogFramePosition()
	var texture = ResourceUnit.loadRes(sceneName(), sceneName(), "dialog_frame")

	frame.rect_size = rect_size
	frame.rect_position = rect_position
	frame.texture = texture

	scene().add_child(frame)

	var component_pack = ComponentPack.new("__dialogFrame", frame)

	dialog_frame = component_pack

func getDialogTitle():
	return dialog_title

func renderDialogTitle():
	var title = Label.new()
	
	var rect_size = model().getDialogTitleRectSize()
	var rect_position = model().getDialogTitlePosition()
	var font = ResourceUnit.loadRes(sceneName(), sceneName(), "title_font")
	var font_color = ResourceUnit.loadRes(sceneName(), sceneName(), "title_font_color")

	title.align = Label.ALIGN_CENTER
	title.valign = Label.VALIGN_CENTER

	title.rect_size = rect_size
	title.rect_position = rect_position
	title.add_font_override("font", font)
	title.add_color_override("font_color", font_color)
	title.text = model().getTitle()

	var frame = getDialogFrame().getComponent()
	frame.add_child(title)

	var component_pack = ComponentPack.new("__dialogTitle", title)
	dialog_title = component_pack

func getDialogPic():
	return dialog_pic

func renderDialogPic():
	var pic = TextureRect.new()
	
	var rect_size = model().getDialogPicRectSize()
	var rect_position = model().getDialogPicPosition()
	var texture = ResourceUnit.loadRes(sceneName(), sceneName(), "dialog_pic")

	pic.expand = true
	pic.rect_size = rect_size
	pic.rect_position = rect_position
	pic.texture = texture

	var frame = getDialogFrame().getComponent()
	frame.add_child(pic)

	var component_pack = ComponentPack.new("__dialogPic", pic)
	dialog_pic = component_pack

func getDialogInfo():
	return dialog_info

func renderDialogInfo():
	var info = RichTextLabel.new()

	var rect_size = model().getInfoRectSize()
	var rect_position = model().getInfoPosition()
	var font = ResourceUnit.loadRes(sceneName(), sceneName(), "info_font")
	var font_color = ResourceUnit.loadRes(sceneName(), sceneName(), "info_font_color")
	var text = model().getInfo()

	info.rect_size = rect_size
	info.rect_position = rect_position

	info.clear()
	info.push_font(font) 
	info.push_color(font_color)
	info.add_text(text)

	var frame = getDialogFrame().getComponent()
	frame.add_child(info)

	var component_pack = ComponentPack.new("__dialogInfo", info)
	dialog_info = component_pack

func setDialogTitleText(title_text):
	var title = getDialogTitle().getComponent()
	title.text = title_text	
	service().setTitle(title_text)

func setDialogInfoText(info_text):
	var font = ResourceUnit.loadRes(sceneName(), sceneName(), "info_font")
	var font_color = ResourceUnit.loadRes(sceneName(), sceneName(), "info_font_color")
	var info = getDialogInfo().getComponent()

	info.clear()
	info.push_font(font) 
	info.push_color(font_color)
	info.add_text(info_text)

	service().setInfo(info_text)

func getOptionList():
	return dialog_option_list

func __getOptionPositionList():
	var option_num = model().getOptionNum()
	var frame_rect_size = model().getOptionFrameRectSize()
	var button_rect_size = model().getOptionButtonRectSize()

	var x_gap = (frame_rect_size[0] - button_rect_size[0]) / 2
	var y_gap = (frame_rect_size[1] - option_num * button_rect_size[1]) / (option_num + 1)

	var ret = []

	for index in range(option_num):
		ret.append(Vector2(x_gap, y_gap + index * (y_gap + button_rect_size[1])))
	
	return ret

func __renderOption(option_text, option_position):
	var option = TextureButton.new()
	var rect_size = model().getOptionButtonRectSize()
	var texture = ResourceUnit.loadRes(sceneName(), sceneName(), "option_button")
	
	option.rect_size = rect_size
	option.rect_position = option_position
	option.texture_normal = texture

	var option_label = Label.new()
	var font = ResourceUnit.loadRes(sceneName(), sceneName(), "option_font")
	var font_color = ResourceUnit.loadRes(sceneName(), sceneName(), "option_font_color")
	option_label.align = Label.ALIGN_CENTER
	option_label.valign = Label.VALIGN_CENTER
	option_label.rect_size = rect_size
	option_label.rect_position = Vector2()
	option_label.text = option_text
	option_label.add_font_override("font", font)
	option_label.add_color_override("font_color", font_color)

	option.add_child(option_label)

	return option

func getOptionFrame():
	return dialog_option_frame

func renderOptionFrame():
	var inner_frame = TextureRect.new()
	
	var rect_size = model().getOptionFrameRectSize()
	var rect_position = model().getOptionFramePosition()
	inner_frame.rect_size = rect_size
	inner_frame.rect_position = rect_position

	var frame = getDialogFrame().getComponent()
	frame.add_child(inner_frame)

	var component_pack = ComponentPack.new("__optionFrame", inner_frame)
	dialog_option_frame = component_pack

func renderOptionList():
	var option_frame = getOptionFrame().getComponent()
	for component_pack in dialog_option_list:
		var option = component_pack.getComponent()
		option_frame.remove_child(option)
	
	dialog_option_list.clear()
	
	var option_num = model().getOptionNum()
	var option_position_list = __getOptionPositionList()		
	var option_text_list = model().getOptionTextList()

	for index in range(option_num):
		var option = __renderOption(option_text_list[index], option_position_list[index])
		option_frame.add_child(option)
		var component_pack = ComponentPack.new(index, option)
		dialog_option_list.append(component_pack)
