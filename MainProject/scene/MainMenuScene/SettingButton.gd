extends TextureButton

var s_name
var c_name

func _init():
	c_name = "SettingButton"

func setSceneName(s_name_):
	s_name = s_name_
	$SettingButtonText.setSceneName(s_name)

func loadResource():
	setButtonIcon()
	$SettingButtonText.loadResource()

func setButtonIcon():
	texture_normal = ResourceUnit.loadTexture(s_name, c_name, "texture_normal")
	texture_hover = ResourceUnit.loadTexture(s_name, c_name, "texture_hover")

