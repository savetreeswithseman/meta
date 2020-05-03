local io = require('io')
math.randomseed(os.time())


local current_date = ""

local function save_current_date()
  local f  = io.popen("date +%d-%b-%Y ")
  current_date = f:read("*a")
  f:close()
end

local fword = {
  -- F
  1 , 1 , 1 , 1 ,
  1 , 0 , 0 , 0 ,
  1 , 0 , 0 , 0 ,
  1 , 1 , 1 , 1 ,
  1 , 0 , 0 , 0 ,
  1 , 0 , 0 , 0 ,
  1 , 0 , 0 , 0 , 

  -- A

  0 , 0 , 1 , 0 ,
  0 , 1 , 0 , 1 ,
  1 , 0 , 0 , 1 ,
  1 , 0 , 0 , 1 ,
  1 , 1 , 1 , 1 ,
  1 , 0 , 0 , 1 ,
  1 , 0 , 0 , 1 , 

  -- S
  0 , 1 , 1 , 1 ,
  1 , 0 , 0 , 0 ,
  1 , 0 , 0 , 0 ,
  0 , 1 , 1 , 0 ,
  0 , 0 , 0 , 1 ,
  0 , 0 , 0 , 1 ,
  1 , 1 , 1 , 0 , 

  -- T

  1 , 1 , 1 , 1 ,
  0 , 0 , 1 , 0 ,
  0 , 0 , 1 , 0 ,
  0 , 0 , 1 , 0 ,
  0 , 0 , 1 , 0 ,
  0 , 0 , 1 , 0 ,
  0 , 0 , 1 , 0 

}

local setup_date = function() 
  -- currently does nothing
end

local function random_string ()
  local res = ""
  for i = 0,10 do
    res = res .. string.char(math.random(97,122))
  end
  return res
end

local function git_commit(times)
  for i = 0,times do
    local res = random_string()
    os.execute("echo ".. res .. " >> file ")
    os.execute("git add -A && git commit -m ".. res)
  end
end

local function date_change(days)
  os.execute("date --set='"..tostring(days).." day '")
end

local function magic () 
  date_change(-(28*4) -1)
  for i = 0,3 do
    for  j = 0,6 do
      git_commit(fword[j*4+i+1]*10)
      date_change(1)
    end
  end
  for i = 0,3 do
    for  j = 0,6 do
      git_commit(fword[j*4+i+1+28]*10)
      date_change(1)
    end
  end
  for i = 0,3 do
    for  j = 0,6 do
      git_commit(fword[j*4+i+1+56]*10)
      date_change(1)
    end
  end
  for i = 0,3 do
    for  j = 0,6 do
      git_commit(fword[j*4+i+1+84]*10)
      date_change(1)
    end
  end
end


save_current_date()
magic()

os.execute("date --set='"..string.sub(current_date,0,-2).."'")
