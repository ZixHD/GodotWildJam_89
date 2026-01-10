extends State
class_name Idle

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func Enter():
	_update_animation()
	
func _update_animation():
	if player.last_facing_direction == "left":
		animation_player.play("idleL")
	elif player.last_facing_direction == "right":
		animation_player.play("idleR")
	pass

func Physics_Update(_delta: float):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	_change_state(direction_x, direction_y)	
	
func _change_state(direction_x, direction_y):
	
	if player.hit:
		Transitioned.emit(self, "death")
		return
		
	if GameManager.player_cutscene:
		Transitioned.emit(self, "cutscene")
		return
		
	if direction_x != 0 or direction_y != 0:
		Transitioned.emit(self, "walk")
		return
	if Input.is_action_just_pressed("dash") and not player.is_dashing and player.dash_timer <= 0: 
		Transitioned.emit(self, "dash")
		return
	#if player.cutscene or Engine.time_scale == 0:
		#Transitioned.emit(self, "cutscene")
		#return
	if player.is_attacking:
		Transitioned.emit(self, "attack")
		return
	
	
