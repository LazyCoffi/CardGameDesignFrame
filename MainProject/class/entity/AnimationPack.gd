extends Node
class_name AnimationPack

var ScriptTree = TypeUnit.type("ScriptTree")

var texture_path_list		# Array
var gap						# float

func _init():
	texture_path_list = []
	gap = 0

func copy():
	var ret = TypeUnit.type("AnimationPack").new()
	ret.texture_path_list = texture_path_list.duplicate(true)
	ret.gap = gap

	return ret

func addTexturePath(texture_path):
	texture_path_list.append(texture_path)

func delTexturePath(index):
	texture_path_list.remove(index)

func getTexturePathList():
	return texture_path_list

func getGap():
	return gap

func setGap(gap_):
	gap = gap_

func pack():
	var script_tree = ScriptTree.new()
	
	script_tree.addAttr("texture_path_list", texture_path_list)
	script_tree.addAttr("gap", gap)

	return script_tree

func loadScript(script_tree):
	texture_path_list = script_tree.getStrArray("texture_path_list")
	gap = script_tree.getFloat("gap")
