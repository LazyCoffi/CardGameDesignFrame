extends Node2D

signal changeSceneSignal

var is_registered

func isRegistered():
	return is_registered

func register():
	is_registered = true

func _init():
	is_registered = false

func _ready():
	setConnection()
	setBackground()
	setTitle()

func setTitle():
	var title_path = GlobalSetting.getRes("main_menu/title")
	var title = ResourceTool.loadTexture(title_path)
	
	$MainMenuTitle.texture = title

func setBackground():
	var backgrounds_path = GlobalSetting.getRes("main_menu/backgrounds")
	var bg_num = backgrounds_path.size()
	var bg = ResourceTool.loadTexture(backgrounds_path[UnitTools.rrange(bg_num)])
	
	$MainMenuBackground.texture = bg

func setConnection():
	$StartButton.connect("pressed", self, "switchToCharacterGen")

func switchToCharacterGen():
	SceneContainer.createCharacterGen()
	emit_signal("changeSceneSignal", SceneContainer.getCharacterGen())
