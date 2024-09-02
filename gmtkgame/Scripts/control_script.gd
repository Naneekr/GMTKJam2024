extends Control

const LAST_HOUR: int = 8
const num_of_clients: int = 2

var tab_container: TabContainer

var gold: int = 0

var day_count: int = 1
var hour_count: int = 1
var hour_label: Label

#Smithing Material
var ingots: Dictionary =\
{
"bronze": 0,
"steel": 0,
"orichalcum": 0
}

var logs: Dictionary =\
{
"oak": 0,
"mahogany": 0,
"yggdrasil": 0
}

var gems: Dictionary =\
{
"fire": 0,
"wind": 0,
"storm": 0,
"water": 0,
"earth": 0,
"prism": 0
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hour_label = $VBoxContainer/HBoxContainer/HourCountLabel #type_string(typeof())
	tab_container = $VBoxContainer/TabContainer
	var action_menu = $VBoxContainer/TabContainer/ActionMenu
	action_menu.connect_menu_buttons([_take_client, _smith_item, _go_to_map])
	tab_container.get_node("MapMenu").connect_menu_buttons([func(): print("1"), func(): print("2"), func(): print("3")])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _take_client() -> void:
	if not _increment_hour(1):
		return #TODO: Add no time left message
	
	var rng = RandomNumberGenerator.new()
	
	var client_choice: int = rng.randi_range(1, num_of_clients)
	
	Dialogic.start(["Client1", "Client2"][client_choice-1])
	
func _smith_item() -> void:
	tab_container.current_tab = 1
	
func _go_to_map() -> void:
	tab_container.current_tab = 2
	
func _increment_hour(delta: int) -> bool:
	delta = hour_count + delta
	
	if delta <= LAST_HOUR:
		hour_count = delta
		hour_label.text = str(hour_count)
		return true
	
	else:
		return false
