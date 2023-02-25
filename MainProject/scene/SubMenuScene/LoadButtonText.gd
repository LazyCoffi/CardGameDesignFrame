extends Label

var s_name
var c_name

func _init():
	c_name = "LoadButtonText"

func setSceneName(s_name_):
	s_name = s_name_

func loadResource():
	__setButtonText()

func __setButtonText():
	var font = ResourceUnit.loadRes(s_name, c_name , "font")
	var font_color = ResourceUnit.loadRes(s_name, c_name, "font_color")
	var font_text = ResourceUnit.loadRes(s_name, c_name, "font_text")

	add_font_override("font", font)
	add_color_override("font_color", font_color)
	self.text = font_text
