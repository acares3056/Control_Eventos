<%
' Conéctate a tu base de datos aquí y realiza la consulta para obtener los datos de los clientes
' Supongamos que obtienes los datos y los almacenas en un recordset llamado rsClientes

' Configura la cadena de conexión a tu base de datos
Dim connectionString
connectionString = "tu_cadena_de_conexion_a_la_base_de_datos"

' Crea un objeto de conexión a la base de datos
Set connection = Server.CreateObject("ADODB.Connection")

' Abre la conexión a la base de datos
connection.Open connectionString

' Realiza la consulta SQL para obtener los datos de los clientes
sql = "SELECT IDCliente, Nombre, Apellido FROM Clientes"
Set rsClientes = connection.Execute(sql)

' Formatea los datos en formato JSON
response.write "{""data"": ["
Do Until rsClientes.EOF
    response.write "{"
    response.write """IDCliente"": """ & rsClientes("IDCliente") & """, "
    response.write """Nombre"": """ & rsClientes("Nombre") & """, "
    response.write """Apellido"": """ & rsClientes("Apellido") & """"
    ' Puedes agregar más campos aquí según tus necesidades
    response.write "}"
    If Not rsClientes.EOF Then response.write ","
    rsClientes.MoveNext
Loop
response.write "]}"
%>
