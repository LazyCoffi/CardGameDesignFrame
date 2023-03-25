extends Node
class_name AudioPack

var ScriptTree = TypeUnit.type("ScriptTree")

var audio_path

func _init():
	audio_path = null

func copy():
	var ret = TypeUnit.type("AudioPack").new()

	ret.audio_path = audio_path

	return ret

func setAudioPath(audio_path_):
	audio_path = audio_path_

func getAudioPath():
	return audio_path

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("audio_path", audio_path)

	return script_tree

func loadScript(script_tree):
	audio_path = script_tree.getStr("audio_path")
