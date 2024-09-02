extends PopupPanel

var count_labels: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	count_labels = find_children("*CountLabel", "Label")
	get_node("VBoxContainer/MarginContainer2/Button").pressed.connect(func(): hide())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_label(index: int, amount: int) -> void:
	count_labels[index].text = str(amount)
