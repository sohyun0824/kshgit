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

<a href="/uploadForm">/uploadForm</a><br>
<a href="/uploadAjax">/uploadAjax</a><br>
<a href="/display?fileName=2020/08/25/test.png">/display?fileName=2020/08/25/test.png</a>

</body>
</html>
