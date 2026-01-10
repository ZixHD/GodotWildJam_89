extends Node

var music_players := {}
var sfx_players := {}
var music_db := 0.0
var sfx_db := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_audio_players()

func setup_audio_players():
	for bus in ["Music", "Ambience"]:
		var player = AudioStreamPlayer.new()
		player.bus = bus
		music_players[bus] = player
		add_child(player)

	for i in range(8):
		var player = AudioStreamPlayer.new()
		player.bus = "SFX"
		sfx_players[i] = player
		add_child(player)

func play_sfx(stream: AudioStream, volume: float = 0.0) -> void:
	for player in sfx_players.values():
		if not player.playing:
			player.stream = stream
			player.volume_db = volume + sfx_db
			player.play()
			return

func play_music(stream: AudioStream, bus: String = "Music") -> void:
	if music_players.has(bus):
		music_players[bus].stream = stream
		music_players[bus].volume_db = music_db
		music_players[bus].play()

func set_music_volume(db: float) -> void:
	music_db = db
	for player in music_players.values():
		player.volume_db = db

func fade_music(target_db: float, duration: float = 1.0):
	var tween = create_tween()
	tween.tween_property(music_players["Music"], "volume_db", target_db, duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
