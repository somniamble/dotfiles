local allowed_globals = {}
for key, _ in pairs(_G) do
  table.insert(allowed_globals, key)
end

-- return {
--   -- by default, build all fnl/ files into lua/
--   build = true,
--   -- remove stale lua/files
--   clean = true,
--   compiler = {
--     modules = {
--       -- enforce unknown variable errors
--       allowedGlobals = allowed_globals
--     }
--   }
-- }

return {
  build = {
    { atomic = true, verbose = true },
    { "fnl/**/*.macro*.fnl", false },
    -- put all lua files inside `.compiled/lua`, note we must still name
    -- final directory lua/ due to how nvim's runtimepath works
    { "fnl/**/*.fnl", function(path)
      -- ~/.config.nvim/fnl/hello/there.fnl -> ~/.config/nvim/.compiled/lua/hello/there.fnl
      return string.gsub(path, "/fnl/", "/.compiled/lua/")
    end },
    -- { "init.fnl", true } -- optionally compile init.fnl to init.lua
    clean = {{ ".compiled/lua/**/*.lua", true }},
    compiler = {
      modules = {
        allowedGlobals = allowed_globals
      }
    }
  }
}
