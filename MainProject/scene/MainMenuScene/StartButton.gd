extends TextureButton

func loadResource(s_name, c_name):
	setButtonIcon(s_name, c_name)
	$StartButtonText.loadResource(s_name, "StartButtonText")

func setButtonIcon(s_name, c_name):
	texture_normal = ResourceUnit.loadTexture(s_name, c_name, "texture_normal")
	texture_hover = ResourceUnit.loadTexture(s_name, c_name, "texture_hover")
