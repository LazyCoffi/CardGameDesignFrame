extends Node

var ScriptTree = TypeUnit.type("ScriptTree")

var resource_table	# Dict
var node_list		# Array
var type_table		# Dict

class TextureNode:
	var texture_path
	var s_name
	var c_name
	var r_name

	func _init():
		texture_path = ""
	
	func setName(s_name_, c_name_, r_name_):
		s_name = s_name_
		c_name = c_name_
		r_name = r_name_
	
	func getSName():
		return s_name
	
	func getCName():
		return c_name
	
	func getRName():
		return r_name
	
	func getTexturePath():
		return texture_path
	
	func setTexturePath(texture_path_):
		texture_path = texture_path_

	func loadRes():
		return load(texture_path)

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("texture_path", texture_path)
		script_tree.addAttr("s_name", s_name)
		script_tree.addAttr("c_name", c_name)
		script_tree.addAttr("r_name", r_name)

		return script_tree
	
	func loadScript(script_tree):
		texture_path = script_tree.getStr("texture_path")
		s_name = script_tree.getStr("s_name")
		c_name = script_tree.getStr("c_name")
		r_name = script_tree.getStr("r_name")

class TextNode:
	var text
	var s_name
	var c_name
	var r_name

	func _init():
		text = ""

	func setName(s_name_, c_name_, r_name_):
		s_name = s_name_
		c_name = c_name_
		r_name = r_name_
	
	func getSName():
		return s_name
	
	func getCName():
		return c_name
	
	func getRName():
		return r_name
	

	func getText():
		return text
	
	func setText(text_):
		text = text_
	
	func loadRes():
		return text
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("text", text)
		script_tree.addAttr("s_name", s_name)
		script_tree.addAttr("c_name", c_name)
		script_tree.addAttr("r_name", r_name)

		return script_tree
	
	func loadScript(script_tree):
		text = script_tree.getStr("text")
		s_name = script_tree.getStr("s_name")
		c_name = script_tree.getStr("c_name")
		r_name = script_tree.getStr("r_name")

class FontNode:
	var font_path
	var font_size
	var s_name
	var c_name
	var r_name

	func _init():
		font_path = ""
		font_size = 0

	func setName(s_name_, c_name_, r_name_):
		s_name = s_name_
		c_name = c_name_
		r_name = r_name_
	
	func getSName():
		return s_name
	
	func getCName():
		return c_name
	
	func getRName():
		return r_name

	func getFontPath():
		return font_path
		
	func setFontPath(font_path_):
		font_path = font_path_
	
	func getFontSize():
		return font_size
	
	func setFontSize(font_size_):
		font_size = font_size_
	
	func loadRes():
		var font = DynamicFont.new()
		font.font_data = load(font_path)
		font.size = font_size

		return font

	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("font_path", font_path)
		script_tree.addAttr("font_size", font_size)
		script_tree.addAttr("s_name", s_name)
		script_tree.addAttr("c_name", c_name)
		script_tree.addAttr("r_name", r_name)

		return script_tree

	func loadScript(script_tree):
		font_path = script_tree.getStr("font_path")
		font_size = script_tree.getInt("font_size")
		s_name = script_tree.getStr("s_name")
		c_name = script_tree.getStr("c_name")
		r_name = script_tree.getStr("r_name")

class ColorNode:
	var color_name
	var rgba_int
	var rgb
	var rgba
	var type
	var s_name
	var c_name
	var r_name

	func _init():
		color_name = ""
		rgba_int = 0
		rgb = []
		rgba = []
		type = 0	

	func setName(s_name_, c_name_, r_name_):
		s_name = s_name_
		c_name = c_name_
		r_name = r_name_
	
	func getSName():
		return s_name
	
	func getCName():
		return c_name
	
	func getRName():
		return r_name

	func getColorName():
		return color_name
	
	func setColorName(color_name_):
		color_name = color_name_
		type = 0
	
	func setRgbaInt(rgba_int_):
		rgba_int = rgba_int_
		type = 1	

	func setRgb(rgb_):
		rgb = rgb_
		type = 2
	
	func setRgba(rgba_):
		rgba = rgba_
		type = 3
	
	func loadRes():
		match type:
			0:
				return Color(color_name)	
			1:
				return Color(rgba_int)
			2:
				return Color(rgb[0], rgb[1], rgb[2])
			3:
				return Color(rgba[0], rgba[1], rgba[2], rgba[3])
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("color_name", color_name)
		script_tree.addAttr("rgba_int", rgba_int)
		script_tree.addAttr("rgb", rgb)
		script_tree.addAttr("rgba", rgba)
		script_tree.addAttr("type", type)
		script_tree.addAttr("s_name", s_name)
		script_tree.addAttr("c_name", c_name)
		script_tree.addAttr("r_name", r_name)

		return script_tree
	
	func loadScript(script_tree):
		color_name = script_tree.getStr("color_name")
		rgba_int = script_tree.getInt("rgba_int")
		rgb = script_tree.getFloatArray("rgb")
		rgba = script_tree.getFloatArray("rgba")
		type = script_tree.getInt("type")
		s_name = script_tree.getStr("s_name")
		c_name = script_tree.getStr("c_name")
		r_name = script_tree.getStr("r_name")

func _init():
	resource_table = {}
	node_list = []
	__initTypeTable()

func addTexture(s_name, c_name, r_name, 
				texture_path):
	var node = TextureNode.new()
	node.setTexturePath(texture_path)
	node.setName(s_name, c_name, r_name)
	__storeResourceIndex(s_name, c_name, r_name, 
						 "TextureNode", node)

func addText(s_name, c_name, r_name,
			 text):
	var node = TextNode.new()
	node.setText(text)
	node.setName(s_name, c_name, r_name)

	__storeResourceIndex(s_name, c_name, r_name,
						 "TextNode", node)

func addFont(s_name, c_name, r_name,
			 font_path, font_size):
	var node = FontNode.new()
	node.setFontPath(font_path)
	node.setFontSize(font_size)
	node.setName(s_name, c_name, r_name)

	__storeResourceIndex(s_name, c_name, r_name,
						 "FontNode", node)

func addColorByName(s_name, c_name, r_name,
					color_name):
	var node = ColorNode.new()
	node.setColorName(color_name)
	node.setName(s_name, c_name, r_name)

	__storeResourceIndex(s_name, c_name, r_name,
						 "ColorNode", node)

func addColorByRgbaInt(s_name, c_name, r_name,
					   rgba_int):
	var node = ColorNode.new()
	node.setRgbaInt(rgba_int)
	node.setName(s_name, c_name, r_name)

	__storeResourceIndex(s_name, c_name, r_name,
						 "ColorNode", node)

func addColorByRgb(s_name, c_name, r_name,
				   rgb):
	var node = ColorNode.new()
	node.setRgb(rgb)
	node.setName(s_name, c_name, r_name)

	__storeResourceIndex(s_name, c_name, r_name,
						 "ColorNode", node)

func addColorByRgba(s_name, c_name, r_name,
				   rgba):
	var node = ColorNode.new()
	node.setRgba(rgba)
	node.setName(s_name, c_name, r_name)

	__storeResourceIndex(s_name, c_name, r_name,
						 "ColorNode", node)

func getTextureList():
	var ret = []
	for s_name in resource_table.keys():
		for c_name in resource_table[s_name].keys():
			for r_name in resource_table[s_name][c_name].keys():
				var	index = int(resource_table[s_name][c_name][r_name][0])
				var node = node_list[index]

				if node is TextureNode:
					ret.append(node)

	return ret

func getTextList():
	var ret = []
	for s_name in resource_table.keys():
		for c_name in resource_table[s_name].keys():
			for r_name in resource_table[s_name][c_name].keys():
				var	index = int(resource_table[s_name][c_name][r_name][0])
				var node = node_list[index]

				if node is TextNode:
					ret.append(node)

	return ret

func getFontList():
	var ret = []
	for s_name in resource_table.keys():
		for c_name in resource_table[s_name].keys():
			for r_name in resource_table[s_name][c_name].keys():
				var	index = int(resource_table[s_name][c_name][r_name][0])
				var node = node_list[index]

				if node is FontNode:
					ret.append(node)

	return ret

func getColorList():
	var ret = []
	for s_name in resource_table.keys():
		for c_name in resource_table[s_name].keys():
			for r_name in resource_table[s_name][c_name].keys():
				var	index = int(resource_table[s_name][c_name][r_name][0])
				var node = node_list[index]

				if node is ColorNode:
					ret.append(node)
	
	return ret

func loadRes(s_name, c_name, r_name):
	var index = int(resource_table[s_name][c_name][r_name][0])

	return node_list[index].loadRes()

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addAttr("resource_table", resource_table)
	script_tree.addObjectArray("node_list", node_list)

	return script_tree

func loadScript(script_tree):
	resource_table = script_tree.getRawAttr("resource_table")
	var script_list = script_tree.getScriptTreeArray("node_list")
	node_list.resize(script_list.size())

	for s_name in resource_table.keys():
		for c_name in resource_table[s_name].keys():
			for r_name in resource_table[s_name][c_name].keys():
				var index = int(resource_table[s_name][c_name][r_name][0])
				var type = __getType(resource_table[s_name][c_name][r_name][1])
				var node = type.new()
				node.loadScript(script_list[index])
				node_list[index] = node

func __storeResourceIndex(s_name, c_name, r_name, 
						  node_type, node):
	var index = node_list.size()
	node_list.append(node)

	if not resource_table.has(s_name):
		resource_table[s_name] = {}
	if not resource_table[s_name].has(c_name):
		resource_table[s_name][c_name] = {}
	resource_table[s_name][c_name][r_name] = [index, node_type]

func __initTypeTable():
	type_table = {}
	__addType("TextureNode", TextureNode)
	__addType("TextNode", TextNode)
	__addType("FontNode", FontNode)
	__addType("ColorNode", ColorNode)

func __getType(type_name):
	return type_table[type_name]

func __addType(type_name, type):
	type_table[type_name] = type

func initScript():
	var path = "res://scripts/system/resource_unit.json"
	var file = File.new()
	if file.file_exists(path):
		var script_tree = ScriptTree.new()
		script_tree.loadFromJson(path)
		loadScript(script_tree)
