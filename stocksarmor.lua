-- the script for accessing stored clothing
local args = {...}
local utils = require('utils');

require('hack/scripts/stocksfuncs')
dofile('hack/scripts/stocksfuncs.lua');

-----------------------------
--functions
----------------------------
function find_armor()
  local b = dfhack.script_environment('stocksfuncs').get_all_items()
  armor = {}
  for i, item in ipairs(b) do
    if item.isArmorNotClothing(item) == true then
      table.insert(armor, item)
     -- print(item)
    end
    
  end
  count_armor_types(armor)
end

function count_armor_types(armor)
  armortypes = {}
  for i, item in ipairs(armor) do
    typestored = false
    for j, k in ipairs(armortypes) do 
      if item._type == k then
        --print('item'..item)
        typestored = true
      end
    end
    if typestored == false then
      table.insert(armortypes, item._type)
    end
  end
  for i, item in ipairs(armortypes) do
    --print(item)
  end
  count_armor_of_type(armor, armortypes)
  --c = dfhack.script_environment('stocksfuncs').count_each(armor)
 -- for i, item in ipairs(c) do
   -- print(item)
 -- end
end
function count_armor_of_type(armor, armortypes)
  c = {}
  for i, item in ipairs(armortypes) do
    print(item)
    count = 0;
    oftype = {}
    mats = {}
    countMasterw = 0;
    for j, k in ipairs(armor) do
      --print(k.subtype.name)
      if item == k._type then
        print('got here')
        count = count + 1
        table.insert(oftype, k)
        if k.getQuality(k) >= 5 then
          countMasterw = countMasterw + 1
        end
        --print(k.getQuality(k))
      end
    end
    for x,y in ipairs(oftype) do
      print(y)
    end
    v = dfhack.script_environment('stocksfuncs').count_each(oftype)
    print(item)
    str = string.match(tostring(item),"<type: item_(.+)st>").."  total: "..count..' | '..countMasterw.."*"
    --str = dfhack.script_environment('stocksfuncs').get_type(item)..'  total: '..count..' | '..countMasterw..'*'
   -- print(str)
    table.insert(c, str)
    for x, y in ipairs(v) do
      --print(y)
      
      vstr = '--'..y
      
      --print(vstr)
      table.insert(c, vstr)
      
    end
    sep = ' '
    table.insert(c, sep)
  end
  
  print('-----------------------------------------------------------------')
  print('Displaying stockpiled armor counts - Total | Masterwork/Artifact')
  print('-----------------------------------------------------------------')
  for i, item in ipairs(c) do
    print(item)
  end

end



find_armor()