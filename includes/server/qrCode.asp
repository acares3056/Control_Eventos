<%
	function qrCode(strText,intSize)
	    if strText = "this" then
	        strProtocol = "http"
	        strHTTPS = lcase(request.ServerVariables("HTTPS"))
	        if strHTTPS <> "off" then strProtocol = "https"
	        strDomain = Request.ServerVariables("SERVER_NAME")
	        strURL = Request.ServerVariables("SCRIPT_NAME")
	        strQueryString = Request.ServerVariables("QUERY_STRING")
	        strText = strProtocol & "://" & strDomain & strURL & "?" & strQueryString
	    end if

	    qrCode = "https://chart.googleapis.com/chart?cht=qr&chs=" & intSize & "x" & intSize & "&chld=L|1&chl=" & server.URLEncode(strText)

	end function

%>