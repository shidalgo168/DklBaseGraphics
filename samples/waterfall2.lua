--
-- waterfall2.lua
--
-- Döiköl Base Graphics Library
--
-- Copyright (c) 2017-2018 Armando Arce - armando.arce@gmail.com
--
-- This library is free software; you can redistribute it and/or modify
-- it under the terms of the MIT license. See LICENSE for details.
--

require "dbg/DklBaseGraphics"

local bg
local x
local y
local col
local total = 0
local maxValue = 0

function setup()
	size(500,350)
	local f = loadFont("data/Karla.ttf",12)
	textFont(f)
	bg = DklBaseGraphics:new(width(),height())
	
	x = {0,1,2,3,4,5,6,7}
	y = {0,53,20,-13,-19,17,-17,13}
	col = {"#40f783","daf083"}
end

function draw()
	background(255)
	

	bg:plot(y,x,{type="w",col=col,bty="n",main="waterfall2.lua",sub="Horizontal example",xlab="X axis",ylab="Y axis"})
	--bg:box({which="figure"})
end

function windowResized(w,h)
	bg:resize_window(w,h)
end