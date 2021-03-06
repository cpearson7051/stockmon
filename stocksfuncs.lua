-- a script for monitoring stockpiles, this is a holder for functions

utils = require('utils')
args = {...}


-------------------
-- FUNCTIONS
----------------------



---------------------------
function get_type(item)
  return string.match(tostring(item._type),"<type: item_(.+)st>"):lower()
end
---------------------------

function get_all_items()
  --print('start function')
  local utils = require('utils')
  piles = {}
  shops = {}

  for k, v in ipairs(df.global.world.buildings.all) do
    local str = utils.getBuildingName(v)
    if string.find(str, "Stockpile") then
    
      table.insert(piles, v)
    
    else
      --if its not a stockpile, its a building.
      --should i call buildings by name or fuckit.
      table.insert(shops, v)
    end
  end
  --now we have all buildings and stockpiles.
  for i, pile in ipairs(piles) do
    --print(utils.getBuildingName(pile))
  end
  --lets see whats inside
  allstored = {}

  for i, pile in ipairs(piles) do
   --inside the stockpiles..
   local contents = dfhack.buildings.getStockpileContents(pile)
   for j, item in ipairs(contents) do
     --if item is a bin, look in the bin
     --print(item)
     local itemname = get_type(item)
     if itemname == "bin" or itemname == "barrel" then
       local bincon = dfhack.items.getContainedItems(item)
         for k, v in ipairs(bincon) do
           table.insert(allstored, v)
         end
     else
   
       table.insert(allstored, item)
     end
   end
  
  end

  --for i, item in ipairs(allstored) do
  --  print(item)
  --end
  --print('hit')
  return allstored
end

------for counting bars and ores
function count_each(list)
  types = {}
  --table.insert(temp, list[0])
  --print(temp)
  for i, item in ipairs(list) do
    g = dfhack.matinfo.decode(item).material.state_name.Solid
    --print(g)
    a = check_list(g, types)
    if a == false then
      table.insert(types, item)
    end
  end
  for i, item in ipairs(types) do
    g = dfhack.matinfo.decode(item).material.state_name.Solid
    --print(g)
  end
  counts = run_numbers(types, list)
  return counts
end

function check_list(item, types)
  isin = false
  for i, j in ipairs(types) do
    --print(item)
    h = dfhack.matinfo.decode(j).material.state_name.Solid
   
    if g == h then
      --print('found')
      isin = true
    end
  end
  return isin
end

function run_numbers(types, list)
  counts = {}
  for i, j in ipairs(types) do
    num = 0;
    mw = 0;
    g = dfhack.matinfo.decode(j).material.state_name.Solid
    --print(g..' check against')
    for k, v in ipairs(list) do
      
      h = dfhack.matinfo.decode(v).material.state_name.Solid
     -- print(h)
      if g == h then
        num = num + 1;
        --print('found match')
      end
      if v.getQuality(v) >= 5 then
        mw = mw + 1;
      end
    end
    str = g..' '..num..' | '..mw..'*';
    --print(str)
    table.insert(counts, str)
    --print(g..' done')
  end
  
  for i, j in ipairs(counts) do
    --print(j)
  end
  return counts
end


function get_ores()
  
  --local b = dfhack.script_environment('stocksfuncs').get_all_items()
  ores = {}
  for i, item in ipairs(b) do
    c = dfhack.script_environment('stocksfuncs').get_type(item)
    
    if c == "boulder" then
      mat = dfhack.matinfo.decode(item)
      p = df.global.world.raws.inorganics[mat.index].metal_ore.mat_index
      count = 0
      ore = false
      for x,y in ipairs(p) do
        count = count + 1
      end
      if count > 0 then
        ore = true
      end

      if ore == true then
        table.insert(ores, item)
        d = item
        g = dfhack.matinfo.decode(item).material.state_name.Solid
      end
    end
  end
  --all ores retrieved, now sort and display
  c = dfhack.script_environment('stocksfuncs').count_each(ores)
  --print(c)
end
--------------------------------------
--end of bars and ores functions.