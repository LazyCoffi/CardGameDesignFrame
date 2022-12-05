extends Node
class_name Card

var category				# 卡牌类型
var info 					# 卡牌信息
var attr					# 卡牌参数
var local_functions = {}	# 本地函数

var Script = load("res://class/Script.gd")

func _ready():
	pass # Replace with function body.

func exec(func_name, params):
	Exception.assert(local_functions.has(func_name))
	var local_func = local_functions[func_name]
	return local_func.exec(params)

func pack():
	var script = Script.new()

	script.addScript("category", category)
	script.addScript("info", info)
	script.addScript("attr", attr)
	script.addScriptDict("local_functions", local_functions)
	
	return script

func loadScript(script):
	Exception.assert(script is Script)
	var Category = load("res://class/Category.gd")
	category = Category.new().loadScript(script.getScript("category"))
	var Info = load("res://class/Info.gd")
	info = Info.new().loadScript(script.getScript("info"))
	var Attr = load("res://class/Attr.gd")
	attr = Attr.new().loadScript(script.getScript("attr"))
	var LocalFunction = load("res//class/LocalFunction.gd")
	var raw_local_functions = script.getScriptDict("local_functions")
	for key in raw_local_functions.keys():
		local_functions[key] = LocalFunction.new().loadScript(raw_local_functions[key])
