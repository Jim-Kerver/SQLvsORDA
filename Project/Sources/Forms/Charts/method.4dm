Case of 
	: (Form event code:C388=On Load:K2:1)
		//initialize web areas for charts
		WebArea_LoadPlotlyURL(OBJECT Get pointer:C1124(Object named:K67:5; "ORDA"))
		WebArea_LoadPlotlyURL(OBJECT Get pointer:C1124(Object named:K67:5; "SQL"))
End case 