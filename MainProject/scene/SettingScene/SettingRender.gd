extends "res://scene/BaseRender.gd"
class_name SettingRender

var setting_frame		# ComponentPack
var bgm_text			# ComponentPack
var bgm_volume			# ComponentPack
var bgm_volume_mark		# ComponentPack
var sound_text			# ComponentPack
var sound_volume		# ComponentPack
var sound_volume_mark	# ComponentPack
var return_button		# ComponentPack
var return_text			# ComponentPack

func getSettingFrame():
	return setting_frame

func renderSettingFrame():
	var frame = TextureRect.new()

	var rect_size = model().getSettingFrameRectSize()
	var rect_position = model().getSettingFramePosition()
	var texture = ResourceUnit.loadRes(sceneName(), sceneName(), "setting_frame")

	frame.rect_size = rect_size
	frame.rect_position = rect_position
	frame.texture = texture

	scene().add_child(frame)

	var component_pack = ComponentPack.new("__settingFrame", frame)

	setting_frame = component_pack

func getBgmText():
	return bgm_text

func renderBgmText():
	var label = Label.new()
	
	var rect_size = model().getBgmTextRectSize()
	var rect_position = model().getBgmTextPosition()
	var text = model().getBgmText()
	var font = ResourceUnit.loadRes(sceneName(), "BgmText", "font")
	var font_color = ResourceUnit.loadRes(sceneName(), "BgmText", "font_color")

	label.align = Label.ALIGN_CENTER
	label.valign = Label.VALIGN_CENTER
	label.rect_size = rect_size
	label.rect_position = rect_position
	label.text = text
	label.add_font_override("font", font)
	label.add_color_override("font_color", font_color)

	var frame = getSettingFrame().getComponent()
	frame.add_child(label)

	var component_pack = ComponentPack.new("__bgmText", label)

	bgm_text = component_pack

func getBgmVolume():
	return bgm_volume	

func renderBgmVolume():
	var volume = TextureButton.new()
	
	var rect_size = model().getBgmVolumeRectSize()
	var rect_position = model().getBgmVolumePosition()
	var texture = ResourceUnit.loadRes(sceneName(), "BgmVolume", "texture")

	volume.rect_size = rect_size
	volume.rect_position = rect_position
	volume.texture_normal = texture

	var frame = getSettingFrame().getComponent()
	frame.add_child(volume)

	var component_pack = ComponentPack.new("__bgmVolume", volume)

	bgm_volume = component_pack

func getBgmVolumeMark():
	return bgm_volume_mark

func renderBgmVolumeMark():
	var mark = TextureRect.new()

	var rect_size = model().getVolumeMarkRectSize()
	var rect_position = Vector2(0, 0)
	var texture = ResourceUnit.loadRes(sceneName(), "SoundVolumeMark", "texture")

	mark.rect_size = rect_size
	mark.rect_position = rect_position
	mark.texture = texture

	var volume = getBgmVolume().getComponent()
	volume.add_child(mark)

	var component_pack = ComponentPack.new("__bgmVolumeMark", mark)
	bgm_volume_mark = component_pack

func getSoundVolume():
	return sound_volume

func renderSoundVolume():
	var volume = TextureButton.new()
	
	var rect_size = model().getSoundVolumeRectSize()
	var rect_position = model().getSoundVolumePosition()
	var texture = ResourceUnit.loadRes(sceneName(), "SoundVolume", "texture")

	volume.rect_size = rect_size
	volume.rect_position = rect_position
	volume.texture_normal = texture

	var frame = getSettingFrame().getComponent()
	frame.add_child(volume)

	var component_pack = ComponentPack.new("__soundVolume", volume)

	sound_volume = component_pack

func getSoundVolumeMark():
	return sound_volume_mark

func renderSoundVolumeMark():
	var mark = TextureRect.new()

	var rect_size = model().getVolumeMarkRectSize()
	var rect_position = Vector2(0, 0)
	var texture = ResourceUnit.loadRes(sceneName(), "SoundVolumeMark", "texture")

	mark.rect_size = rect_size
	mark.rect_position = rect_position
	mark.texture = texture

	var volume = getSoundVolume().getComponent()
	volume.add_child(mark)

	var component_pack = ComponentPack.new("__soundVolumeMark", mark)
	sound_volume_mark = component_pack

func updateBgmVolumeMark():
	var volume = getSoundVolume().getComponent()
	var mark = getBgmVolumeMark().getComponent()
	var local_position = volume.get_local_mouse_position()
	mark.rect_position = Vector2(local_position[0], 0)

	var rect_size = model().getBgmVolumeRectSize()
	service().adjustBgmVolume(rect_size, local_position)

func updateSoundVolumeMark():
	var volume = getSoundVolume().getComponent()
	var mark = getSoundVolumeMark().getComponent()
	var local_position = volume.get_local_mouse_position()
	mark.rect_position = Vector2(local_position[0], 0)

	var rect_size = model().getSoundVolumeRectSize()
	service().adjustSoundVolume(rect_size, local_position)

func getSoundText():
	return sound_text

func renderSoundText():
	var label = Label.new()
	
	var rect_size = model().getSoundTextRectSize()
	var rect_position = model().getSoundTextPosition()
	var text = model().getSoundText()
	var font = ResourceUnit.loadRes(sceneName(), "SoundText", "font")
	var font_color = ResourceUnit.loadRes(sceneName(), "SoundText", "font_color")

	label.align = Label.ALIGN_CENTER
	label.valign = Label.VALIGN_CENTER
	label.rect_size = rect_size
	label.rect_position = rect_position
	label.text = text
	label.add_font_override("font", font)
	label.add_color_override("font_color", font_color)

	var frame = getSettingFrame().getComponent()
	frame.add_child(label)

	var component_pack = ComponentPack.new("__soundText", label)

	sound_text = component_pack

func getReturnButton():
	return return_button

func renderReturnButton():
	var button = TextureButton.new()
	
	var rect_size = model().getReturnButtonRectSize()
	var rect_position = model().getReturnButtonPosition()
	var texture = ResourceUnit.loadRes(sceneName(), "ReturnButton", "texture")

	button.rect_size = rect_size
	button.rect_position = rect_position
	button.texture_normal = texture

	var frame = getSettingFrame().getComponent()
	frame.add_child(button)

	var component_pack = ComponentPack.new("__returnButton", button)

	return_button = component_pack

func getReturnText():
	return return_text

func renderReturnText():
	var label = Label.new()
	
	var rect_size = model().getReturnTextRectSize()
	var rect_position = model().getReturnTextPosition()
	var text = model().getReturnText()
	var font = ResourceUnit.loadRes(sceneName(), "ReturnText", "font")
	var font_color = ResourceUnit.loadRes(sceneName(), "ReturnText", "font_color")

	label.align = Label.ALIGN_CENTER
	label.valign = Label.VALIGN_CENTER
	label.rect_size = rect_size
	label.rect_position = rect_position
	label.text = text
	label.add_font_override("font", font)
	label.add_color_override("font_color", font_color)

	var button = getReturnButton().getComponent()
	button.add_child(label)

	var component_pack = ComponentPack.new("__returnText", label)

	return_text = component_pack
