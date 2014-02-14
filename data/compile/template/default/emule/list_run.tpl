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
<script src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/js'; ?>/jquery-2.0.2.min.js?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>"></script>
<?php
PwHook::display(array(PwSimpleHook::getInstance("head"), "runDo"), array(), "", $__viewer);
?>

<link href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/style.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />
<link href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/topbar_0.css?v=<?php echo htmlspecialchars(NEXT_RELEASE, ENT_QUOTES, 'UTF-8');?>" rel="stylesheet" />

<style>
.aPre{
    cursor:url(<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/common/pre.cur),auto;
}
.aNext{cursor:url(<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/common/next.cur),auto;right:0;}
</style>
</head>
<body>
<link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="电驴资源">
<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/tip-dig.css" rel="stylesheet">

<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/global-broad.css" rel="stylesheet">
<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/v3-blog.css" rel="stylesheet">
<style type="text/css">div#favWindow div.bottom-bar{padding-top:24px;height:24px;}
div#favWindow div.bottom-bar a.closeButton{display:inline-block;margin-bottom:42px;}
</style>


<!--[if IE]>
<style type="text/css">
#favIframe{
	height:166px;
}
/* 收藏成功后 */
div#favBox div.favBottom{
	/*
	height:40px;
	margin-top:0px;
	*/

}

/* 登录时 */
div#favWindow div.bottom-bar a.closeButton{
	margin-top:-24px;
	display:inline-block;
	text-decoration:none;
	margin-left:6px;
}


#wrap #navside{
		width:252px;
		margin-left:3px;
	}
#wrap #navside #userres table td,#wrap #navside #relativeres table td{
		word-wrap: break-word;
		width:170px;
	}
#relMore p a.topic-title{
		word-wrap: break-word;
		width:240px;
   }
#hotres p.itshot{
	word-wrap: break-word;
	width:240px;
}
.ipctom-multiline .iptcom-info{
		float:left;
	}
.ipctom-multiline {
    	zoom: 1;     /* trigger hasLayout */
    }
div#moreInfo table{
	margin-top:0;
}
#setupform{
	padding:0;
	margin:0;
}
table#postTable{
	margin-top:-20px;
}
textarea#ed2k_url{
	margin-top:-10px;
	height:140px;
}
/*
#listExamples input.inplace{
	margin-left:-220px;

}
*/

#content a.transEdit{
	margin-top:-24px;
	}
#res{
	margin-top:12px;
	padding-left: 0px;
}
.morecom{
	clear:left
}

table.restable td a.folder-entry-title{
	width:130px;

}
div#folder-table-movie table.restable{
	padding:0;
	margin:0;

}
div#folder-table-movie table.restable td{
	clear: both;
	word-break:break-all;
	display:block;
}
#folder-table-movie{
	padding-right:0;
	height:auto;
	display:table;
	width:100%;
	padding-left:10px;
}
.folder-entry-thumb{
	margin-top:12px;
	width: 100px;
	height: 100px;
	padding:2px;
	border:1px solid #CCC;
}
table#recTable img{
	margin-top:8px;
}
span#noteDrag{
	display:block;
	margin-top:0px;
	margin-bottom:8px;
}

dd.imgForGame img.imgForGame{
	margin-top:5px;
	padding-top:0;
}
input.downall{
	padding-left:4px;
	padding-right:4px;
}
object.copyflash{
	margin-left:4px;
}
.emulemain table span.subtitle{
	margin-right:150px;
	margin-left:250px;

}
.left_class_order{
	margin-top:5px;
	margin-bottom:10px;
}

ul.topic-list li.non-topic{
	margin-bottom:5px;
}
ul.topic-list li{
	padding-top:0px!important;
	/*
	border:1px solid #B22222;
	*/
	padding-bottom:5px;
	display:inline-block;
}
.face{
	padding-top:0px!important;
	padding-bottom:0!important;

}
.file_img{
	height:100px;
	margin-top:0!important;
	margin-bottom:0;
}
.blog_title{
	/*
	padding-top:14px;
	*/
}
.blog_entry {
	padding-top:0;
	text-align:left;
    margin:0;
}
table.favTable{
	display:inline-block;
}
table.favTable tr td{
   width:100%;
   margin:0 auto;
   text-align:center;

   clear:right;
}
div#myBox input#playerBtn{
	padding:0 2px;
}
div#myBox div#boxBottom{
	height:26px;
}
div#myBox input#closeBtn{
	padding:0 2px;
	/*margin-top:-30px;*/
}

/* 底部 iframe */
div#searchIframe{
		position:absolute;
	   	width:100%;
		/*top: expression( ( ignoreMe = document.body.scrollBottom) + 'px' );*/
	    top:expression( ( -searchIframe.offsetHeight + ( document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight ) + ( ignoreMe = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop ) ) + 'px' );
	    height:0;
}
#similarArtists div ul.artistsMedium{
	padding:0;
	margin:0;
	margin-top:10px;
}
</style>
<![endif]-->

<!--[if IE 6]>
<style type="text/css">
.task_notice .icon { margin: 4px 10px 0 8px;}
td a span.play100{
	display: block;
	top:5px;
	right:8px;
}
.morecom{
	clear:left
}
#content a.transEdit{
	margin-top:-24px;
	margin-right:20px;
}
.commentContent{
	position:static;
	float:none;
	width:640px;
}
#topic_to_top_css{
    float:right;
    padding-right:0px;
    padding-top:2px;
}
/* 候选区*/

#ie7nav{
	height:20px;
	padding-bottom:0px;
	margin-bottom:0px;
}
.post-contents {
	width:630px;
}

#listExamples span.filesize{
	position:relative;
	width:90px;
}
input.downall{
	padding-top:0px;
}
.boxy-content { padding-bottom:15px; }

div.glassbox div.bottom-bar{
	/*
	height:34px;
	margin-top:0px;
	*/
}
div.glassbox div.bottom-bar a.grayButton{
	margin-top:-12px;
}
#favIframe{
	height:168px;
}
div#favWindow{
	position:relative;
}
/* 登录时,底部和关闭按钮 */
div#favWindow div.bottom-bar{
	margin-top:-44px;
	padding-top:24px;
	height:24px;

}
div#favWindow div.bottom-bar a.closeButton{
	background: #F0F0F0;
	padding:0px 4px;
	border-top:1px solid #E7E7E7;
	border-left:1px solid #E7E7E7;
	border-right:1px solid #666;
	border-bottom:1px solid #666;
	color:#333;
	text-decoration:none;

}
/* 收藏成功后 */
div#favBox div.favBottom{
	/*
	height:34px;
	margin-top:0px;
	*/

}
div#favBox div.favBottom a.closeButton{
	background: #F0F0F0;
	padding:0px 2px;
	border-top:1px solid #E7E7E7;
	border-left:1px solid #E7E7E7;
	border-right:1px solid #666;
	border-bottom:1px solid #666;
	color:#333;
	text-decoration:none;
	display:inline-block;
	margin-left:430px;
	margin-top:3px;
}

/* last.fm */
#similarArtists p.powered{
	margin-right:12px;
}

</style>
<![endif]-->
<!--[if gte IE 7]>
<style type="text/css">
/*
.task_notice .icon { float: none;}
.task_notice_body p.hometext{width:100%;}
.task_notice h3 { margin:0;}
.task_notice_body p.hometext{width:58%;margin-left:78px}
*/
div#favWindow{
	margin-top:0!important;
}
div#favWindow div.bottom-bar{
	margin-top:-34px;
	height:28px;
}
div#favWindow div.bottom-bar a.closeButton{
	margin-top:9px;
	padding:0 4px;
}


div#favWindow div.bottom-bar a.grayButton{
	background: #F0F0F0;
	padding:2px 4px!important;
	border-top:1px solid #E7E7E7!important;
	border-left:1px solid #E7E7E7!important;
	border-right:1px solid #666!important;
	border-bottom:1px solid #666!important;
	color:#333!important;
}
div#folder-table-wrapper{
	display:inline-block;
	min-height:50px;
}

span#noteDrag{
	margin-bottom:0px;
}
.ipctom-multiline .iptcom-info{
	margin-top:0;
	}
#content a.transEdit{
	margin-top:-24px;
	margin-right:36px;
}
.commentContent{
	position:static!important;
	float:none!important;
	width:650px;
}
.tab-nav li{
	padding-bottom:0px;
}
#ie7nav{
	/*
	margin-top:-4px;
	*/
}
input.downall{
	padding-top:2px;
}
#catalogGroup,#viewall{
	height:18px;
	display:block;
	padding-bottom:0;
	margin-left:4px;
	float:left;
}
</style>
<![endif]-->
<style>
#where-ru{
	display:none;
}
</style>

<style id="poshytip-css-tip-verycd" type="text/css">
div.tip-verycd{visibility:hidden;position:absolute;top:0;left:0;}
div.tip-verycd table, div.tip-verycd td{margin:0;font-family:inherit;font-size:inherit;font-weight:inherit;font-style:inherit;font-variant:inherit;}
div.tip-verycd td.tip-bg-image span{display:block;font:1px/1px sans-serif;height:10px;width:10px;overflow:hidden;}
div.tip-verycd td.tip-right{background-position:100% 0;}
div.tip-verycd td.tip-bottom{background-position:100% 100%;}
div.tip-verycd td.tip-left{background-position:0 100%;}
div.tip-verycd div.tip-inner{background-position:-10px -10px;}
div.tip-verycd div.tip-arrow{visibility:hidden;position:absolute;overflow:hidden;font:1px/1px sans-serif;}
</style>
</head>
<body> 

<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/topbar_0.css" rel="stylesheet">

<div id="page-wrapper" class="package">
<div id="page-body" class="package">   

<!-- Nav -->

<div id="wrap">
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
			<form action="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&a=search'; ?>" method="post">
				<input type="text" id="s" aria-label="搜索关键词" accesskey="s" placeholder="搜索其实很简单" x-webkit-speech speech name="q"/>
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
if(0){
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
} 

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
.lazy {display: none;}
</style>
<script type="text/javascript" src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/js'; ?>/jquery-2.0.2.min.js" ></script>
<script type="text/javascript" src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/js'; ?>/jquery.lazyload.min.js" ></script>
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
		<li><a href="/sto/music/" onclick="VeryCD.Track('/stat/baseMusic/');">音乐</a></li>
		<li><a class="on" href="/sto/book/" onclick="VeryCD.Track('/stat/baseBook/');">图书</a></li>
		<li><a href="/sto/software/" onclick="VeryCD.Track('/stat/baseSoftware/');">软件</a></li>
		<li><a href="/sto/datum/" onclick="VeryCD.Track('/stat/baseDatum/');">资料</a></li>
		<li><a href="/sto/edu/" onclick="VeryCD.Track('/stat/baseEdu/');">教育</a></li>
		<li><a href="/yule/" onclick="VeryCD.Track('/stat/baseYule/');">娱乐</a></li>
		<li><a class="four" target="_blank" href="/theater/" onclick="VeryCD.Track('/stat/baseTheater/');">观影指南</a></li>
		<li><a class="three" href="/base/timetable/" onclick="VeryCD.Track('/stat/baseTimetable/');">排片表</a></li>
        <li><a href="/top/" onclick="VeryCD.Track('/stat/baseTop/');">驴榜</a></li>
	</ul>

	<div class="more" style="font-size:12px;">
        <a href="/archives/" onclick="VeryCD.Track('/stat/baseArchives/')">更新列表»</a>
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
<script type="text/javascript">
$(document).ready(function(){
$("img.lazy").show().lazyload({ 
    effect : "fadeIn",
    //placeholder : "img/grey.gif",
    placeholder : "<?php echo htmlspecialchars($error_img, ENT_QUOTES, 'UTF-8');?>",
    threshold : 60
});
});
</script>

<div id="nav">

<style type="text/css">
dl#libCatalog dd .on {
margin-left: 2px;
text-decoration: none;
background: #E7E7E7;
}
.box_7 {
border: 4px solid #E6E6E6;
padding: 0px;
background: #E6E6E6;
}
.box_7 .title {}
.box_7 .title h3{padding:0;margin:0;font-size: 14px;line-height: 20px;color: #000;font-weight: bold;padding:2px 6px 6px 6px;}
.box_7 .main{border: 1px solid #cfcfcf;background: #fff;}
dl#libCatalog dd {
    background: #f4f4f4;
    border: 1px solid #e7e7e7;
    display: block;
    margin: 4px 0px;
    padding: 2px;
    font-weight: normal;
    letter-spacing: 0;
}
#someLinks{padding:0;text-align:center;}
dl#libCatalog dd a {
    display: block;
    border: 0px;
    text-indent: 18px;
    padding-left:0;
}

.rightBox .rightTitle{margin:0;height:31px;overflow:auto;zoom:1;border:1px solid #cfcfcf;border-bottom:0;}
.rightBox .rightTitle .h3{float:left;margin:0;height:31px;line-height:31px;padding-left:10px;font-size:14px;font-weight:bold;}
.rightBox .rightTitle .h3 span{height:17px;padding-left:5px;border-left:5px solid #c00;}
.rightBox .rightTitle .h3 span a{color:#464646;}
#someLinks {
    text-align: center !important;
}
dl#someLinks dd {
    padding-left: 0;
}
dl.indexLeftItem {
    background: none repeat scroll 0 0 #fff;
}

/* 渐变 */
.title_bg{
background: #fefefe; /* Old browsers */
background: -moz-linear-gradient(top, #fefefe 0%, #e9e9e9 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#fefefe), color-stop(100%,#e9e9e9)); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top, #fefefe 0%,#e9e9e9 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top, #fefefe 0%,#e9e9e9 100%); /* Opera11.10+ */
background: -ms-linear-gradient(top, #fefefe 0%,#e9e9e9 100%); /* IE10+ */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fefefe', endColorstr='#e9e9e9',GradientType=0 ); /* IE6-9 */
background: linear-gradient(top, #fefefe 0%,#e9e9e9 100%); /* W3C */
}
#wrap {
    background: none;
    _background: none !important;
}

.left_class_order{margin-top:0;*margin-top:0 !important;}
</style>


<div class="box_7 rightBox">
<div class="rightTitle title_bg">
<div class="h3"><span>图书分类</span></div>
</div>
<div class="main" style="padding:0 5px;">
<dl id="libCatalog">
<?php                	                	                	                	    
foreach($subcatelist as $row){
?>       	                	                	                         
          	    <dd><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($row['id']); ?>">&gt;<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?><span class="recordCount">(<?php echo htmlspecialchars($row['atotal'], ENT_QUOTES, 'UTF-8');?>)</span></a></dd>
<?php  
}
?>
</dl>
</div>
</div>
<div style="height:10px;background:#fff;"></div>

<div class="box_7 rightBox">

<div class="rightTitle title_bg">
<div class="h3"><span>相关链接</span></div>
</div>
<div class="main" style="padding:10px;">
<dl id="someLinks">
<dd><a href="#" title="订阅本站资源">订阅本站资源</a></dd>
<dd><a href="#" id="emuleOld" title="Download eMule">电驴(eMule)经典版下载</a></dd>
<dd><a href="#" title="get firefox" id="getfirefox" target="_blank">推荐使用 Firefox 浏览器</a></dd>
<dd style=" clear:both;"></dd>
</dl>
</div>
</div>

<div style="height:10px;background:#fff;"></div>


<!---->

<div class="box_7 rightBox">
<div class="rightTitle title_bg">
<div class="h3"><span>今日热门</span></div>
</div>

<div class="main" style="padding:10px;">
<!---->
<dl class="indexLeftItem">
<?php 
foreach($hotTopic as $row){
?>
<dd class="leftMiddle">
   <a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onClick="" style="text-decoration:none;" id="entry_link_2961048"><img class="lazy hot_img" data-original="<?php echo htmlspecialchars($showimgapi, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['cover'], ENT_QUOTES, 'UTF-8');?>" style="width: 100px; height: 100px" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" /><noscript><img src="<?php echo htmlspecialchars($showimgapi, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['cover'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" class="hot_img" /></noscript></a><br>
<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onClick=""><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a>            
            </dd>
<?php 
}
?>
            
</dl>

</div>

</div>
<div style="height:10px;background:#fff;"></div>
<p style="text-align: center;">

</p>

</div>
<div id="content">

    <ul class="topic-list" style="*margin-top:-19px">
 <li id="searchBar">
<form id="advance_search_form" method="get" action="http://www.verycd.com/search/folders" target="_blank">
    <div class="left_class_order" style="margin-bottom:10px!important;">
        <span>
        排序:
        <span class="left_class_new left_class_filter">
        <a href="javascript:setType('sort','rpost');onButtonClick();VeryCD.Track('/stat/stoListPostBook/');">发布
                    <img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/emule/new02.gif">
        </a>
                <img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/emule/newtopic_bg.gif">
        更新
                    <img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/emule/new02_red.gif">
                </span>
    </span>
    <select name="sort" id="sort" onChange="onButtonClick();VeryCD.Track('/stat/stoListSortBook/');" class="selectClass">
        <option value="default">默认排序</option>
        <option value="post">发布时间从老到新</option>
        <option value="rpost">发布时间从新到老</option>
        <option value="update">更新时间从老到新</option>
        <option value="rupdate" selected="selected">更新时间从新到老</option>
        <option value="size">文件大小从小到大</option>
        <option value="rsize">文件大小从大到小</option>
    </select>
    <span class="left_class_filter"><img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/emule/line.gif"></span>
        </div>
<input type="hidden" name="csrf_token" value="<?php echo WindSecurity::escapeHTML(Wind::getComponent('windToken')->saveToken('csrf_token')); ?>"/></form></li>
<?php 
foreach($infolist as $row){
?>
                        <li>
                <a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onClick=""><img class="lazy file_img" data-original="<?php echo htmlspecialchars($showimgapi, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['cover'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" /><noscript><img src="<?php echo htmlspecialchars($showimgapi, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['cover'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" class="file_img" /></noscript></a>
 <h3>
<span class="left_topics_class_sort"><a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($row['cid']); ?>"><?php echo htmlspecialchars($row['cname'], ENT_QUOTES, 'UTF-8');?></a></span>                <a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onClick=""><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a>
 </h3>
        <div class="blog_entry">
<?php  if(0){
?>
     <div class="face">
        <a href="http://www.verycd.com/i/4489064/" onClick="VeryCD.Track('/stat/indexUserface/');"><img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/64_avatar_small.jpg" hoverstyle="2" hovertips="type=2&amp;id=4489064" class="fixsize"></a><p style="WORD-WRAP: break-word;TABLE-LAYOUT: fixed;word-break:break-all"><a hoverstyle="2" hovertips="type=2&amp;id=4489064" href="http://www.verycd.com/i/4489064/" onClick="VeryCD.Track('/stat/indexUsername/');">cctv098998</a></p></div>
<?php  } ?>
<!--[if IE 6]><span style="text-indent:-24px;margin-left:-12px"></span><![endif]-->
<?php echo htmlspecialchars($row['description'], ENT_QUOTES, 'UTF-8');?>
(<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" class="fullarticle" onClick="">全文</a>)
                    <br>
    	<span style="color:green;">
    	<span class="date-time"><?php echo htmlspecialchars($row['ptime'], ENT_QUOTES, 'UTF-8');?></span> 发布, <?php  if(0){ ?><span class="date-time"></span> 更新 - <strong>128</strong>个文件, <strong>4.05GB</strong>, <strong>1630</strong>条评论</span>
<?php  } ?>
        <div class="blog_metadata">        </div>
        </div>
        </li>
<?php                                                                              

} 
?>	
        </ul>
<div class="pnav">
<div class="pages-nav" style="margin: 10px 7px 0px 0px;padding:0 0 20px 0px!important;padding-bottom:0;">
<?php $__tplPageCount=(int)$listcount;
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
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($cid),'&page=', rawurlencode($_page_i); 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_pre J_pages_pre">&laquo;&nbsp;上一页</a>
	<?php  if ($_page_min > 1) { 
		$_page_i = 1;		
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($cid),'&page=', rawurlencode($_page_i); 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">1...</a>
	<?php  } 
  for ($_page_i = $_page_min; $_page_i < $__tplPageCurrent; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($cid),'&page=', rawurlencode($_page_i); 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  } ?>
	<strong><?php echo htmlspecialchars($__tplPageCurrent, ENT_QUOTES, 'UTF-8');?></strong>
<?php  if ($__tplPageCurrent < $_page_max) { 
  for ($_page_i = $__tplPageCurrent+1; $_page_i <= $_page_max; $_page_i++) { 
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($cid),'&page=', rawurlencode($_page_i); 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>"><?php echo htmlspecialchars($_page_i, ENT_QUOTES, 'UTF-8');?></a>
	<?php  } 
  if ($_page_max < $__tplPageTotal) { 
		$_page_i = $__tplPageTotal;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($cid),'&page=', rawurlencode($_page_i); 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>">...<?php echo htmlspecialchars($__tplPageTotal, ENT_QUOTES, 'UTF-8');?></a>
	<?php  }
		$_page_i = $__tplPageCurrent+1;
	?>
	<a href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=list&cid=', rawurlencode($cid),'&page=', rawurlencode($_page_i); 
 echo htmlspecialchars(array() ? '&' . http_build_query(array()) : '', ENT_QUOTES, 'UTF-8');?>" class="pages_next J_pages_next">下一页&nbsp;&raquo;</a>
<?php  } ?>
</div>
<?php } ?>

<span href="#" style="display:none">  </span>
</div>
</div>
</div><!--End of content-->
<div style="clear:both"></div>
</div><!-- End of page wrap-->

</div><!-- End of #page-body -->
<!--.main-wrap,#main End-->
<div class="tac">
 <br />
 
</div>
<div class="footer_wrap">
	<div class="footer">
		<pw-drag id="footer_segment"/>
                <div class="tmode_traverseList">
<ul class="cc">
<?php if(is_array($__design_data['J_mod_3'])){
						$__data=$__design_data['J_mod_3'];
					}else{
						$display=Wekit::load('design.srv.display.PwDesignDisplay');
						$__data=$display->getModuleData(3);
					};foreach($__data AS $__k=>$__v){?>
  <li><a href="<?php echo WindSecurity::escapeHTML($__v['url']);?>" target="_blank" target="_blank"><?php if($__v['__style']){?><span style="<?php echo WindSecurity::escapeHTML($__v['__style']);?>"><?php echo WindSecurity::escapeHTML($__v['name']);?></span><?php }else{
 echo WindSecurity::escapeHTML($__v['name']);
 }?></a></li>
<?php }?>
  <li><a href="index.php?m=link&c=index&a=run" class="J_link_apply">申请链接</a></li>
</ul>
</div>
		<div class="bottom">
		<?php 
			$nav = Wekit::load('SRV:nav.bo.PwNavBo');
			$bottom = $nav->getNavFromConfig('bottom');
			foreach($bottom as $key=>$value){
		
 echo $value['name'];
  } ?>
		</div>
		<p>Powered by <a href="#" target="_blank" rel="nofollow">phpwind v<?php echo htmlspecialchars(NEXT_VERSION, ENT_QUOTES, 'UTF-8');?></a> &copy;2013-<?php  echo date('Y'); ?> <a href="#" target="_blank" rel="nofollow">phpwind.com</a> <a href="http://www.miitbeian.gov.cn" target="_blank" rel="nofollow"><?php echo htmlspecialchars(Wekit::C('site','info.icp'), ENT_QUOTES, 'UTF-8');?></a></p>
		<p><?php echo Wekit::C('site','statisticscode');?></p>
	</div>
	 
	 
	 
	<div id="cloudwind_common_bottom"></div>
	<?php
PwHook::display(array(PwSimpleHook::getInstance("footer"), "runDo"), array(), "", $__viewer);
?>
</div>
<div style="display:none;">
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F268a910d12a04866f4f834ce95825591' type='text/javascript'%3E%3C/script%3E"));
</script>
</div>
<!--返回顶部-->
<a href="#" rel="nofollow" role="button" id="back_top" tabindex="-1">返回顶部</a>

</body>
</html>
