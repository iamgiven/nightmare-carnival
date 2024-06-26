extends ProgressBar

@onready var damage_bar = $DamageBar
@onready var timer = $Timer

var current_health = 100

func _ready():
	value = current_health
	damage_bar.value = current_health

func update_health(new_health):
	var previous_health = current_health
	current_health = new_health
	value = current_health
	
	if current_health < previous_health:
		damage_bar.value = previous_health
		timer.start()

func _on_timer_timeout():
	var tween = create_tween()
	tween.tween_property(damage_bar, "value", current_health, 0.3)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_SINE)
