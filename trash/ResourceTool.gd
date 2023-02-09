extends Node

func parse(script_path):
	var file = File.new()
	assert(file.file_exists(script_path))
	file.open(script_path, File.READ)
	var json_str = file.get_as_text()
	file.close()
	var json_ret = JSON.parse(json_str)
	assert(json_ret.error == 0)
	
	return json_ret.result

func loadImage(image_path):
	var image = Image.new()
	assert(image.load(image_path) == 0)
	
	return image

func loadFont(font_attr):
	var font = DynamicFont.new()
	font.font_data = load(font_attr["font"])
	font.size = font_attr["font_size"]
	return font

func loadColor(color_name):
	return Color(color_name)

func loadTexture(texture_path):
	var texture = load(texture_path)
	assert(texture is Texture)
	
	return texture
