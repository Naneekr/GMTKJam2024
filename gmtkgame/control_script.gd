extends Control

const LAST_HOUR: int = 8
const num_of_clients: int = 2

var day_count: int = 1
var hour_count: int = 1
var hour_label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hour_label = $VBoxContainer/HBoxContainer/HourCountLabel
	var action_menu = $VBoxContainer/TabContainer/ActionMenu
	action_menu.connect_buttons(_take_client, _smith_item, _go_to_map)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _take_client() -> void:
	if not _increment_hour(1):
		return #TODO: Add no time left message
	
	var rng = RandomNumberGenerator.new()
	
	var client_choice: int = rng.randi_range(1, num_of_clients)
	
	Dialogic.start(["Client1", "Client2"][client_choice-1])
	
func _smith_item() -> void:
	print("Smithing arms!")
	
func _go_to_map() -> void:
	print("Away we go!")
	
func _increment_hour(delta: int) -> bool:
	delta = hour_count + delta
	
	if delta <= LAST_HOUR:
		hour_count = delta
		hour_label.text = str(hour_count)
		return true
	
	else:
		return false
