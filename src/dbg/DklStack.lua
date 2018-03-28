DklBaseGraphics = DklBaseGraphics or {}

require "dbg/DklAxis"

function stackrange(data)
	local total = 0
	local maxv = data[1][1]
	local minv = data[1][1]
	for i=1,#data do
		for j=1,#data[i]do
			total= total+data[i][j]
			if(data[i][j]<minv)then
				minv=data[i][j]
			end
		end
		if(total>maxv)then
			maxv = total
		end
		total = 0
	end
	return {minv,maxv}
end

function DklBaseGraphics:stacked(x,y,args)
	args = args or {}
	
	local pch = args.pch or self.plt.pch
	local tpch = type(pch) == "table"
	local _pch = pch

	local cex = args.cex or self.plt.cex
	local tcex = type(cex) == "table"
	local _cex = cex
	
	local col = args.col or self.plt.col
	local tcol = type(col) == "table"
	
	local bg = args.bg or self.plt.bg
	local tbg = type(bg) == "table"
	local lwd = args.lwd or self.plt.lwd
	local tlwd = type(lwd) == "table"
	local _tmp
	local  yVal
	local accum = 0
	pushMatrix()
	translate(self.fig.xoff,self.fig.yoff)
	translate(self.plt.xoff,self.plt.yoff)
	translate(-self.plt.usr[1]*self.plt.xscl,self.plt.usr[3]*self.plt.yscl)
	
	noFill()
	_tmp = not tcol and stroke(col)
	_tmp = not tbg and pch > 14 and fill(bg)
	_tmp = not tlwd and strokeWeight(lwd)
	if(args.mode == "ver")then
		for i=1,#x do
			for j=1,#y[i] do
				_cex = tcex and cex[(j-1)%#cex+1] or _cex
				_pch = tpch and pch[(j-1)%#pch+1] or _pch
				_tmp = tcol and fill(col[(j-1)%#col+1])
				_tmp = tbg and _pch > 14 and fill(bg[(j-1)%#bg+1])
				_tmp = tlwd and strokeWeight(lwd[(j-1)%#tlwd+1])
				yVal = (y[i][j]*self.plt.yscl)
				rect(x[i]*self.plt.xscl,-y[i][j]*self.plt.yscl-accum,0.3*self.plt.xscl,yVal)
				accum = accum + yVal
			end
			accum = 0
		end
	else
		for i=1,#y do
			for j=1,#x[i] do
				_cex = tcex and cex[(j-1)%#cex+1] or _cex
				_pch = tpch and pch[(j-1)%#pch+1] or _pch
				_tmp = tcol and fill(col[(j-1)%#col+1])
				_tmp = tbg and _pch > 14 and fill(bg[(j-1)%#bg+1])
				_tmp = tlwd and strokeWeight(lwd[(j-1)%#tlwd+1])
				xVal = (x[i][j]*self.plt.xscl)
				rect(0+accum,-(y[i])*self.plt.yscl,xVal,0.3*self.plt.yscl)	
				accum = accum + xVal
			end
			accum = 0
		end
	end
	fill(0)
	popMatrix()
end
