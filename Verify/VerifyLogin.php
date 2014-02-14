<?php
require_once("YinXiangMaLib.php");
$YinXiangMa_response=YinXiangMa_ValidResult(@$_POST['YinXiangMa_challenge'],@$_POST['YXM_level'][0],@$_POST['YXM_input_result']);
if($YinXiangMa_response == "true") { echo "Yes!";}
else{ echo "No!";}
?>
