extends Node

var on_purchase_success
var on_purchase_failed
var on_restore_purchase_success
var on_restore_purchase_failed
var on_product_detail

var payment

func _init():
	payment = Engine.get_singleton("GodotPayments")	
	if payment :
		print("init iap_android")
		payment.setAutoConsume(false)
		# set callback with this script instance
		payment.setPurchaseCallbackId(get_instance_id())

func bind(unused, on_purchase_success_, on_purchase_failed_, on_restore_purchase_success_, on_restore_purchase_failed_, on_product_detail_):
	on_purchase_success = on_purchase_success_
	on_purchase_failed = on_purchase_failed_
	on_restore_purchase_success = on_restore_purchase_success_
	on_restore_purchase_failed = on_restore_purchase_failed_
	on_product_detail = on_product_detail_

# When starting our game, we can check if the user has purchased any product. 
# YOU SHOULD DO THIS ONLY AFTER 2/3 SECONDS AFTER YOUR GAME IS LOADED. 
# If we do this as the first thing when the game is launched, 
# IAP might not be initialized and our game will crash on start. 
# request user owned item, callback : has_purchased
func restore_purchases():
	if payment:
		payment.requestPurchased()

# purchase item
# callback : purchase_success, purchase_fail, purchase_cancel, purchase_owned
func purchase(product_id):
	if payment:
		# transaction_id could be any string that used for validation internally in java
		payment.purchase(product_id, "transaction_id")

func purchase_success(receipt, signature, product_id):
	print("purchase_success : ", product_id)
	if on_purchase_success :
		on_purchase_success.call_func(product_id)

func purchase_fail():
	print("purchase_fail")
	if on_purchase_failed :
		on_purchase_failed.call_func()

func purchase_cancel():
	pass

func purchase_owned(product_id):
	pass

# restore purchases
func has_purchased(receipt, signature, product_id):
	if product_id == "":
		print("has_purchased : nothing")
	else:
		print("has_purchased : ", product_id)
		if on_restore_purchase_success :
			on_restore_purchase_success.call_func(product_id)
	
# detail info of IAP items
# var sku_details = {
#     product_id (String) : {
#         type (String),
#         product_id (String),
#         title (String),
#         description (String),
#         price (String),  # this can be used to display price for each country with their own currency
#         price_currency_code (String),
#         price_amount (float)
#     },
#     ...
# }

var sku_details = {}

# query for details of IAP items
# callback : sku_details_complete
func request_product_detail(product_ids):
	if payment:
		var sku_list = PoolStringArray(product_ids)
		payment.querySkuDetails(sku_list)

func sku_details_complete(result):
	print("sku_details_complete : ", result)
	for key in result.keys():
		sku_details[key] = result[key]

func sku_details_error(error_message):
	print("error_sku_details = ", error_message)