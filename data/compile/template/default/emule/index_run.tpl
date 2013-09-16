<!doctype html>
<html>
<head>
<meta charset="<?php echo htmlspecialchars(Wekit::V('charset'), ENT_QUOTES, 'UTF-8');?>" />
<title><?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','seo','title'), ENT_QUOTES, 'UTF-8');?> - <?php echo Wekit::C("site", "info.name"); ?></title>
<meta http-equiv="X-UA-Compatible" content="chrome=1">
<meta name="generator" content="phpwind v<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','version'), ENT_QUOTES, 'UTF-8');?>" />
<meta name="description" content="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','seo','description'), ENT_QUOTES, 'UTF-8');?>" />
<meta name="keywords" content="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','seo','keywords'), ENT_QUOTES, 'UTF-8');?>" />
<link rel="stylesheet" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/css'.Wekit::getGlobal('theme','debug'); ?>/core.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" />
<link rel="stylesheet" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/css'.Wekit::getGlobal('theme','debug'); ?>/style.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" />
<!-- <base id="headbase" href="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','base'), ENT_QUOTES, 'UTF-8');?>/" /> -->
<?php echo Wekit::C('site', 'css.tag');?>
<script>
//全局变量 Global Variables
var GV = {
	JS_ROOT : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','res'), ENT_QUOTES, 'UTF-8');?>/js/dev/',										//js目录
	JS_VERSION : '<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>',											//js版本号(不能带空格)
	JS_EXTRES : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','extres'), ENT_QUOTES, 'UTF-8');?>',
	TOKEN : '<?php echo htmlspecialchars(Wind::getComponent('windToken')->saveToken('csrf_token'), ENT_QUOTES, 'UTF-8');?>',	//token $.ajaxSetup data
	U_CENTER : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=space'; ?>',		//用户空间(参数 : uid)
<?php 
$loginUser = Wekit::getLoginUser();
if ($loginUser->isExists()) {
?>
	//登录后
	U_NAME : '<?php echo htmlspecialchars($loginUser->username, ENT_QUOTES, 'UTF-8');?>',										//登录用户名
	U_AVATAR : '<?php echo htmlspecialchars(Pw::getAvatar($loginUser->uid), ENT_QUOTES, 'UTF-8');?>',							//登录用户头像
<?php 
}
?>
	U_AVATAR_DEF : '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>/face/face_small.jpg',					//默认小头像
	U_ID : parseInt('<?php echo htmlspecialchars($loginUser->uid, ENT_QUOTES, 'UTF-8');?>'),									//uid
	REGION_CONFIG : '',														//地区数据
	CREDIT_REWARD_JUDGE : '<?php echo $loginUser->showCreditNotice();?>',			//是否积分奖励，空值:false, 1:true
	URL : {
		LOGIN : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=u&c=login'; ?>',										//登录地址
		QUICK_LOGIN : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=u&c=login&a=fast'; ?>',								//快速登录
		IMAGE_RES: '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','images'), ENT_QUOTES, 'UTF-8');?>',										//图片目录
		CHECK_IMG : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=u&c=login&a=showverify'; ?>',							//验证码图片url，global.js引用
		VARIFY : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=verify&a=get'; ?>',									//验证码html
		VARIFY_CHECK : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=verify&a=check'; ?>',							//验证码html
		HEAD_MSG : {
			LIST : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=message&c=notice&a=minilist'; ?>'							//头部消息_列表
		},
		USER_CARD : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=space&c=card'; ?>',								//小名片(参数 : uid)
		LIKE_FORWARDING : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=post&a=doreply'; ?>',							//喜欢转发(参数 : fid)
		REGION : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=misc&c=webData&a=area'; ?>',									//地区数据
		SCHOOL : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=misc&c=webData&a=school'; ?>',								//学校数据
		EMOTIONS : "<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emotion&type=bbs'; ?>",					//表情数据
		CRON_AJAX : '<?php echo htmlspecialchars($runCron, ENT_QUOTES, 'UTF-8');?>',											//计划任务 后端输出执行
		FORUM_LIST : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=forum&a=list'; ?>',								//版块列表数据
		CREDIT_REWARD_DATA : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=u&a=showcredit'; ?>',					//积分奖励 数据
		AT_URL: '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=remind'; ?>',									//@好友列表接口
		TOPIC_TYPIC: '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=forum&a=topictype'; ?>'							//主题分类
	}
};
</script>
<script src="<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','js'), ENT_QUOTES, 'UTF-8');?>/wind.js?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<?php
PwHook::display(array(PwSimpleHook::getInstance("head"), "runDo"), array(), "", $__viewer);
?>

<link href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/style.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
<link href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/topbar_0.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
<script type="text/javascript" src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/js'; ?>/jquery-2.0.2.min.js" ></script>
<style>
.aPre{
        cursor:url(<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/common/pre.cur),auto;
}
.aNext{
        cursor:url(<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/common/next.cur),auto;right:0;
}
#index_body #index_body_mainDiv{margin:80px 0 10px}
</style>
</head>
<body>
<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/tip-dig.css" rel="stylesheet">

<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/topbar_0.css" rel="stylesheet">
<div id="index_body">
<?php if ($site_info_notice = Wekit::C('site','info.notice')) {?>
<style>.header_wrap{top:29px;}body{padding-top:75px;}</style><div id="notice"><?php echo htmlspecialchars($site_info_notice, ENT_QUOTES, 'UTF-8');?></div>
<?php }?>
<header class="header_wrap">
	<div id="J_header" class="header cc">
		<div class="logo">
			<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/',''; ?>">
				<?php  if($__css = Wekit::C('site', 'css.logo')) { ?>
				<!--后台logo上传-->
				<img src="<?php echo htmlspecialchars(Pw::getPath($__css), ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars(Wekit::C('site','info.name'), ENT_QUOTES, 'UTF-8');?>">
				<?php  } else { ?>
				<img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/logo.png" alt="<?php echo htmlspecialchars(Wekit::C('site','info.name'), ENT_QUOTES, 'UTF-8');?>">
				<?php  } ?>
			</a>
		</div>
		<nav class="nav_wrap">
			<div class="nav">
				<ul>
	<?php  $nav = Wekit::load('SRV:nav.bo.PwNavBo');
		  $nav->setRouter();
		  $currentId =  '';
		   $main = $child = array();
		  if ($nav->isForum()) $nav->setForum($pwforum->foruminfo['parentid'], $fid, $tid);
		  $main = $nav->getNavFromConfig('main', true);
		  foreach($main as $key=>$value){
			if ($value['current']) {
				$current = 'current';
				$currentId = $key;
			} else {
				$current = '';
			}
			$value['child'] && $child[$key] = $value['child'];
		  ?>
					<li class="<?php echo htmlspecialchars($current, ENT_QUOTES, 'UTF-8');?>"><?php echo $value['name'];?></li>
	<?php  } ?>
				</ul>
			</div>
		</nav>
		<?php
PwHook::display(array(PwSimpleHook::getInstance("header_nav"), "runDo"), array(), "", $__viewer);
?>
		<div class="header_search" role="search">
			<form action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=search&c=s'; ?>" method="post">
				<input type="text" id="s" aria-label="搜索关键词" accesskey="s" placeholder="搜索其实很简单" x-webkit-speech speech name="keyword"/>
				<button type="submit" aria-label="搜索"><span>搜索</span></button>
			<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form>
		</div>
		<?php  if (!$loginUser->isExists()) { ?>
<div class="header_login">
	<?php
PwHook::display(array(PwSimpleHook::getInstance("header_info_3"), "runDo"), array(), "", $__viewer);
?><a rel="nofollow" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=u&c=login'; ?>">登录</a><a rel="nofollow" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=u&c=register'; ?>">注册</a>
</div>
<?php  } else {
	if ($pwforum && $pwforum->isForum()) {
		$_tmpfid = $pwforum->fid;
		$_tmpcid = $pwforum->getCateId();
	} else {
		$_tmpfid = 0;
		$_tmpcid = $pwforum ? $pwforum->getCateId() : '0';
	}
?>
	<a class="header_login_btn" id="J_head_forum_post" role="button" aria-label="快速发帖" aria-haspopup="J_head_forum_pop" href="#" title="快速发帖" tabindex="-1"><span class="inside"><span class="header_post" >发帖</span></span></a>
	<div id="J_head_forum_pop" tabindex="0" class="pop_select_forum" style="display:none;" aria-label="快速发帖菜单,按ESC键关闭菜单">
		<a id="J_head_forum_close" href="#" class="pop_close" role="button">关闭窗口</a>
		<div class="core_arrow_top" style="left:310px;"><em></em><span></span></div>
		<div class="hd">发帖到其他版块</div>
		<div id="J_head_forum_ct" class="ct cc" data-fid="<?php echo htmlspecialchars($_tmpfid, ENT_QUOTES, 'UTF-8');?>" data-cid="<?php echo htmlspecialchars($_tmpcid, ENT_QUOTES, 'UTF-8');?>">
			<div class="pop_loading"></div>
		</div>
		<div class="ft">
			<div class="associate">
				<label class="fr"><input type="checkbox" id="J_head_forum_join" data-url="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=forum&a=join'; ?>">添加到我的版块</label>
				发帖到：<span id="J_post_to_forum"></span>
			</div>
			<div class="tac">
				<button type="button" class="btn btn_submit disabled" disabled="disabled" id="J_head_forum_sub" data-url="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=post'; ?>">确定</button>
			</div>
		</div>
	</div>
	<?php 
		$messageCount = $loginUser->info['notices'] + $loginUser->info['messages'];
		$messageClass = $messageCount ? 'header_message' : 'header_message header_message_none';
	?>
	<a class="header_login_btn" id="J_head_msg_btn" tabindex="0" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=message&c=message'; ?>" aria-haspopup="J_head_msg_pop" aria-label="消息菜单,按pagedown打开菜单,tab键导航,esc键关闭"><span class="inside"><span class="<?php echo htmlspecialchars($messageClass, ENT_QUOTES, 'UTF-8');?>">消息<em class="core_num J_hm_num"><?php echo htmlspecialchars($messageCount, ENT_QUOTES, 'UTF-8');?></em></span></span></a>
	<!--消息下拉菜单-->
	<div id="J_head_msg_pop" tabindex="0" aria-label="消息下拉菜单,按ESC键关闭菜单" class="header_menu_wrap my_message_menu" style="display:none;">
		<div class="header_menu cc">
			<div class="header_menu_hd" id="J_head_pl_hm"><span class="<?php echo htmlspecialchars($messageClass, ENT_QUOTES, 'UTF-8');?> header_message_down">消息<em class="core_num J_hm_num"><?php echo htmlspecialchars($messageCount, ENT_QUOTES, 'UTF-8');?></em></span></div>
			<div id="J_head_msg" class="my_message_content"><div class="pop_loading"></div></div>
		</div>
	</div>
	<div class="header_login_later">
		<?php
PwHook::display(array(PwSimpleHook::getInstance("header_info_1"), "runDo"), array(), "", $__viewer);
?>
		<a aria-haspopup="J_head_user_menu" aria-label="个人功能菜单,按pagedown打开菜单,tab键导航,esc键关闭" tabindex="0" rel="nofollow" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=space&uid=', rawurlencode($loginUser->uid); ?>" id="J_head_user_a" class="username" title="<?php echo htmlspecialchars($loginUser->username, ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars(Pw::substrs($loginUser->username,6), ENT_QUOTES, 'UTF-8');?><em class="core_arrow"></em></a>
		<?php
PwHook::display(array(PwSimpleHook::getInstance("header_info_2"), "runDo"), array(), "", $__viewer);
?>
		<div class="fl">
		<div id="J_head_user_menu" role="menu" class="header_menu_wrap my_menu_wrap" style="display:none;">
			<div class="header_menu my_menu cc">
				<div class="header_menu_hd" id="J_head_pl_user"><span title="<?php echo htmlspecialchars($loginUser->username, ENT_QUOTES, 'UTF-8');?>" class="username"><?php echo htmlspecialchars(Pw::substrs($loginUser->username,6), ENT_QUOTES, 'UTF-8');?></span><em class="core_arrow_up"></em></div>
				<ul class="ct cc">
				<?php  $nav = Wekit::load('SRV:nav.bo.PwNavBo');
					$myNav = $nav->getNavFromConfig('my');
					foreach($myNav as $key=>$value){
				?>
					<li><?php echo $value['name'];?></li>
				<?php  } 
 
				$_url = '';
				$_panelManage = false;
				if ($loginUser->getPermission('panel_bbs_manage')) {
					$_url = 'manage/content/run';
					$_panelManage = true;
				}
				if (!$_panelManage && $loginUser->getPermission('panel_user_manage')) {
					$_url = 'manage/user/run';
					$_panelManage = true;
				}
				if (!$_panelManage && $loginUser->getPermission('panel_report_manage')) {
					$_url = 'manage/report/run';
					$_panelManage = true;
				}
				if (!$_panelManage && $loginUser->getPermission('panel_recycle_manage')) {
					$_url = 'manage/recycle/run';
					$_panelManage = true;
				}
				if ($_panelManage) {
				?>
					<li><a href="<?php echo htmlspecialchars(WindUrlHelper::createUrl($_url), ENT_QUOTES, 'UTF-8');?>" rel="nofollow"><em class="icon_system"></em>前台管理</a></li>
				<?php } if (Pw::getstatus($loginUser->info['status'], PwUser::STATUS_ALLOW_LOGIN_ADMIN) || Pw::inArray(3, $loginUser->groups)) {?>
					<li><a href="<?php echo htmlspecialchars(Wind::getComponent('router')->getRoute('pw')->checkUrl('admin.php'), ENT_QUOTES, 'UTF-8');?>" target="_blank" rel="nofollow"><em class="icon_admin"></em>系统后台</a></li>
				<?php  } ?>
				</ul>
				<ul class="ft cc">
					<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=profile'; ?>"><em class="icon_profile"></em>个人设置</a></li>
					<?php
PwHook::display(array(PwSimpleHook::getInstance("header_my"), "runDo"), array(), "", $__viewer);
?>
					<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=u&c=login&a=logout'; ?>" rel="nofollow"><em class="icon_quit"></em>退出</a></li>
				</ul>
			</div>
		</div>
		</div>
	</div>
	<?php  if ($loginUser->info['message_tone'] > 0 && $messageCount > 0) { ?>
	<audio autoplay="autoplay">
		<source src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/images'; ?>/message/msg.wav" type="audio/wav" />
		<source src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/images'; ?>/message/msg.mp3" type="audio/mp3" />
		<div style='overflow:hidden;width:0;float:left'><embed src='<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/images'; ?>/message/msg.wav' width='0' height='0' AutoStart='true' type='application/x-mplayer2'></embed></div>
	</audio>
	<?php  } 
  } ?>
	</div>
</header>
<?php 
if ($child) {
foreach ($child as $ck => $cv) {
	 if ($currentId == $ck){
?>
	<div class="nav_weak" id="<?php echo htmlspecialchars($ck, ENT_QUOTES, 'UTF-8');?>">
<?php  }else{ ?>
	<div class="nav_weak" id="<?php echo htmlspecialchars($ck, ENT_QUOTES, 'UTF-8');?>" style="display:none">
<?php  } ?>
		<ul class="cc">
			<?php  foreach($cv as $_v){
				$current = $_v['current'] ? 'current' : '';
			?>
			<li class="<?php echo htmlspecialchars($current, ENT_QUOTES, 'UTF-8');?>"><?php echo $_v['name'];?></li>
			<?php  } ?>
		</ul>
	</div>
<?php }} ?>
<div class="tac"> </div>
 <style>
    #nav_div {
    margin: 10px 0 10px 0;
    }
#nav_div a :hover, a:active,a:hover{
        color: black;
        text-decoration: underline;
}
.slide_con a:hover { text-decoration:none; }
#nav_div{
        background: url(http://v4.vcimg.com/global/images/global_bg_1.gif?v=31218) repeat-x 0 -77px;
        height: 32px;
        line-height: 30px;
        line-height: 32px;
        padding: 0 10px;
        overflow: hidden;
}
#nav_div ul{float: left;margin:0px;padding:0px}
#nav_div li{float: left;}
#nav_div .big li a{

        float: left;
        padding: 0 10px;
        font-size: 14px;
        background-image: url(http://v4.vcimg.com/global/images/global_bg_1.gif?v=31218);
        background-repeat: repeat-x;
        background-position: 0 100px;
        height: 32px;
        font-weight: bold;
}
#nav_div .line{
        float:left;
        margin:0 5px;
        border-left: 1px solid #fff;height: 32px;
}
#nav_div .big li a:link,#nav_div .big li a:visited{color:#000;text-decoration:none;}
        #nav_div .big li a:hover,#nav_div .big li a:active {color:#fff;text-decoration:none;background-position: 0 -118px;color: #fff;}
#nav_div .big li a.hover,#nav_div .big li a.hover:link,#nav_div .big li a.hover:visited{background-position: 0 -37px;color: #fff;}
#nav_div .big .korean_active a:hover{background:url(http://v4.vcimg.com/base/images/hanju/bar_hover_bg.jpg) repeat-x;}

#nav_div .small{margin:5px 0;font-size:12px;}
#nav_div .small a{display:block;width:34px;height:22px;line-height:22px;text-align:center;margin:0 2px;}
#nav_div .small a:link,#nav_div .small a:visited{}
#nav_div .small a:hover,#nav_div .small a:active{text-decoration:none;}
#nav_div .small a.on,#nav_div .small a:hover{color:#fff;background:url(http://v4.vcimg.com/global/images/global_img_1.gif) no-repeat -50px 0 #c00;}
#nav_div li a{line-height: 30px;line-height: 32px\9;}
.ul, .ul ul {
list-style-type: none;
}
#nav_div .more{float: right;line-height: 30px;line-height: 32px\9;}
#nav_div .more a{line-height: 30px;line-height: 32px\9;}
#nav_div .small a.four{ width:62px; }
#nav_div .small a.four:hover{ width:62px; color:#fff;background:url(http://v4.vcimg.com/global/images/global_bar_icon4.gif) no-repeat;}
#nav_div .small a.three{width:48px; }
#nav_div .small a.three:hover,#nav_div .small a.active{width:48px;color:#fff;background:url(http://v4.vcimg.com/global/images/global_bar_icon3.gif) no-repeat;}
    </style>

<div class="mainDiv" id="index_body_mainDiv">
	<div id="nav_div" style="">
	<ul id="header_ul_big" class="ul big">
		<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule'; ?>" onclick="">首页</a></li>
<?php  foreach($rootCate as $row){
?>
		<li><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($row['id']); ?>" onclick=""><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php 
} ?>
	</ul>
	<ul class="ul small">
		<li><a href="http://www.verycd.com/sto/music/" onclick="VeryCD.Track('/stat/baseMusic/');">音乐</a></li>
		<li><a class="on" href="http://www.verycd.com/sto/book/" onclick="VeryCD.Track('/stat/baseBook/');">图书</a></li>
		<li><a href="http://www.verycd.com/sto/software/" onclick="VeryCD.Track('/stat/baseSoftware/');">软件</a></li>
		<li><a href="http://www.verycd.com/sto/datum/" onclick="VeryCD.Track('/stat/baseDatum/');">资料</a></li>
		<li><a href="http://www.verycd.com/sto/edu/" onclick="VeryCD.Track('/stat/baseEdu/');">教育</a></li>
		<li><a href="http://www.verycd.com/yule/" onclick="VeryCD.Track('/stat/baseYule/');">娱乐</a></li>
		<li><a class="four" target="_blank" href="http://www.verycd.com/theater/" onclick="VeryCD.Track('/stat/baseTheater/');">观影指南</a></li>
		<li><a class="three" href="http://www.verycd.com/base/timetable/" onclick="VeryCD.Track('/stat/baseTimetable/');">排片表</a></li>
        <li><a href="http://www.verycd.com/top/" onclick="VeryCD.Track('/stat/baseTop/');">驴榜</a></li>
	</ul>

	<div class="more" style="font-size:12px;">
        <a href="http://www.verycd.com/archives/" onclick="VeryCD.Track('/stat/baseArchives/')">更新列表»</a>
    </div>
	</div>
</div>

<h2 id="whereru" style="text-align:left;margin:10px 0">
    您的位置：<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule'; ?>">首页</a>
<?php  foreach($postion as $row){
?>
&gt;&nbsp;<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($row['id']); ?>" onclick=""><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a>
<?php 
}?>
                <!-- 管理小组 START-->
        <p id="manageGroup">
        </p>
        <!-- 管理小组 END-->

    
</h2><br>


<div id="top_ad" style="margin: 0 0 10px 0"></div>
<!-- head -->
<div class="mainDiv">
<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/index.css" rel="stylesheet">

<div class="line_space"></div>
<style type="text/css">
.block:after {
    clear: both;
    content: " ";
    display: block;
}
</style>
<div class="folder_div box_7">
<div style="margin: 4px 0 0;" id="folderlist">
<div class="tab-nav-1 tab-nav-1_index block">
<ul style="float: left;" id="hotnavs" class="ul block">
	<li class="on"
		onmouseover=""
		onmouseout=""
		id="foldertagg_0"><a href="javascript:void(0);"
		target="_blank">最新</a></li>
	<li
		onmouseover=""
		onmouseout=""
		id="foldertagg_1" class=""><a
		href="" target="_blank">随机</a></li>
	<li
		onmouseover=""
		onmouseout=""
		id="foldertagg_2" class=""><a
		href="javascript:void(0);" target="_blank">最热</a></li>
</ul>
</div>
<div id="index" class="clearfix">
<div class="id_left">
<div class="vc_old main vc_old_index" id="folderdiv_index_0" style="">
<ul  class="clearfix ul">
<?php 
foreach($emuleIndex['new'] as $row){
?>
	<li class="list">
	<div class="cover_3"><a
		href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" target="_blank" onclick=""> <img src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>" style="width: 100px; height: 100px" name="lazyload"
		alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>"> </a></div>
	<div class="cv_title">
	<ul>
		<li class="strong"><a
			href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onclick="" target="_blank"><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a></li>
		<li></li>
	</ul>
	</div>
	</li>
<?php 
}
?>
</ul>
</div>
<div class="vc_old main vc_old_index" id="folderdiv_index_1" style="display: none">
<ul class="clearfix ul">
<?php 
foreach($emuleIndex['rand'] as $row){
?>
	<li class="list">
	<div class="cover_3"><a
		href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" target="_blank" onclick=""> <img style="width: 100px; height: 100px" src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>"
		alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>"> </a></div>
	<div class="cv_title">
	<ul>
		<li class="strong"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onclick=""
			target="_blank"><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a></li>
	</ul>
	</div>
	</li>
<?php 
}
?>
</ul>
</div>
<div class="vc_old main vc_old_index" id="folderdiv_index_2" style="display: none">
<ul class="clearfix ul">
<?php 
foreach($emuleIndex['hot'] as $row){
?>
	<li class="list">
	<div class="cover_3"><a
		href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" target="_blank" onclick=""> <img style="width: 100px; height: 100px" src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>"
		alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>"> </a></div>
	<div class="cv_title">
	<ul>
		<li class="strong"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onclick=""
			target="_blank"><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a></li>
	</ul>
	</div>
	</li>
<?php 
}
?>
</ul>
</div>
</div>
<div class="id_right">
<div class="box_7">
<div class="sidebar_hot main clearfix">
<div class="side_hot_nav side_hot_nav_index clearfix">
<ul id="hotnavs" class="ul clearfix">
<?php 
foreach($emuleIndex['catehot'] as $key=>$row){
?>
	<li
		onmouseout=""
		onmouseover=""
		id="hotnav_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" class=""><a onclick="void(0);return false;"
		target="_blank" name="for_pad" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($row['id']); ?>"><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php 
}
?>
</ul>
</div>
<div class="side_hot_list side_hot_list_index">
<?php 
foreach($emuleIndex['catehot'] as $key=>$list){
?>
<ul id="hottab_index_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" class="clearfix" style="<?php  if($key){?>display:none<?php }?>">
<?php 
foreach($list['list'] as $k=>$row){
?>
	<li class="<?php  if(!$k){?>on<?php }?>" onmouseout=""
		onmouseover=""
		id="hot1tag_<?php echo htmlspecialchars($k, ENT_QUOTES, 'UTF-8');?>"><a title="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>"
		onclick=""
		href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" class="clearfix">
	<div class="list_ins">
	<div class="list_top clearfix">
	<div class="li_view_num"><?php echo htmlspecialchars($row['hits'], ENT_QUOTES, 'UTF-8');?></div>
	<div class="li_title"><span class="compositor red_compositor"><?php echo htmlspecialchars($k+1, ENT_QUOTES, 'UTF-8');?></span><span>[<?php echo htmlspecialchars($row['cname'], ENT_QUOTES, 'UTF-8');?>]</span>&nbsp;<strong><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></strong></div>
	</div>
	<div class="list_main clearfix">
	<div class="li_img">
	<div class="entry_cover  show_play"><!--[if IE 6]><span class="spacer" style="width:54px;height:74px;"></span><![endif]--><img
		width="" height="" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>"
		src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>"
		class="cover_img">
	<div class="play_ico_small"></div>
	</div>
	</div>
	<div class="li_info"></div>
	</div>
	</div>
	</a></li>
<?php 
}
?>
</ul>
<?php 
}
?>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

</div>

<div class="mainDiv" id="advertisement_bottom">
<div class="line_space"></div>
<div
	style="width: 960px; height: 90px; border: 1px solid #ccc; padding: 10px 14px;">
<!--960X90_AD--></div>
<div class="clear"></div>

<div class="mainDiv">

<div class="line_space"></div>

<?php 
foreach($emuleIndex['topiclist'] as $key=>$value){
?>
<div class="folder_div folder_div_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?> box_7">
<div style="margin: 4px 0 0;" id="folderlist">
<div class="tab-nav-1 tab_nav_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?> block">
<ul style="float: left;" id="hotnavs" class="ul block cate_list">
<?php 
foreach($value['subcate']['cate'] as $kk=>$val){
?>
	<li relcla="cate_class_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" relid="cate_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" class="<?php  if(!$kk){ ?>on<?php  } ?>"
		onmouseover=""
		onmouseout=""
		id="foldertagg_<?php echo htmlspecialchars($kk, ENT_QUOTES, 'UTF-8');?>"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($val['id']); ?>"
		target="_blank"><?php echo htmlspecialchars($val['name'], ENT_QUOTES, 'UTF-8');?></a></li>
<?php  } ?>
</ul>
</div>
<div class="clearfix">
<div class="id_left id_moreleft">
<?php 
foreach($value['subcate']['list'] as $ky=>$v){
?>
<div class="vc_old main moremain cate_class_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>" id="cate_<?php echo htmlspecialchars($key, ENT_QUOTES, 'UTF-8');?>_<?php echo htmlspecialchars($ky, ENT_QUOTES, 'UTF-8');?>" style="<?php  if($ky){ ?>display:none;<?php  } ?>">
<ul class="clearfix ul">
<?php 
foreach($v as $k=>$row){
?>
	<li class="list">
	<div class="cover_3"><a
		href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" target="_blank"
		onclick=""> <img
		src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>"
		style="width: 100px; height: 100px" name="lazyload"
		alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>"> </a></div>
	<div class="cv_title">
	<ul>
		<li class="strong"><a
			href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>"
			onclick=""
			target="_blank"><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a></li>
		<li></li>
	</ul>
	</div>
	</li>
<?php  } ?>
</ul>
<div style="" class="more_t"><a
	onclick="" target="_blank"
	href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($val['id']); ?>">更多<?php echo htmlspecialchars($row['cname'], ENT_QUOTES, 'UTF-8');?>&gt;&gt;</a></div>
</div>
<?php  } ?>
</div>
<div class="id_right">
<div class="idr_out">
<div class="idr_in">
<div class="red_title">
<h3><span>随机精选</span></h3>
</div>
<div class="side_list_2">                
   <ul class="ul">                                   
<?php 
foreach($value['rand'] as $key=>$row){
?>
 <li>                        
  <span class="left">                            
<span class="compositor red_compositor"><?php echo htmlspecialchars($key+1, ENT_QUOTES, 'UTF-8');?></span>                            
<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" title="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" onclick=""><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a>
</span>
<span class="right"></span>
</li>
<?php  } ?>
   </ul>        
   </div>
</div>
</div>
</div>
</div>
</div>
</div>
<?php 
} ?>
</div>

<div class="mainDiv" id="advertisement_bottom">
<div class="line_space"></div>
<div
	style="width: 960px; height: 90px; border: 1px solid #ccc; padding: 10px 14px;">
<!--960X90_AD--></div>
<div class="clear"></div>
<!--.main-wrap,#main End-->
<div class="tac">
 <br />
 
</div>
<div class="footer_wrap">
	<div class="footer">
		<pw-drag id="footer_segment"/>
		<div class="bottom">
		<?php 
			$nav = Wekit::load('SRV:nav.bo.PwNavBo');
			$bottom = $nav->getNavFromConfig('bottom');
			foreach($bottom as $key=>$value){
		
 echo $value['name'];
  } ?>
		</div>
		<p>Powered by <a href="http://www.phpwind.net/" target="_blank" rel="nofollow">phpwind v<?php echo htmlspecialchars(NEXT_VERSION, ENT_QUOTES, 'UTF-8');?></a> &copy;2003-2103 <a href="http://www.phpwind.com" target="_blank" rel="nofollow">phpwind.com</a> <a href="http://www.miitbeian.gov.cn" target="_blank" rel="nofollow"><?php echo htmlspecialchars(Wekit::C('site','info.icp'), ENT_QUOTES, 'UTF-8');?></a></p>
		<p><?php echo Wekit::C('site','statisticscode');?></p>
	</div>
	 
	 
	 
	<div id="cloudwind_common_bottom"></div>
	<?php
PwHook::display(array(PwSimpleHook::getInstance("footer"), "runDo"), array(), "", $__viewer);
?>
</div>

<!--返回顶部-->
<a href="#" rel="nofollow" role="button" id="back_top" tabindex="-1">返回顶部</a>

</div>
<script type="text/javascript">
$(document).ready(function(){
var index=0;
  $('.side_hot_nav_index #hotnavs li').mouseover(function(){
     index=$(this).index();
     $('.side_hot_list_index ul').hide();
     $('#hottab_index_'+index).show();
  });
  $('.side_hot_list_index ul li').mouseover(function(){
     $('.side_hot_list_index ul li').removeClass('on');
     $(this).addClass('on');
  });
  $('.tab-nav-1_index #hotnavs li').mouseover(function(){
     index=$(this).index();
     $('.tab-nav-1_index #hotnavs li').removeClass('on');
     $(this).addClass('on');
     $('#index .id_left div.vc_old_index').hide();
     $('.id_left #folderdiv_index_'+index).show();
  });
  $('.cate_list li').mouseover(function(){
     index=$(this).index();
     $('.cate_list li').removeClass('on');
     $(this).addClass('on');
     var id=$(this).attr('relid');
     var cla=$(this).attr('relcla');
     $('.'+cla).hide();
     $('#'+id+'_'+index).show();
  });
});
</script>
</body>
</html>
