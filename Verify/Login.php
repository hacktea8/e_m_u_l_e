<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>ӡ����-�й���һ����֤������ƽ̨</title>
    </head>
    <body>
		<form action="VerifyLogin.php" method="post">
		<script type='text/javascript'>
		function YXM_valided_true()
		{
			document.getElementById('ajax_valid_result').value = '��֤��������ȷ��';
		}
		function YXM_valided_false()
		{
			document.getElementById('ajax_valid_result').value = '��֤���������';
		}
		</script>
        <script type='text/javascript'>
		var YXM_PUBLIC_KEY = '363eb5f8fd2c87abc84f68876b9d320e';//������дPUBLIC_KEY
		var YXM_localsec_url = 'http://127.0.0.1/YinXiangMa_PHP_SDK_Demo_V4.0/localsec/';//��������Ӧ������·��
		function YXM_local_check()
		{
		if(typeof(YinXiangMaDataString)!='undefined')return;
		YXM_oldtag = document.getElementById('YXM_script');
		var YXM_local=document.createElement('script');
		YXM_local.setAttribute("type","text/javascript");
		YXM_local.setAttribute("id","YXM_script");
		YXM_local.setAttribute("src",YXM_localsec_url+'yinxiangma.js?pk='+YXM_PUBLIC_KEY+'&v=YinXiangMa_PHPSDK_4.0');
		YXM_oldtag.parentNode.replaceChild(YXM_local,YXM_oldtag);  
		}
		setTimeout("YXM_local_check()",3000);
		document.write("<input type='hidden' id='YXM_here' /><script type='text/javascript' charset='gbk' id='YXM_script' src='http://api.yinxiangma.com/api3/yzm.yinxiangma.php?pk="+YXM_PUBLIC_KEY+"&v=YinXiangMaPHPSDK_4.0'><"+"/script>");
		</script> 
		<input type="submit" value="�ύ" />
		<input type="text" id="ajax_valid_result" value="������ʾ��ʾУ����" />
		</form>
    </body>
</html>
