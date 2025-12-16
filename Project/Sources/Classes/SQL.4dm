Function getYearlyTotals()->$result : Object
	
	ARRAY INTEGER:C220($years; 0)
	ARRAY REAL:C219($totals; 0)
	
	Begin SQL
		SELECT YEAR(SaleDate), SUM(SalePriceTotal)
		FROM Sales
		GROUP BY 1
		INTO :$years, :$totals
	End SQL
	
	//convert to collection
	var $yearsCol; $totalsCol : Collection
	$yearsCol:=New collection:C1472
	$totalsCol:=New collection:C1472
	ARRAY TO COLLECTION:C1563($yearsCol; $years)
	ARRAY TO COLLECTION:C1563($totalsCol; $totals)
	$result:=New object:C1471("years"; $yearsCol; "totals"; $totalsCol)
	
Function getYearlyTotals2()->$result : Object
	
	ARRAY INTEGER:C220($years; 0)
	ARRAY REAL:C219($totals; 0)
	
	Begin SQL
		SELECT YEAR(SaleDate), SUM(SalePriceTotal)
		FROM Sales
		GROUP BY SaleDate
		INTO :$years, :$totals
	End SQL
	
	//aggregate the results
	$result:=New object:C1471
	For ($i; 1; Size of array:C274($years))
		$year:=String:C10($years{$i})
		If (Not:C34(OB Is defined:C1231($result; $year)))
			$result[$year]:=$totals{$i}
		Else 
			$result[$year]+=$totals{$i}
		End if 
	End for 
	
Function getMonthlyTotals()->$result : Object
	
	ARRAY INTEGER:C220($years; 0)
	ARRAY INTEGER:C220($months; 0)
	ARRAY REAL:C219($totals; 0)
	
	Begin SQL
		SELECT YEAR(SaleDate), MONTH(SaleDate), SUM(SalePriceTotal)
		FROM Sales
		ORDER BY SaleDate
		GROUP BY 1, 2
		INTO :$years, :$months, :$totals
	End SQL
	
	//convert results
	$result:=New object:C1471
	For ($i; 1; Size of array:C274($years))
		$yearMonth:=String:C10($years{$i})+"-"+String:C10($months{$i})
		If (Not:C34(OB Is defined:C1231($result; $yearMonth)))
			$result[$yearMonth]:=$totals{$i}
		Else 
			$result[$yearMonth]+=$totals{$i}
		End if 
	End for 
	
Function getSalesPerProduct()->$result : Object
	ARRAY TEXT:C222($productNames; 0)
	ARRAY REAL:C219($totals; 0)
	
	Begin SQL
		SELECT Product.Name, SUM(SalePriceTotal)
		FROM Sales
		JOIN Product
		ON Sales.ProductPK = Product.PK
		GROUP BY Product.Name
		INTO :$productNames, :$totals
	End SQL
	
	$result:=New object:C1471
	For ($i; 1; Size of array:C274($productNames))
		$result[$productNames{$i}]:=$totals{$i}
	End for 
	
Function getSalesPerProductPerMonth()->$result : Object
	ARRAY TEXT:C222($productNames; 0)
	ARRAY INTEGER:C220($years; 0)
	ARRAY INTEGER:C220($months; 0)
	ARRAY REAL:C219($totals; 0)
	var $ProductYearMonth : Text
	
	Begin SQL
		SELECT Product.Name, YEAR(SaleDate), MONTH(SaleDate), SUM(SalePriceTotal)
		FROM Sales
		JOIN Product
		ON Sales.ProductPK = Product.PK
		GROUP BY 1, 2, 3
		INTO :$productNames, :$years, :$months, :$totals
	End SQL
	
	//aggregate the results
	$result:=New object:C1471
	For ($i; 1; Size of array:C274($years))
		$ProductYearMonth:=$productNames{$i}+";"+String:C10($years{$i})+"-"+String:C10($months{$i})
		If (Not:C34(OB Is defined:C1231($result; $ProductYearMonth)))
			$result[$ProductYearMonth]:=$totals{$i}
		Else 
			$result[$ProductYearMonth]+=$totals{$i}
		End if 
	End for 
	
Function getSalesAndQuantityPerProductPerYear()->$result : Object
	
	ARRAY TEXT:C222($productNames; 0)
	ARRAY LONGINT:C221($quantities; 0)
	ARRAY INTEGER:C220($years; 0)
	ARRAY REAL:C219($totals; 0)
	
	Begin SQL
		SELECT Product.Name, Year(SaleDate), Sum(Quantity), Sum(SalePriceTotal)
		FROM Sales
		JOIN Product
		ON Sales.ProductPK = Product.PK
		GROUP BY 1, 2
		INTO :$productNames, :$years, :$quantities, :$totals
	End SQL
	
	//aggregate results
	$result:=New object:C1471
	var $productNameYear : Text
	For ($i; 1; Size of array:C274($productNames))
		$productNameYear:=$productNames{$i}+";"+String:C10($years{$i})
		If (Not:C34(OB Is defined:C1231($result; $productNameYear)))
			$result[$productNameYear]:=New object:C1471(\
				"quantity"; $quantities{$i}; \
				"totals"; $totals{$i}\
				)
		Else 
			$result[$productNameYear].quantity+=$quantities{$i}
			$result[$productNameYear].totals+=$totals{$i}
		End if 
	End for 
	
	