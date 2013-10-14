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
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ol>
			<li>计划任务是一项使系统在规定时间自动执行某些特定任务的功能。</li>
			<li>合理设置执行时间，能有效地为服务器减轻负担。</li>
			<li>对于如“期限头衔自动回收”此类需每天更新的计划任务建议不设置月和周的更新时间，否则对于购买一或几天的头衔的用户可能在一周或者一月内都无法回收头衔。</li>
			<li>触发任务除系统指定的时间外，用户行为也可触发。触发任务的任务周期只是初始值。</li>
		</ol>
	</div>
	<div class="cc mb10">
		<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=cron&c=cron&a=add'; ?>" class="btn"><span class="add"></span>添加计划</a>
		<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=cron&c=cron&a=import'; ?>" class="btn J_cron_back fr">恢复系统计划任务</a>
	</div>
	<div class="table_list">
		<table width="100%">
			<thead>
				<tr>
					<td>计划标题</td>
					<td>任务周期</td>
					<td>任务状态</td>
					<td>上次执行时间</td>
					<td>下次执行时间</td>
					<td>操作</td>
				</tr>
			</thead>
		<?php  
			foreach ($list as $cron){
			$modified = $cron['modified_time'] ? Pw::time2str($cron['modified_time']) : '-';
			$next = $cron['next_time'] ? Pw::time2str($cron['next_time']) : '-';
		?>
			<tr>
				<td><?php echo htmlspecialchars($cron['subject'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($cron['type'], ENT_QUOTES, 'UTF-8');?></td>
				<td><?php  if ($cron['isopen']) {?> 开启 <?php  }else{?> 关闭<?php }?></td>
				<td><?php echo htmlspecialchars($modified, ENT_QUOTES, 'UTF-8');?></td>
				<td><?php echo htmlspecialchars($next, ENT_QUOTES, 'UTF-8');?></td>
				<td><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?id=', rawurlencode($cron['cron_id']),'&m=cron&c=cron&a=edit'; ?>" class="mr5">[编辑]</a>
				<?php  if ($cron['isopen'] !=2){ ?>
				<a class="J_ajax_del" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=cron&c=cron&a=dodelete'; ?>" data-pdata="{'id': '<?php echo htmlspecialchars($cron['cron_id'], ENT_QUOTES, 'UTF-8');?>'}">[删除]</a></td>
				<?php  } ?>
			</tr>
		<?php  
			}
		?>
		</table>
	</div>
	
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
$(function(){
	$('#J_time_select').on('change', function(){
		$('#J_time_'+ $(this).val()).show().siblings('.J_time_item').hide();
	});

	var lock = false;
	$('a.J_cron_back').on('click', function(e){
		e.preventDefault();
		var $this = $(this);
		if(lock) {
			return false;
		}
		lock = true;

		$.post(this.href, function(data) {
			lock = false;
			if(data.state === 'success') {
				$( '<span class="tips_success fr">' + data.message + '</span>' ).insertAfter($this).fadeIn( 'fast' );
				reloadPage(window);
			}else if( data.state === 'fail' ) {
				Wind.dialog.alert(data.message);
			}
		}, 'json');
	});
});
</script>
</body>
</html>