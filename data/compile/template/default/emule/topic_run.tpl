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
<style>
.aPre{cursor:url(<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/common/pre.cur),auto;}
.aNext{
   cursor:url(<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/common/next.cur),auto;right:0;
}
</style>
                </head>
<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/tip-dig.css" rel="stylesheet">

<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/global-broad.css" rel="stylesheet">
<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/topic.css" rel="stylesheet">
<style type="text/css">
.tab_con_tab{display:none;}
#theRel,#con_theRel{display:block;}
div#favWindow div.bottom-bar{padding-top:24px;height:24px;}
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
<script type="text/javascript" src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/js'; ?>/ZeroClipboard.js" ></script>
<script type="text/javascript" src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/js'; ?>/item.js" ></script>
</head>
<body>

<link type="text/css" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/css'.Wekit::getGlobal('theme','debug'); ?>/topbar_0.css" rel="stylesheet">

<div id="page-wrapper" class="package">
    
    <style>
    #nav_div {
    margin: 10px 0 10px 0;
    }
    </style>
    
        
<style>
#nav_div a :hover, a:active,a:hover{
	color: black;
	text-decoration: underline;
}
.slide_con a:hover { text-decoration:none; }
#nav_div{
	background: url(http://v4.vcimg.com/global/images/global_bg_1.gif?v=31218) repeat-x 0 -77px;
	height: 32px;
	line-height: 30px;
	line-height: 32px\9;
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


<style type="text/css">
@-moz-document url-prefix()
{
.current_browser_class { color:#ffffff; }
}

@media screen and (-webkit-min-device-pixel-ratio:0)
{
.current_browser_class { padding: 10px 0 0 0; }
}
</style>

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
   // placeholder : "img/grey.gif",
    threshold : 60
});
});
</script>

    <div id="content" style="width:730px">
        <div id="favBox" class="glassbox" style="display:none">
    <div class="title-bar"><span class="title">收藏了该资源的用户还收藏了:</span></div>
    <div class="boxContent">
    <div id="favBoxContent">
        </div>
    <div class="favBottom">
    <a href="javascript://" class="closeButton" id="closeFavButton" onClick="closeFavBox()">关闭</a>
    </div>
    </div>
    </div>
     <div id="contentInfo">
        <h1 id="topicstitle"><?php echo htmlspecialchars($info['name'], ENT_QUOTES, 'UTF-8');?></h1>
                                 <input value="" name="entryid" id="entryid" type="hidden">
                 <div class="topicImg">
     		            <a id="topicImgUrl" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($info['id']); ?>" title="<?php echo htmlspecialchars($info['name'], ENT_QUOTES, 'UTF-8');?>">
                                    <img class="cover" src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($info['thum'], ENT_QUOTES, 'UTF-8');?>">
                        </a>
                <div>
                    <div id="visitTimes" style="margin-top:5px; display:none">
                                                    <strong id="visitTimes-title" style="display:inline-block;vertical-align:top;"></strong>
                            <span id="current-page-views" style="display: inline-block; vertical-align: top;">6052次 浏览</span><br>
                            <span id="favoriteNumber" favorites="274" style="display:inline-block;vertical-align:top;">274次 收藏</span>
                                            </div>
               </div>
        </div>
        <div style="float:left;width:580px;overflow:hidden;">
        <div class="block1">
            <div class="block11" id="block11">
                <ul>
                    <li><strong style="display:inline-block;vertical-align:top;">发布：</strong>
                        <span style="display:inline-block;vertical-align:top;"><?php echo htmlspecialchars($info['ptime'], ENT_QUOTES, 'UTF-8');?>
                        </span>
                    </li>
                    <li>
                    <strong style="display:inline-block;vertical-align:top;">更新：</strong>
                    <span class="date-time" style="display:inline-block;vertical-align:top;"><?php echo htmlspecialchars($info['utime'], ENT_QUOTES, 'UTF-8');?></span>
                    </li>
                </ul>

                    
            </div>

<?php  if (0){ ?>            
						<div class="resInfoBox" id="membertable">
				<div hoverstyle="3" hovertips="type=2&amp;id=4416523" class="header">
					<a class="imgs" href="http://www.verycd.com/i/4416523/" onClick="" style="text-decoration:none;"><img src="">
	                	<span class="follow">关注 <em>2</em></span>
	                	<span class="fans">粉丝 <em>340</em></span>
                	</a>
				</div>
				<div class="context">
					<p class="text">
						<strong><a hoverstyle="3" hovertips="type=2&amp;id=4416523" href="http://www.verycd.com/i/4416523/" onClick="VeryCD.TrackEvent('topic','发布者','用户名');">达漫V</a></strong>
						<span><img src="/15.gif" class="honorimage" title="金光盘(Exp:17641)" align="absmiddle" height="20" width="25"></span>
											</p>
					<p class="num">精华资源: <a onClick="" href="http://www.verycd.com/i/4416523/create/folders/?stat=elite">169</a></p>
					<p class="num">全部资源: <a onClick="" href="http://www.verycd.com/i/4416523/create/folders/?stat=total">172</a></p>
										<div class="btn">
						<div class="haddle_btn">
					        <div data-follow-type="0" data-follow-id="4416523" data-follow="0" style="" class="haddle_btn" onClick="">
					        	<a data-follow="0" style="" class="light_addbtn" href="#"><span class="addicon"></span>加关注</a>
								<span data-follow="1" style="display:none;" class="addbtn_even"><span class="addbtn_dgray"></span>已关注<em>|</em><a class="red" style="cursor:pointer;">取消</a></span>
								<a data-follow="2" style="display:none;" class="light_addbtn" href="#"><span class="addicon_a"></span><em>|</em><span class="addicon"></span>加关注</a>
						    	<span data-follow="3" style="display:none;" class="addbtn_even"><span class="addicon_c"></span>相互关注<em>|</em><a class="red" style="cursor:pointer;">取消</a></span>
					        </div>
						</div>
					</div>
									</div>
			</div>
<?php  } ?>
			        </div>
<!-- .block1 -->
        <div id="showFolderBaseDoDiv" style="float: left;"></div>
        <div class="block2" style="float:left;">
            <div style="float:left;">
                                <div id="addFavModule" style="float:left;position:relative;width:125px;margin-left:5px">
                    <a class="addFav addFavModule_a" title="收藏该资源" id="addFav"></a>
                    <div style="position: absolute; left: 133px; top: -17px; margin: 0px; border: 1px solid rgb(205, 180, 126); width: 310px; background: none repeat scroll 0% 0% rgb(255, 255, 205); height: 55px;" id="folderfavoritatips">
                        <div style="position: absolute; height: 30px; width: 12px; top: 18px;left:-12px; background: url(http://v4.vcimg.com/images/folder/tipsleft.gif) no-repeat scroll 0% 0% transparent;">
                        </div>
                        <div style="padding: 4px; color: rgb(104, 100, 89);">
                            <span style="margin-left: 3px; padding-top: 4px; float: left;"><img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/images'; ?>/emule/light.gif"></span>
                            <div style="padding: 4px; color: rgb(104, 100, 89);">
                                <div style="padding: 0px; margin: 0px 0px 0px 17px;text-align:left;">
                                    <span style="float: left;">收藏资源后，一旦有新更新（字幕、文件）我们</span>
                                    <a onClick="$('#folderfavoritatips').hide();return false;" style="float:right;display:block;padding:3px 7px 0pt 3px;width: 5px;height: 30px;" href="#"><img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/emule/canceltips.gif"></a>
                                    <div>将会用站内消息和电子邮件通知你。</div>
                                    <div style="clear: both;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- #addFavModule -->
            </div>
            <div style="float:right;padding:5px 0px 5px 0px;">
                <span>
                    <strong>相关：</strong>
                    <div id="shte_mainbox"></div>

                        <div id="folderfavoritatips" style="position:absolute;margin:-35px 0 0 -38px;*margin:-15px 0 0 -239px;border:1px solid #cdb47e;width:310px;background:#ffffcd;display:none;height:55px;">
                        <div style="position:absolute;height:12px;width:23px;margin:-12px 0 0 18px;background:url(http://v4.vcimg.com/images/folder/tipstop.gif) no-repeat;"></div>
                        <div style="padding:4px;color:#686459;">
                            <span style="margin-left:3px;padding-top:4px;float:left;"><img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/default/images'; ?>/emule/light.gif"></span>
                            <div style="padding:4px;color:#686459;">
                                <div style="padding:0px;margin:0px;margin-left:17px;">
                                <span style="float:left">收藏资源后，一旦有新更新（字幕、文件）我们</span>
                                <a href="#" style="float:right;display:block;padding:3px 7px 0 3px;padding:3px 3px 0 0\9;width:5px;height:30px;" onClick="VeryCD.Track('/stat/topicfavtipsclose/');return hidden_favorite_tips();"><img src="<?php echo Wind::getComponent('response')->getData('G', 'url', 'themes').'/site/'.Wekit::C('site', 'theme.site.default').'/images'; ?>/emule/canceltips.gif"></a>
                                <div>将会用站内消息和电子邮件通知你。</div>
                                <div style="clear:both"></div>
                                </div>
                            </div>
                        </div>
                        </div>
                </span>
            </div>
            <div id="feedbackspan" style="float:left;width:100%;text-align:right;"></div>
        </div>
     </div>

</div>
        <div id="favWindow" class="glassbox" style="display:none">
        <div class="loginNote"><span style="margin-left:6px;margin-top:2px;display:inline-block;">请登录</span></div><iframe id="favIframe" src="" marginwidth="0" marginheight="0" border="0" allowtransparency="true" frameborder="0" scrolling="no"></iframe><div class="bottom-bar">
        <a href="javascript://" class="closeButton" onClick="closeLoginBox()">关闭</a>
                </div>
                </div>
               

        <div style="clear:both"></div>
        <!-- ads start -->
               
                <!-- ads over -->
                <div class="tab-nav group-mods" id="theCon">
			<ul>
				<li class="current"><a href="#theCon">详细内容</a></li>
				<li><a href="#theRel">相关资源</a></li>
				<li><a href="#theRes">补充资源</a></li>
				<li><a href="#theCom">用户评论</a></li>
			</ul>
        </div>
        <div class="blog_entry">
            <div class="iptcom" id="iptcomED2K">
                 <div>
<?php echo $info['downurl'];?>
</div>
                 <div onclick="_hmt.push(['_trackEvent', 'VIPdownload', 'click', '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($info),'%5B%5C%27id%5C%27%5D'; ?>'])"  style="border:1px solid #faccaa; background:#ffffce; text-align:center; clear:both; padding: 5px 10px; margin:5px 10px 5px 0; font-size:1.2em">
VIP通道:<?php echo $info['vipdwurl'];?>
</div>
            </div>
            <div class="iptcom" id="iptcomCname">
<?php echo $info['intro'];?>
        <!--Wrap-tail end--></div>
                </div>
  <div class="tab-nav group-mods">
			<ul>
				<li><a href="#theCon">详细内容</a></li>
				<li class="current" ><a id="theRel" href="#theRel" index='1' onclick="show_hide_tab('theRel','tab_con_tab')">相关资源</a></li>
				<li><a id="theRes" href="#theRes" index='2' onclick="show_hide_tab('theRes','tab_con_tab')">补充资源</a></li>
				<li><a id="theCom" href="#theCom" index='3' onclick="show_hide_tab('theCom','tab_con_tab')">用户评论</a></li>
			</ul>
        </div>
        			<div id="con_theRel" class="tab_con_tab">
    		<table class="restable topic_class_restable">
		<tbody>
<?php  foreach($info['relatdata'] as $key=>$row){
if($key%5==0){
   echo '<tr>';
}
?>	   	            			<td>
<a title="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" class="folder-entry-title" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onClick="" target="_blank">
<img class="lazy folder-entry-thumb"  data-original="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" /><noscript><img src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" class="folder-entry-thumb" /></noscript></a>
<a title="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" class="folder-entry-title" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onClick="" target="_blank"><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a>
			</td>
<?php 
  if($key%5==0){
     echo '</tr>';
  }
}
?>
    		</tbody>
    		</table>
</div>
<div class="tab_con_tab" id="con_theRes">
            <h3>这里是其它用户补充的资源(<a href="#commentFolder" id="extred2k">我也要补充</a>):</h3>
                			<div class="emuletop-no">
    				暂无补充资源
    			</div>
</div>									
<div id="con_theCom" class="tab_con_tab">
<!-- Comment BEGIN -->	
<div class="ds-thread topic_admin_class_edit"></div>
<script type="text/javascript">var duoshuoQuery = {short_name:"emu"};	(function() {		var ds = document.createElement('script');		ds.type = 'text/javascript';ds.async = true;		ds.src = 'http://static.duoshuo.com/embed.js';		ds.charset = 'UTF-8';		(document.getElementsByTagName('head')[0] 		|| document.getElementsByTagName('body')[0]).appendChild(ds);	})();	
</script><!-- Comment END -->
</div>

</div>
            <a id="commentFolder"></a>
						            			<div class="clearBoth"></div><br>

		 <div id="navside">
		                            

						<div id="userres">
	            <h3>该用户的其它精华资源</h3> <img id="closeUser" class="closebtn" alt="" src="/res/images/emule/toggle.gif">
	            <div id="userMore">
<?php  if(0){ ?>
	        		<table border="0" cellpadding="0" cellspacing="0" width="100%">
	                    <tbody><tr>
	                    <td style="width:48px">
	                        <a class="relatelink" href="http://www.verycd.com/topics/2960998/" onClick="VeryCD.Track('/stat/topicsOther/'+this.href);" target="_blank">
	                        <img title="PDF[2013/08/23 23:43:47]资源更新 共1个文件 28.53MB" src="/thumb_025.jpg" class="resimg" height="48" width="48">
	                        </a>
	                    </td>
	                    <td valign="middle">
	                    <a title="PDF[2013/08/23 23:43:47]资源更新 共1个文件 28.53MB" class="topic-title" href="http://www.verycd.com/topics/2960998/" onClick="VeryCD.Track('/stat/topicsOther/'+this.href);" target="_blank">
	                    《荷塘月色：钢琴弹奏流行歌曲集2  简易版》扫描版[PDF]
	                    </a>
	                    <img class="png" title="这是一个精华资源" src="/elite_on.gif">	                    </td>
	                    </tr>
	                    </tbody></table>
	        		<p class="checkall"><a href="" target="_blank">更多 &gt;&gt;</a></p>
<?php  } ?>
				</div> <!-- end of userMore -->
			</div> <!-- end of userres -->
								   		   <div id="favriteuser">
				<h3>刚收藏了本资源的用户</h3><img id="closeRell" class="closebtn" alt="" src="/res/images/emule/toggle.gif">
				<div id="closeRellmore">
<?php  if(0){ ?>									<div style="width:252px;height:65px;margin-left:5px;">
						<a style="margin-right:5px;" target="_blank" title="" href="" onClick=""><img hoverstyle="3" hovertips="type=2&amp;id=1681550" alt="apocn" class="resimg" src="/50_avatar_small.jpg" height="48px" width="48px"></a>
						<a hoverstyle="3" hovertips="type=2&amp;id=1681550" target="_blank" style="height22px;line-height:22px;text-align:center;white-space:nowrap;" title="" onClick="" href="">apocn</a>
						<br><p style="margin:6px 0px 0px 65px;color:#999999"><span title="2013/08/24 09:37:20" class="date-time">7小时前</span>&nbsp;收藏了</p>
					</div>
<?php  } ?>
								</div>
			</div>
									<div id="relativeres">
	            <h3>相关资源</h3> <img id="closeRel" class="closebtn" alt="" src="/res/images/emule/toggle.gif">
				<div id="relMore">
<?php 
foreach($info['relatdata'] as $row){
?>
                       	<p class="itshot">
			<a class="relatelink" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onClick="" target="_blank">
           <img class="lazy hot_img"  data-original="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>" style="width: 100px; height: 100px" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" /><noscript><img src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" class="hot_img" /></noscript></a>
			 <a title="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" class="topic-title" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic&aid=', rawurlencode($row['id']); ?>" onClick="" target="_blank"><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a>
</p>
<?php 
} ?>
			 <dl id="hotres">
    	            <dt>今日热门</dt>
    				                                               
<?php 
foreach($hotTopic as $row){
?>
<dd class="itshot">
<a id="entry_link_2960900" title="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic'; ?>&aid=<?php echo htmlspecialchars($row['id'], ENT_QUOTES, 'UTF-8');?>" onClick="" target="_blank" style="text-decoration:none;"><img class="lazy hot_img"  data-original="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>" style="width: 100px; height: 100px;display:inline;" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" /><noscript><img src="<?php echo htmlspecialchars($thumhost, ENT_QUOTES, 'UTF-8');
 echo htmlspecialchars($row['thum'], ENT_QUOTES, 'UTF-8');?>" alt="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" class="hot_img" /></noscript>
                        <div id="entry_2960900" style="display:none;" class="entry_score_small"></div>
                        </a>
                        <br>
<a title="<?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?>" href="<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emule&c=topic'; ?>&aid=<?php echo htmlspecialchars($row['id'], ENT_QUOTES, 'UTF-8');?>" onClick="" target="_blank"><?php echo htmlspecialchars($row['name'], ENT_QUOTES, 'UTF-8');?></a>
</dd>
<?php 
} ?>	        
                    				                            				                
             </dl>  <!-- end of hotres -->
</div>
</div>
	    </div><!-- end of navside -->
</div><!-- end of page wrap-->


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
		<p>Powered by <a href="#" target="_blank" rel="nofollow">phpwind v<?php echo htmlspecialchars(NEXT_VERSION, ENT_QUOTES, 'UTF-8');?></a> &copy;2013-<?php  echo date('Y'); ?> <a href="#" target="_blank" rel="nofollow">phpwind.com</a> <a href="http://www.miitbeian.gov.cn" target="_blank" rel="nofollow"><?php echo htmlspecialchars(Wekit::C('site','info.icp'), ENT_QUOTES, 'UTF-8');?></a></p>
		<p><?php echo Wekit::C('site','statisticscode');?></p>
	</div>
	 
	 
	 
	<div id="cloudwind_common_bottom"></div>
	<?php
PwHook::display(array(PwSimpleHook::getInstance("footer"), "runDo"), array(), "", $__viewer);
?>
</div>

<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F268a910d12a04866f4f834ce95825591' type='text/javascript'%3E%3C/script%3E"));
</script>

<!--返回顶部-->
<a href="#" rel="nofollow" role="button" id="back_top" tabindex="-1">返回顶部</a>

</div>
<script type="text/javascript">
function show_hide_tab(show,hide){
  $('.'+hide).hide();
  $('.group-mods ul li').removeClass('current');
  $('#'+show).parent().addClass('current');
  $('#con_'+show).show();
}
</script>
</body>
</html>
