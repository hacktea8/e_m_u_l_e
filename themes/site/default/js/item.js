window.onerror=function(){return true;}
$(function () {
	//隔行变色
	$('tr').addClass('odd');
	$('tr:even').addClass('even');
	$('#tr_baidu').removeClass();
	//全选
	$("#checkall").change(function(){
		$("input:checkbox").attr("checked",$(this).attr("checked")?true:false);
	})
	//默认全选中
	$("input:checkbox").attr("checked","checked");
	$(".cbxitem").each(function(){
		var es = $(this).val().replace("[www.ed2kers.com]","");
		var es = es.split("|");
		var fs = es[2].split(".");
		fs[fs.length-2] = fs[fs.length-2]+"[www.ed2kers.com]";
		es[2] = fs.join('.');
		$(this).val(es.join('|'));
		$(this).next().attr("href",$(this).val());
	})
	//复制
	ZeroClipboard.setMoviePath("http://www.ed2kers.com/res/js/ZeroClipboard.swf");
	var clip = new ZeroClipboard.Client(); // 新建一个对象 
	clip.setHandCursor( true ); // 设置鼠标为手型 
	clip.glue("btncopy"); // 和上一句位置不可调换 
	clip.addEventListener( "mouseOver", function(client) { 
		var ed2ks="";
		$("tbody input:checkbox:checked").each(function(){
			ed2ks+=$(this).val()+"\r\n";
		})
		client.setText( $.trim(ed2ks) ); // 重新设置要复制的值 
	});
	for (i=0;i<document.images.length;i++){
		if (document.images[i].width>760){
			document.images[i].height*=760/document.images[i].width;
			document.images[i].width="760";
		}
	}
})
Array.prototype.S=String.fromCharCode(2);  
Array.prototype.in_array=function(e)  
{  
var r=new RegExp(this.S+e+this.S);  
return (r.test(this.S+this.join(this.S)+this.S));  
}  
function getext(imgPath){
	return (imgPath.substr(imgPath.length -5)).substr((imgPath.substr(imgPath.length -5)).indexOf('.')+1).toLowerCase();
}
function download(i, first) {
	var str="cbxitem";
    var a = document.getElementsByName(str);
    var n = a.length;
	//尝试使用activex方式批量新增下载
	try {
		var ed2k_links = '';
		var ax = new ActiveXObject("IE2EM.IE2EMUrlTaker");
		var emule_version = ax.GetEmuleVersion();
		if ('e' != emule_version.substr(0,1)) {
			throw {errorCode:'eMule not Installed.'};
		}
		for (var i = i; i < n; i++) {
			if(a[i].checked) {
				if (ed2k_links=='') {
					ed2k_links = a[i].value;
				} else {
					ed2k_links += "\n"+a[i].value;
				}
			}
		}
		ax.SendUrl(ed2k_links, 'dd', document.location);
		delete ax;
		return;
	} catch (e) {}

	if (!window.continueDown) {
		//使用最旧的方法来批量新增下载
		for (var i = i; i < n; i++) {
			if(a[i].checked) {
				window.location=a[i].value;
				if (first)
					timeout = 6000;
				else
					timeout = 500;
				i++;
				window.setTimeout("download('"+str+"', "+i+", 0)", timeout);
				break;
			}
		}
	} else {
		//使用稍微新一点的方法来批量新增下载
		for (var i = i; i < n; i++) {
			if(a[i].checked) {
				if(first){
					var k = i;
					var current_link = a[k].nextSibling;
					var multi_text = '';
					var tmp_counter = 0;
					var comma = '';
					while(true){
						if(a[k].checked && current_link){//如果是有效节点并且被选中
							if(current_link.href){
								if(current_link.href.indexOf('ed2k') !== 0){
									current_link = current_link.nextSibling;
									continue; 
								}
								if(tmp_counter > 7){//收集超过若干个有效链接后，退出
									multi_text += '<br />…………'; 
									break; 
								}
								var right_link = current_link;
								tmp_counter++;
								if (navigator.userAgent.toLowerCase().indexOf("msie")==-1) {
									multi_text += comma+current_link.text;
								}else{
									multi_text += comma+current_link.innerText;
								}
								comma = '<br />';
							}

							current_link = current_link.nextSibling;
						}else{//未被选中，或往下没有相邻节点了，那么切换到下个父节点
							if(++k >= n){//如果父节点也到底了，那么退出
								break; 
							}
							current_link = a[k].nextSibling;
						}
					}
					downPopup(right_link,multi_text);
				}

				continueDown(a[i].value);
				//window.location=a[i].value;
				if (first)
					timeout = 6000;
				else
					timeout = 500;
				i++;
				window.setTimeout("download('"+str+"', "+i+", 0)", timeout);
				break;
			}
		}
	}
}