extends PopupPanel

var container: VBoxContainer
var merch_unit : Resource = preload("res://Scenes/MerchandiseUnit.tscn")

enum RecipeItem
{
	NAME,
	MATERIALS,
	AMOUNTS,
	REQUIREMENTS
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	container = $ScrollContainer/VBoxContainer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_merchandise_unit(merch_data: Dictionary) -> MerchandiseUnit:
	var new_unit: MerchandiseUnit = merch_unit.instantiate()
	new_unit.create(
		merch_data[RecipeItem.NAME], 
		str(merch_data[RecipeItem.REQUIREMENTS][0]), 
		str(merch_data[RecipeItem.REQUIREMENTS][1]), 
		str(merch_data[RecipeItem.REQUIREMENTS][2])
	)
	container.add_child(new_unit)
	return new_unit
