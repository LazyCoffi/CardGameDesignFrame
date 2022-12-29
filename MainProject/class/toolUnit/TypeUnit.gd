extends Node

var type_table

func _init():
	__initTypeTable()

func getTypeByName(type_name):
	Exception.assert(type_table.has(type_name))
	return type_table[type_name]

func isType(val, type_name):
	match type_name:
		"all":	
			return true
		"int":
			return val is int
		"float":
			return val is float
		"bool":
			return val is bool
		"null":
			return val == null
		"Number":
			return val is int or val is float
		"String":
			return val is String
		"Array":
			return val is Array
		"Dictionary":
			return val is Dictionary
	
	var types = type_name.split("_")
	if types.size() == 2:
		if types[1] == "Array":
			for val_ in val:
				if not isType(val_, types[0]):
					return false
		elif types[1] == "Dictionary":
			for val_ in val.values():
				if not isType(val_, types[0]):
					return false
		else:
			return false

		return true
	elif types.size() > 2:
		return false

	return val is getTypeByName(type_name)

func isAdaptable(val, type_name):
	if isType(val, type_name):
		return true

	match type_name:
		"int":
			return isType(val, "float")
		"float":
			return isType(val, "int")
		"int_Array":
			return isType(val, "float_Array")
		"float_Array":
			return isType(val, "int_Array")
		"int_Dictionary":
			return isType(val, "float_Dictionary")
		"float_Dictionary":
			return isType(val, "int_Dictionary")
	
	return false

func verifyParamsType(params, params_form):
	Exception.assert(params.size() == params_form.size())
	var siz = params.size()
	for index in range(siz):
		if not isType(params[index], params_form[index]):
			return false
	
	return true

func verifyParamsAdaptable(params, params_form):
	Exception.assert(params.size() == params_form.size())
	var siz = params.size()
	for index in range(siz):
		if not isAdaptable(params[index], params_form[index]):
			return false
	
	return true

func __initTypeTable():
	type_table = {}
	__addType("entity", "Attr")
	__addType("entity", "Card")
	__addType("entity", "Category")
	__addType("entity", "Info")
	__addType("entity", "ScriptTree")
	__addType("entity", "ValRange")
	__addType("functionalSystem", "AttrConditionSet")
	__addType("functionalSystem", "AttrFunctionSet")
	__addType("functionalSystem", "BaseConditionSet")
	__addType("functionalSystem", "BaseFunctionSet")
	__addType("functionalSystem", "CardInterfaceSet")
	__addType("functionalSystem", "Function")
	__addType("functionalSystem", "FunctionalGraph")
	__addType("functionalSystem", "FunctionalInterface")
	__addType("functionalSystem", "FunctionalSet")
	__addType("functionalSystem", "LocalFunction")
	__addType("functionalSystem", "MathFunctionSet")
	__addType("sceneUnit", "SceneFactory")

func __addType(dict, type_name):
	var type = load("res://class/" + dict + "/" + type_name + ".gd")
	type_table[type_name] = type
