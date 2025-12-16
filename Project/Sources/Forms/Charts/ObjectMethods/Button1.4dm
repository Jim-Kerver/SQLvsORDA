//compare 2 SQL methods
//method 1: GROUP BY YEAR(SaleDate)
//method 2: GROUP BY SaleDate and then aggregate the resulting arrays
var $SQL : cs:C1710.SQL
var $graph : cs:C1710.Chart.Plotly
var $graphDataset : cs:C1710.Chart.PlotlyDataset
var $dataSQL; $dataSQL2 : Object

$SQL:=cs:C1710.SQL.new()

//MARK: SQL proper group by year
Form:C1466.Time1:=Milliseconds:C459
$dataSQL:=$SQL.getYearlyTotals()

//convert data into graph
$graph:=cs:C1710.Chart.Plotly.new()
$graph.setTitle("Total sales value per year SQL (GROUP BY YEAR(SaleDate))")
$graph.setXAxisTitle("Year")
$graph.setYAxisTitle("$Sold")

$graphDataset:=cs:C1710.Chart.PlotlyDataset.new()
$graphDataset.x:=$dataSQL.years
$graphDataset.y:=$dataSQL.totals
$graphDataset.type:="bar"
$graph.data.push($graphDataset)
Form:C1466.Time1:=Milliseconds:C459-Form:C1466.Time1
$graph.drawChart(OBJECT Get pointer:C1124(Object named:K67:5; "ORDA"))


//MARK: SQL, aggregate by date, then aggregate arrays by year
Form:C1466.Time2:=Milliseconds:C459
$dataSQL2:=$SQL.getYearlyTotals2()

//convert data into graph (reuse existing $graph class instance)
$graph.setTitle("Total sales value per year (GROUP BY SaleDate and aggregate)")

$graphDataset.x:=OB Keys:C1719($dataSQL2)
$graphDataset.y:=OB Values:C1718($dataSQL2)
$graph.data:=New collection:C1472($graphDataset)
Form:C1466.Time2:=Milliseconds:C459-Form:C1466.Time2
$graph.drawChart(OBJECT Get pointer:C1124(Object named:K67:5; "SQL"))