local function select_slot_with_seeds()
	spm = {
	["minecraft:wheat"] = "minecraft:wheat_seeds",
	["minecraft:beetroots"] = "minecraft:beetroot_seeds"
	}
	for i=1,16 do
		turtle.select(i)
		local item = turtle.getItemDetail()
		if item then		
			if spm[crop.name] == item.name then 
				break
			end
		end
	end
end

local function interact()
	turtle.digDown()
	select_slot_with_seeds()
	turtle.placeDown()
end

local function check_crop()
	a, crop = turtle.inspectDown()
	if crop.name == "minecraft:wheat" then
		if crop.state.age == 7 then
			return true
			end
	elseif b.name == "minecraft:beetroots" then
		if crop.state.age == 3 then
			return true
			end
	end
end

local function harvest()
	turtle.suckDown()
	if check_crop() then interact() end
	turtle.suck()
	turtle.forward()
end

local function go_to_station_from_start()
	turtle.turnRight()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.turnRight()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.down()
	turtle.down()
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.forward()
end

local function return_from_station_to_start()
	turtle.turnRight()
	turtle.turnRight()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.turnRight()
	turtle.up()
	turtle.up()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.forward()	
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.forward()
	turtle.forward()	
	turtle.turnRight()
	turtle.forward()
	turtle.forward()	
end

local function tank_up()
	while turtle.getFuelLevel() <= 4000 do
		for i=1,16 do
			turtle.select(i)
			refueling_state = turtle.refuel()
			if refueling_state then break
			else go_get_fuel()
			end
		end
	end
end

local function unload_crops_and_seeds_and_refuel()
	go_to_station_from_start()
	turtle.turnRight()
	for i=1,16 do
		turtle.select(i)
		local item = turtle.getItemDetail()
		if string.match(item.name, "seeds") then
			turtle.drop()
		end
	end
	turtle.turnRight()
	turtle.turnRight()
	for i=1,16 do
		turtle.select(i)
		local item = turtle.getItemDetail()
		if item.name ~= "minecraft:coal" then
			if not string.match(item.name, "seeds") then
				turtle.drop()
			end
		end
	end	
	turtle.turnRight()
	return_from_station_to_start()
end

local function plow_row(row_lenght)
	for i = 1, row_lenght do
		harvest()
	end
end

local function turner()
	if last_turn == "left" then
		turtle.turnRight()
		turtle.forward()
		turtle.turnRight()
		last_turn = "right"
	elseif last_turn == "right" then
		turtle.turnLeft()
		turtle.forward()
		turtle.turnLeft()
		last_turn = "left"
	end
end

local function full_circle()
	local row_lenght = 23
	local nr_of_rows = 7
	last_turn = left
	for i=1,nr_of_rows-1 do
		plow_row(row_lenght)
		turner()
	end
	plow_row(row_lenght)
	turtle.turnRight()
	for i=1,nr_of_rows-1 do
		turtle.forward()
	end
	turtle.turnRight() 
	--powinien byc na poczatku petli
	unload_crops_and_seeds_and_refuel()
end

while true do 
	full_circle() 
	sleep(300)
end