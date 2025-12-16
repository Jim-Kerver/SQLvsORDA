//%attributes = {"invisible":true}
//Retuns a random Date between a given range
#DECLARE($startDate : Date; $endDate : Date)->$d : Date

var $days; $offset : Integer

$days:=$endDate-$startDate
$offset:=Random:C100%$days
$d:=$startDate+$offset
