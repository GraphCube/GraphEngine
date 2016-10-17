<cfparam name="URL.CNID" default="0">
<cfparam name="URL.refCall" default="MoneyHole">

<cfquery name="getMoney" datasource="#DataSource#">
SELECT *
FROM Money
WHERE CNID = #URL.CNID#
ORDER BY sector
</cfquery>
<cfquery name="gMember" datasource="#DataSource#">
SELECT district,name,party,statename,imageFile,nextElection
FROM congress
WHERE CNID = #URL.CNID#
</cfquery>
<!--- GET MAX VAL --->
<cfquery name="mxV" dbtype="query">
SELECT MAX(total) as mxMoney
FROM getMoney
</cfquery>
<cfset colorList=('##82E0AA,##73C6B6,##85C1E9,##BB8FCE,##F1948A,##F7DC6F,##27AE60,##E59866,##BFC9CA,##AEB6BF,##F39C12,##D7BDE2,##CB4335')>
<cfset colorListA=('##ABEBC6,##A2D9CE,##AED6F1,##D2B4DE,##F5B7B1,##F9E79F,##2ECC71,##EDBB99,##D5DBDB,##D6DBDF,##F8C471,##EBDEF0,##EC7063')>
<br clear="all">

<div style="float:left;padding-left:28px;margin-top:2px;margin-bottom:8px; vertical-align:middle;" class="f12">
<cfoutput query="gMember">
<div style="float:left;margin-right:5px;" class="f12">
<img src="http://www.graphcube.com/congressImg/#imageFile#" width="46px" class="roundBorder2" style="border:1px rgba(204,204,204,0.60) solid;">
</div>
<b class="f12"><cfif district EQ 0>Senator<cfelse>Representative</cfif> #name#</b><span class="f12"><div style="display:inline-block;margin:-2px 4px 0px 4px;width:14px;height:14px;-moz-border-radius:7px;-webkit-border-radius:7px;border-radius:7px;opacity:1;background-color:<cfif party EQ "Republican">red<cfelseif party EQ "Democratic">blue<cfelse>purple</cfif>; vertical-align:middle"></div>#party#: #statename#/<cfif district EQ 0>Senator<cfelse>#district#</cfif></span>
<br>
Next Election: <cfif gMember.nextElection EQ 0>Retiring<cfelseif gMember.nextElection EQ 1>Running for Senate<cfelseif gMember.nextElection EQ 2>Presidential Campaign<cfelse>#gMember.nextElection#</cfif><br>
</cfoutput>
<b>Total Contributions:</b> 
<cfset gTXC=0>
<cfoutput query="getMoney">
<cfset gTXC=(gTXC+total)>
</cfoutput>
<cfoutput><b>$#NumberFormat(gTXC,'9,999')#</b></cfoutput>
<br>
</div>
<br clear="all">


<div id="GraphContainer" style="padding-top:20px;padding-bottom:20px;border:0px solid #d5d5d5;">
<table border="0" cellspacing="0" cellpadding="0" width="96%">
<cfoutput query="getMoney">
<tr id="data#CurrentRow#">
<td class="f12" width="200px" height="20px;" align="right" style="padding-right:3px;border-right:1px solid ##CCCCCC;">#sector#</td>
<!---SET % Bars --->
<cfset mxP=Round((total/mxV.mxMoney)*100)>
<cfset vx=Round(total/1000)>
<cfset mxPC=Round((pac/mxV.mxMoney)*100)>
<cfset mxIN=Round((individual/mxV.mxMoney)*100)>
<cfif total EQ 0><cfset mxPCrw=0><cfelse><cfset mxPCrw=Round((pac/total)*100)></cfif>
<cfif total EQ 0><cfset mxINrw=0><cfelse><cfset mxINrw=Round((individual/total)*100)></cfif>
<td height="20px;"><div id="r#currentRow#Ax" style="float:left;height:16px;width:0%;background-color:#listGetAt(colorList, CurrentRow)#;display:block;text-align:right;padding-top:4px;<cfif currentrow LT getMoney.RecordCount>margin-bottom:1px;</cfif>" onMouseover="ddrivetip('<b>#sector#</b><br><span style=color:yellow;>PAC Contributions:</span> $#NumberFormat(PAC,'9,999')#<br>PAC = #mxPCrw#% of Total $#NumberFormat(total,'9,999')#')" onMouseout="hideddrivetip()" class="pointer myWTrans"><img src="images/1pxClear2.png" width="1" height="1" onLoad="document.getElementById('r#currentRow#Ax').style.width='#mxPC#%';"><cfif Round(mxPC+mxIN) GTE 80><cfif mxIN LT 20><cfif vx GTE 1000>$#NumberFormat(vx,'9,999')#
<cfelse><span class="black">$#vx# K</span></cfif>
<cfelse>
&nbsp;</cfif></cfif>
</div><div id="r#currentRow#Bx" style="float:left;height:16px;width:0%;background-color:#listGetAt(colorListA, CurrentRow)#;display:block;text-align:right;padding-top:4px;<cfif currentrow LT getMoney.RecordCount>margin-bottom:1px;</cfif>" onMouseover="ddrivetip('<b>#sector#</b><br><span style=color:lime;>Individual  Contributions:</span> $#NumberFormat(individual,'9,999')#<br>Individual = #mxINrw#% of Total $#NumberFormat(total,'9,999')#')" onMouseout="hideddrivetip()" class="pointer myWTrans black"><img src="images/1pxClear.png" width="1" height="1" onLoad="document.getElementById('r#currentRow#Bx').style.width='#mxIN#%';">
<cfif Round(mxPC+mxIN) GTE 80><cfif mxIN GTE 20><cfif vx GTE 1000>$#NumberFormat(vx,'9,999')#
<cfelse>$#vx#</cfif>
K&nbsp;&nbsp;<cfelse>
&nbsp;</cfif></cfif>
</div>
<cfif Round(mxPC+mxIN) GTE 80><cfelse><div style="float:left;padding-left:5px;padding-top:5px;" class="f09">
<cfif vx GTE 1000>$#NumberFormat(vx,'9,999')#
<cfelse>$#vx#
</cfif>K</div>
</cfif></td>
</tr>
</cfoutput>
</table>




</div><!---//GraphContainer--->
<!---<br clear="all">
<cfoutput>
<a nohref class="btnBL f10 pointer" style="float:left;padding:4px;margin-left:4px;" onClick="document.getElementById('#URL.refCall#').style.display='none';"> Close Chart </a>
<br clear="all">
CNID: #URL.CNID#
<br>
</cfoutput>--->
<br clear="all">
<!---<cfdump var="#getMoney#">--->
<!---<cfoutput query="getMoney">
#Sector# $#NumberFormat(PAC,'9,999')# $#NumberFormat(individual,'9,999')#<br>
</cfoutput>--->
