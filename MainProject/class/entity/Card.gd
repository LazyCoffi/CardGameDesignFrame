extends Node
class_name Card

var Category = load("res://class/entity/Category.gd")
var Info = load("res://class/entity/Info.gd")
var Attr = load("res://class/entity/Attr.gd")
var LocalFunction = load("res://class/functionalSystem/LocalFunction.gd")
var ScriptTree = load("res://class/entity/ScriptTree.gd")

var category				# 卡牌类型
var info 					# 卡牌信息
var attr					# 卡牌参数
var local_functions = {}	# 本地函数

func _ready():
	pass # Replace with function body.

func exec(func_name, params):
	Exception.assert(local_functions.has(func_name))
	var local_func = local_functions[func_name]
	return local_func.exec(params)

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("category", category)
	script_tree.addObject("info", info)
	script_tree.addObject("attr", attr)
	script_tree.addObjectDict("local_functions", local_functions)
	
	return script_tree

func loadScript(script_tree):
	Exception.assert(script_tree is ScriptTree)
	category = script_tree.getObject("category", Category)
	info = script_tree.getObject("info", Info)
	attr = script_tree.getObject("attr", Attr)
	local_functions = script_tree.getObjectDict("local_functions", LocalFunction)
