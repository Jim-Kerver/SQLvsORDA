//%attributes = {"invisible":true}
var $customer : cs:C1710.CustomerEntity
var $file : 4D:C1709.File
var $fileHandle : 4D:C1709.FileHandle
var $customerName : Text
$file:=File:C1566("/RESOURCES/CustomerNames.txt")
$fileHandle:=$file.open("read")

$customerName:=$fileHandle.readLine()
While (Not:C34($fileHandle.eof))
	$customer:=ds:C1482.Customer.new()
	$customer.Name:=$customerName
	$customer.save()
	
	$customerName:=$fileHandle.readLine()
End while 