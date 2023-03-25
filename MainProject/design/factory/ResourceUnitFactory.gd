extends "res://design/factory/Factory.gd"
class_name ResourceUnitFactory

func _init():
	entity_type = "ResourceUnit"
	entity = TypeUnit.type(entity_type).new()

func initMemberList():
	addFuncMember("addTexture", [
		{"name" : "s_name", "type" : "String", "param_type" : "val"},
		{"name" : "c_name", "type" : "String", "param_type" : "val"},
		{"name" : "r_name", "type" : "String", "param_type" : "val"},
		{"name" : "texture_path", "type" : "String", "param_type" : "path"}
	])

	addFuncMember("addText", [
		{"name" : "s_name", "type" : "String", "param_type" : "val"},
		{"name" : "c_name", "type" : "String", "param_type" : "val"},
		{"name" : "r_name", "type" : "String", "param_type" : "val"},
		{"name" : "text", "type" : "String", "param_type" : "val"},
	])

	addFuncMember("addFont", [
		{"name" : "s_name", "type" : "String", "param_type" : "val"},
		{"name" : "c_name", "type" : "String", "param_type" : "val"},
		{"name" : "r_name", "type" : "String", "param_type" : "val"},
		{"name" : "font_path", "type" : "String", "param_type" : "path"},
		{"name" : "font_size", "type" : "int", "param_type" : "val"}
	])

	addFuncMember("addColorByName", [
		{"name" : "s_name", "type" : "String", "param_type" : "val"},
		{"name" : "c_name", "type" : "String", "param_type" : "val"},
		{"name" : "r_name", "type" : "String", "param_type" : "val"},
		{"name" : "color_name", "type" : "String", "param_type" : "val"}
	])

	addFuncMember("addColorByRgbaInt", [
		{"name" : "s_name", "type" : "String", "param_type" : "val"},
		{"name" : "c_name", "type" : "String", "param_type" : "val"},
		{"name" : "r_name", "type" : "String", "param_type" : "val"},
		{"name" : "rgba_int", "type" : "int", "param_type" : "val"}
	])

func initOverviewList():
	addArrayOverview("TextureNode", "getTextureList", [
		{"attr_name" : "s_name", "func_name" : "getSName"},
		{"attr_name" : "c_name", "func_name" : "getCName"},
		{"attr_name" : "r_name", "func_name" : "getRName"},
		{"attr_name" : "path", "func_name" : "getTexturePath"}
	])

	addArrayOverview("TextNode", "getTextList", [
		{"attr_name" : "s_name", "func_name" : "getSName"},
		{"attr_name" : "c_name", "func_name" : "getCName"},
		{"attr_name" : "r_name", "func_name" : "getRName"},
		{"attr_name" : "text", "func_name" : "getText"}
	])

	addArrayOverview("FontNode", "getFontList", [
		{"attr_name" : "s_name", "func_name" : "getSName"},
		{"attr_name" : "c_name", "func_name" : "getCName"},
		{"attr_name" : "r_name", "func_name" : "getRName"},
		{"attr_name" : "font_path", "func_name" : "getFontPath"},
		{"attr_name" : "font_size", "func_name" : "getFontSize"},
	])

	addArrayOverview("ColorNode", "getColorList", [
		{"attr_name" : "s_name", "func_name" : "getSName"},
		{"attr_name" : "c_name", "func_name" : "getCName"},
		{"attr_name" : "r_name", "func_name" : "getRName"},
		{"attr_name" : "color_name", "func_name" : "getColorName"},
	])
