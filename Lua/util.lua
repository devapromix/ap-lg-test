function sign(x)
   if x > 0 then
      return 1
   elseif x < 0 then
      return -1
   else
      return 0
   end
end

function signedDescr(n)
   if n >= 0 then
      return '+' .. n
   else
      return '-' .. -n
   end
end

function descr_a(s)
   local c = s:sub(1, 1)
   if c:match('%u') then
      return s
   elseif c:match('[aeiou]') then
      return 'an ' .. s
   else
      return 'a ' .. s
   end
end

function delete(t, e)
   for i, e2 in ipairs(t) do
      if e2 == e then
         table.remove(t, i)
         return
      end
   end
   assert(false, 'element not found')
end

function capitalize(s)
   return s:sub(1, 1):upper() .. s:sub(2)
end

function split(s, pat)
   local i = 1
   result = {}
   while true do
      a, b = s:find(pat, i)
      if a then
         table.insert(result, s:sub(i, a - 1))
         i = b + 1
      else
         table.insert(result, s:sub(i))
         break
      end
   end
   return result
end