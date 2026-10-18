extends Camera2D

func _ready():
	#cari node peta lewat group peta
	var peta = get_tree().get_first_node_in_group("peta")
	if peta == null:
		print("Peta tidak ditemukan! Cek group 'peta' di level ini.")
		return

	#ambil data peta
	var area = peta.get_used_rect()
	var ukuran_tile = peta.tile_set.tile_size
	var skala = peta.global_transform.get_scale()
	var posisi = peta.global_position

	#ubah ke piksel lalu pasang sebagai batas kamera
	limit_left   = int(posisi.x + area.position.x * ukuran_tile.x * skala.x)
	limit_top    = int(posisi.y + area.position.y * ukuran_tile.y * skala.y)
	limit_right  = int(posisi.x + area.end.x * ukuran_tile.x * skala.x)
	limit_bottom = int(posisi.y + area.end.y * ukuran_tile.y * skala.y)

	print("Batas kamera: ", limit_left, ", ", limit_top, ", ", limit_right, ", ", limit_bottom)
