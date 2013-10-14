<!doctype html>
<html>
<head>
<meta charset="<?php echo htmlspecialchars(Wekit::V('charset'), ENT_QUOTES, 'UTF-8');?>">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title><?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','c','name'), ENT_QUOTES, 'UTF-8');?></title>
<link href="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','css'), ENT_QUOTES, 'UTF-8');?>/admin_style.css?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
<script>
//全局变量，是Global Variables不是Gay Video喔
var GV = {
	JS_ROOT : "<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','res'), ENT_QUOTES, 'UTF-8');?>/js/dev/",																									//js目录
	JS_VERSION : "<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>",																										//js版本号
	TOKEN : '<?php echo htmlspecialchars(Wind::getComponent('windToken')->saveToken('csrf_token'), ENT_QUOTES, 'UTF-8');?>',	//token ajax全局
	REGION_CONFIG : {},
	SCHOOL_CONFIG : {},
	URL : {
		LOGIN : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','loginUrl'), ENT_QUOTES, 'UTF-8');?>',																													//后台登录地址
		IMAGE_RES: '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>',																										//图片目录
		REGION : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=misc&c=webData&a=area'; ?>',					//地区
		SCHOOL : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=misc&c=webData&a=school'; ?>'				//学校
	}
};
</script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/wind.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/jquery.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>

</head>
<body>
<div class="wrap">

	<div class="nav">
		<ul class="cc">
			<li class="current"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=log&c=manage'; ?>">前台日志</a></li>
			<li class=""><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=log&c=adminlog'; ?>">后台日志</a></li>
			<li class=""><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=log&c=loginlog'; ?>">用户登录日志</a></li>
		</ul>
	</div>
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ol>
			<li>为了保证后台的安全性，系统只允许站点创始人删除日志</li>
			<li>只允许删除3个月前的日志</li>
		</ol>
	</div>
	<div class="h_a">搜索</div>
	<div class="search_type cc mb10">
		<form action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=log&c=manage'; ?>" method="post">
		<div class="ul_wrap">
			<ul class="cc">
				<li>
					<label>操作对象：</label><input type="text" class="input length_3" value="<?php echo htmlspecialchars($searchData['operated_user'], ENT_QUOTES, 'UTF-8');?>" name="operated_user">
				</li>
				<li>
					<label>操作者：</label><input type="text" class="input length_3" value="<?php echo htmlspecialchars($searchData['created_user'], ENT_QUOTES, 'UTF-8');?>" name="created_user">
				</li>
				<li>
					<label>操作描述：</label><input type="text" class="input length_3" value="<?php echo htmlspecialchars($searchData['keywords'], ENT_QUOTES, 'UTF-8');?>" name="keywords">
				</li>
				<li>
					<label>操作类型：</label><select name="typeid" class="select_3">
						<option value="" <?php echo htmlspecialchars(Pw::isSelected(!$searchData['typeid']), ENT_QUOTES, 'UTF-8');?>>全部</option>
					<?php foreach ($typeids as $_type => $_typeid) {?>
						<option value="<?php echo htmlspecialchars($_typeid, ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($_typeid == $searchData['typeid']), ENT_QUOTES, 'UTF-8');?>><?php echo htmlspecialchars($typeTitles[$_type], ENT_QUOTES, 'UTF-8');?></option>
					<?php }?>
					</select>
				</li>
				<li>
					<label>所属版块：</label><select name="fid" class="select_3">
						<option value="">所有版块</option>
					<?php  foreach($catedb as $cate) {?>
						<optgroup label=">><?php echo htmlspecialchars($cate['name'], ENT_QUOTES, 'UTF-8');?>">
						<?php  if ($forumList[$cate['fid']]) {
							foreach ($forumList[$cate['fid']] as $forum) { ?>
									<option value="<?php echo htmlspecialchars($forum['fid'], ENT_QUOTES, 'UTF-8');?>" <?php echo htmlspecialchars(Pw::isSelected($forum['fid'] == $searchData['fid']), ENT_QUOTES, 'UTF-8');?>><?php echo $forum['level'];?>|--<?php echo htmlspecialchars($forum['name'], ENT_QUOTES, 'UTF-8');?></option>						<?php }}?>
						</optgroup>
					<?php }?>
					</select>
				</li>
				<li>
					<label>IP地址：</label><input type="text" class="input length_3" name="ip" value="<?php echo htmlspecialchars($searchData['ip'], ENT_QUOTES, 'UTF-8');?>">
				</li>
				<li>
					<label>操作时间：</label><input class="input length_2 mr5 J_date" type="text" name="start_time" value="<?php echo htmlspecialchars($searchData['start_time'], ENT_QUOTES, 'UTF-8');?>"><span class="mr5">至</span><input class="input length_2 J_date" type="text" name="end_time" value="<?php echo htmlspecialchars($searchData['end_time'], ENT_QUOTES, 'UTF-8');?>">
				</li>
			</ul>
		</div>
		<div class="btn_side">
			<button class="btn btn_submit" type="submit">搜索</button>
		</div>
		<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	</div>
	
	<div class="table_list">
		<table width="100%">
			<thead>
				<tr>
					<td width="80">操作类型</td>
					<td width="90">操作者</td>
					<td width="90">操作对象</td>
					<td width="90">所属版块</td>
					<td>操作描述</td>
					<td width="120">操作时间</td>
					<td width="80">IP</td>
				</tr>
			</thead>
	<?php foreach ($list as $key => $_item) {
		$forumN = ($_item['fid']) ? $allForumList[$_item['fid']]['name'] : '----------';
	?>
			<tr>
				<td><?php echo htmlspecialchars($_item['type'], ENT_QUOTES, 'UTF-8');?></td>
				<td><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=space&uid=', rawurlencode($_item['created_userid']); ?>" target="_blank"><?php echo htmlspecialchars($_item['created_username'], ENT_QUOTES, 'UTF-8');?></a></td>
				<td><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=space&uid=', rawurlencode($_item['operated_uid']); ?>" target="_blank"><?php echo htmlspecialchars($_item['operated_username'], ENT_QUOTES, 'UTF-8');?></a></td>
				<td><?php echo strip_tags($forumN);?></td>
				<td><?php echo $_item['content'];?></td>
				<td><?php echo htmlspecialchars(Pw::time2str($_item['created_time'], 'Y-m-d H:i:s'), ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($_item['ip'], ENT_QUOTES, 'UTF-8');?></td>
			</tr>
	<?php }?>
		</table>
		<div class="p10">
			<?php $__tplPageCount=(int)$count;
$__tplPagePer=(int)$perpage;
$__tplPageTotal=(int)0;
$__tplPageCurrent=(int)$page;
if($__tplPageCount > 0 && $__tplPagePer > 0){
$__tmp = ceil($__tplPageCount / $__tplPagePer);
($__tplPageTotal !== 0 &&  $__tplPageTotal < $__tmp) || $__tplPageTotal = $__tmp;}
$__tplPageCurrent > $__tplPageTotal && $__tplPageCurrent = $__tplPageTotal;
if ($__tplPageTotal > 1) {
 
$_page_min = max(1, $__tplPageCurrent-3);
$_page_max = min($__tplPageTotal, $__tplPageCurrent+3);
?>
<div class="pages">
<?php  if ($__tplPageCurrent > $_page_min) { 
	$_page_i = $__tplPageCurrent-1;
?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=log&c=manage'; 
 echo htmlspecialchars($searchData ? '&' . http_build_query($searchData) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=log&c=manage'; 
 echo htmlspecialchars($searchData ? '&' . http_build_query($searchData) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=log&c=manage'; 
 echo htmlspecialchars($searchData ? '&' . http_build_query($searchData) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=log&c=manage'; 
 echo htmlspecialchars($searchData ? '&' . http_build_query($searchData) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=log&c=manage'; 
 echo htmlspecialchars($searchData ? '&' . http_build_query($searchData) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=log&c=manage'; 
 echo htmlspecialchars($searchData ? '&' . http_build_query($searchData) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
		</div>
	</div>
	<?php if ($canClear) {?>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<a class="btn" id="J_clear" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=log&c=manage&a=clear'; ?>">确定清除3个月前日志</a>
		</div>
	</div>
	<?php }?>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</div>
<script>
Wind.use('ajaxForm', 'dialog', function(){
	var clear = $('#J_clear');
	clear.on('click', function(e){
		e.preventDefault();

		Wind.dialog({
			type : 'confirm',
			isMask	: false,
			message : '确认删除？',
			follow	: clear,
			onOk	: function() {
				clear.parent().find('span').remove();

				$.post(clear.attr('href'), {
					step : '2'
				}, function(data){
					if(data.state == 'success') {
						$( '<span class="tips_success">' + data.message + '</span>' ).appendTo(clear.parent()).fadeIn('slow').delay( 1000 ).fadeOut(function(){
							reloadPage(window);
						});
					}else if(data.state == 'fail'){
						$( '<span class="tips_error">' + data.message + '</span>' ).appendTo(clear.parent()).fadeIn( 'fast' );
					}
				}, 'json');
			}
		});
	});
});
</script>
</body>
</html>