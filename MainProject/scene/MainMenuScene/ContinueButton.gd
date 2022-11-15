extends TextureButton

func _ready():
	setButtonIcon()

func setButtonIcon():
	var btn_paths = GlobalSetting.getRes("main_menu/btn_icons")
	texture_normal = ResourceTool.loadTexture(btn_paths[0])
	texture_hover = ResourceTool.loadTexture(btn_paths[1])
