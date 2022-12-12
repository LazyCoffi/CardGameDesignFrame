extends Node
class_name ValRange

var upper_bound
var lower_bound
var has_upper
var has_lower

var ScriptTree = load("res://class/ScriptTree.gd")

func _init():
	has_upper = false
	has_lower = false

func hasUpper():
	return has_upper

func upper():
	if hasUpper():
		return upper_bound
	Exception.assert(false, "Nonexist upper_bound")

func hasLower():
	return has_lower

func lower():
	if hasLower():
		return lower_bound
	Exception.assert(false, "Nonexist lower_bound")

func setUpper(upper_bound_):
	Exception.assert(upper_bound_ is int or upper_bound_ is float, 
						"Range must be int or float")
	has_upper = true
	if hasLower():
		upper_bound = max(upper_bound_, lower_bound)
	else:
		upper_bound = upper_bound_

func setLower(lower_bound_):
	Exception.assert(lower_bound_ is int or lower_bound_ is float, 
						"Range must be int or float")
	has_lower = true
	if hasUpper():
		lower_bound = min(lower_bound_, upper_bound)
	else:
		lower_bound = lower_bound_

func delUpper():
	has_upper = false

func delLower():
	has_lower = false

func pack():
	var script_tree = ScriptTree.new()

	if hasUpper():
		script_tree.addAttr("upper_bound", upper_bound)
	if hasLower():
		script_tree.addAttr("lower_bound", lower_bound)
	
	return script_tree

func loadScript(script_tree):
	if script_tree.has("upper_bound"):
		has_upper = true
		upper_bound = script_tree.getAttr("upper_bound")
	if script_tree.has("lower_bound"):
		has_lower = true
		lower_bound = script_tree.getAttr("lower_bound")
	
	if hasUpper():
		Exception.assert(upper_bound is int or upper_bound is float, 
						"Range must be int or float")

	if hasLower():
		Exception.assert(lower_bound is int or lower_bound is float, 
						"Range must be int or float")
	
	if hasUpper() and hasLower():
		Exception.assert(lower_bound < upper_bound, 
						"lower_bound must be smaller than upper_bound")


