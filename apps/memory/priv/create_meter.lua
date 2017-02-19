local meter = KEYS[1]
local unit = KEYS[2]
local total = KEYS[3]
local progress = KEYS[4]

local total_key = "meter_total:::" .. meter
local unit_key = "meter_unit:::" .. meter
local progress_key  = "meter_progress:::" .. meter

if redis.call("EXISTS", total_key) == 1 then
  return "already exists"

else
  redis.call("SET", total_key, total)
  redis.call("SET", unit_key, unit)
  redis.call("SET", progress_key, progress)
  return "ok"
end
