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
			<li class="current"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=app'; ?>">已安装</a></li>
			<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=app&a=install'; ?>">本地安装</a></li>
			<?php  if(Wekit::load('APPCENTER:service.srv.PwDebugApplication')->inDevMode1()){ ?>
			<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=develop'; ?>">开发助手</a></li>
			<?php  } ?>
		</ul>
	</div>
<?php if($count==0 && !isset($search)){ ?>
	<div class="tips_light">您还没有已安装的应用</div>
<?php }else{ ?>
	<div class="mb10 cc">
	<form action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=appcenter&c=app&a=search'; ?>" method="POST">
		<span class="fl mr20">
			<input type="text" class="input length_4 mr5" value="<?php echo htmlspecialchars($keyword, ENT_QUOTES, 'UTF-8');?>" name="keyword">
			<button class="btn btn_submit" type="submit">查找</button>
		</span>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
		<span class="fl" style="padding-top:4px;">共<span class="b org"><?php echo htmlspecialchars($count, ENT_QUOTES, 'UTF-8');?></span>个应用</span>
	</div>
	<div class="table_list">
	<table width="100%">
		<colgroup>
			<col width="90">
			<col width="350">
			<col width="120">
		</colgroup>
		<thead>
			<tr>
				<td>应用图标</td>
				<td>应用介绍</td>
       	<td>最后更新</td>
				<td>操作</td>
			</tr>
		</thead>
<?php  
$app_ids = array();
foreach ($apps as $k => $app) { 
if(strpos($app['logo'], '://') === false){
$app['logo'] = Wekit::url()->extres . '/' . $app['alias'] . '/' . $app['logo'];
}
?>
			<tr>
				<td><div class="app_icon"><b></b><img src="<?php echo htmlspecialchars($app['logo'], ENT_QUOTES, 'UTF-8');?>" onerror="this.onerror=null;this.src='<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/admin/yy.png'" alt="<?php echo htmlspecialchars($app['name'], ENT_QUOTES, 'UTF-8');?>" width="80" height="80"></div></td>
				<td valign="top">
					<?php  if($app['status'] & 1){ ?>
						<h3 class="mb5 f12"><a target="_blank" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=app&app=', rawurlencode($app['alias']); ?>"><?php echo htmlspecialchars($app['name'], ENT_QUOTES, 'UTF-8');?></a></h3>
					<?php  }else{ ?>
						<h3 class="mb5 f12"><?php echo htmlspecialchars($app['name'], ENT_QUOTES, 'UTF-8');?></h3>
					<?php  } ?>
					<div class="mb5">
						<span class="mr15">版本：V<?php echo htmlspecialchars($app['version'], ENT_QUOTES, 'UTF-8');?></span>
						<span>开发者：<?php echo htmlspecialchars($app['author_name'] ? $app['author_name'] : '匿名', ENT_QUOTES, 'UTF-8');?></span>
					</div>
					<div class="gray"><?php echo htmlspecialchars($app['description'] ? $app['description'] : '这家伙很懒', ENT_QUOTES, 'UTF-8');?></div>
					<div>
						<span class="mr20"><a href="<?php echo htmlspecialchars($app['website'], ENT_QUOTES, 'UTF-8');?>" target="_blank"><?php echo htmlspecialchars($app['website'], ENT_QUOTES, 'UTF-8');?></a></span>
						<?php  if($app['app_id'][0] !== 'L'){ $app_ids[] = $app['app_id']; } ?>
					</div>
				</td>
				<td><span><?php echo htmlspecialchars(Pw::time2str($app['created_time']), ENT_QUOTES, 'UTF-8');?></span></td>
				<td>
				<?php  if($app['status'] & 2){ ?>
				<a id="app_set_<?php echo htmlspecialchars($app['app_id'], ENT_QUOTES, 'UTF-8');?>" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?app=', rawurlencode($app['alias']),'&m=app&c=manage'; ?>" class="btn btn_submit btn_big mr5">设置</a>
				<?php  }elseif($app['app_id'][0] !== 'L'){ ?>
				<a id="app_set_<?php echo htmlspecialchars($app['app_id'], ENT_QUOTES, 'UTF-8');?>" href="<?php echo htmlspecialchars($app['admin_url'], ENT_QUOTES, 'UTF-8');?>" style="display:none" class="btn btn_submit btn_big mr5">设置</a>
				<?php  }else{ ?>
				<button title="无需设置" class="btn btn_submit btn_big mr5 disabled" style="margin:0;" disabled>设置</button><?php  } ?><button data-act="卸载" data-msg="卸载将清除所有数据，确定要卸载吗？" data-action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?app_id=', rawurlencode($app['app_id']),'&m=appcenter&c=app&a=uninstall'; ?>" class="J_ajax_upgrade btn_big btn">卸载</button>
				<button data-act="升级" data-msg="确定要升级吗？升级将覆盖当前应用" id="app_update_<?php echo htmlspecialchars($app['app_id'], ENT_QUOTES, 'UTF-8');?>" data-action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?app_id=', rawurlencode($app['app_id']),'&m=appcenter&c=app&a=upgrade'; ?>" class="J_ajax_upgrade btn btn_big btn_error" style="display:none">升级</button>
				<?php  if($app['status'] & 4 && Wekit::load('APPCENTER:service.srv.PwDebugApplication')->inDevMode1()){ ?>
				<div><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?alias=', rawurlencode($app['alias']),'&m=appcenter&c=develop&a=edit'; ?>" class="btn btn_big mr5">设计</a>
				<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?alias=', rawurlencode($app['alias']),'&m=appcenter&c=app&a=export'; ?>" class="btn btn_big">导出</a></div>
				<?php  } ?>
				</td>
			</tr>
<?php  } ?>
		</table>
	</div>
	<?php  if(isset($search)) { 
 $__tplPageCount=(int)$count;
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
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?keyword=', rawurlencode($keyword),'&page=', rawurlencode($_page_i),'&m=appcenter&c=app&a=search'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?keyword=', rawurlencode($keyword),'&page=', rawurlencode($_page_i),'&m=appcenter&c=app&a=search'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?keyword=', rawurlencode($keyword),'&page=', rawurlencode($_page_i),'&m=appcenter&c=app&a=search'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?keyword=', rawurlencode($keyword),'&page=', rawurlencode($_page_i),'&m=appcenter&c=app&a=search'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?keyword=', rawurlencode($keyword),'&page=', rawurlencode($_page_i),'&m=appcenter&c=app&a=search'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?keyword=', rawurlencode($keyword),'&page=', rawurlencode($_page_i),'&m=appcenter&c=app&a=search'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } 
  }else{ 
 $__tplPageCount=(int)$count;
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
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=appcenter&c=app'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=appcenter&c=app'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=appcenter&c=app'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=appcenter&c=app'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=appcenter&c=app'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?page=', rawurlencode($_page_i),'&m=appcenter&c=app'; 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } 
  } 
 }?>


</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
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
        		if(v.admin_url) {
        			$('#app_set_'+k).show();
        			$('#app_set_'+k).attr('href', v.admin_url.replace(/&amp;/g, '&')); //0531版本后台云搜索、广告管家无法使用的解决办法 http://www.phpwind.net/read/3027660 by taishici
        		}
        		v.update_url && $('#app_update_'+k).show();
        		v.open_new && $('#app_set_'+k).attr('target', '_blank');
        	});
        },
        error: function () {
        }
    });
}
Wind.use('dialog',function() {
	
	$('.J_ajax_upgrade').on('click',function(e) {
		e.preventDefault();
		var $this = $(this), url = $this.data('action'), msg = $this.data('msg'), act = $this.data('act');
		var params = {
				message	: msg,
				type	: 'confirm',
				isMask	: false,
				follow	: $(this),//跟随触发事件的元素显示
				onOk	: function() {
					$.ajax({
				        url: url,
				        type: "GET",
				        dataType: "JSON",
				        beforeSend: function ( xhr ) {
				        	$this.text('正在' + act + '。。。').prop('disabled',true).addClass('disabled tips_loading');
				        },
				        success: function(data) {
				        	$this.removeClass('disabled tips_loading').text(act).removeProp('disabled');
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
</body>
</html>
