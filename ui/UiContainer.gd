class_name UiContainer extends Control


func _ready() -> void:
	owner.ready.connect(_focus_child)
	visibility_changed.connect(_focus_child)


func _focus_child() -> void:
	if not visible: return
	for c in find_children("", "Control"):
		if c is BaseButton or c is Range:
			c.grab_focus()
			break
