extends Node

var ScriptTree = TypeUnit.type("ScriptTree")

var bgm_player			# 播放BGM
var sound_player		# 播放音效
var bgm_volume			# float
var sound_volume		# float

const volume_db_range = [-10.0, 10.0]

func _init():
	bgm_player = AudioStreamPlayer.new()
	sound_player = AudioStreamPlayer.new()
	setBgmVolume(50)
	setSoundVolume(50)

func getBgmPlayer():
	return bgm_player

func getSoundPlayer():
	return sound_player

func playBgm(bgm_path):
	bgm_player.stop()
	var audio_stream = load(bgm_path)
	audio_stream.loop = true
	bgm_player.stream = audio_stream
	bgm_player.play()

func playSound(sound_path):
	var audio_stream = load(sound_path)
	audio_stream.loop = false
	sound_player.stream = audio_stream
	sound_player.play()

func setBgmVolume(volume):
	bgm_volume = max(0, min(100, volume))
	var lower = volume_db_range[0]
	var upper = volume_db_range[1]
	var volume_db = lower + (upper - lower) * (volume / 100.0)	
	
	bgm_player.volume_db = volume_db

func getBgmVolume():
	return bgm_volume

func setSoundVolume(volume):
	sound_volume = max(0, min(100, volume))
	var lower = volume_db_range[0]
	var upper = volume_db_range[1]
	var volume_db = lower + (upper - lower) * (volume / 100.0)	
	
	sound_player.volume_db = volume_db

func getSoundVolume():
	return sound_volume

func pack():
	var script_tree = ScriptTree.new()

	script_tree.addAttr("bgm_volume", bgm_volume)
	script_tree.addAttr("sound_volume", sound_volume)

	return script_tree

func loadScript(script_tree):
	bgm_volume = script_tree.getFloat("bgm_volume")
	sound_volume = script_tree.getFloat("sound_volume")
