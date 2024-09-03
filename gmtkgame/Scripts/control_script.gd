extends Control

const LAST_HOUR: int = 8
const num_of_clients: int = 2

enum
{
	BRONZE,
	STEEL,
	ORICHALCUM,
	OAK,
	MAHOGANY,
	YGGDRASIL,
	GEM_FIRE,
	GEM_WIND,
	GEM_STORM,
	GEM_WATER,
	GEM_EARTH,
	GEM_PRISM
}

enum RecipeItem
{
	NAME,
	MATERIALS,
	AMOUNTS,
	REQUIREMENTS
}

enum MerchInfo
{
	NAME,
	STATS,
	RECIPE,
	NODE_REF
}

enum CxInfo
{
	NAME,
	PICTURE,
	STATS
}

var materials_popup: PopupPanel
var merchandise_popup: PopupPanel
var job_list_popup: PopupPanel
var tab_container: TabContainer

var gold_count: int = 0

var day_count: int = 1
var hour_count: int = 1
var hour_label: Label
var gold_label: Label

var active_jobs: Array = []
var held_merch: Array = []

#Smithing Material
var materials: Dictionary =\
{
BRONZE: 0,
STEEL: 0,
ORICHALCUM: 0,
OAK: 0,
MAHOGANY: 0,
YGGDRASIL: 0,
GEM_FIRE: 0,
GEM_WIND: 0,
GEM_STORM: 0,
GEM_WATER: 0,
GEM_EARTH: 0,
GEM_PRISM: 0
}

var recipes: Array =\
[
	{RecipeItem.NAME: "Bronze Sword", RecipeItem.MATERIALS: [BRONZE], RecipeItem.AMOUNTS: [2], RecipeItem.REQUIREMENTS: [1, 0, 0]},
	{RecipeItem.NAME: "Steel Sword", RecipeItem.MATERIALS: [STEEL], RecipeItem.AMOUNTS: [2], RecipeItem.REQUIREMENTS: [2, 1, 0]},
	{RecipeItem.NAME: "Orichalcum Sword", RecipeItem.MATERIALS: [ORICHALCUM], RecipeItem.AMOUNTS: [2], RecipeItem.REQUIREMENTS: [4, 1, 1]},
	{RecipeItem.NAME: "Bronze Dagger", RecipeItem.MATERIALS: [BRONZE], RecipeItem.AMOUNTS: [1], RecipeItem.REQUIREMENTS: [0, 1, 0]},
	{RecipeItem.NAME: "Steel Dagger", RecipeItem.MATERIALS: [STEEL], RecipeItem.AMOUNTS: [1], RecipeItem.REQUIREMENTS: [0, 3, 0]},
	{RecipeItem.NAME: "Orichalcum Dagger", RecipeItem.MATERIALS: [ORICHALCUM], RecipeItem.AMOUNTS: [1], RecipeItem.REQUIREMENTS: [1, 4, 1]},
	{RecipeItem.NAME: "Oak Staff", RecipeItem.MATERIALS: [OAK], RecipeItem.AMOUNTS: [2], RecipeItem.REQUIREMENTS: [0, 0, 2]},
	{RecipeItem.NAME: "Mahogany Staff", RecipeItem.MATERIALS: [MAHOGANY], RecipeItem.AMOUNTS: [2], RecipeItem.REQUIREMENTS: [0, 0, 4]},
	{RecipeItem.NAME: "Yggdrasil Staff", RecipeItem.MATERIALS: [YGGDRASIL], RecipeItem.AMOUNTS: [2], RecipeItem.REQUIREMENTS: [1, 0, 6]}
]

var customers: Array =\
[
	{CxInfo.NAME: "Man of No Renown", CxInfo.PICTURE: preload("res://Sprites/GMTK NoChinFinn.png"), CxInfo.STATS: [2, 1, 0]},
	{CxInfo.NAME: "Foxman the Deranged", CxInfo.PICTURE: preload("res://Sprites/freaky Fox.png"), CxInfo.STATS: [1, 1, 3]}
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hour_label = find_child("HourCountLabel") #type_string(typeof())
	gold_label = find_child("GoldCountLabel")
	tab_container = $VBoxContainer/TabContainer
	materials_popup = $MaterialsPopup
	merchandise_popup = $MerchandisePopup
	job_list_popup = $JobListPopup
	tab_container.get_node("ActionMenu").connect_menu_buttons([_take_client, _go_to_smithy, _go_to_map])
	var smith_functions: Array = []
	for i in range(9):
		smith_functions.append(func(): _smith_item(i))
	tab_container.get_node("SmithMenu").connect_menu_buttons(smith_functions)
	tab_container.get_node("MapMenu").connect_menu_buttons([func(): tab_container.current_tab = 3, func(): tab_container.current_tab = 4, func(): print("3")])
	tab_container.get_node("OreTraderMenu").connect_menu_buttons([func(): _transact(20, BRONZE), func(): _transact(50, STEEL), func(): _transact(200, ORICHALCUM)])
	tab_container.get_node("SawmillMenu").connect_menu_buttons([func(): _transact(20, OAK), func(): _transact(50, MAHOGANY), func(): _transact(200, YGGDRASIL)])
	find_child("ShopButton").pressed.connect(func(): tab_container.current_tab = 0)
	find_child("MaterialsButton").pressed.connect(func(): materials_popup.show())
	find_child("MerchandiseButton").pressed.connect(func(): merchandise_popup.show())
	find_child("JobsButton").pressed.connect(func(): job_list_popup.show())
	_increment_gold(200)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _take_client() -> void:
	if not _increment_hour(1):
		return #TODO: Add no time left message
	
	var rng = RandomNumberGenerator.new()
	
	var client_choice: int = rng.randi_range(0, num_of_clients-1)
	
	Dialogic.start(["Client1", "Client2"][client_choice])
	
	job_list_popup.add_job_unit(customers[client_choice])
	
func _go_to_smithy() -> void:
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
		
func _increment_material(mat_type: int, amount: int = 1) -> void:
	materials[mat_type] += amount
	materials_popup.update_label(mat_type, materials[mat_type])
	
func _decrement_material(mat_type: int, amount: int = 1) -> bool:
	if materials[mat_type] < amount:
		return false
	
	materials[mat_type] -= amount
	materials_popup.update_label(mat_type, materials[mat_type])
	return true

func _increment_gold(amount: int = 1) -> void:
	gold_count += amount
	
	gold_label.text = str(gold_count)
	
func _spend_gold(amount: int = 1) -> bool:
	if gold_count < amount:
		return false
	
	gold_count -= amount
	gold_label.text = str(gold_count)
	return true

func _transact(gold_amount: int, mat_type: int, mat_amount: int = 1) -> void:
	if _spend_gold(gold_amount):
		_increment_material(mat_type, mat_amount)
	else:
		pass #TODO: Add error notification

func _smith_item(recipe_choice: int) -> void:
	var chosen_recipe = recipes[recipe_choice]
	
	if _decrement_material(chosen_recipe[RecipeItem.MATERIALS][0], chosen_recipe[RecipeItem.AMOUNTS][0]):
		held_merch.append({
			MerchInfo.RECIPE: recipe_choice,
			MerchInfo.NODE_REF: merchandise_popup.add_merchandise_unit(chosen_recipe)
		})
	
	else:
		pass #TODO: Add error notification
