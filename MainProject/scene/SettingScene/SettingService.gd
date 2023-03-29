extends "res://scene/BaseService.gd"
class_name SettingService

func return():
	model().returnFunction(scene())

func adjustBgmVolume(rect_size, local_position):
	var volume = float(local_position[0]) / float(rect_size[0]) * 100
	
	AudioPlayer.setBgmVolume(volume)

func adjustSoundVolume(rect_size, local_position):
	var volume = float(local_position[0]) / float(rect_size[0]) * 100
	
	AudioPlayer.setSoundVolume(volume)
