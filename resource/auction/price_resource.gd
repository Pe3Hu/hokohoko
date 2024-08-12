class_name PriceResource extends Resource


var orientation: String = "vertical"
var sections: Array[SectionResource]

#var price: PriceResource:
	#set = set_price
#var title: String:
	#set = set_title
#var avg_price: int:
	#set = set_avg_price
#var deals: Array[DealResource]
#
#
#func set_title(title_: String) -> ProductResource:
	#title = title_
	#return self
	#
#func set_avg_price(avg_price_: int) -> ProductResource:
	#avg_price = avg_price_
	#return self
	#
#func set_price(price_: priceResource) -> ProductResource:
	#price = price_
	#price.add_room(self)
	#return self


