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
<!--默认风格列表-->
	<div class="nav">
		<ul class="cc">
			<?php  foreach($addons as $key => $value){ ?>
			<li class="<?php echo htmlspecialchars(Pw::isCurrent($key==$type), ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?type=', rawurlencode($key),'&m=appcenter&c=style'; ?>"><?php echo htmlspecialchars($value[0], ENT_QUOTES, 'UTF-8');?></a></li>
			<?php  } ?>
			<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=style&a=install'; ?>">本地安装</a></li>
			<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=style&a=manage'; ?>">界面管理</a></li>
			<?php  if(Wekit::load('APPCENTER:service.srv.PwDebugApplication')->inDevMode1()){ ?>
			<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=style&a=generate'; ?>">开发助手</a></li>
			<?php  } ?>
		</ul>
	</div>
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ul>
			<li>整站模板：只能默认选择一套。</li>
			<li>个人空间：安装后前台全部展示，具体显示靠用户选择。</li>
			<li>版块模板：安装后，需要到 <span class="org">论坛->版块管理->编辑->版块风格</span> 选择性展示。</li>
			<li>门户模板：需要到 <span class="org">门户->页面管理->创建自定义页面</span>，然后通过页面模块管理，设置模板</li>
		</ul>
	</div>
	<div id="J_style_tip" style="display:none;" class="tips_light">发现新风格，<a id="J_scan" href="">安装</a></div>
	<div class="mb10 cc">共 <span class="org"><?php echo htmlspecialchars($count, ENT_QUOTES, 'UTF-8');?></span> 套模板</div>
	
	<div class="design_page">
		<ul class="cc">
		<?php 
		$app_ids = array();
		foreach($styles as $id => $v){?>
			<li>
			<?php 
			$logo = $v['logo'];
			if($logo && (strpos($logo,'http://')===false)) {
				$args = array(Wekit::url()->themes, $addons[$type][1], $v['alias'], $logo);
				$logo = implode('/', $args);
			}
			?>
				<div class="img"><img src="<?php echo htmlspecialchars($logo, ENT_QUOTES, 'UTF-8');?>" width="210" height="160" lt="<?php echo htmlspecialchars($v['alias'], ENT_QUOTES, 'UTF-8');?>"></div>
				<div class="title" title="<?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?></div>
				<div class="descrip" title="<?php echo htmlspecialchars($v['description'], ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($v['description'] ? $v['description'] : '这家伙很懒', ENT_QUOTES, 'UTF-8');?></div>
				<div class="type"><span class="version">风格版本:<?php echo htmlspecialchars($v['version'], ENT_QUOTES, 'UTF-8');?></span>
				<span class="author">作者：
				<?php  if($v['website']){ ?>
				<a href="<?php echo htmlspecialchars($v['website'], ENT_QUOTES, 'UTF-8');?>" target="_blank"><?php echo htmlspecialchars($v['author_name'] ? $v['author_name'] : '请叫我雷锋', ENT_QUOTES, 'UTF-8');?></a>
				<?php  }else{ 
 echo htmlspecialchars($v['author_name'] ? $v['author_name'] : '请叫我雷锋', ENT_QUOTES, 'UTF-8');
  } ?>
				</span></div>
				<?php  if($v['app_id'][0] !== 'L') { $app_ids[] = $v['app_id']; }?>
				<div class="ft">
					<?php  if($type != 'forum' && $type != 'portal'){ 
  if($v['iscurrent'] == 1){ ?>
					<span class="org">默认模板</span>
					<?php  }else{ ?>
					<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=style&a=default'; ?>" class="J_ajax_refresh" data-pdata="{'styleid': '<?php echo htmlspecialchars($id, ENT_QUOTES, 'UTF-8');?>'}">设为默认</a><a data-msg="确定要卸载吗？" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=style&a=uninstall'; ?>" class="J_ajax_del" data-pdata="{'styleid': '<?php echo htmlspecialchars($id, ENT_QUOTES, 'UTF-8');?>'}">卸载</a>
					<?php  }if($type == 'site'){ ?>
					<!-- <a target="_blank" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?styleid=', rawurlencode($id),'&m=appcenter&c=style&a=preview'; ?>">预览</a> -->
					<?php  }} else { ?>
					<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=style&a=uninstall'; ?>" class="J_ajax_del" data-pdata="{'styleid': '<?php echo htmlspecialchars($id, ENT_QUOTES, 'UTF-8');?>'}">卸载</a>
					<?php  } if(Wekit::C('site', 'debug') && $type != 'portal'){ ?>
					<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?type=', rawurlencode($type),'&alias=', rawurlencode($v['alias']),'&m=appcenter&c=style&a=export'; ?>">导出</a>
					<?php  } ?>
					<a id="app_update_<?php echo htmlspecialchars($v['app_id'], ENT_QUOTES, 'UTF-8');?>" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?app_id=', rawurlencode($v['app_id']),'&m=appcenter&c=app&a=upgrade'; ?>" class="J_ajax_upgrade" data-msg="确定要升级吗？升级将覆盖原先应用" style="display:none">升级</a>
				</div>
			</li>
			<?php }?>
		</ul>
	</div>
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
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?type=', rawurlencode($type),'&page=', rawurlencode($_page_i),'&m=appcenter&c=style'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?type=', rawurlencode($type),'&page=', rawurlencode($_page_i),'&m=appcenter&c=style'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?type=', rawurlencode($type),'&page=', rawurlencode($_page_i),'&m=appcenter&c=style'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?type=', rawurlencode($type),'&page=', rawurlencode($_page_i),'&m=appcenter&c=style'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?type=', rawurlencode($type),'&page=', rawurlencode($_page_i),'&m=appcenter&c=style'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?type=', rawurlencode($type),'&page=', rawurlencode($_page_i),'&m=appcenter&c=style'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
</body>
<script>
var url = '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=app&a=refresh'; ?>',
app_ids = '<?php echo htmlspecialchars(implode(",", $app_ids), ENT_QUOTES, 'UTF-8');?>';
if(app_ids) {
	$.ajax({
        url: url,
        data: {app_ids : app_ids},
        type: "POST",
        dataType: "json",
        success: function (data) {
        	$.each(data.data, function(k,v){
        		v.update_url && $('#app_update_'+k).show();
        	});
        },
        error: function () {
        }
    });
}
Wind.use('dialog',function() {
	
	$('.J_ajax_upgrade').on('click',function(e) {
		e.preventDefault();
		var $this = $(this), url = $this.attr('href');
		var params = {
				message	: '确定要升级吗？升级将覆盖当前应用',
				type	: 'confirm',
				isMask	: false,
				follow	: $(this),//跟随触发事件的元素显示
				onOk	: function() {
					$.ajax({
				        url: url,
				        type: "GET",
				        dataType: "JSON",
				        beforeSend: function ( xhr ) {
				        	$this.text('正在升级。。。').prop('disabled',true).addClass('disabled tips_loading');
				        },
				        success: function(data) {
				        	$this.removeClass('disabled tips_loading').text('升级').removeProp('disabled');
				        	if(data.state === 'success') {
								if(data.referer) {
									location.href = decodeURIComponent(data.referer);
								}else {
									reloadPage(window);
								}
							}else if( data.state === 'fail' ) {
								Wind.dialog.alert(data.message);
							}
				        }
				    });
				}
			};
			Wind.dialog(params); 
		
	});
	
});
</script>
</html>