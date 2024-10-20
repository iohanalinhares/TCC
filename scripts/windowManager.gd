extends Node

var current_window = null

func close_current_window():
	if current_window:
		current_window.queue_free()
		current_window = null
