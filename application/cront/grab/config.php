<?php

$_root='http://www.ed2kers.com/';
//
$catelistPattern='#<li><a title=".+" href="(.+)"><span>(.+)</span></a></li>#Uis';
$subcatelistPattern='#<li><a href="(.+)">(.+)</a></li>#U';
$listPattern='#<a target="_blank" href="/(.+)\.html">(.+)</a>\s+</li>\s+<li>\s+<b>发布:</b>(.+)<br />\s+<b>更新:</b>(.+)\s+<li>\s+</ul>#Ums';
$pagesizePattern='#<div class="pagelist"><span class="pageinfo"> \d+ 条记录 1/(\d+) 页 \s*&nbsp;#Us';
//
$bookimg='#<div class="litimg fLeft">\s*<img alt="[^"]+" src="([^"]+)" style="width:128px;height:128px" />\s*</div>#Us';
//
$bookdownPattern='#<table id="ed2k">(.+)</table>#Us';
//
$bookdesPattern='#<div class="destext">\s*<table>(.+)</table>\s*</div>#Us';
//
$strreplace=array(
array('from'=>'http://hi.baidu.com/ed2kers/item/4fd50d532f2c8d30aaf6d72d','to'=>'/aboutus/serverlist'),
array('from'=>'http://hi.baidu.com/ed2kers/item/5af6243b27e7a7e32e8ec22f','to'=>'/aboutus/connectsrv'),
array('from'=>'http://hi.baidu.com/ed2kers/item/4b66a3c6b8b679f796445257','to'=>'/aboutus/connectkad')
);
//
$pregreplace=array(
array('from'=>'##','to'=>'')
);


?>
