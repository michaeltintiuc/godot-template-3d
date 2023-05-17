class_name UiButton extends Button


@export var type := Types.UiButton.START


func _pressed() -> void:
	if type == Types.UiButton.START: Events.start_game.emit()
	elif type == Types.UiButton.OPTIONS: Events.show_options.emit()
	elif type == Types.UiButton.BACK: Events.ui_go_back.emit()
	elif type == Types.UiButton.QUIT: Events.quit_game.emit()
	elif type == Types.UiButton.PAUSE: Events.toggle_pause_game.emit()


func _input(event: InputEvent) -> void:
	if type != Types.UiButton.BACK or not is_visible_in_tree(): return
	if event.is_action_pressed("ui_cancel"):
		Events.ui_go_back.emit()
		get_viewport().set_input_as_handled()
