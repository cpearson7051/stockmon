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
      --print(item.subtype.name)
    end
    
  end
  count_armor_types(armor)
end

function count_armor_types(armor)
  armortypes = {}
  --subtypes = {}
  for i, item in ipairs(armor) do
    typestored = false
    --print(item.subtype.name)
    
    for j, k in ipairs(armortypes) do 
      --subtypestored = false
      if item.subtype.name == k then  --item._type
        
        typestored = true
        
      end
      
    end
    if typestored == false then
      table.insert(armortypes, item.subtype.name)  --item._type
    end
  end
 -- maint = {}
 -- for i, item in ipairs(armor) do
    --print(item._type)
  --  z = dfhack.script_environment('stocksfuncs').get_type(item)
   -- print(z)
  --  main = false
  --  for j, k in ipairs(maint) do
  --    if z == k then
  --      main = true
  --    end
      
  --  end
  --  if main == false then
   --   table.insert(maint, z)
  --  end
  --end
  --for i, item in ipairs(maint) do
   -- print(item)
 -- end
  
  count_armor_of_type(armor, armortypes,maint)
  --c = dfhack.script_environment('stocksfuncs').count_each(armor)
 -- for i, item in ipairs(c) do
   -- print(item)
 -- end
end
function count_armor_of_type(armor, armortypes)
  c = {}
  --for b,mt in ipairs(maint) do
 --   table.insert(c, mt)
  --add maintypes
  for i, item in ipairs(armortypes) do
    count = 0;
    oftype = {}
    mats = {}
    countMasterw = 0;
    
    for j, k in ipairs(armor) do
      --print(k._type)
      if item == k.subtype.name then --k._type
        count = count + 1
        table.insert(oftype, k)
        if k.getQuality(k) >= 5 then
          countMasterw = countMasterw + 1
        end
        --print(k.getQuality(k))
      end
    end
    for x,y in ipairs(oftype) do
      --print(y)
    end
    v = dfhack.script_environment('stocksfuncs').count_each(oftype)
    --print(item)
    str = '--'..item..' total: '..count..' | '..countMasterw..'*'
    --str = string.match(tostring(item),"<type: item_(.+)st>").."  total: "..count..' | '..countMasterw.."*"
    --str = dfhack.script_environment('stocksfuncs').get_type(item)..'  total: '..count..' | '..countMasterw..'*'
   -- print(str)
    table.insert(c, str)
    for x, y in ipairs(v) do
      --print(y)
      
      vstr = '----'..y
      
      --print(vstr)
      table.insert(c, vstr)
      
    end
    sep = ' '
    table.insert(c, sep)
  end
  ---end maintypes
 -- end
  
  print('-----------------------------------------------------------------')
  print('Displaying stockpiled armor counts - Total | Masterwork/Artifact')
  print('-----------------------------------------------------------------')
  for i, item in ipairs(c) do
    print(item)
  end

end



find_armor()