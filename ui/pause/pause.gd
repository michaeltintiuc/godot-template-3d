extends UiContainer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and get_tree().paused:
		Events.toggle_pause_game.emit()
		get_viewport().set_input_as_handled()
