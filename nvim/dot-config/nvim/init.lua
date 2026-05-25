require("vim._core.ui2").enable({})

require("core.set")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

require("core.remap")
require("core.ft")
