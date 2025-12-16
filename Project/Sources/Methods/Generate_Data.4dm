//%attributes = {}
//remove all data
ds:C1482.Sales.all().drop()
ds:C1482.Customer.all().drop()
ds:C1482.Product.all().drop()

//generate data
Generate_Customers
Generate_Products
Generate_Sales(1000000)