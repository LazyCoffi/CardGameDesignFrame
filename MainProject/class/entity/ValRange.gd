extends Node
class_name ValRange

var attr_type		# String
var has_bound		# bool
var has_upper		# bool
var has_lower		# bool
var upper_bound		# attr
var lower_bound		# attr

var ScriptTree = TypeUnit.type("ScriptTree")

func _init():
	has_upper = false
	has_lower = false

func copy():
	var ret = TypeUnit.type("ValRange").new()
	ret.attr_type = attr_type
	ret.has_bound = has_bound
	ret.has_upper = has_upper
	ret.has_lower = has_lower
	ret.upper_bound = upper_bound
	ret.lower_bound = lower_bound

	return ret

func setAttrType(attr_type_):
	attr_type = attr_type_

func hasBound():
	return has_bound

func activeBound():
	has_bound = true

func hasUpper():
	return has_upper

func upper():
	if hasUpper():
		return upper_bound
	Logger.assert(false, "Nonexist upper_bound")

func hasLower():
	return has_lower

func lower():
	if hasLower():
		return lower_bound
	Logger.assert(false, "Nonexist lower_bound")

func setUpper(upper_bound_):
	Logger.assert(upper_bound_ is int or upper_bound_ is float, 
						"Range must be int or float")
	has_upper = true
	if hasLower():
		upper_bound = max(upper_bound_, lower_bound)
	else:
		upper_bound = upper_bound_

func setLower(lower_bound_):
	Logger.assert(lower_bound_ is int or lower_bound_ is float, 
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

	script_tree.addAttr("attr_type", attr_type)
	script_tree.addAttr("has_bound", has_bound)
	script_tree.addAttr("has_upper", has_upper)
	script_tree.addAttr("has_lower", has_lower)
	script_tree.addAttr("upper_bound", upper_bound)
	script_tree.addAttr("lower_bound", lower_bound)
	
	return script_tree

func loadScript(script_tree):
	attr_type = script_tree.getStr("attr_type")
	has_bound = script_tree.getBool("has_bound")
	has_upper = script_tree.getBool("has_upper")
	has_lower = script_tree.getBool("has_lower")
	upper_bound = script_tree.getAttr("upper_bound", attr_type)
	lower_bound = script_tree.getAttr("lower_bound", attr_type)
