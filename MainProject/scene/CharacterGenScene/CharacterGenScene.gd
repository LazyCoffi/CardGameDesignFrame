extends Node2D

signal changeSceneSignal

var is_registered

func isRegistered():
	return is_registered

func register():
	is_registered = true

func _init():
	is_registered = false

