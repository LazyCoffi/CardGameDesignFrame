extends "res://scene/BaseService.gd"
class_name DialogService

func execOptionEffectFunc(index):
	model().execOptionEffectFunc(index, scene())
