extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var video_stream_player: VideoStreamPlayer = $AspectRatioContainer/VideoStreamPlayer
func _ready() -> void:
	animation_player.play("intro")
	pass

func play_video() -> void:
	#Intro is in a non-standard aspect ratio, should be fixed in some future release
	video_stream_player.play()
	await animation_player.animation_finished
	SceneManager._next_scene()
