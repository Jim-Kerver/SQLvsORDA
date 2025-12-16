//%attributes = {"invisible":true}
// RandomBetween (minValue : Integer; maxValue : Integer) -> Integer
#DECLARE($minValue : Integer; $maxValue : Integer)->$result : Integer
ASSERT:C1129($minValue<$maxValue; "Hey, you did it wrong!")

// Random(n) returns integer from 0..n
// So Random(range) + low gives desired result
$result:=(Random:C100%($maxValue-$minValue+1))+$minValue