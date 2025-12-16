If (ds:C1482.Sales.getCount()=0)
	CONFIRM:C162("The database is empty, do you want to generate data? (creating 1 million records, it might take some time...)")
	If (OK=1)
		Generate_Data
	End if 
End if 