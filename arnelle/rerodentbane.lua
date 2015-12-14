-- Customimized ReRodentBane settings
local rerodentbane = require("arnelle/lib/rerodentbane")


rerodentbane.bind({}, "i", {rerodentbane.cut, "tl"})
rerodentbane.bind({}, "k", {rerodentbane.cut, "tm"})
rerodentbane.bind({}, "o", {rerodentbane.cut, "tr"})
rerodentbane.bind({}, "h", {rerodentbane.cut, "ml"})
rerodentbane.bind({}, ";", {rerodentbane.cut, "mm"})
rerodentbane.bind({}, "l", {rerodentbane.cut, "mr"})
rerodentbane.bind({}, "n", {rerodentbane.cut, "bl"})
rerodentbane.bind({}, "j", {rerodentbane.cut, "bm"})
rerodentbane.bind({}, "m", {rerodentbane.cut, "br"})

rerodentbane.bind({}, "u", rerodentbane.undo)

rerodentbane.bind({}, "Space", function()
    rerodentbane.warp()
    rerodentbane.click()
    rerodentbane.stop()
end)

rerodentbane.bind({"Shift"}, "Space", function()
    rerodentbane.warp()
    rerodentbane.click(3)
    rerodentbane.stop()
end)


return rerodentbane
