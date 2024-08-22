extends Control

const LAST_HOUR: int = 8
const num_of_clients: int = 2

var day_count: int = 1
var hour_count: int = 1
var hour_label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tab_1 = $VBoxContainer/TabContainer/BoxContainer
	tab_1.get_node("MarginContainer/AspectRatioContainer/ClientButton").pressed.connect(self._take_client)
	tab_1.get_node("MarginContainer2/AspectRatioContainer2/SmithButton").pressed.connect(self._smith_item)
	tab_1.get_node("MarginContainer3/AspectRatioContainer3/MapButton").pressed.connect(self._go_to_map)
	
	hour_label = $VBoxContainer/HBoxContainer/HourCountLabel


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
