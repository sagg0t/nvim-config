-- load driver
local driver = require("luasql.postgres")
-- create environment object
env = assert(driver.postgres())
-- connect to data source
con = assert(env:connect("luasql-test")) -- luasql-test - db name
-- retrieve a cursor
cur = assert(con:execute("SELECT name, email from people"))
-- print all rows, the rows will be indexed by field names
row = cur:fetch ({}, "a")
while row do
  print(string.format("Name: %s, E-mail: %s", row.name, row.email))
  -- reusing the table of results
  row = cur:fetch(row, "a")
end
-- close everything
cur:close() -- already closed because all the result set was consumed
con:close()
env:close()

local PGAdapter = {}

return PGAdapter
