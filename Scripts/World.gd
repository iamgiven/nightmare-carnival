extends Node3D

@onready var hit_rect = $UI/HitRect
@onready var spawns = $Map/Spawns
@onready var navigation_region = $Map/NavigationRegion3D
@onready var player_health_bar = $UI/PlayerHealthBar
@onready var target_kill = $UI/TargetKill
var zombie = load("res://Scenes/Zombie.tscn")
var instance

signal zombie_died

var kill_count = 0
var required_kills = 10  # default to easy
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$BackgroundSound.play()
	player = get_node("Map/NavigationRegion3D/Player")
	player.connect("health_changed", Callable(self, "_on_player_health_changed"))
	player.connect("player_hit", Callable(self, "_on_player_player_hit"))
	player.connect("died", Callable(self, "_on_player_died"))
	connect("zombie_died", Callable(self, "_on_zombie_died"))

	# Set difficulty
	var level_difficulty = ProjectSettings.get_setting("custom/level_difficulty", "easy")
	match level_difficulty:
		"easy":
			required_kills = 25
		"medium":
			required_kills = 50
		"hard":
			required_kills = 100
			player.max_health = 50
			player.current_health = 50
		"nightmare":
			required_kills = 100
			player.max_health = 1
			player.current_health = 1
	player.emit_signal("health_changed", player.current_health)
	
	# Update the target label
	target_kill.text = "Target: %d" % required_kills

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_player_hit():
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false

func _get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)

func _on_zombie_spawn_timer_timeout():
	var spawn_point = _get_random_child(spawns).global_position
	instance = zombie.instantiate()
	instance.position = spawn_point
	instance.connect("zombie_died", Callable(self, "_on_zombie_died"))
	navigation_region.add_child(instance)

func _on_zombie_died():
	kill_count += 1
	$UI/KillLabel.update_kill_count(kill_count)
	if kill_count >= required_kills:
		call_deferred("_game_won")

func _on_player_health_changed(new_health):
	player_health_bar.update_health(new_health)

func _game_won():
	if not is_inside_tree():
		return
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Congratulations.tscn")

func _on_player_died():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
