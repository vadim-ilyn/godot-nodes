extends Node

const TEST_PRODUCT = "test_product"
var payment_events_handler

var products_details = {
	"test_product" : {
			"product_id" : TEST_PRODUCT,
			"price" : 1,
			"description" : "description",
			"name" : "some product"
		}
}

var completed_purchases = {}

func _ready():
	pass

func set_instance(payment_events_handler_):
	payment_events_handler = payment_events_handler_

# data : {"product_id": product_id}
func purchase(data):
	if data.product_id == TEST_PRODUCT :
		completed_purchases[TEST_PRODUCT] = data
		_add_action(TEST_PRODUCT, "purchase_success")
	else :
		_add_action(TEST_PRODUCT, "purchase_fail")
	return 0

func restore_purchases():
	if completed_purchases.size() > 0 :
		for key in completed_purchases.keys() :
			_add_action(completed_purchases[key].product_id, "has_purchased")
	else :
		_add_action("", "has_purchased")
	return 0

# product_ids it is array ["my_product1_id", "my_product2_id, ..."]
func request_product_detail(product_ids):
	_add_action(products_details, "product_details_complete")	
	return 0

func _add_action(args, callback):
	var t = Timer.new()
	t.set_one_shot(true)
	t.start(1.0)
	add_child(t)
	assert(payment_events_handler)
	t.connect("timeout", payment_events_handler, callback, [args])