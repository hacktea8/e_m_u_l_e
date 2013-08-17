<?php

$_root='http://www.ed2kers.com/';
//
$catelistPattern='#<li><a title=".+" href="(.+)"><span>(.+)</span></a></li>#Uis';
$subcatelistPattern='#<li><a href="(.+)">(.+)</a></li>#U';
$listPattern='#<ul>\s+<li class="dtitle" style="display:block;">.+<a target="_blank" href="/(.+)\.html">(.+)</a>\s+</li>\s+<li>\s+<b>摘要:</b>(.+)<br />\s*<b>发布:</b>(\d+-\d+-\d+ \d+:\d+:\d+)<br />\s+<b>更新:</b>(\d+-\d+-\d+ \d+:\d+:\d+)<li>\s+</ul>#Uis';
$listPattern='#<li>\s+<b>发布:</b>([\d-]+ [\d:]+)<br />\s+<b>更新:</b>([\d-]+ [\d:]+)<li>\s*</ul>#Us';
$pagesizePattern='##';



?>
