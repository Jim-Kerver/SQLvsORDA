//%attributes = {"invisible":true}
var $product : cs:C1710.ProductEntity
var $productNames : Collection
var $productName : Text
$productNames:=New collection:C1472("Screwdriver"; "Hammer"; "Screw"; "Bolt"; "Nut"; "Drill"; "Chainsaw"; "Saw"; "Drill bit set"; "Tool case"; "Allen Key")
For each ($productName; $productNames)
	$product:=ds:C1482.Product.new()
	$product.Name:=$productName
	$product.Price:=Num:C11(String:C10(RandomBetween(0; 20))+"."+String:C10(RandomBetween(1; 99)); ".")
	$product.save()
End for each 