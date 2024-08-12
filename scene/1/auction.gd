class_name Auction extends PanelContainer


@export var world: World
@export var rooms: VBoxContainer

@onready var room_scene = preload("res://scene/1/room.tscn")

var resource: AuctionResource


func _ready() -> void:
	resource = AuctionResource.new()
	init_mediators()
	init_rooms()
	
	resource.init_trades()
	update_prices()
	
func init_mediators() -> void:
	var n = 9
	
	for product in Global.arr.product:
		add_mediators_with_random_price_based_on_product_and_role(product, "vendor", n)
		add_mediators_with_random_price_based_on_product_and_role(product, "customer", n)
	
func add_mediators_with_random_price_based_on_product_and_role(product_: String, role_: String, count_: int) -> void:
	var product = resource.products[product_]
	
	for _i in count_:
		var mediator_resource = MediatorResource.new()
		mediator_resource.set_product(product).set_role(role_).set_auction(resource)
		mediator_resource.vault.gold = 1000
		
		if role_ == "vendor":
			mediator_resource.vault.change_product("rock", 2)
	
func init_rooms() -> void:
	for product in resource.rooms:
		var room = room_scene.instantiate()
		var room_resource = resource.rooms[product]
		rooms.add_child(room)
		room.resource = room_resource
	
func update_prices() -> void:
	for room in rooms.get_children():
		room.update_prices()
	
func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_SPACE:
				if event.is_pressed() && !event.is_echo():
					resource.init_trades()
					update_prices()
