class_name DealResource extends Resource


var product: ProductResource:
	set = set_product
var vendor: MediatorResource:
	set = set_vendor
var customer: MediatorResource:
	set = set_customer
var price: int:
	set = set_price


func set_product(product_: ProductResource) -> DealResource:
	product = product_
	return self
	
func set_vendor(vendor_: MediatorResource) -> DealResource:
	vendor = vendor_
	vendor.is_deal = true
	return self
	
func set_customer(customer_: MediatorResource) -> DealResource:
	customer = customer_
	customer.is_deal = true
	return self
	
func set_price(price_: int) -> DealResource:
	price = price_
	
	vendor.vault.change_product(product.title, -1)
	customer.vault.change_product(product.title, 1)
	
	customer.vault.gold -= price
	vendor.vault.gold += price
	
	vendor.room.add_deal(self)
	#print(["deal", "vendor " + str(vendor.index), "customer " + str(customer.index)])
	return self
