class_name VaultResource extends Resource


var mediator: MediatorResource
var gold: int = 0
var products: Dictionary


func _init() -> void:
	for product in Global.arr.product:
		products[product] = 0
	
func change_product(title_: String, value_: int) -> void:
	products[title_] += value_
