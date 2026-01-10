extends State
class_name Running

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func Enter():
	_update_animation()
	
func _update_animation():
	if player.last_facing_direction == "right":
		animation_player.play("walkR")
	else:
		animation_player.play("walkL")
	pass
	
func Physics_Update(_delta: float):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	_change_state(direction_x)
	
	player.velocity.x = direction_x * player.running_speed
	player.velocity.y = direction_y * player.running_speed
	player.move_and_slide()
	

func _change_state(direction_x):
	
	if direction_x < 0:
		player.last_facing_direction = "left"
	elif direction_x > 0:
		player.last_facing_direction = "right"
	_update_animation()
	
	if direction_x == 0:
		Transitioned.emit(self, "idle")
		return
	
	if player.cutscene or Engine.time_scale == 0:
		Transitioned.emit(self, "cutscene")
		return
	
