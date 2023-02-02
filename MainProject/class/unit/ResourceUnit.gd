extends Node

var ScriptTree = load("res://class/entity/ScriptTree.gd")

var resource_table	# Dict

func _init():
	__initScript()

func loadTexture(s_name, c_name, r_name):
	var res = __getRes(s_name, c_name, r_name)
	var texture = load(res["texture"])

	return texture

func loadText(s_name, c_name, r_name):
	var res = __getRes(s_name, c_name, r_name)
	return res["text"]

func loadFont(s_name, c_name, r_name):
	var res = __getRes(s_name, c_name, r_name)
	var font = DynamicFont.new()
	font.font_data = load(res["font"])
	font.size = res["font_size"]

	return font

func __initScript():
	var script_tree = ScriptTree.new()
	script_tree.loadFromJson("res://scripts/system/resource_unit.json")
	resource_table = script_tree.getRawAttr("resource_table")

func loadColor(s_name, c_name, r_name):
	var res = __getRes(s_name, c_name, r_name)

	if res.has("color_name"):
		return Color(res["color_name"])
	
	if res.has("rgba_int"):
		return Color(res["rbga_int"])
	
	if res.has("rgb"):
		var rgb = res["rgb"]
		return Color(rgb[0], rgb[1], rgb[2])

	if res.has("rgba"):
		var rgba = res["rgba"]
		return Color(rgba[0], rgba[1], rgba[2], rgba[3])

func __getRes(s_name, c_name, r_name):
	 Exception.assert(resource_table.has(s_name))
	 Exception.assert(resource_table[s_name].has(c_name))
	 Exception.assert(resource_table[s_name][c_name].has(r_name))
	 return resource_table[s_name][c_name][r_name]
