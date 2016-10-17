<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
<link href="../style/control.css" rel="stylesheet" type="text/css">
<cfparam name="URL.xTopScale" default="100">
<cfparam name="URL.xBottomScale" default="100">
<cfparam name="URL.yLeftScale" default="100">
<cfparam name="URL.yBottomScale" default="100">
<cfparam name="URL.MXval" default="1000000">
<cfparam name="URL.title" default="Money Sources">
<cfparam name="URL.vCount" default="13">
<cfparam name="URL.CNID" default="0">
<!---SET THE GRID SCALES--->
<cfif URL.MXval GT 1000000>
	<cfset xTopScale=(URL.MXval/10^6)>
    <cfset sFactor='M'>
<cfelseif URL.MXval GTE 1000 AND URL.MXval LTE 1000000>
	<cfset xTopScale=(URL.MXval/10^3)>
    <cfset sFactor='K'>
<cfelse>
	<cfset sFactor=''>
</cfif>
<!---//GRID SCALES--->


</head>

<body>
<br clear="all">
<div id="pageContainer" style="width:50%;padding-top:25px;">
<br clear="all">

<div id="graphContainer" style="position:relative;float:left; width:80%;margin-left:65px;min-height:200px;border-width:1px 1px 1px 1px;border-color:#ABABAB;border-style:solid;background-color:rgba(147,167,199,0.20);">

<!---TOP TITLE--->
<cfoutput>
<div id="topAxis" style="position:relative;margin-top:-35px;text-align:center;" class="f11">#URL.Title# <cfif LEN(sFactor) GT 0>(#sFactor#$)</cfif></div>
<!---//TOP TITLE--->
</cfoutput>

<!---0 VALUE LABLE--->
<div style="float:left;position:absolute;width:5%;margin-left:-2px;margin-top:8px;" class="f08">0</div>
<!---//0VALUE LABLE--->



<cfloop index="g" from="1" to="10">
<cfoutput>
<cfset xAXT=(Round(g*URL.MXval/10))>
<cfset xAXTp=(g*10)>
<cfset tMoveLeft='-3'>
<cfif xAXT GTE 1000 AND xAXT LT 1000000>
	<cfset displayFactor=(10^3)>
    <cfset displayN='K'>
<cfelseif xAXT GTE 1000000>
	<cfset displayFactor=(10^6)>
    <cfset displayN='M'>
<cfelse>
	<cfset displayFactor=(1)>
    <cfset displayN=''>
</cfif>
<cfif LEN(Round(xAXT/displayFactor)) EQ 2>
	<cfset tMoveLeft='-8'>
<cfelseif LEN(Round(xAXT/displayFactor)) EQ 3>
	<cfset tMoveLeft='-9'>
<cfelse>
	<cfset tMoveLeft='-6'>
</cfif>
<cfset gridLen=(URL.vCount*15+7)>
<div style="float:left;position:absolute;left:#xAXTp#%;height:#gridLen#px;border-width:0px 0px 0px 1px;border-style:dotted;border-color:##B0B0B0;margin-top:20px;z-index:1;text-align:center;"><div style="margin-left:#tMoveLeft#px;z-index:35;margin-top:-12px;" class="f08">#Round(xAXT/displayFactor)##displayN#</div></div>
</cfoutput>
</cfloop>







</div><!---//GraphContainer--->

</div><!---//PageContainer--->

</body>
</html>