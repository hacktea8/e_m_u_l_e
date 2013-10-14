<textarea name="<?php echo htmlspecialchars($editor_name, ENT_QUOTES, 'UTF-8');?>" id="J_wind_editor" style="height:300px;width:100%;padding:0;margin:0;"><?php echo htmlspecialchars($atc_content, ENT_QUOTES, 'UTF-8');?></textarea>
<script>
	/*
	* 编辑器中与NextWind相关的业务配置的全局变量（注意必须是全局），这些配置变量在编辑器的插件中会调用到
	*/
	var Post_Type_Enum = {
		NEW_POST:1, 	//发新帖操作
		MODIFY:2,		//修改帖子内容
		REPLY:3 		//回复
	};

	<?php 
		$postType = 'NEW_POST';
		if ($do == 'doreply') {
			$postType = 'REPLY';
		}else if( $do == 'domodify' ) {
			$postType = 'MODIFY';
		}
	?>
	//发帖类型
	var POST_TYPE = Post_Type_Enum.<?php echo $postType;?>;
	var EDIT_CONFIG = {
        sell : <?php echo Pw::array2str($sellConfig);?>,
        enhide : <?php echo Pw::array2str($enhideConfig);?>,
        ifhide : '1'
	};
	var IMAGE_CONFIG = {
		tabs : ['local','album','network'],
		filetype : <?php echo Pw::array2str(Pw::subArray(Wekit::C('attachment', 'extsize'), array('jpg', 'jpeg', 'png', 'gif', 'bmp')));?>,
		uploadUrl: "<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=upload&a=dorun&_json=1'; ?>",//上传地址
		postData : {fid : '<?php echo htmlspecialchars($fid, ENT_QUOTES, 'UTF-8');?>', uid : '<?php echo htmlspecialchars($loginUser->uid, ENT_QUOTES, 'UTF-8');?>'}
	};
	var ATTACH_CONFIG = {
		ifopen : '<?php echo htmlspecialchars($allowUpload, ENT_QUOTES, 'UTF-8');?>',
		uploadUrl : "<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=upload&a=dorun&_json=1'; ?>",//上传地址
		modifyUrl : "<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=upload&a=replace&_json=1'; ?>",//修改地址
		deleteUrl : '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=attach&a=delete&_json=1'; ?>',
        attachnum : parseInt('<?php echo htmlspecialchars($attachnum, ENT_QUOTES, 'UTF-8');?>'),
        list : <?php echo Pw::array2str($attach);?>,
        postData : {fid : '<?php echo htmlspecialchars($fid, ENT_QUOTES, 'UTF-8');?>', csrf_token : GV.TOKEN},
        remoteAttUrl:'<?php echo htmlspecialchars($db_ftpweb, ENT_QUOTES, 'UTF-8');?>',
        filetype : <?php echo Pw::array2str(Wekit::C('attachment', 'extsize'));?>,
        atUserList:[<?php echo htmlspecialchars($atusers, ENT_QUOTES, 'UTF-8');?>]
    }
    //表情数据的地址
    var EMOTION_URL = '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=emotion&type=bbs'; ?>';
    //at好友数据地址
    var AT_URL = '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=remind'; ?>';
    //at弹窗的地址
    //var AT_DIALOG_URL = '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?c=remind&a=friend'; ?>';
    var AT_USER_SPACE = '<?php echo Wind::getComponent('response')->getData('G', 'url', 'base'),'/','index.php?m=space'; ?>?uid=';
   //应用插件配置
	var editorApp = {
		root: '<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','extres'), ENT_QUOTES, 'UTF-8');?>/',
		items: <?php echo WindSecurity::escapeEncodeJson($editor_app_config, 'UTF-8');?>
	};
    /*
	* 引用编辑器js并初始化编辑器
	*/
	Wind.ready('global.js', function() {
		Wind.use('jquery', 'windeditor',function() {
			var plugins = [];
			//!TODO 假设现在没有html权限，后续需要后端输出
			if(1/*如果没有html权限,则使用bbcode，此时需加载bbcode插件*/) {
				plugins.push('bbcode');
			}else {
				if( !$.browser.msie ) {
					plugins.push('codemirror');//否则是html权限，非IE则加载codemirror代码高亮
				}
			}
			var mini = 'fontName fontSize bold italic underline foreColor justifyLeft justifyCenter justifyRight insertLink insertPhoto'.split(' ');
			// @提醒权限
			var REMIND_OPEN = '<?php echo htmlspecialchars($loginUser->getPermission('remind_open'), ENT_QUOTES, 'UTF-8');?>',
				VIDEO_OPEN = '<?php echo htmlspecialchars($loginUser->getPermission('allow_publish_vedio'), ENT_QUOTES, 'UTF-8');?>',
				MUSIC_OPEN = '<?php echo htmlspecialchars($loginUser->getPermission('allow_publish_music'), ENT_QUOTES, 'UTF-8');?>';
			//根据服务器端配置判断是否加载编辑器功能插件
			var customPlugins = [];
			if (ATTACH_CONFIG.ifopen == 1) { customPlugins.push('insertFile'); }
			if (VIDEO_OPEN == 1) { customPlugins.push('insertVideo'); }
			if (MUSIC_OPEN == 1) { customPlugins.push('insertMusic'); }
			if (EDIT_CONFIG.enhide.ifopen == 1) { customPlugins.push('insertHide'); }
			if (EDIT_CONFIG.sell.ifopen == 1) { customPlugins.push('insertSell'); }
			if (REMIND_OPEN == 1) { customPlugins.push('atremind'); }
			//插入代码和openApp的插件放最后
			plugins = plugins.concat(['insertEmoticons', 'insertPhoto'],customPlugins,['insertCode', 'openApp']);
			//简单模式时的插件
			mini = mini.concat( customPlugins );
			$('#J_wind_editor').windeditor({
				editor_path	: window.GV.JS_ROOT + 'windeditor/',//windoweditor的路径
				plugins		: plugins,
				defaultToolbarMode:'<?php echo htmlspecialchars(Wekit::C('bbs','editor.style') == 1 ? 'mini' : 'default', ENT_QUOTES, 'UTF-8');?>',//编辑器的默认模式，有default和mini模式
				mini		: mini.join(' '),
				theme		: 'buyiui',
				localSave	: POST_TYPE === Post_Type_Enum.NEW_POST ? true : false,// 发新帖才保存本地，IE本地存储还有问题
				iframeCss	: ['<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','url','css'), ENT_QUOTES, 'UTF-8');?>/editor_content.css?v=<?php echo htmlspecialchars(Wind::getComponent('response')->getData('G','c','version'), ENT_QUOTES, 'UTF-8');?>'],//为了更好的可见即所得，加载阅读页的css文件
				onInit		: function () {
					$(this.editorDoc.body).addClass('editor_content');
					var editor = this,
						title_ele = $('#J_atc_title'),
						content_ele = $('#J_wind_editor');
					window.onbeforeunload = function() {
						editor.saveContent();
					    var atc_title = $.trim(title_ele.val());
					    var title_holder = title_ele.attr('placeholder');
					    var atc_content = $.trim(content_ele.val());
					    if ((atc_title != "" && atc_title != title_holder) || (atc_content != "" && atc_content != "<br>")) {
							return "您正在编辑的帖子没有保存，离开会导致内容丢失，是否确定离开？";
						}
					}
					if(POST_TYPE === Post_Type_Enum.REPLY) {
						var quickReply = editor.localStorage.get('quickReply');
						if(quickReply) {
							editor.textarea.val(quickReply);
							editor.setContent(quickReply);
						}
					}
				}
			});
		});
	});
</script>
