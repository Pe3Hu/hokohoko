class_name ProductResource extends Resource


var auction: AuctionResource:
	set = set_auction
var title: String:
	set = set_title
var avg_price: int:
	set = set_avg_price
var deals: Array[DealResource]


func set_title(title_: String) -> ProductResource:
	title = title_
	return self
	
func set_avg_price(avg_price_: int) -> ProductResource:
	avg_price = avg_price_
	return self
	
func set_auction(auction_: AuctionResource) -> ProductResource:
	auction = auction_
	auction.add_room(self)
	return self
