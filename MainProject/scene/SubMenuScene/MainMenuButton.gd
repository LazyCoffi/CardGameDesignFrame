extends TextureButton

var s_name
var c_name

func _init():
	c_name = "MainMenuButton"

func setSceneName(s_name_):
	s_name = s_name_
	$MainMenuButtonText.setSceneName(s_name)

func loadResource():
	setButtonIcon()
	$MainMenuButtonText.loadResource()

func setButtonIcon():
	texture_normal = ResourceUnit.loadRes(s_name, c_name, "texture_normal")
	texture_hover = ResourceUnit.loadRes(s_name, c_name, "texture_hover")