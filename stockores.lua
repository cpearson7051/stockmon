-- the script for accessing stored ores
local args = {...}
local utils = require('utils');

require('hack/scripts/stocksfuncs')
dofile('hack/scripts/stocksfuncs.lua');

function get_ores()
  
  local b = dfhack.script_environment('stocksfuncs').get_all_items()
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
  for i, item in ipairs(c) do
    strlen = string.len(item)
    str = string.match(item,"(.+) | (.+)")
    print(str)
  end
  --print(c)
end

get_ores()


-------unused bits of code for later ref
     -- print(df.global.world.raws.inorganics[0].metal_ore)
     --print(item:isMetalOre(mat.metal_ore))
     --print(df.world.raws.inorganics[item].metal_ore.mat_index)
     -- print(dfhack.matinfo.getToken(item))
     -- print(mat.index)