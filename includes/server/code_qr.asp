<%

Function GenerateQRCode(content, destino)
    Dim xmlhttp, url, qrCodeFileName, qrCodeFilePath
    Set xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
    url = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" & Server.URLEncode(content)
    qrCodeFileName = "qrcode_" & hora_numerica() & ".png"
    qrCodeFilePath = destino & qrCodeFileName

    xmlhttp.Open "GET", url, False
    xmlhttp.Send
    
    If xmlhttp.Status = 200 Then
        Dim binaryStream
        Set binaryStream = Server.CreateObject("ADODB.Stream")
        binaryStream.Type = 1 ' Binary
        binaryStream.Open
        binaryStream.Write xmlhttp.responseBody
        binaryStream.SaveToFile qrCodeFilePath, 2 ' Overwrite
        binaryStream.Close
        Set binaryStream = Nothing
    End If
    
    Set xmlhttp = Nothing
    GenerateQRCode = qrCodeFilePath
End Function

function hora_numerica()

    hora= right("00" & hour(now()), 2)
    minuto= right("00" & minute(now()), 2)
    segundo= right("00" & second(now()), 2)

    hora_numerica = hora & minuto & segundo
end Function

%>