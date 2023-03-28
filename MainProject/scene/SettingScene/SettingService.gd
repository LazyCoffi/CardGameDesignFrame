extends Node
class_name SettingService

var scene_ref

func setRef(scene):
	scene_ref = scene

func scene():
	return scene_ref

func model():
	return scene_ref.model()

func return():
	model().returnFunction(scene())

func adjustBgmVolume(rect_size, local_position):
	var volume = float(local_position[0]) / float(rect_size[0]) * 100
	
	AudioPlayer.setBgmVolume(volume)

func adjustSoundVolume(rect_size, local_position):
	var volume = float(local_position[0]) / float(rect_size[0]) * 100
	
	AudioPlayer.setSoundVolume(volume)
