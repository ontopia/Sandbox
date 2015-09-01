<%@ include file="declarations.jsp"%>
<%
  boolean mainpage = false;
%>
<html>
<head>
  <title>Ontopia - <template:get name="title"/></title> 
  <link rel="stylesheet" type="text/css" href="resources/stylesheet.css"></link>
  <template:get name="headertags"/>
</head>

<body>

<%@ include file="topbox.jsp"%>

<div class=home>Home/</div>
<div class=breadcrumbs><template:get name="breadcrumbs"/></div>

<table class=contentbox>
<tr><td class=menu>
  <template:get name="menu"/>

<td class=spacer>

<td class="main">

<div class=breadcrumbs><template:get name="title"/></div>

<template:get name="main"/>

<tr><td colspan="3" id="bottom-spacer">
</table>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-39133770-8', 'auto');
  ga('send', 'pageview');

</script>
</body>
</html>

