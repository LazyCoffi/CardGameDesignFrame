extends Node
class_name PollingBucket

## 轮询桶: 基本逻辑为一轮内当前桶内的顺序保持不变，在一轮结束前桶内只允许删除不允许增加，新加入的内容储存至缓冲区；一轮结束后，将缓冲区内容加入，重排所有内容，并从头开始轮询

var ScriptTree = TypeUnit.type("ScriptTree")
var Function = TypeUnit.type("Function")
var Integer = TypeUnit.type("Integer")
var Float = TypeUnit.type("Float")
var StringPack = TypeUnit.type("StringPack")
var NullPack = TypeUnit.type("NullPack")

class BucketNode:
	var param_name
	var param

	var param_type

	func _init(param_name_, param_):
		param_name = param_name_
		param = param_
	
	func copy():
		return BucketNode.new(param_name, param.copy())
	
	func setParamType(param_type_):
		param_type = param_type_
	
	# param_name
	func getParamName():
		return param_name
	
	func setParamName(param_name_):
		param_name = param_name_
	
	# param
	func getParam():
		return param
	
	func setParam(param_):
		param = param_
	
	func pack():
		var script_tree = ScriptTree.new()

		script_tree.addAttr("param_name")
		script_tree.addObject("param", param)

		return script_tree

	func loadScript(script_tree):
		param_name = script_tree.getStr("param_name")
		param = script_tree.getObject("param", param_type)

var pointer
var bucket
var buffer
var init_shuffle_function
var regular_shuffle_function

var param_type

func _init():
	pointer = 0
	bucket = []
	buffer = []
	init_shuffle_function = null
	regular_shuffle_function = null

func copy():
	var ret = TypeUnit.type("PollingBucket")
	ret.pointer = pointer
	ret.bucket = []
	for node in bucket:
		ret.bucket.append(node.copy())
	ret.buffer = []
	for node in buffer:
		ret.buffer.append(node.copy())
	ret.init_shuffle_function = init_shuffle_function.copy()
	ret.regular_shuffle_function = ret.regular_shuffle_function.copy()

	ret.param_type = param_type
	
	return ret

func setParamType(param_type_):
	param_type = param_type_

func active():
	__initConstruct()

# pointer
func isAccessable():
	return pointer < bucket.size()

func getPointer():
	return pointer

func setPointer(pointer_):
	pointer = pointer_

# bucket
func getBucket():
	return bucket

func setBucket(bucket_):
	bucket = bucket_

# buffer
func getBuffer():
	return buffer

func setBuffer(buffer_):
	buffer = buffer_

# init_shuffle_function
func getInitShuffleFunction():
	return init_shuffle_function

func setInitShuffleFunction(init_shuffle_function_):
	init_shuffle_function = init_shuffle_function_

# regular_shuffle_function
func getRegularShuffleFunction():
	return regular_shuffle_function

func setRegularShuffleFunction(regular_shuffle_function_):
	 regular_shuffle_function = regular_shuffle_function_

func getParamName():
	Logger.assert(pointer < bucket.size(), "Pointer is out of bucket size!")
	return bucket[pointer].getParamName()

func getParam():
	Logger.assert(pointer < bucket.size(), "Pointer is out of bucket size!")
	return bucket[pointer].getParam()

func getParamsNameList():
	var ret = []
	for node in bucket:
		ret.append(node.getParamName())
	
	return ret

func getParamsList():
	var ret = []
	for node in bucket:
		ret.append(node.getParam())
	
	return ret

func walk():
	if pointer + 1 >= bucket.size():
		pointer = 0
		__regularConstruct()
	else:
		pointer += 1

func append(param_name, param):
	buffer.append(BucketNode.new(param_name, param))

func del(param_name):
	for index in range(bucket.size()):
		if bucket[index].getParamName() == param_name:
			var ret = bucket[index]
			bucket.remove(index)
			if index < pointer:
				pointer -= 1

			return ret
	
	return null
	
func __shuffle(function):
	function.exec([bucket])

func __initConstruct():
	bucket.append_array(buffer)
	buffer.clear()
	__shuffle(init_shuffle_function)

func __regularConstruct():
	bucket.append_array(buffer)
	buffer.clear()
	__shuffle(regular_shuffle_function)

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addAttr("pointer", pointer)
	script_tree.addTypeObjectArray("bucket", bucket)
	script_tree.addTypeObjectArray("buffer", buffer)
	script_tree.addObject("init_shuffle_function", init_shuffle_function)
	script_tree.addObject("regular_shuffle_function", regular_shuffle_function)

	return script_tree

func loadScript(script_tree):
	pointer = script_tree.getInt("pointer")
	bucket = script_tree.getTypeObjectArray("bucket", BucketNode, param_type)
	buffer = script_tree.getTypeObjectArray("buffer", BucketNode, param_type)
	init_shuffle_function = script_tree.getObject("init_shuffle_function", Function)
	regular_shuffle_function = script_tree.getObject("regular_shuffle_function", Function)
