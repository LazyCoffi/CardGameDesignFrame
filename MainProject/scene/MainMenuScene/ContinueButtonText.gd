extends Label

func loadResource(s_name, c_name):
	setButtonText(s_name, c_name)

func setButtonText(s_name, c_name):
	var font = ResourceUnit.loadFont(s_name, c_name , "font")
	var font_color = ResourceUnit.loadColor(s_name, c_name, "font_color")
	var font_text = ResourceUnit.loadText(s_name, c_name, "font_text")

	add_font_override("font", font)
	add_color_override("font_color", font_color)
	self.text = font_text
