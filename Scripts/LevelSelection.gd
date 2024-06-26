extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$start_menu_bgm.play()
	$EasyButton.connect("pressed", Callable(self, "_on_EasyButton_pressed"))
	$MediumButton.connect("pressed", Callable(self, "_on_MediumButton_pressed"))
	$HardButton.connect("pressed", Callable(self, "_on_HardButton_pressed"))
	$NightmareButton.connect("pressed", Callable(self, "_on_NightmareButton_pressed"))
	$MainMenuButton.connect("pressed", Callable(self, "_on_MainMenuButton_pressed"))

func _on_EasyButton_pressed():
	set_level_difficulty("easy")
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_MediumButton_pressed():
	set_level_difficulty("medium")
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_HardButton_pressed():
	set_level_difficulty("hard")
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_NightmareButton_pressed():
	set_level_difficulty("nightmare")
	get_tree().change_scene_to_file("res://Scenes/World.tscn")

func _on_MainMenuButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func set_level_difficulty(difficulty: String):
	ProjectSettings.set_setting("custom/level_difficulty", difficulty)
	ProjectSettings.save()
