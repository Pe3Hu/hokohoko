class_name AuctionResource extends Resource


var rooms: Dictionary
var products: Dictionary


func _init():
	init_products()
	
func init_products() -> void:
	for product in Global.arr.product:
		var product_resource = ProductResource.new()
		product_resource.set_title(product).set_avg_price(50).set_auction(self)
		products[product] = product_resource
	
func add_room(product_: ProductResource) -> void:
	var room_resource = RoomResource.new()
	room_resource.product = product_
	rooms[product_.title] = room_resource
	
func init_trades() -> void:
	for product in Global.arr.product:
		var room = rooms[product]
		room.start_trade_round()
	
