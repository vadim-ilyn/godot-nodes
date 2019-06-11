extends Node

# show_waiting_animation
# Used only for iOS to add waiting animation
# var result = in_app_store.purchase({"product_id": product_id})
# call on result == "ok" is true

# кнопка в настройках для restore purchases, нет автомотического восстановления покупок, только после нажатия на кнопку

# test play store purchase/requestPurchased:
# iap.restore_purchases()
# iap.purchase("android.test.purchased")

var iapAndroid = load("res://Scripts/iap/iapAndroid.gd")
var iapIOS = load("res://Scripts/iap/iapIOS.gd")
var iapTest = load("res://Scripts/iap/iapTest.gd")

var payment

func _ready():
	if Engine.has_singleton("GodotPayments") :
		payment = iapAndroid.new()
	elif Engine.has_singleton("InAppStore") :
		payment = iapIOS.new()
		# Get pending events 1 time per second
		var events_handle_timer = Timer.new()
		add_child(events_handle_timer)
		events_handle_timer.start(1)
		events_handle_timer.connect("timeout", payment, "on_events_timer_update")
	elif has_node("/root/TestPayment") :
		payment = iapTest.new(get_node("/root/TestPayment"))

func is_payment():
	return payment != null

func bind(show_waiting_animation_impl, on_purchase_success, on_purchase_failed, on_restore_purchase_success, on_restore_purchase_failed, on_product_detail):
	payment.bind(show_waiting_animation_impl, on_purchase_success, on_purchase_failed, on_restore_purchase_success, on_restore_purchase_failed, on_product_detail)

func purchase(product_id):
	if payment :
		payment.purchase(product_id)

func restore_purchases():
	if payment :
		payment.restore_purchases()

# product_ids : ["pid1", "pid2"]
func request_product_detail(product_ids):
	if payment :
		payment.request_product_detail(product_ids)