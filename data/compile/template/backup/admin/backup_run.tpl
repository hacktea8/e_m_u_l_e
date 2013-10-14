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
			<li class="current"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=backup&c=backup'; ?>">数据库备份</a></li>
			<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=backup&c=backup&a=restore'; ?>">数据库还原</a></li>
		</ul>
	</div>
	<div class="h_a">功能说明</div>
	<div class="prompt_text">
		<ul>
			<li>推荐使用mysqldump、phpmyadmin、navicat等专业的mysql工具来备份还原。</li>
		</ul>
	</div>
	<div class="h_a">数据表</div>
	<form action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=backup&c=backup&a=doback'; ?>" method="post" class="J_ajaxForm" id="J_backup_form">
	<div class="table_full">
		<table width="100%">
			<col class="th" />
			<tr>
				<th>数据表列表</th>
				<td>
					<div class="sql_list J_check_wrap">
						<dl>
							<dt>
								<span class="span_1"><label><input type="checkbox" class="J_check_all" data-checklist="J_check_x" data-direction="x" checked>全选</label></span>
								<span class="span_2"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=backup&c=backup'; ?>">全部数据表</a> | <a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?system=1&m=backup&c=backup'; ?>">系统数据表（<?php echo htmlspecialchars($count, ENT_QUOTES, 'UTF-8');?>）</a></span>
								<span class="span_3">描述</span>
							</dt>
							<dd>
							<?php  foreach ($tables as $v) { ?>
								<p>
									<span class="span_1"><input type="checkbox" name="tabledb[]" value="<?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?>" class="J_check" data-xid="J_check_x" checked="checked"></span>
									<span class="span_2"><?php echo htmlspecialchars($v['name'], ENT_QUOTES, 'UTF-8');?></span>
									<span class="span_3"><?php echo htmlspecialchars($v['Comment'], ENT_QUOTES, 'UTF-8');?></span>
								</p>
							<?php  } ?>
							</dd>
						</dl>
					</div>
				</td>
			</tr>
		</table>
		<div class="h_a">数据备份选项</div>
		<table width="100%">
			<col class="th" />
			<col width="400" />
			<col />
			<tr>
				<th>数据插入方式</th>
				<td>
					<ul class="single_list cc">
						<li><label class="mr20"><input type="radio" name="insertmethod" value="common" checked>普通方式</label><span class="gray">一条insert语句对应一个记录</span></li>
						<li><label class="mr20"><input type="radio" name="insertmethod" value="extend">扩展插入</label><span class="gray">一条insert语句对应多个记录</span></li>
					</ul>
				</td>
				<td><div class="fun_tips"></div></td>
			</tr>
			<tr>
				<th>分卷备份</th>
				<td>
					<input type="text" class="input length_5 mr5" name="sizelimit" value="2048">KB
				</td>
				<td><div class="fun_tips">每个分卷文件长度（单位：KB）</div></td>
			</tr>
			<tr>
				<th>压缩备份文件</th>
				<td>
					<ul class="switch_list cc">
						<li><label><input type="radio" name="compress" value="1" checked><span>开启</span></label></li>
						<li><label><input type="radio" name="compress" value="0"><span>关闭</span></label></li>
					</ul>
				</td>
				<td><div class="fun_tips">压缩备份文件以减少占用的空间</div></td>
			</tr>
		</table>
	</div>
	<div class="btn_wrap">
		<div class="btn_wrap_pd">
			<button class="btn btn_submit J_ajax_submit_btn" id="J_backup_btn" type="submit">备份</button>
			<button class="btn J_ajax_submit_btn" type="submit" data-action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=backup&c=backup&a=repair'; ?>">修复</button>
			<button class="btn J_ajax_submit_btn" type="submit" data-action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','admin.php?m=backup&c=backup&a=optimize'; ?>">优化</button>
			<span id="J_backup_tip"></span>
		</div>
	</div>
	<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
	
	
</div>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/pages/admin/common/common.js?v<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<script>
Wind.use('dialog', 'ajaxForm', function() { 
	
	/*var btn = $('#J_backup_btn'),	//提交按钮
		message_send_tip = $('#J_backup_tip');*/
	
	/*$('#J_backup_form').ajaxForm( {
		dataType : 'json',
		beforeSubmit : function(arr, $form, options) {
			var text = btn.text();
						
			//按钮文案、状态修改
			btn.text(text +'中...').prop('disabled',true).addClass('disabled');
			
		},
		success : function(data, statusText, xhr, $form) {
			btn.parent().find('span').remove();
			if( data.state === 'fail' ) {
				$( '<span class="tips_error">' + data.message + '</span>' ).insertAfter(btn).fadeIn( 'fast' );
				//btn.removeProp('disabled').removeClass('disabled');
			}else{
				if( data.state === 'success' ) {
					//完成
					$( '<span class="tips_success">' + data.message + '</span>' ).insertAfter(btn).fadeIn('slow').delay( 1000 ).fadeOut(function() {

						if(window.parent.Wind.dialog) {
							reloadPage(window.parent);
						}else {
							reloadPage(window);
						}
							
					});
				}else{
					//队列
					var _data = data.data;
					if(_data.haveBuild <= Number(_data.count)) {
						$('#J_step_input').val(_data.step);
						$('#J_countStep_input').val(_data.countStep);
						message_send_tip.html('共'+ _data.count +'条，已发送'+_data.haveBuild)
						btn.click();
						//console.log(_data.step);
					}
				}
			}
		}
	});*/
});
</script>
</body>
</html>