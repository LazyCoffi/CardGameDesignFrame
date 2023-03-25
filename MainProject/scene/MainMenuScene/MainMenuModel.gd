extends Node
class_name MainMenuModel

var HyperFunction = TypeUnit.type("HyperFunction")

var start_function		# HyperFunction
var continue_function	# HyperFunction
var setting_function	# HyperFunction
var exit_function		# HyperFunction

func startFunction(scene_ref):
	start_function.exec([scene_ref])

func setStartFunction(start_function_):
	start_function = start_function_

func continueFunction(scene_ref):
	continue_function.exec([scene_ref])

func setContinueFunction(continue_function_):
	continue_function = continue_function_

func settingFunction(scene_ref):
	setting_function.exec([scene_ref])

func setSettingFunction(setting_function_):
	setting_function = setting_function_

func exitFunction(scene_ref):
	exit_function.exec([scene_ref])

func setExitFunction(exit_function_):
	exit_function = exit_function_

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addObject("start_function", start_function)
	script_tree.addObject("continue_function", continue_function)
	script_tree.addObject("setting_function", setting_function)
	script_tree.addObject("exit_function", exit_function)

	return script_tree

func loadScript(script_tree):
	start_function = script_tree.getObject("start_function", HyperFunction)
	continue_function = script_tree.getObject("continue_function", HyperFunction)
	setting_function = script_tree.getObject("setting_function", HyperFunction)
	exit_function = script_tree.getObject("exit_function", HyperFunction)
