extends Node

var in_app_store

var show_waiting_animation
var on_purchase_success
var on_purchase_failed
var on_restore_purchase_success
var on_restore_purchase_failed
var on_product_info

func _init():
	in_app_store = Engine.get_singleton("InAppStore")
	if in_app_store :
		print("init iap_ios")

func bind(show_waiting_animation_impl, on_purchase_success_, on_purchase_failed_, on_restore_purchase_success_, on_restore_purchase_failed_, on_product_info_):
	show_waiting_animation = show_waiting_animation_impl
	on_purchase_success = on_purchase_success_
	on_purchase_failed = on_purchase_failed_
	on_restore_purchase_success = on_restore_purchase_success_
	on_restore_purchase_failed = on_restore_purchase_failed_
	on_product_info = on_product_info_

func purchase(product_id):
	if in_app_store :
		var result = in_app_store.purchase({"product_id": product_id})
		print("# purchase " + str(product_id) + " -> " + str(result))
		if result == 0 :
			if show_waiting_animation :
				show_waiting_animation.call_func()

func restore_purchases():
	if in_app_store :
		var result = in_app_store.restore_purchases()
		print("# restore purchases " + str(result))

# product_ids it is array ["my_product1_id", "my_product2_id, ..."]
func request_product_detail(product_ids):
	if in_app_store :
		var data = {
			"product_ids" : product_ids
		}
		var result = in_app_store.request_product_info(data)
		print("# request_product_info: " + str(result))

func on_events_timer_update():
	if in_app_store :
		print("------------------------------------")
		while in_app_store.get_pending_event_count() > 0 :
			print("# pending_event_count: " + str(in_app_store.get_pending_event_count()))
			var event = in_app_store.pop_pending_event()
			print("# event: " + str(event))
			
			if event.type == "purchase":
				if event.result == "ok" :
					in_app_store.finish_transaction(event.product_id)
					if on_purchase_success :
						on_purchase_success.call_func(event.product_id)
				else:
					if on_purchase_failed :
						on_purchase_failed.call_func(event.product_id)
			elif event.type == "restore" :
				if event.result == "ok" :
					if on_restore_purchase_success :
						on_restore_purchase_success.call_func(event.product_id)
				else:
					if on_restore_purchase_failed :
						on_restore_purchase_failed.call_func(event.product_id)
			if event.type == "product_info" :
				if on_product_info :
					on_product_info.call_func(event)