-- the script for accessing stored bars
local args = {...}
local utils = require('utils');

require('hack/scripts/stocksfuncs')
dofile('hack/scripts/stocksfuncs.lua');




function get_bars()
  
  local b = dfhack.script_environment('stocksfuncs').get_all_items()
  bars = {}
  for i, item in ipairs(b) do
    c = dfhack.script_environment('stocksfuncs').get_type(item)
    if c == "bar" then
      table.insert(bars, item)
      d = item
      g = dfhack.matinfo.decode(item).material.state_name.Solid
    end
  end
  --all bars retrieved, now sort and display
  c = dfhack.script_environment('stocksfuncs').count_each(bars)
  --print(c)
end

get_bars()