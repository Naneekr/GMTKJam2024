class_name SubMenu

extends Control

var menu_buttons: Array


func _ready() -> void:
	menu_buttons = get_menu_buttons()

func get_menu_buttons() -> Array:
	var found_menu_buttons: Array
	for candidate in find_children("*Button*"):
		if candidate.is_in_group("SubMenuButton"):
			found_menu_buttons.append(candidate)
			
	return found_menu_buttons
	
func connect_menu_buttons(callbacks: Array) -> void:
	var connections: int = len(callbacks)
	
	assert(connections == len(menu_buttons), "Given %s callbacks but has %s menu buttons!" % [connections, str(len(menu_buttons))])
	
	for i in connections:
		menu_buttons[i].pressed.connect(callbacks[i])
