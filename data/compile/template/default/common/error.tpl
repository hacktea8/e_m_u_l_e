<?php if ($refresh) {?>
<meta http-equiv="refresh" content="1; url=<?php echo htmlspecialchars($referer, ENT_QUOTES, 'UTF-8');?>" />
<?php }
 if ($title) {?>
<h2 class="reg_head"><?php echo htmlspecialchars($title, ENT_QUOTES, 'UTF-8');?></h2>
<?php }?>
<div class="reg_cont_wrap">
	<div class="reg_message reg_ignore">
		<ul class="mb10 f14">
			<?php  foreach ($message as $value){
			    if (!is_string($value)) continue;
				if(!WIND_DEBUG)
					$value = str_replace(Wind::getRootPath(Wind::getAppName()), '~/', $value);?>
			<li id="J_html_error"><?php echo htmlspecialchars($value, ENT_QUOTES, 'UTF-8');?></li>
			<?php  } ?>
		</ul>
<?php $url = Wekit::C('site', 'info.url');
  if($referer){ ?>
		<div class="error_return"><a href="<?php echo htmlspecialchars($referer, ENT_QUOTES, 'UTF-8');?>">返回上一页</a> 或者 <a href="<?php if($url){echo $url;} else{
 echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/',''; 
 }?>">回到首页</a></div>
		<?php  }else{ ?>
		<div class="error_return"><a href="javascript:window.history.go(-1);">返回上一页</a> 或者 <a href="<?php if($url){echo $url;} else{
 echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/',''; 
 }?>">回到首页</a></div>
		<?php  } ?>
	</div>
</div>