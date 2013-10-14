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
			<li class="current"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=upgrade'; ?>">版本升级</a></li>
			<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=fixup'; ?>">安全中心</a></li>
		</ul>
	</div>
	<?php  if(isset($connect_fail)){ ?>
	<div class="upgrade_page">
		<div class="not_content_mini">
		<?php  if($connect_fail){ ?>
			<i></i><?php echo htmlspecialchars($connect_fail, ENT_QUOTES, 'UTF-8');
  } else { ?>
			<i></i>无法连接云平台，请尝试申请云服务。或选择手动升级。
		<?php  } ?>
		</div>
	</div>
	<?php  } else { 
  if($result){ ?>
			<div class="table_list">
			<table width="100%">
				<colgroup>
					<col width="260">
					<col width="260">
					<col width="200">
					<col width="200">
				</colgroup>
				<thead>
					<tr>
						<td>升级包名称</td>
						<td>发布时间</td>
						<td>操作</td>
						<td></td>
					</tr>
				</thead>
				<?php  if(isset($result)){ ?>
				<tbody >
					<?php  foreach($result as $v){ ?>
						<tr>
							<td><?php echo htmlspecialchars($v['version'], ENT_QUOTES, 'UTF-8');?></td>
							<td><?php echo htmlspecialchars(Pw::time2str($v['time']), ENT_QUOTES, 'UTF-8');?></td>
							<td><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?version=', rawurlencode($v['version']),'&m=appcenter&c=upgrade&a=select'; ?>" class="btn J_ajax_confirm" data-msg="确定已关闭网站，并建议备份程序和数据库。">立即升级</a></td>
							<td></td>
						</tr>
					<?php  } ?>
				</tbody>
				<?php  } ?>
			</table>
		</div>
		<?php  } else { ?>
		<div class="upgrade_page">
			<div class="not_content_mini"><i class="success"></i>恭喜，您使用的是最新版本！</div>
		</div>
		<?php  } 
  } ?>
	</div>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('dialog',function() {
	
	$('.J_ajax_confirm').on('click',function(e) {
		e.preventDefault();
		var $this = $(this), url = $this.attr('href'), msg = $this.data('msg');
		var params = {
				message	: msg,
				type	: 'confirm',
				isMask	: false,
				follow	: $(this),//跟随触发事件的元素显示
				onOk	: function() {
					window.location.href = url;
				}
			};
			Wind.dialog(params); 
		
	});
	
});
</script>
</body>
</html>
