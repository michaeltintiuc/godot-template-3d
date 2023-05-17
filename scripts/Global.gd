extends Node


func _init() -> void:
	randomize()
	process_mode = PROCESS_MODE_ALWAYS


func _ready() -> void:
	Events.quit_game.connect(quit_game)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"): Events.toggle_pause_game.emit(); return


func quit_game() -> void:
	get_tree().quit()
