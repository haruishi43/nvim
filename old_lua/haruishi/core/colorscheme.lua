local status, _ = pcall(vim.cmd, "colorscheme carbonfox")
if not status then
  print("Colorscheme not found!")
  return
end
