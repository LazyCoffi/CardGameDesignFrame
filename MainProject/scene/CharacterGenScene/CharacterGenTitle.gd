extends Label

signal changeSceneSignal

var is_registered

func isRegistered():
	return is_registered

func register():
	is_registered = true

func _init():
	is_registered = false

func _ready():
	setTitleText()	

func setTitleText():
	var font_data = GlobalSetting.getRes("character_gen/title/font")
	var font = ResourceTool.loadFont(font_data)
	var font_color_name = GlobalSetting.getRes("character_gen/title/font_color")
	var font_color = ResourceTool.loadColor(font_color_name)
	add_font_override("font", font)
	add_color_override("font_color", font_color)

	var text = GlobalSetting.getRes("character_gen/title/title_text")
	self.text = text
