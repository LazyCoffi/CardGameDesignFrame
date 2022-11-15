extends Label

func _ready():
	setButtonText()

func setButtonText():
	var font_data = GlobalSetting.getRes("main_menu/font")
	var font = ResourceTool.loadFont(font_data)
	var font_color_name = GlobalSetting.getRes("main_menu/font_color")
	var font_color = ResourceTool.loadColor(font_color_name)
	add_font_override("font", font)
	add_color_override("font_color", font_color)
	var font_text = GlobalSetting.getRes("main_menu/btn_texts")
	self.text = font_text[3]
