//%attributes = {"invisible":true}
#DECLARE($NrOfRecords : Integer)
var $customers : cs:C1710.CustomerSelection
var $products : cs:C1710.ProductSelection
var $sale : cs:C1710.SalesEntity

$products:=ds:C1482.Product.all()
$customers:=ds:C1482.Customer.all()
$status:=New collection:C1472("New"; "Confirmed"; "Pending"; "Finished")
For ($i; 1; $NrOfRecords)
	$sale:=ds:C1482.Sales.new()
	$sale.product:=$products[RandomBetween(0; ($products.length-1))]
	$sale.customer:=$customers[RandomBetween(0; ($customers.length-1))]
	$sale.Quantity:=RandomBetween(1; 255)
	$sale.SalePriceTotal:=$sale.Quantity*$sale.product.Price
	$sale.SaleDate:=RandomDate(!2024-01-01!; !2025-12-31!)
	$sale.Status:=$status[RandomBetween(0; ($status.length-1))]
	$sale.save()
End for 