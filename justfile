default:
    @just build

build:
    nvim --headless -u build.lua +LaviBuild +q
    stylua .
    dprint fmt
