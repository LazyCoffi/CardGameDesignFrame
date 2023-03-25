extends Node

var bgm_player			# 播放BGM
var sound_player		# 播放音效

func _init():
	bgm_player = AudioStreamPlayer.new()
	sound_player = AudioStreamPlayer.new()

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
