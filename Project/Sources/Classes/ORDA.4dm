Class constructor
	//set the remote contexts to use later
	ds:C1482.setRemoteContextInfo("yearlyTotals"; "Sales"; "SaleDate,SalePriceTotal")
	ds:C1482.setRemoteContextInfo("salesPerProduct"; "Sales"; "product.Name,SalePriceTotal")
	ds:C1482.setRemoteContextInfo("salesPerProductPerMonth"; "Sales"; "SaleDate,product.Name,SalePriceTotal")
	ds:C1482.setRemoteContextInfo("SalesAndQuantityPerProductPerYear"; "Sales"; "SaleDate,product.Name,SalePriceTotal,Quantity")
	
Function getYearlyTotals()->$result : Object
	var $sales : cs:C1710.SalesSelection
	var $sale : cs:C1710.SalesEntity
	var $year : Text
	
	
	$sales:=ds:C1482.Sales.all(New object:C1471("context"; "yearlyTotals"))
	
	$result:=New object:C1471
	For each ($sale; $sales)
		
		$year:=String:C10(Year of:C25($sale.SaleDate))
		If (Not:C34(OB Is defined:C1231($result; $year)))
			$result[$year]:=$sale.SalePriceTotal
		Else 
			$result[$year]+=$sale.SalePriceTotal
		End if 
		
	End for each 
	
Function getMonthlyTotals()->$result : Object
	var $sales : cs:C1710.SalesSelection
	var $sale : cs:C1710.SalesEntity
	var $year; $month; $yearMonth : Text
	
	$sales:=ds:C1482.Sales.all(New object:C1471("context"; "yearlyTotals"))
	//$sales:=ds.Sales.query("PK != '' order by SaleDate"; New object("context"; "yearlyTotals"))
	
	$result:=New object:C1471
	For each ($sale; $sales)
		
		$year:=String:C10(Year of:C25($sale.SaleDate))
		$month:=String:C10(Month of:C24($sale.SaleDate))
		$yearMonth:=$year+"-"+$month
		If (Not:C34(OB Is defined:C1231($result; $yearMonth)))
			$result[$yearMonth]:=$sale.SalePriceTotal
		Else 
			$result[$yearMonth]+=$sale.SalePriceTotal
		End if 
		
	End for each 
	
Function getSalesPerProduct()->$result : Object
	var $sales : cs:C1710.SalesSelection
	var $sale : cs:C1710.SalesEntity
	
	$sales:=ds:C1482.Sales.all(New object:C1471("context"; "salesPerProduct"))
	//$sales:=ds.Sales.query("PK != '' order by product.Name"; New object("context"; "salesPerProduct"))
	
	$result:=New object:C1471
	For each ($sale; $sales)
		
		If (Not:C34(OB Is defined:C1231($result; $sale.product.Name)))
			$result[$sale.product.Name]:=$sale.SalePriceTotal
		Else 
			$result[$sale.product.Name]+=$sale.SalePriceTotal
		End if 
		
	End for each 
	
Function getSalesPerProductPerMonth()->$result : Object
	var $sales : cs:C1710.SalesSelection
	var $sale : cs:C1710.SalesEntity
	var $year; $month; $ProductYearMonth : Text
	
	//$sales:=ds.Sales.all(New object("context"; "salesPerProductPerMonth"))
	$sales:=ds:C1482.Sales.query("PK != '' order by product.Name, SaleDate"; New object:C1471("context"; "salesPerProductPerMonth"))
	
	$result:=New object:C1471
	For each ($sale; $sales)
		
		$year:=String:C10(Year of:C25($sale.SaleDate))
		$month:=String:C10(Month of:C24($sale.SaleDate))
		$ProductYearMonth:=$sale.product.Name+";"+$year+"-"+$month
		If (Not:C34(OB Is defined:C1231($result; $ProductYearMonth)))
			$result[$ProductYearMonth]:=$sale.SalePriceTotal
		Else 
			$result[$ProductYearMonth]+=$sale.SalePriceTotal
		End if 
		
	End for each 
	
Function getSalesAndQuantityPerProductPerYear()->$result : Object
	var $sales : cs:C1710.SalesSelection
	var $sale : cs:C1710.SalesEntity
	var $year; $productNameYear : Text
	
	$sales:=ds:C1482.Sales.all()
	//$sales:=ds.Sales.query("PK != '' order by product.Name, SaleDate"; New object("context"; "SalesAndQuantityPerProductPerYear"))
	
	//aggregate results
	$result:=New object:C1471
	var $productNameYear : Text
	For each ($sale; $sales)
		$productNameYear:=$sale.product.Name+";"+String:C10(Year of:C25($sale.SaleDate))
		If (Not:C34(OB Is defined:C1231($result; $productNameYear)))
			$result[$productNameYear]:=New object:C1471(\
				"quantity"; $sale.Quantity; \
				"totals"; $sale.SalePriceTotal\
				)
		Else 
			$result[$productNameYear].quantity+=$sale.Quantity
			$result[$productNameYear].totals+=$sale.SalePriceTotal
		End if 
	End for each 