<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<a href="/sample/getText">/sample/getText</a><br>
<a href="/sample/getSample">/sample/getSample</a><br>
<a href="/sample/getSample.json">/sample/getSample.json</a><br>
<a href="/sample/getSample2">/sample/getSample2</a><br>
<a href="/sample/getList">/sample/getList</a><br>
<a href="/sample/getMap">/sample/getMap</a><br>
<a href="/sample/check.json?height=140&weight=60">/sample/check.json?height=140&weight=60</a><br>
<a href="/sample/check.json?height=160&weight=60">/sample/check.json?height=160&weight=60</a><br>
<a href="/sample/product/bags/1234">/sample/product/bags/1234</a><br>


<a href="/board/list">/board/list</a><br>
</body>
</html>
