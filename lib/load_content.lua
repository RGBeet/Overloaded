local mod_path = "" .. SMODS.current_mod.path       -- save the mod path for future usage!

-- LOADING JOKERS
Overloaded.object_buffer = {
	['Jokers'] = {}
}

local function load_items(path,func)
	local files = NFS.getDirectoryItems(mod_path..path)
	--tell('File path is '.. path)
	MadLib.loop_func(files, function(file)
		--tell('File is '..file)
		local f, err = SMODS.load_file(path..file)
		if err then
			--tell_error(err)
			--errors[file] = err
			return false
		end

		local item = f()
		if not (item and item.data) then
			--tell('Item could not load - improper data structure.')
			return false
		elseif item.devmode then
			--tell('Item could not load - devmode only!')
			return false
		end

		if item.categories and MadLib.list_matches_one(item.categories, function(c)
			return Overloaded.Config[v] ~= nil and Overloaded.Config[v] == false
		end) then
			--tell('Item '..(item.data and item.data.key or 'UNKNOWN')..' could not load - configs turned off.')
			return false
		end

		local data = item.data
		if data.object_type then
			if func then func(item.data) end
			--tell('Attempting to load item '..(item.data and item.data.key or 'UNKNOWN')..'.')
			SMODS[data.object_type](data)
		end
	end)
end

local function loop_directories(tbl, path)
    path = path or {}
    --tell('Loading Directories')
	print(path)
	MadLib.loop_table(tbl, function(key,value)
        if type(value) ~= "table" then return false end
		if value.pass ~= nil and value.pass() == true then
			--tell("Loading folder at: " .. table.concat(path, ".") .. (next(path) and "." or "") .. key)
			local final_path = 'items/'
			MadLib.loop_func(path, function(v,i)
				final_path = final_path .. v .. '/'
			end)
			load_items(final_path..key..'/',value.func)
		else
			table.insert(path, key)
			loop_directories(value, path)
			table.remove(path)
		end
	end)
end

Overloaded.JokerIds = {} -- joker ids
Overloaded.Directories = {
	['boosters']	= {
		pass = function()
			return true
		end
	},
	['jokers'] = {
        pass = function()
            return true
        end,
        func = function(d) -- add joker id to joker ids
            d.pools = { ['OverloadedJoker'] = true }
            d.blueprint_compat  = d.blueprint_compat or true
            d.eternal_compat    = d.eternal_compat or true
            d.perishable_compat = d.perishable_compat or true
            d.unlocked          = d.unlocked or true
            d.discovered        = d.discovered or true
        end
    },
	['consumeables'] = {
		['elemental'] = {
			pass = function()
				return true
			end
		}
	}
}
loop_directories(Overloaded.Directories)

local function load_folder(folder)
	local files = NFS.getDirectoryItems(mod_path .. folder)
	for _, file in ipairs(files) do
		local f, err = SMODS.load_file(folder .. "/" .. file)
		if err then
			errors[file] = err
		else
			local curr_obj = f()
			local namey = curr_obj.name
            local configs = Overloaded.Config[curr_obj.name]
			if curr_obj.name == "HTTPS Module" and configs == nil then
				Overloaded.Config[curr_obj.name] = false
			end
			if configs == nil then
				Overloaded.Config[curr_obj.name] = true
			end
			if configs == true then
				if curr_obj.init then
					curr_obj:init()
				end
				if not curr_obj.items then
					-- No items
				else
					for _, item in ipairs(curr_obj.items) do
						if not item.order then
							item.order = 0
						end
						if curr_obj.order then
							item.order = item.order + curr_obj.order
						end
						if SMODS[item.object_type] then
							if not Overloaded.object_buffer[item.object_type] then
								Overloaded.object_buffer[item.object_type] = {}
							end
							--tell("Added item to obj_buffer of "..namey)
							Overloaded.object_buffer[item.object_type][#Overloaded.object_buffer[item.object_type] + 1] = item
						else
							--tell("Error loading item "..namey .." :(")
						end
					end
				end
			end
		end
	end
end
--load_folder('items/misc') -- load the items folder