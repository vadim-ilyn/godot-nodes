extends Node

var test_payment

var show_waiting_animation
var on_purchase_success
var on_purchase_failed
var on_restore_purchase_success
var on_restore_purchase_failed
var on_product_info

func _init(payment_singleton):
	test_payment = payment_singleton
	if test_payment :
		print("init test payment")
		test_payment.set_instance(self)

func bind(show_waiting_animation_impl, on_purchase_success_, on_purchase_failed_, on_restore_purchase_success_, on_restore_purchase_failed_, on_product_info_):
	show_waiting_animation = show_waiting_animation_impl
	on_purchase_success = on_purchase_success_
	on_purchase_failed = on_purchase_failed_
	on_restore_purchase_success = on_restore_purchase_success_
	on_restore_purchase_failed = on_restore_purchase_failed_
	on_product_info = on_product_info_

func purchase(product_id):
	var result = test_payment.purchase({"product_id": product_id})
	print("# purchase " + str(product_id) + " -> " + str(result))
	if result == 0 :
		if show_waiting_animation :
			show_waiting_animation.call_func()

func restore_purchases():
	var result = test_payment.restore_purchases()
	print("# restore purchases " + str(result))

# product_ids it is array ["my_product1_id", "my_product2_id, ..."]
func request_product_detail(product_ids):
	var result = test_payment.request_product_detail(product_ids)
	print("# request_product_info: " + str(result))

# callbacks
func purchase_success(product_id):
	print("purchase_success : ", product_id)
	if on_purchase_success :
		on_purchase_success.call_func(product_id)

func purchase_fail(product_id):
	print("purchase_fail")
	if on_purchase_failed :
		on_purchase_failed.call_func()

# restore purchases
func has_purchased(product_id):
	if product_id == "":
		print("has_purchased : nothing")
	else:
		print("has_purchased : ", product_id)
		if on_restore_purchase_success :
			on_restore_purchase_success.call_func(product_id)

func product_details_complete(result):
	print("product_details_complete : ", result)