var $ORDA : cs:C1710.ORDA
var $SQL : cs:C1710.SQL
var $graph : cs:C1710.Chart.Plotly
var $graphDataset : cs:C1710.Chart.PlotlyDataset
var $dataORDA; $dataSQL : Object

$ORDA:=cs:C1710.ORDA.new()
$SQL:=cs:C1710.SQL.new()

//MARK: ORDA
Form:C1466.Time1:=Milliseconds:C459
$dataORDA:=$ORDA.getSalesAndQuantityPerProductPerYear()

var $values : Collection
$values:=OB Values:C1718($dataORDA)

//convert data into graph
$graph:=cs:C1710.Chart.Plotly.new()
$graph.setTitle("Total sales value per product per month ORDA")
$graph.setXAxisTitle("Product;Year-Month")
$graph.setYAxisTitle("$Sold")


$graphDataset:=cs:C1710.Chart.PlotlyDataset.new()
$graphDataset.name:="sales Totals"
$graphDataset.x:=OB Keys:C1719($dataORDA)
$graphDataset.y:=$values.extract("totals")
$graphDataset.type:="bar"
$graph.data.push($graphDataset)

$graphDataset:=cs:C1710.Chart.PlotlyDataset.new()
$graphDataset.name:="Quantity"
$graphDataset.x:=OB Keys:C1719($dataORDA)
$graphDataset.y:=$values.extract("quantity")
$graphDataset.type:="bar"
$graph.data.push($graphDataset)

Form:C1466.Time1:=Milliseconds:C459-Form:C1466.Time1
$graph.drawChart(OBJECT Get pointer:C1124(Object named:K67:5; "ORDA"))

//MARK: SQL
Form:C1466.Time2:=Milliseconds:C459
$dataSQL:=$SQL.getSalesAndQuantityPerProductPerYear()
$values:=OB Values:C1718($dataSQL)

//convert data into graph
$graph.setTitle("Total sales value per product per month SQL")

$graphDataset:=cs:C1710.Chart.PlotlyDataset.new()
$graphDataset.name:="sales Totals"
$graphDataset.x:=OB Keys:C1719($dataSQL)
$graphDataset.y:=$values.extract("totals")
$graphDataset.type:="bar"
$graph.data:=New collection:C1472($graphDataset)


$graphDataset:=cs:C1710.Chart.PlotlyDataset.new()
$graphDataset.name:="Quantity"
$graphDataset.x:=OB Keys:C1719($dataSQL)
$graphDataset.y:=$values.extract("quantity")
$graphDataset.type:="bar"
$graph.data.push($graphDataset)

Form:C1466.Time2:=Milliseconds:C459-Form:C1466.Time2
$graph.drawChart(OBJECT Get pointer:C1124(Object named:K67:5; "SQL"))