extends Button
	
func _on_pressed() -> void:
	if Dialogic.current_timeline != null:
		return
		
	else:
		get_tree().change_scene_to_file("res://Scenes/Test area.tscn")
