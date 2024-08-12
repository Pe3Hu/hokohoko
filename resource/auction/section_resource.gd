class_name SectionResource extends Resource


var price: PriceResource:
	set = set_price
var type: String:
	set = set_type
var values: Array:
	set = set_values

var extent: float
var center: Vector2


func set_type(type_: String) -> SectionResource:
	type = type_
	return self
	
func set_values(values_: Array) -> SectionResource:
	values = values_
	extent = values.back() - values.front() + 1
	return self
	
func set_price(price_: PriceResource) -> SectionResource:
	price = price_
	return self
