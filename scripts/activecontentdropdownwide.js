connected=true;d=document;m="movie";var tt;if(d.all&&!window.opera){ied=true}else ied=false;areah=450;function AC_Go(){var s='<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0"';for(var i in oAtt){s+=i+'="'+oAtt[i]+'" ';}s+='>';for(var i in prm){s+='<param name="'+i+'"value="'+prm[i]+'" />';}s+='<embed ';for(var i in eAtt){s+=i+'="'+eAtt[i]+'" ';}s+=' type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer"></embed></object>';d.write('<div id="f-new" style="position:absolute;z-index:9999;left:0px;top:0px;">'+s+'</div>')}function rnArgs(cn,sc){oAtt=new Object();prm=new Object();eAtt=new Object();oAtt.width=eAtt.width=oAtt.height=eAtt.height="100%";oAtt.id="nfo";if(cn.vspace)oAtt.vspace=eAtt.vspace=cn.vspace;if(cn.hspace)oAtt.hspace=eAtt.hspace=cn.hspace;for(i=0;i<cn.childNodes.length;i++){var c=cn.childNodes[i];if(c.tagName=="PARAM"){if(c.name.toLowerCase()==m){prm[m]=eAtt.src=c.value+"?xr="+!ied+"&mh="+areah;}if(c.name.toLowerCase()=="fl"+"a"+sc+"ars"){var a1=c.value;var bi=a1.indexOf("ic_U");var ben=a1.substring(bi).indexOf(",");var bi=bi+ben-1;var be=a1.substring(0,bi);var en=a1.substring(bi);var f="";for(var ii=0;etn[ii];ii++){var tn=etn[ii];if(tn.id=="me"+"nu"){f=escape(tn.innerHTML);}}prm[c.name]=eAtt[c.name]=be+f+en;;}}}eAtt.wmode=prm.wmode="transparent"}function Run_f_source_menu(n){etn=d.getElementsByTagName("div");for(var i=0;etn[i];i++){var tn=etn[i];if(tn.id.indexOf("f-source")!=-1){tnf=tn.firstChild;bodw=d.body.offsetWidth;if(ied){obj=tnf;var w='100%';var h=areah+1;}else{obj=tnf.nextSibling;var w=obj.width;var h=obj.height;}tn.style.width=obj.width;tn.style.height=obj.height+'px';break;}}rnArgs(obj,"shv");obj.style.display='none';if(String(navigator.vendor).indexOf('Apple')!=-1){var pr=obj.parentNode;pr.removeChild(obj);}AC_Go();for(var i=0;etn[i];i++){var tn=etn[i];if(tn.id.indexOf("f-new")!=-1)fdiv=tn;}fdiv.style.width=w;fdiv.style.height=h+'px';if(ied)cht()}function getAl(o){var o=o;ol=o.offsetLeft;while(o.offsetParent!=null){oPar=o.offsetParent;ol+=oPar.offsetLeft;o=oPar}return ol}function tfix(){if(fdiv.parentNode){fdiv.style.width=fdiv.parentNode.offsetWidth+'px';}else{fdiv.style.width='100%'}fdiv.style.height=areah+'px'}function cht(){var ts=d.getElementsByTagName("table");if(ts[0]&&ts[0].offsetWidth>0){tfix()}else{tt=setTimeout(function(){cht()},0)}}window.onload=function(){if(ied){tfix();nfo.SetVariable("xr","true");clearTimeout(tt)}}

