extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func connect_buttons(callbacks) -> void:
	var sword_container := $HBoxContainer/SwordContainer
	var dagger_container := $HBoxContainer/DaggerContainer
	var staff_container := $HBoxContainer/StaffContainer
	var containers := [sword_container, dagger_container, staff_container]
	
	for i in len(containers):
		for j in len(containers[i]):
			containers[i].get_node("MarginContainer%s/Button" % j).pressed.connect(callbacks[i][j])
