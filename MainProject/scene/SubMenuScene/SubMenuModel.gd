extends "res://scene/BaseModel.gd"
class_name SubMenuModel

var resume_function		# HyperFunction
var setting_function	# HyperFunction
var exit_function		# HyperFunction

func resumeFunction(scene_ref):
	resume_function.exec([scene_ref])

func setResumeFunction(resume_function_):
	resume_function = resume_function_

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

	script_tree.addObject("resume_function", resume_function)
	script_tree.addObject("setting_function", setting_function)
	script_tree.addObject("exit_function", exit_function)

	return script_tree

func loadScript(script_tree):
	resume_function = script_tree.getObject("resume_function", HyperFunction)
	setting_function = script_tree.getObject("setting_function", HyperFunction)
	exit_function = script_tree.getObject("exit_function", HyperFunction)
