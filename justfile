default:
    @just build fmt

fmt:
    stylua .
    dprint fmt

build:
    nvim --headless -u build.lua +LaviBuild +q
