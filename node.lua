

minetest.register_node("digibuilder:digibuilder", {
	description = "Digibuilder",

	tiles = {"digibuilder.png"},

	tube = {
		insert_object = function(pos, _, stack, _)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("main", stack)
		end,
		can_insert = function(pos, _, stack, _)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			stack = stack:peek_item(1)

			return inv:room_for_item("main", stack)
		end,
		input_inventory = "main",
		connect_sides = {bottom = 1}
	},

	light_source = 13,
	groups = {
		cracky = 3,
		oddly_breakable_by_hand = 3,
		tubedevice = 1,
		tubedevice_receiver = 1
	},

	sounds = default.node_sound_glass_defaults(),

	digiline = {
		receptor = {
			rules = digibuilder.digiline_rules,
			action = function() end
		},
		effector = {
			rules = digibuilder.digiline_rules,
			action = digibuilder.digiline_effector
		}
	},

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		-- default digiline channel
		meta:set_string("channel", "digibuilder")
	end,

	on_construct = function(pos)
		-- start nodetimer if not started
		local timer = minetest.get_node_timer(pos)
		if not timer:is_started() then
			timer:start(2)
		end

		-- inventory
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)

		-- formspec
		digibuilder.update_formspec(meta)
	end,

	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		local name = player:get_player_name()

		return inv:is_empty("main") and
			inv:is_empty("upgrade") and
			not minetest.is_protected(pos, name)
	end,

	on_timer = function()--pos, elapsed)

		-- restart timer
		return true
	end,

	on_receive_fields = function(pos, _, fields, sender)
		--local meta = minetest.get_meta(pos);

		if not sender then
			return
		end

		if minetest.is_protected(pos, sender:get_player_name()) then
			-- not allowed
			return
		end


		if fields.save then
      print("save")
		end

	end,

	-- inventory protection
	allow_metadata_inventory_take = function(pos, _, _, stack, player)
		if player and player:is_player() and minetest.is_protected(pos, player:get_player_name()) then
			-- protected
			return 0
		end

		return stack:get_count()
	end,

	allow_metadata_inventory_put = function(pos, _, _, stack, player)
		if player and player:is_player() and minetest.is_protected(pos, player:get_player_name()) then
			-- protected
			return 0
		end

		return stack:get_count()
	end,

	on_punch = function()--pos, node, puncher)
    --TODO show marker on punch
	end
})