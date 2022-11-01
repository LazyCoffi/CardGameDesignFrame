extends Node

static func parse(script_path):
	var file = File.new()
	assert(file.file_exists(script_path))
	file.open(script_path, File.READ)
	var json_str = file.get_as_text()
	file.close()
	var json_ret = JSON.parse(json_str)
	assert(json_ret.error == 0)
	
	return json_ret.result

static func loadImage(avator_path):
	var image = Image.new()
	var image_path = "res://assert/avator/" + avator_path + ".png"
	assert(image.load(image_path) == 0)
	return image
