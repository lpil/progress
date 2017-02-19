local request_id = KEYS[1]
local meter = KEYS[2]
local increment_amount = KEYS[3]

local history_key = "meter_request_history:::" .. meter
local total_key = "meter_total:::" .. meter
local progress_key = "meter_progress:::" .. meter

if redis.call("SISMEMBER", history_key, request_id) == 1 then
  return "already incremented"

elseif redis.call("EXISTS", total_key, request_id) == 0 then
  return "unknown meter"

else
  redis.call("SADD", history_key, request_id)
  redis.call("INCRBY", progress_key, increment_amount)
  return "incremented"
end
