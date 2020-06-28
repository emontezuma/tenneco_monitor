Imports DevExpress.XtraEditors
Imports DevExpress.Skins
Imports MySql.Data.MySqlClient
Imports System.Speech.Synthesis
Imports System.IO.Ports
Imports System.IO
Imports System.Text
Imports System.Net.Mail
Imports System.Net.Http
Imports System.Net
Imports System.ComponentModel

Public Class XtraForm1
    Dim Estado As Integer = 0
    Dim procesandoInfoFallas As Boolean = False
    Dim procesandoAudios As Boolean = False
    Dim procesandoEscalamientos As Boolean
    Dim procesandoRepeticiones As Boolean
    Dim estadoPrograma As Boolean
    Dim eSegundos = 0
    Dim MensajeLlamada = ""
    Dim procesandoMensajes As Boolean = False
    Dim procesandoCorreos As Boolean = False
    Dim errorPuerto As Boolean = False
    Dim errorCorreos As String

    Private Sub XtraForm1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        If Process.GetProcessesByName _
          (Process.GetCurrentProcess.ProcessName).Length > 1 Then

            Application.Exit()
        End If
        estadoPrograma = True
        ListBoxControl1.Items.Clear()
        agregarLOG("Se incicia el programa", 1, 0)
        Try
            agregarLOG("Se inicia la aplicación de Envío de correos", 1, 0)
            'elvis Shell(Application.StartupPath & "\vbCorreos.exe", AppWinStyle.MinimizedNoFocus)
        Catch ex As Exception
            agregarLOG("Error en la ejecución de la aplicación de envío de correos. Error: " & ex.Message, 7, 0)
        End Try
        horaDesde = Now
        Dim cadSQL As String = "SELECT flag_agregar FROM sigma.configuracion"
        Dim reader As DataSet = consultaSEL(cadSQL)
        Dim regsAfectados = 0
        If errorBD.Length > 0 Then
            BarManager1.Items(2).Visibility = DevExpress.XtraBars.BarItemVisibility.Always
            BarManager1.Items(1).Visibility = DevExpress.XtraBars.BarItemVisibility.Never
            agregarLOG("No se logró la conexión con MySQL. Error: " + errorBD, 9, 0)

        Else
            BarManager1.Items(2).Visibility = DevExpress.XtraBars.BarItemVisibility.Never
            BarManager1.Items(1).Visibility = DevExpress.XtraBars.BarItemVisibility.Always
            agregarLOG("Conexión satisfactoria a MySQL", 1, 0)
            iniciarPantalla()
        End If
        depurar()
        enviarCorreos()
        ContarLOG()
    End Sub

    Sub iniciarPantalla()
        Dim regsAfectados As Integer = 0
        'Se escribe en la base de datos
        regsAfectados = consultaACT("UPDATE sigma.configuracion SET ejecutando_desde = '" & Format(Now, "yyyy/MM/dd HH:mm:ss") & "'")
        If errorBD.Length > 0 Then
            'Error en la base de datos
            agregarLOG("Ocurrió un error al intentar ejecutar una actualización en la base de datos de SIGMA. Error: " + errorBD, 9, 0)
        ElseIf regsAfectados = 0 Then
            regsAfectados = consultaACT("INSERT INTO configuracion (ejecutando_desde, revisar_cada) VALUES ('" & Format(horaDesde, "yyyy/MM/dd HH:mm:ss") & "', 60)")
        End If
        BarManager1.Items(3).Caption = "Ejecutandose desde: " + Format(horaDesde, "ddd, dd-MMM-yyyy HH:mm:ss")
        calcularRevision()
    End Sub

    Private Sub XtraForm1_SizeChanged(sender As Object, e As EventArgs) Handles Me.SizeChanged
        ListBoxControl1.Width = Me.Width - 30
        GroupControl1.Width = ListBoxControl1.Width
        ListBoxControl1.Height = Me.Height - 250
        SimpleButton3.Left = Me.Width - SimpleButton3.Width - 20
        SimpleButton2.Left = Me.Width - SimpleButton2.Width - 20

    End Sub

    Private Sub SimpleButton1_Click(sender As Object, e As EventArgs) Handles SimpleButton1.Click
        If XtraMessageBox.Show("El log actual se quitará de la pantalla definitivamente. ¿Desea continuar?", "Inicializar LOG en pantalla", MessageBoxButtons.YesNo, MessageBoxIcon.Question) <> DialogResult.No Then
            Dim totalRegs As Integer = ListBoxControl1.Items.Count
            ListBoxControl1.Items.Clear()
            ListBoxControl1.Items.Add(Format(Now, "dd-MMM-yyyy HH:mm:ss") & ": " + "Se inicializa el LOG a solicitud del usuario. Se eliminan " & totalRegs & " registro(s) del LOG acumulandose desde " & Format(horaDesde, "dd-MMM-yyyy HH:mm:ss"))
            horaDesde = Now
            ContarLOG()
        End If
    End Sub

    Private Sub SimpleButton3_Click(sender As Object, e As EventArgs) Handles SimpleButton3.Click
        autenticado = False
        Dim Forma As New XtraForm2
        Forma.Text = "Detener aplicación"
        Forma.ShowDialog()
        If autenticado Then
            If XtraMessageBox.Show("Esta acción detendrá el envío de alertas. ¿Desea detener el monitor de alertas?", "Detener la aplicación", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) <> DialogResult.No Then
                Estado = 1
                SimpleButton3.Visible = False
                SimpleButton2.Visible = True
                ContextMenuStrip1.Items(1).Enabled = False
                ContextMenuStrip1.Items(2).Enabled = True
                estadoPrograma = False
                agregarLOG("La interfaz ha sido detenida por el usuario: " & usuarioCerrar, 9, 0)
            End If
        End If
    End Sub

    Private Sub SimpleButton2_Click(sender As Object, e As EventArgs) Handles SimpleButton2.Click
        If XtraMessageBox.Show("Esta acción reanudará el envío de alertas. ¿Desea reanudar el monitor de alertas?", "Reanudar la aplicación", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) <> DialogResult.No Then
            Estado = 1
            SimpleButton3.Visible = True
            SimpleButton2.Visible = False
            ContextMenuStrip1.Items(1).Enabled = True
            ContextMenuStrip1.Items(2).Enabled = False
            enviarCorreos()
            estadoPrograma = True
            agregarLOG("La interfaz ha sido reanudada por un usuario", 9, 0)
        End If
    End Sub

    Private Sub agregarLOG(cadena As String, tipo As Integer, reporte As Integer, Optional aplicacion As Integer = 1)
        'Se agrega a la base de datos
        'tipo 1: Info
        'tipo 2: Incongruencia en los datos (usuario)
        'tipo 8: Error crítico de Base de datos infofallas
        'tipo 9: Error crítico de Base de datos sigma
        Dim regsAfectados = consultaACT("INSERT INTO sigma.log (aplicacion, tipo, reporte, texto) VALUES (0, " & tipo & ", " & reporte & ", '" & Microsoft.VisualBasic.Strings.Left(cadena, 250) & "')")
        If aplicacion = 10 Then
            regsAfectados = consultaACT("UPDATE sigma.configuracion SET flag_monitor = 'S'")
        End If

    End Sub

    Private Sub ContarLOG()
        If ListBoxControl1.Items.Count > 2000 Then
            For i = ListBoxControl1.Items.Count - 1 To 2000 Step -1
                ListBoxControl1.Items.RemoveAt(i)
            Next
        End If
        BarManager1.Items(4).Caption = IIf(ListBoxControl1.Items.Count = 0, "Ningún registro en el LOG", IIf(ListBoxControl1.Items.Count = 1, "Un registro en el LOG", ListBoxControl1.Items.Count & " registros en el LOG"))
    End Sub

    Private Sub HyperlinkLabelControl1_Click(sender As Object, e As EventArgs) Handles HyperlinkLabelControl1.Click
        System.Diagnostics.Process.Start("www.mmcallmexico.mx")
    End Sub

    Private Sub ComboBoxEdit2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ComboBoxEdit2.SelectedIndexChanged
        Dim MiFuente As Font = New System.Drawing.Font("Lucida Sans", 9, FontStyle.Regular)

        If ComboBoxEdit2.SelectedIndex = 0 Then

            ListBoxControl1.Font = MiFuente

        ElseIf ComboBoxEdit2.SelectedIndex = 1 Then
            MiFuente = New System.Drawing.Font("Lucida Sans", 6, FontStyle.Regular)
            ListBoxControl1.Font = MiFuente
        ElseIf ComboBoxEdit2.SelectedIndex = 2 Then
            MiFuente = New System.Drawing.Font("Lucida Sans", 7, FontStyle.Regular)
            ListBoxControl1.Font = MiFuente

        ElseIf ComboBoxEdit2.SelectedIndex = 3 Then
            MiFuente = New System.Drawing.Font("Lucida Sans", 11, FontStyle.Regular)
            ListBoxControl1.Font = MiFuente
        ElseIf ComboBoxEdit2.SelectedIndex = 4 Then
            MiFuente = New System.Drawing.Font("Lucida Sans", 13, FontStyle.Regular)
            ListBoxControl1.Font = MiFuente
        ElseIf ComboBoxEdit2.SelectedIndex = 5 Then
            MiFuente = New System.Drawing.Font("Lucida Sans", 15, FontStyle.Regular)
            ListBoxControl1.Font = MiFuente
        End If
    End Sub

    Private Sub revisaFlag_Tick(sender As Object, e As EventArgs) Handles revisaFlag.Tick
        If procesandoInfoFallas Or Not estadoPrograma Then Exit Sub

        procesandoInfoFallas = True
        revisaFlag.Enabled = False
        paseaStock()
        cancelarAlertas()
        calcularEstimado()
        asignarCarga()
        alertaSO()
        alertaTSE()
        alertaTSEAnticipado()
        alertaTPE()
        alertaTPEAnticipado()
        alertaProgramacion()
        alertaProgramacionAnticipado()
        'Se revisan los lotes en espera

        procesandoInfoFallas = False
        revisaFlag.Enabled = True

    End Sub
    Sub calcularEstimado()
        Dim cadSQL As String = "SELECT id, ruta, inicia FROM sigma.lotes WHERE ISNULL(estimada)"
        Dim reader As DataSet = consultaSEL(cadSQL)
        Dim regsAfectados = 0
        Dim pases1 = 0
        Dim pases2 = 0

        If errorBD.Length > 0 Then
            agregarLOG("Ocurrió un error al intentar leer MySQL. Error: " + Microsoft.VisualBasic.Strings.Left(errorBD, 250), 9, 0)
        Else
            If reader.Tables(0).Rows.Count > 0 Then
                For Each lotes In reader.Tables(0).Rows
                    cadSQL = "SELECT proceso, tiempo_stock, tiempo_proceso, tiempo_setup FROM sigma.det_rutas WHERE estatus = 'A' AND ruta = " & lotes!ruta & " ORDER BY secuencia"
                    Dim procesos As DataSet = consultaSEL(cadSQL)
                    Dim fechaInicial = lotes!inicia
                    Dim fechaHasta = fechaInicial
                    If procesos.Tables(0).Rows.Count > 0 Then
                        Dim tiempoEstimadoTotal = 0
                        For Each operaciones In procesos.Tables(0).Rows
                            fechaHasta = calcularFechaEstimada(fechaInicial, operaciones!tiempo_stock, operaciones!proceso)
                            fechaHasta = calcularFechaEstimada(fechaHasta, operaciones!tiempo_proceso + operaciones!tiempo_setup, operaciones!proceso)
                            fechaInicial = fechaHasta
                        Next
                        pases1 = pases1 + 1
                        regsAfectados = consultaACT("UPDATE sigma.lotes SET tiempo_estimado = " & DateAndTime.DateDiff(DateInterval.Second, lotes!inicia, fechaHasta) & ", estimada = '" & Format(fechaInicial, "yyyy/MM/dd HH:mm:ss") & "', calcular_hasta = 'N' WHERE id = " & lotes!id)
                    End If
                Next
            End If
        End If

        cadSQL = "SELECT a.id, a.proceso, b.tiempo_stock, b.tiempo_proceso, b.tiempo_setup, a.fecha_entrada FROM sigma.lotes_historia a LEFT JOIN sigma.det_rutas b ON a.ruta_detalle = b.id WHERE ISNULL(a.fecha_estimada)"
        reader = consultaSEL(cadSQL)
        regsAfectados = 0
        If errorBD.Length > 0 Then
            agregarLOG("Ocurrió un error al intentar leer MySQL. Error: " + Microsoft.VisualBasic.Strings.Left(errorBD, 250), 9, 0)
        Else
            Dim pases = 0
            If reader.Tables(0).Rows.Count > 0 Then
                For Each lotes In reader.Tables(0).Rows
                    Dim fechaHasta = calcularFechaEstimada(lotes!fecha_entrada, lotes!tiempo_stock + lotes!tiempo_proceso + lotes!tiempo_setup, lotes!proceso)
                    regsAfectados = consultaACT("UPDATE sigma.lotes_historia SET tiempo_estimado = " & lotes!tiempo_stock + lotes!tiempo_proceso + lotes!tiempo_setup & ",fecha_estimada = '" & Format(fechaHasta, "yyyy/MM/dd HH:mm:ss") & "' WHERE id = " & lotes!id)
                    pases2 = pases2 + 1
                Next
            End If
        End If
        If pases1 > 0 Then agregarSolo("Se calculó el estimado de fecha de entrega para " & pases1 & " lote(s)")
        If pases2 > 0 Then agregarSolo("Se calculó el estimado de fecha de entrega para " & pases2 & "  histórico de lote(s)")

    End Sub

    Sub alertaProgramacion()

        Dim tiempo_holgura = 0
        Dim regsAfectados = 0
        Dim holgura_reprogramar = 0
        Dim veces = 0
        Dim pases = 0
        Dim cadSQL As String = "SELECT * FROM sigma.configuracion"
        Dim readerDS As DataSet = consultaSEL(cadSQL)
        If readerDS.Tables(0).Rows.Count > 0 Then
            Dim readerConfig As DataRow = readerDS.Tables(0).Rows(0)
            tiempo_holgura = ValNull(readerConfig!tiempo_holgura, "N")
            holgura_reprogramar = ValNull(readerConfig!holgura_reprogramar, "N")
        End If

        cadSQL = "SELECT a.id, a.carga, a.alarma, a.alarma_rep, a.permitir_reprogramacion, a.equipo, a.fecha, IFNULL(b.nombre, 'N/A') as nequipo, IFNULL(c.nombre, 'N/A') as nproceso, IFNULL((SELECT SUM(cantidad) FROM sigma.programacion WHERE carga = a.id AND estatus = 'A'), 0) AS piezas, (SELECT COUNT(*) FROM sigma.lotes WHERE carga = a.id) AS avance, b.proceso FROM sigma.cargas a LEFT JOIN sigma.det_procesos b ON a.equipo = b.id AND b.estatus = 'A' LEFT JOIN sigma.cat_procesos c ON b.proceso = c.id AND c.estatus = 'A' WHERE a.estatus = 'A'  AND a.completada = 'N'"
        Dim falla As DataSet = consultaSEL(cadSQL)
        If falla.Tables(0).Rows.Count > 0 Then
            For Each lotes In falla.Tables(0).Rows
                If DateAndTime.DateAdd(DateInterval.Second, tiempo_holgura, lotes!fecha) <= Now() And lotes!piezas > lotes!avance And lotes!alarma = "S" And lotes!alarma_rep <> "S" Then

                    cadSQL = "SELECT * FROM sigma.cat_alertas WHERE tipo = 3 AND (proceso = 0 or proceso = " & lotes!proceso & ") AND estatus = 'A' ORDER BY proceso DESC"
                    Dim alerta As DataSet = consultaSEL(cadSQL)
                    Dim uID = 0

                    If alerta.Tables(0).Rows.Count > 0 Then

                        Dim idAlerta = alerta.Tables(0).Rows(0)!id
                        Dim fechaDesde
                        Dim crearReporte As Boolean = False

                        regsAfectados = consultaACT("UPDATE sigma.alarmas SET fin = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), inicio)) WHERE lote = " & lotes!id & " AND tipo = 7")
                        regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET estado = 9, atendida = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), activada)) WHERE id NOT IN (SELECT reporte FROM sigma.alarmas WHERE tiempo = 0) AND estado <> 9;")

                        Dim porAcumulacion = False
                        If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "N" Then
                            'Se pregunta si hay un rperte activo y si es solapable
                            'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                            crearReporte = True
                            'Else
                            'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                            'Dim solapar As DataSet = consultaSEL(cadSQL)
                            'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                            'End If

                        Else
                            porAcumulacion = True
                            If ValNull(alerta.Tables(0).Rows(0)!acumular_inicializar, "A") = "S" Then
                                If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                    fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                    cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                                Else
                                    cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 "
                                End If
                            Else
                                If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                    fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                    cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                                Else
                                    cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta
                                End If
                            End If

                            Dim acumulado = 0
                            Dim acum As DataSet = consultaSEL(cadSQL)
                            If acum.Tables(0).Rows.Count > 0 Then
                                acumulado = acum.Tables(0).Rows(0)!cuenta
                            End If
                            If acumulado + 1 >= alerta.Tables(0).Rows(0)!acumular_veces Then
                                veces = acumulado + 1
                                'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                                crearReporte = True
                                'Else
                                'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                                'Dim solapar As DataSet = consultaSEL(cadSQL)
                                'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                                'End If
                            End If
                        End If
                        If crearReporte Then
                            regsAfectados = consultaACT("INSERT INTO sigma.vw_reportes (alerta, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, estado) SELECT id, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, 1 FROM sigma.cat_alertas WHERE id = " & alerta.Tables(0).Rows(0)!id)
                            'Se obtieneel último ID
                            cadSQL = "SELECT MAX(id) as ultimo FROM sigma.vw_reportes"
                            Dim ultimo As DataSet = consultaSEL(cadSQL)
                            If ultimo.Tables(0).Rows.Count > 0 Then
                                uID = ultimo.Tables(0).Rows(0)!ultimo
                            End If


                            regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, reporte, accion) VALUES (3, " & lotes!proceso & ", " & lotes!id & ", NOW(), " & idAlerta & ", " & uID & ", 1)")
                            If porAcumulacion Then
                                If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                    regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 And inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "' AND accion = 0")
                                Else
                                    regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 AND accion = 0")
                                End If
                            End If
                        Else
                            'Se crear la alarma suelta

                            regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, accion) VALUES (3, " & lotes!proceso & ", " & lotes!id & ", NOW(), " & idAlerta & ", " & IIf(porAcumulacion, 0, 4) & ")")

                        End If

                        If crearReporte Then
                            pases = pases + 1
                            'Se generan los mensajes a enviar
                            Dim mensajeMMCall As String = Microsoft.VisualBasic.Strings.Left("TIEMPO EXCEDIDO CARGA " & lotes!carga, 40).Trim
                            Dim mensaje As String = "TIEMPO DE CARGA EXCEDIDO" & vbCrLf & "Carga: " & lotes!carga & vbCrLf & "Equipo: " & lotes!nequipo & vbCrLf & "Proceso: " & lotes!nproceso & vbCrLf & "Fecha promesa: " & Format(lotes!fecha, "ddd, dd-MMM-yyyy HH:mm") & vbCrLf & "Demora (H:MM:SS): " & calcularTiempoCad(DateAndTime.DateDiff(DateInterval.Second, lotes!fecha, DateAndTime.Now))
                            mensaje = mensaje.Trim
                            If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "S" Then
                                If ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "T" Then
                                    mensaje = "Hay " & veces & " mensajes de TIEMPO DE CARGA EXCEDIDO por atender"
                                    mensajeMMCall = "Hay " & veces & " TIEMPO CARGAS/EXCED"
                                ElseIf ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "P" Then
                                    mensaje = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 200)
                                    mensajeMMCall = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 40)
                                End If
                            End If
                            'Se cambian los caracteres especiales
                            mensajeMMCall = UCase(mensajeMMCall)
                            mensajeMMCall = Replace(mensajeMMCall, "Á", "A")
                            mensajeMMCall = Replace(mensajeMMCall, "É", "E")
                            mensajeMMCall = Replace(mensajeMMCall, "Í", "I")
                            mensajeMMCall = Replace(mensajeMMCall, "Ó", "O")
                            mensajeMMCall = Replace(mensajeMMCall, "Ú", "U")
                            mensajeMMCall = Replace(mensajeMMCall, "Ü", "U")
                            mensajeMMCall = Replace(mensajeMMCall, "Ñ", "~")
                            mensajeMMCall = Replace(mensajeMMCall, ":", " ")


                            If mensaje.Length = 0 Then
                                mensaje = "Hay tiempos excedidos de programación por atender"
                                agregarLOG("La alerta" & idAlerta & " no tiene un mensaje definido se tomó el mensaje por defecto", 1, 2)
                            End If
                            If mensajeMMCall.Length = 0 Then
                                mensajeMMCall = "Hay cargas/exced"
                                agregarLOG("La alerta" & idAlerta & " no tiene un mensaje para MMCall definido se tomó el mensaje por defecto", 1, 2)
                            End If
                            'If ValNull(alerta.Tables(0).Rows(0)!log, "A") = "S" Then
                            ' regsAfectados = consultaACT("INSERT INTO sigma.log (aplicacion, tipo, alerta, texto) VALUES (10, 1, " & idAlerta '& ", '" & mensaje & "')")
                            'End If

                            If ValNull(alerta.Tables(0).Rows(0)!llamada, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 1, 0, mensaje)
                            If ValNull(alerta.Tables(0).Rows(0)!sms, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 2, 0, mensaje)
                            If ValNull(alerta.Tables(0).Rows(0)!correo, "A") = "S" Then agregarMensaje("correos", alerta.Tables(0).Rows(0)!lista, uID, 0, 3, 0, mensaje)
                            If ValNull(alerta.Tables(0).Rows(0)!mmcall, "A") = "S" Then agregarMensaje("mmcall", alerta.Tables(0).Rows(0)!lista, uID, 0, 4, 0, mensajeMMCall)
                            agregarLOG("Se ha creado el reporte: " & uID & IIf(porAcumulacion, " por acumulación de saltos de operación", ""), 1, uID)
                        End If

                        regsAfectados = consultaACT("UPDATE sigma.cargas SET alarma_rep = 'S' WHERE id = " & lotes!id)
                    End If

                End If
            Next
            If pases > 0 Then agregarSolo("Se generaron " & pases & " alarma(s) por Fecha de carga vencida")
        End If
    End Sub

    Sub alertaProgramacionAnticipado()

        Dim tiempo_holgura = 0
        Dim regsAfectados = 0
        Dim holgura_reprogramar = 0
        Dim veces = 0
        Dim pases = 0
        Dim cadSQL As String = "SELECT * FROM sigma.configuracion"
        Dim readerDS As DataSet = consultaSEL(cadSQL)
        If readerDS.Tables(0).Rows.Count > 0 Then
            Dim readerConfig As DataRow = readerDS.Tables(0).Rows(0)
            tiempo_holgura = ValNull(readerConfig!tiempo_holgura, "N")
            holgura_reprogramar = ValNull(readerConfig!holgura_reprogramar, "N")
        End If

        cadSQL = "SELECT a.id, a.carga, a.alarma, a.alarma_rep_p, a.permitir_reprogramacion, a.equipo, a.fecha, IFNULL(b.nombre, 'N/A') as nequipo, TIME_TO_SEC(TIMEDIFF(a.fecha, NOW())) AS previo, IFNULL(c.nombre, 'N/A') as nproceso, IFNULL((SELECT SUM(cantidad) FROM sigma.programacion WHERE carga = a.id AND estatus = 'A'), 0) AS piezas, (SELECT COUNT(*) FROM sigma.lotes WHERE carga = a.id) AS avance, b.proceso FROM sigma.cargas a LEFT JOIN sigma.det_procesos b ON a.equipo = b.id AND b.estatus = 'A' LEFT JOIN sigma.cat_procesos c ON b.proceso = c.id AND c.estatus = 'A' WHERE a.estatus = 'A' AND TIME_TO_SEC(TIMEDIFF(a.fecha, NOW())) > 0 AND TIME_TO_SEC(TIMEDIFF(a.fecha, NOW())) <= (SELECT MAX(tiempo0) FROM sigma.cat_alertas WHERE tipo = 7 AND estatus = 'A' AND (proceso = 0 OR proceso = b.proceso)) AND a.completada = 'N'"

        Dim falla As DataSet = consultaSEL(cadSQL)
        If falla.Tables(0).Rows.Count > 0 Then
            For Each lotes In falla.Tables(0).Rows
                If lotes!piezas > lotes!avance And lotes!alarma = "S" And lotes!alarma_rep_p <> "S" Then

                    cadSQL = "SELECT * FROM sigma.cat_alertas WHERE tipo = 7 AND estatus = 'A' AND (proceso = 0 OR proceso = " & lotes!proceso & ") ORDER BY tiempo0 DESC LIMIT 1"

                    Dim alerta As DataSet = consultaSEL(cadSQL)
                    Dim uID = 0

                    If alerta.Tables(0).Rows.Count > 0 Then

                        Dim idAlerta = alerta.Tables(0).Rows(0)!id
                        Dim fechaDesde
                        Dim crearReporte As Boolean = False


                        Dim porAcumulacion = False
                        If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "N" Then
                            'Se pregunta si hay un rperte activo y si es solapable
                            'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                            crearReporte = True
                            'Else
                            'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                            'Dim solapar As DataSet = consultaSEL(cadSQL)
                            'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                            'End If

                        Else
                            porAcumulacion = True
                            If ValNull(alerta.Tables(0).Rows(0)!acumular_inicializar, "A") = "S" Then
                                If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                    fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                    cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                                Else
                                    cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 "
                                End If
                            Else
                                If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                    fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                    cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                                Else
                                    cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta
                                End If
                            End If

                            Dim acumulado = 0
                            Dim acum As DataSet = consultaSEL(cadSQL)
                            If acum.Tables(0).Rows.Count > 0 Then
                                acumulado = acum.Tables(0).Rows(0)!cuenta
                            End If
                            If acumulado + 1 >= alerta.Tables(0).Rows(0)!acumular_veces Then
                                veces = acumulado + 1
                                'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                                crearReporte = True
                                'Else
                                'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                                'Dim solapar As DataSet = consultaSEL(cadSQL)
                                'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                                'End If
                            End If
                        End If
                        If crearReporte Then
                            regsAfectados = consultaACT("INSERT INTO sigma.vw_reportes (alerta, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, estado) SELECT id, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, 1 FROM sigma.cat_alertas WHERE id = " & alerta.Tables(0).Rows(0)!id)
                            'Se obtieneel último ID
                            cadSQL = "SELECT MAX(id) as ultimo FROM sigma.vw_reportes"
                            Dim ultimo As DataSet = consultaSEL(cadSQL)
                            If ultimo.Tables(0).Rows.Count > 0 Then
                                uID = ultimo.Tables(0).Rows(0)!ultimo
                            End If


                            regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, reporte, accion) VALUES (7, " & lotes!proceso & ", " & lotes!id & ", NOW(), " & idAlerta & ", " & uID & ", 1)")
                            If porAcumulacion Then
                                If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                    regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 And inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "' AND accion = 0")
                                Else
                                    regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 AND accion = 0")
                                End If
                            End If
                        Else
                            'Se crear la alarma suelta

                            regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, accion) VALUES (7, " & lotes!proceso & ", " & lotes!id & ", NOW(), " & idAlerta & ", " & IIf(porAcumulacion, 0, 4) & ")")

                        End If

                        If crearReporte Then
                            pases = pases + 1
                            'Se generan los mensajes a enviar
                            Dim mensajeMMCall As String = Microsoft.VisualBasic.Strings.Left("ANTICIPICACION CARGA " & lotes!carga, 40).Trim
                            Dim mensaje As String = "ANTICIPACION POR TIEMPO DE CARGA EXCEDIDO" & vbCrLf & "Carga: " & lotes!carga & vbCrLf & "Equipo: " & lotes!nequipo & vbCrLf & "Proceso: " & lotes!nproceso & vbCrLf & "Fecha promesa: " & Format(lotes!fecha, "ddd, dd-MMM-yyyy HH:mm") & vbCrLf & "Anticipación (H:MM:SS): " & calcularTiempoCad(lotes!previo)
                            mensaje = mensaje.Trim
                            If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "S" Then
                                If ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "T" Then
                                    mensaje = "Hay " & veces & " mensajes de ANTICPACION POR TIEMPO DE CARGA EXCEDIDO por atender"
                                    mensajeMMCall = "Hay " & veces & " ANTICIP CARGAS/EXCED"
                                ElseIf ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "P" Then
                                    mensaje = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 200)
                                    mensajeMMCall = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 40)
                                End If
                            End If
                            'Se cambian los caracteres especiales
                            mensajeMMCall = UCase(mensajeMMCall)
                            mensajeMMCall = Replace(mensajeMMCall, "Á", "A")
                            mensajeMMCall = Replace(mensajeMMCall, "É", "E")
                            mensajeMMCall = Replace(mensajeMMCall, "Í", "I")
                            mensajeMMCall = Replace(mensajeMMCall, "Ó", "O")
                            mensajeMMCall = Replace(mensajeMMCall, "Ú", "U")
                            mensajeMMCall = Replace(mensajeMMCall, "Ü", "U")
                            mensajeMMCall = Replace(mensajeMMCall, "Ñ", "~")
                            mensajeMMCall = Replace(mensajeMMCall, ":", " ")


                            If mensaje.Length = 0 Then
                                mensaje = "Hay anticipaciones por tiempos excedidos de programación por atender"
                                agregarLOG("La alerta" & idAlerta & " no tiene un mensaje definido se tomó el mensaje por defecto", 1, 2)
                            End If
                            If mensajeMMCall.Length = 0 Then
                                mensajeMMCall = "Hay anticip cargas/exced"
                                agregarLOG("La alerta" & idAlerta & " no tiene un mensaje para MMCall definido se tomó el mensaje por defecto", 1, 2)
                            End If
                            'If ValNull(alerta.Tables(0).Rows(0)!log, "A") = "S" Then
                            ' regsAfectados = consultaACT("INSERT INTO sigma.log (aplicacion, tipo, alerta, texto) VALUES (10, 1, " & idAlerta '& ", '" & mensaje & "')")
                            'End If

                            If ValNull(alerta.Tables(0).Rows(0)!llamada, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 1, 0, mensaje)
                            If ValNull(alerta.Tables(0).Rows(0)!sms, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 2, 0, mensaje)
                            If ValNull(alerta.Tables(0).Rows(0)!correo, "A") = "S" Then agregarMensaje("correos", alerta.Tables(0).Rows(0)!lista, uID, 0, 3, 0, mensaje)
                            If ValNull(alerta.Tables(0).Rows(0)!mmcall, "A") = "S" Then agregarMensaje("mmcall", alerta.Tables(0).Rows(0)!lista, uID, 0, 4, 0, mensajeMMCall)
                            agregarLOG("Se ha creado el reporte: " & uID & IIf(porAcumulacion, " por acumulación de saltos de operación", ""), 1, uID)
                        End If

                        regsAfectados = consultaACT("UPDATE sigma.cargas SET alarma_rep_p = 'S' WHERE id = " & lotes!id)
                    End If
                End If
            Next
            If pases > 0 Then agregarSolo("Se generaron " & pases & " alarma(s) por Fecha de programación vencida")
        End If
    End Sub

    Sub cancelarAlertas()
        Dim tiempo_holgura = 0
        Dim regsAfectados = 0
        Dim veces = 0
        Dim pases = 0
        Dim cadSQL As String = "SELECT * FROM sigma.configuracion"
        Dim readerDS As DataSet = consultaSEL(cadSQL)
        If readerDS.Tables(0).Rows.Count > 0 Then
            Dim readerConfig As DataRow = readerDS.Tables(0).Rows(0)
            tiempo_holgura = ValNull(readerConfig!tiempo_holgura, "N")
        End If
        regsAfectados = 0
        cadSQL = "SELECT a.id, a.tipo, a.lote, b.numero FROM sigma.alarmas a INNER JOIN sigma.lotes b ON a.lote = b.id AND (b.alarma_tse_paso = 'S' OR b.alarma_tpe_paso = 'S') WHERE ISNULL(fin) AND (a.tipo = 1 OR a.tipo = 2 OR a.tipo = 5 OR a.tipo = 6)"
        Dim reader As DataSet = consultaSEL(cadSQL)
        If errorBD.Length > 0 Then
            agregarLOG("Ocurrió un Error al intentar leer MySQL. Error: " + Microsoft.VisualBasic.Strings.Left(errorBD, 250), 9, 0)
        Else
            pases = 0
            If reader.Tables(0).Rows.Count > 0 Then
                For Each cargas In reader.Tables(0).Rows
                    'Se elimina la alarma
                    regsAfectados = consultaACT("UPDATE sigma.alarmas SET fin = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), inicio)) WHERE id = " & cargas!id)
                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET estado = 9, atendida = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), activada)) WHERE id NOT IN (SELECT reporte FROM sigma.alarmas WHERE tiempo = 0) AND estado <> 9;")
                    If regsAfectados > 0 Then
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, tipo, canal, destino, mensaje) SELECT a.alerta, (80 + a.tipo), a.canal, a.destino, CONCAT('ATENCION La alerta asociada al lote/carga ', '" & cargas!numero & "', ' ha sido resuelta!') FROM sigma.mensajes a WHERE a.tipo <= 5 AND a.canal <> 4 AND a.alerta IN (SELECT id FROM sigma.vw_reportes WHERE estado = 9 AND informar_resolucion = 'S' AND informado = 'N') GROUP BY a.alerta, (80 + a.tipo), a.canal, a.destino, CONCAT('ATENCION La alerta asociada al lote/carga ', '" & cargas!numero & "', ' ha sido resuelta!');INSERT INTO sigma.mensajes (alerta, tipo, canal, destino, mensaje) SELECT a.alerta, (80 + a.tipo), a.canal, a.destino, CONCAT('ALERTA LOTE o CARGA ', '" & cargas!numero & "', ' FUE RESUELTA') FROM sigma.mensajes a WHERE a.tipo <= 5 AND a.canal = 4 AND a.alerta IN (SELECT id FROM sigma.vw_reportes WHERE estado = 9 AND informar_resolucion = 'S' AND informado = 'N') GROUP BY a.alerta, (80 + a.tipo), a.canal, a.destino, CONCAT('ALERTA LOTE o CARGA ', '" & cargas!numero & "', ' FUE RESUELTA');UPDATE sigma.vw_reportes SET informado = 'S' WHERE estado = 9 AND informar_resolucion = 'S' AND informado = 'N';UPDATE sigma.lotes SET " & IIf(cargas!tipo = 1 Or cargas!tipo = 5, "alarma_tse_paso = 'N', alarma_tse = 'N', alarma_tse_p = 'N' ", "alarma_tpe_paso = 'N', alarma_tpe = 'N', alarma_tpe_p = 'N'") & " WHERE id = " & cargas!id)
                    End If
                Next
            End If
        End If
        cadSQL = "SELECT a.id, a.tipo, B.fecha, a.lote, b.alarma_rep, b.carga, b.estatus, b.completada FROM sigma.alarmas a INNER JOIN sigma.cargas b ON a.lote = b.id WHERE ISNULL(a.fin) AND (a.tipo = 3 OR a.tipo = 7)"
        reader = consultaSEL(cadSQL)
        If errorBD.Length > 0 Then
            agregarLOG("Ocurrió un Error al intentar leer MySQL. Error: " + Microsoft.VisualBasic.Strings.Left(errorBD, 250), 9, 0)
        Else
            pases = 0
            If reader.Tables(0).Rows.Count > 0 Then
                For Each cargas In reader.Tables(0).Rows
                    Dim mesajeTexto = ""
                    If Not cargas!completada.Equals(System.DBNull.Value) Then
                        If ValNull(cargas!completada, "A") = "S" Then
                            mesajeTexto = "COMPLETADA"
                        ElseIf DateAndTime.DateAdd(DateInterval.Second, tiempo_holgura, cargas!fecha) > Now() And cargas!tipo = 3 Then
                            mesajeTexto = "POSTERGADA"
                        ElseIf ValNull(cargas!carga, "A") = "" Then
                            mesajeTexto = "ELIMINADA"
                        ElseIf ValNull(cargas!estatus, "A") = "I" Then
                            mesajeTexto = "CANCELADA"
                        End If
                    End If
                    If mesajeTexto.Length > 0 Then
                        regsAfectados = consultaACT("UPDATE sigma.alarmas SET fin = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), inicio)) WHERE id = " & cargas!id)
                        regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET estado = 9, atendida = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), activada)) WHERE id NOT IN (SELECT reporte FROM sigma.alarmas WHERE tiempo = 0) AND estado <> 9;")
                        If regsAfectados > 0 Then
                            regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, tipo, canal, destino, mensaje) SELECT a.alerta, (80 + a.tipo), a.canal, a.destino, CONCAT('ATENCION La alerta por programación excedida de la carga ', '" & cargas!carga & "', ' ha sido " & mesajeTexto & "!') FROM sigma.mensajes a WHERE a.tipo <= 5 AND a.canal= 4 AND a.alerta IN (SELECT id FROM sigma.vw_reportes WHERE estado = 9 AND informar_resolucion = 'S' AND informado = 'N') GROUP BY a.alerta, (80 + a.tipo), a.canal, a.destino, CONCAT('ATENCION La alerta por programación excedida de la carga ', '" & cargas!carga & "', ' ha sido " & mesajeTexto & "!');INSERT INTO sigma.mensajes (alerta, tipo, canal, destino, mensaje) SELECT a.alerta, (80 + a.tipo), a.canal, a.destino, CONCAT('CARGA ', '" & cargas!carga & "', ' HA SIDO " & mesajeTexto & "!') FROM sigma.mensajes a WHERE a.tipo <= 5 AND a.canal= 4 AND a.alerta IN (SELECT id FROM sigma.vw_reportes WHERE estado = 9 AND informar_resolucion = 'S' AND informado = 'N') GROUP BY a.alerta, (80 + a.tipo), a.canal, a.destino, CONCAT('ATENCION La alerta por programación excedida de la carga ', '" & cargas!carga & "', ' ha sido " & mesajeTexto & "!');UPDATE sigma.vw_reportes SET informado = 'S' WHERE estado = 9 AND informar_resolucion = 'S' AND informado = 'N';UPDATE sigma.cargas SET alarma_rep_p = 'N', alarma_rep_paso = 'N', alarma_rep = 'N' WHERE id = " & cargas!id)
                        End If
                    End If
                Next
            End If
        End If
    End Sub

    Sub asignarCarga()
        Dim cadSQL As String = "Select * FROM sigma.configuracion"
        Dim readerDS As DataSet = consultaSEL(cadSQL)
        Dim dias_programacion = 30
        Dim regsAfectados = 0
        Dim holgura_reprogramar = 0
        If readerDS.Tables(0).Rows.Count > 0 Then
            Dim configuracion As DataRow = readerDS.Tables(0).Rows(0)
            dias_programacion = ValNull(configuracion!dias_programacion, "N")
            holgura_reprogramar = ValNull(configuracion!holgura_reprogramar, "N")
        End If
        Dim pases = 0
        Dim desasignar = 0
        regsAfectados = consultaACT("UPDATE sigma.lotes SET carga = 0 WHERE estado <> 99 and estatus = 'A'")
        cadSQL = "SELECT a.id, a.equipo, b.parte, b.cantidad, c.proceso FROM sigma.cargas a INNER JOIN sigma.programacion b ON a.id = b.carga AND b.estatus = 'A' LEFT JOIN sigma.det_procesos c ON a.equipo = c.id AND c.estatus = 'A' WHERE a.estatus = 'A' AND completada <> 'Y' ORDER BY a.fecha ASC"
        Dim reader As DataSet = consultaSEL(cadSQL)
        If errorBD.Length > 0 Then
            agregarLOG("Ocurrió un Error al intentar leer MySQL. Error: " + Microsoft.VisualBasic.Strings.Left(errorBD, 250), 9, 0)
        Else

            If reader.Tables(0).Rows.Count > 0 Then
                For Each cargas In reader.Tables(0).Rows
                    cadSQL = "SELECT a.id, IFNULL((SELECT MIN(orden) FROM sigma.prioridades WHERE parte = a.parte AND fecha >= NOW() AND estatus = 'A'), 100) AS prioridad FROM sigma.lotes a WHERE a.estatus = 'A' AND a.carga = 0 AND a.estado <= 50 AND a.proceso = " & cargas!proceso & " AND a.parte = " & cargas!parte & " ORDER BY inspecciones, prioridad, fecha  ASC"
                    Dim reader2 As DataSet = consultaSEL(cadSQL)
                    If reader2.Tables(0).Rows.Count > 0 Then
                        Dim faltan = ValNull(cargas!cantidad, "N")
                        For Each lotes In reader2.Tables(0).Rows
                            If faltan > 0 Then
                                faltan = faltan - 1
                                regsAfectados = consultaACT("UPDATE sigma.lotes SET carga = " & cargas!id & " WHERE id = " & lotes!id)
                                pases = pases + 1
                            Else
                                Exit For
                            End If
                        Next
                    End If
                Next
            End If
            cadSQL = "SELECT a.id, a.equipo, a.estatus, c.proceso, a.fecha, a.completada, IFNULL((SELECT SUM(cantidad) FROM sigma.programacion WHERE carga = a.id AND estatus = 'A'), 0) AS piezas, (SELECT COUNT(*) FROM sigma.lotes WHERE carga = a.id AND estado <= 50) AS avance, (SELECT COUNT(*) FROM sigma.lotes WHERE carga = a.id AND estado = 50 and equipo = a.equipo) AS enequipo FROM sigma.cargas a LEFT JOIN sigma.det_procesos c ON a.equipo = c.id AND c.estatus = 'A' WHERE a.estatus = 'A' AND completada <> 'Y' ORDER BY a.fecha ASC"
            reader = consultaSEL(cadSQL)
            If reader.Tables(0).Rows.Count > 0 Then
                For Each cargas In reader.Tables(0).Rows
                    If cargas!piezas <= cargas!avance Then
                        If cargas!completada = "N" Then
                            Dim diferencia = DateAndTime.DateDiff(DateInterval.Second, cargas!fecha, DateAndTime.Now)
                            If diferencia < 0 Or diferencia > holgura_reprogramar Then
                                'Se reprograma las programaciones subsiguientes
                                cadSQL = "SELECT a.id, a.fecha, b.proceso FROM sigma.cargas a LEFT JOIN sigma.det_procesos b ON a.equipo = b.id WHERE a.permitir_reprogramacion = 'S' AND a.id <> " & cargas!id & " AND a.estatus = 'A' AND a.fecha >= '" & Format(cargas!fecha, "yyyy/MM/dd HH:mm:ss") & "' AND a.equipo = " & cargas!equipo
                                Dim cargasAdic As DataSet = consultaSEL(cadSQL)
                                If cargasAdic.Tables(0).Rows.Count > 0 Then
                                    For Each reprograma In cargasAdic.Tables(0).Rows
                                        Dim FHasta = calcularFechaEstimada(reprograma!fecha, diferencia, reprograma!proceso)
                                        regsAfectados = consultaACT("UPDATE sigma.cargas SET fecha_anterior = fecha, fecha = '" & Format(FHasta, "yyyy/MM/dd HH:mm:ss") & "', reprogramaciones = reprogramaciones + 1 WHERE id = " & reprograma!id)
                                    Next
                                End If
                                regsAfectados = consultaACT("UPDATE sigma.cargas SET completada = 'S' WHERE id = " & cargas!id)
                            End If
                        ElseIf cargas!enequipo >= cargas!piezas Then
                            regsAfectados = consultaACT("UPDATE sigma.cargas SET completada = 'Y' WHERE id = " & cargas!id)
                        ElseIf cargas!enequipo > 0 Then
                            regsAfectados = consultaACT("UPDATE sigma.cargas SET completada = 'U' WHERE id = " & cargas!id)
                        ElseIf cargas!completada <> "S" Then
                            regsAfectados = consultaACT("UPDATE sigma.cargas SET completada = 'S' WHERE id = " & cargas!id)
                        End If
                    ElseIf cargas!completada <> "N" Then
                        regsAfectados = consultaACT("UPDATE sigma.cargas SET completada = 'N' WHERE id = " & cargas!id)
                    End If
                Next
            End If
            If pases > 0 Then
                agregarLOG("Se ha(n) asignado: " & pases & " cargas de programación", 1, 1)
            End If
        End If


    End Sub

    Sub asignarCargaAntes()
        Dim cadSQL As String = "Select * FROM sigma.configuracion"
        Dim readerDS As DataSet = consultaSEL(cadSQL)
        Dim dias_programacion = 30
        Dim regsAfectados = 0
        If readerDS.Tables(0).Rows.Count > 0 Then
            Dim configuracion As DataRow = readerDS.Tables(0).Rows(0)
            dias_programacion = ValNull(configuracion!dias_programacion, "N")
        End If
        Dim pases = 0
        Dim desasignar = 0
        regsAfectados = consultaACT("UPDATE sigma.lotes Set carga = 0 WHERE estatus ='A' AND estado <> 99 AND carga IN ( SELECT id FROM sigma.cargas WHERE estatus = 'I' AND (completada <> 'Y' AND completada <> 'U')")
        desasignar = regsAfectados
        regsAfectados = consultaACT("UPDATE sigma.lotes a SET a.carga = 0 WHERE a.carga <> 0 AND a.estatus ='A' AND a.carga NOT IN (SELECT id FROM sigma.cargas WHERE id = a.carga)")
        desasignar = desasignar + regsAfectados
        cadSQL = "SELECT a.id, a.equipo, b.parte, b.cantidad, (SELECT COUNT(*) FROM sigma.lotes WHERE parte = b.parte AND carga = a.id) AS avance, b.cantidad - (SELECT avance) AS faltan, c.proceso FROM sigma.cargas a LEFT JOIN sigma.programacion b ON a.id = b.carga AND b.estatus = 'A' LEFT JOIN sigma.det_procesos c ON a.equipo = c.id AND c.estatus = 'A' WHERE a.estatus = 'A' ORDER BY a.fecha ASC"
        Dim reader As DataSet = consultaSEL(cadSQL)
        If errorBD.Length > 0 Then
            agregarLOG("Ocurrió un Error al intentar leer MySQL. Error: " + Microsoft.VisualBasic.Strings.Left(errorBD, 250), 9, 0)
        Else

            If reader.Tables(0).Rows.Count > 0 Then
                For Each cargas In reader.Tables(0).Rows
                    If ValNull(cargas!faltan, "N") > 0 Then
                        cadSQL = "SELECT a.id, IFNULL((SELECT MIN(orden) FROM sigma.prioridades WHERE parte = a.parte AND fecha >= NOW() AND estatus = 'A'), 100) AS prioridad FROM sigma.lotes a WHERE a.estatus = 'A' AND a.carga = 0 AND a.estado < 50 AND a.proceso = " & cargas!proceso & " AND equipo = 0 AND a.parte = " & cargas!parte & " ORDER BY inspecciones, prioridad, fecha  ASC"
                        Dim reader2 As DataSet = consultaSEL(cadSQL)
                        If reader2.Tables(0).Rows.Count > 0 Then
                            Dim faltan = ValNull(cargas!faltan, "N")
                            For Each lotes In reader2.Tables(0).Rows
                                If faltan > 0 Then
                                    faltan = faltan - 1
                                    regsAfectados = consultaACT("UPDATE sigma.lotes SET carga = " & cargas!id & " WHERE id = " & lotes!id)
                                    pases = pases + 1
                                End If
                            Next
                        End If
                    End If
                Next
            End If
            If desasignar > 0 Then agregarSolo("Se desasignaron " & desasignar & " lote(s) con carga de programación inactivas o eliminadas")
            If pases > 0 Then
                agregarSolo("Se asignaron " & pases & " lote(s) a cargas de programación de equipo")
                agregarLOG("Se ha(n) asignado: " & pases & " cargas de programación", 1, 1)
            End If
        End If
    End Sub
    Sub paseaStock()
        Dim cadSQL As String = "SELECT IFNULL((SELECT MIN(orden) FROM sigma.prioridades WHERE parte = a.parte AND fecha >= NOW() AND estatus = 'A'), 100) AS prioridad, a.id, a.estado, a.proceso, a.ruta_detalle, a.fecha, a.calcular_hasta, b.tiempo_stock, c.ultimo_parte, a.parte, a.equipo FROM sigma.lotes a LEFT JOIN sigma.det_rutas b ON a.ruta_detalle = b.id LEFT JOIN sigma.det_procesos c ON a.equipo = c.id WHERE (a.estado = 0 or a.calcular_hasta <> 'N') AND a.estatus = 'A' ORDER BY prioridad, a.fecha ASC"
        Dim reader As DataSet = consultaSEL(cadSQL)
        Dim pases = 0
        Dim realculoStock = 0
        Dim realculoEquipo = 0

        Dim regsAfectados = 0
        If errorBD.Length > 0 Then
            agregarLOG("Ocurrió un error al intentar leer MySQL. Error: " + Microsoft.VisualBasic.Strings.Left(errorBD, 250), 9, 0)
        Else
            If reader.Tables(0).Rows.Count > 0 Then
                For Each lotes In reader.Tables(0).Rows
                    If lotes!calcular_hasta = "N" Or lotes!calcular_hasta = "1" Or lotes!calcular_hasta = "3" Then
                        cadSQL = "SELECT capacidad_stock - (SELECT COUNT(*) FROM sigma.lotes WHERE estado = 20 And proceso = " & lotes!proceso & ") AS capstock FROM sigma.cat_procesos WHERE id = " & lotes!proceso
                        Dim procesos As DataSet = consultaSEL(cadSQL)
                        If procesos.Tables(0).Rows.Count > 0 Then
                            If procesos.Tables(0).Rows(0)!capstock > 0 And (lotes!calcular_hasta <> "3" Or lotes!fecha <= Now()) Then
                                Dim loteID = lotes!id
                                Dim procesoID = lotes!proceso
                                Dim completado = False
                                Dim fechaEstimada = Now()
                                Dim FHasta = calcularFechaEstimada(lotes!fecha, lotes!tiempo_stock, lotes!proceso)
                                If lotes!estado = 0 Then
                                    pases = pases + 1
                                    regsAfectados = consultaACT("UPDATE sigma.lotes SET estado = 20, fecha = NOW(), calcular_hasta = 'N', hasta = '" & Format(FHasta, "yyyy/MM/dd HH:mm:ss") & "' WHERE id = " & lotes!id & ";UPDATE sigma.lotes_historia SET fecha_stock = NOW(), tiempo_espera = TIME_TO_SEC(TIMEDIFF(NOW(), fecha_entrada)) WHERE lote = " & lotes!id & " AND proceso = " & lotes!proceso)
                                Else
                                    realculoStock = realculoStock + 1
                                    regsAfectados = consultaACT("UPDATE sigma.lotes SET hasta = '" & Format(FHasta, "yyyy/MM/dd HH:mm:ss") & "', calcular_hasta = 'N' WHERE id = " & lotes!id)
                                End If

                            End If
                        End If
                    ElseIf lotes!calcular_hasta = "2" Then
                        cadSQL = "SELECT a.tiempo_proceso, a.tiempo_setup, b.reduccion_setup FROM sigma.det_rutas a LEFT JOIN sigma.cat_procesos b ON a.proceso = b.id WHERE a.id = " & lotes!ruta_detalle
                        Dim procesos As DataSet = consultaSEL(cadSQL)
                        If procesos.Tables(0).Rows.Count > 0 Then
                            pases = pases + 1
                            Dim loteID = lotes!id
                            Dim procesoID = lotes!proceso
                            Dim completado = False
                            Dim fechaEstimada = Now()
                            Dim tiempo_sumar = ValNull(procesos.Tables(0).Rows(0)!tiempo_proceso, "N")
                            If ValNull(lotes!ultimo_parte, "N") <> lotes!parte Or procesos.Tables(0).Rows(0)!reduccion_setup = "N" Then
                                tiempo_sumar = tiempo_sumar + procesos.Tables(0).Rows(0)!tiempo_setup
                                regsAfectados = consultaACT("UPDATE sigma.det_procesos SET ultimo_parte = " & lotes!parte & " WHERE id = " & lotes!equipo)
                            End If
                            realculoEquipo = realculoEquipo + 1
                            Dim FHasta = calcularFechaEstimada(lotes!fecha, tiempo_sumar, lotes!proceso)
                            regsAfectados = consultaACT("UPDATE sigma.lotes SET hasta = '" & Format(FHasta, "yyyy/MM/dd HH:mm:ss") & "', calcular_hasta = 'N' WHERE id = " & lotes!id)
                        End If

                    End If

                Next
            End If
            If pases > 0 Then agregarSolo("Se transfirieron " & pases & " lote(s) desde la situación En Espera a situación En Stock")
            If realculoStock > 0 Then agregarSolo("Se recalculó la fecha de stock de " & realculoStock & " lote(s)")
            If realculoEquipo > 0 Then agregarSolo("Se calculó la fecha de proceso de " & realculoEquipo & " lote(s)")
            agregarLOG("Se ha(n) transferido: " & pases & " lote(s) a la siguiente situación", 1, 1)
        End If
    End Sub

    Function calcularFechaEstimada(fecha, tiempoNecesario, proceso)
        calcularFechaEstimada = fecha
        If tiempoNecesario = 0 Then Exit Function
        Dim diaSemana = 0
        Dim fechaEspecifica As Boolean = False
        Dim procesoEspecifico As Boolean = False
        Dim completado = False
        Dim fechaEstimada = fecha
        Dim horaDesde = Format(fechaEstimada, "HH:mm:ss")
        Dim primerDia = True
        Dim MaximoDias = 14
        Dim diasContados = 0
        Do While Not completado
            diasContados = diasContados + 1
            Dim rangosPositivosD(0) As String
            Dim rangosPositivosH(0) As String
            Dim rangosNegativosD(0) As String
            Dim rangosNegativosH(0) As String
            Dim rangoPositivo = 0
            Dim rangoNegativo = 0
            horaDesde = Format(fechaEstimada, "HH:mm:ss")
            'Recorrido por día
            diaSemana = DateAndTime.Weekday(fechaEstimada) - 1
            Dim cadSQL = "SELECT desde, hasta, dia, proceso, tipo FROM sigma.horarios WHERE (dia = " & diaSemana & " OR (dia = 9 AND fecha = '" & Format(fechaEstimada, "yyyy/MM/dd") & "')) AND (proceso = 0 OR proceso = " & proceso & ") AND hasta > '" & horaDesde & "' ORDER BY tipo DESC, proceso DESC, dia DESC, desde, hasta"
            Dim horarios As DataSet = consultaSEL(cadSQL)
            procesoEspecifico = False
            fechaEspecifica = False
            Dim segundos = 0
            Dim primerRegistro = True
            Dim holgura = 0
            Dim combinacion = 0
            Dim sumando As Boolean = True
            Dim continuar = False
            If horarios.Tables(0).Rows.Count > 0 Then
                For Each rango In horarios.Tables(0).Rows

                    If primerRegistro Then
                        primerRegistro = False
                        If rango!tipo = "S" Then
                            rangoPositivo = rangoPositivo + 1
                            If fechaEstimada.date = fecha.date Then
                                If rango!desde.ToString > horaDesde Then
                                    rangosPositivosD(rangoPositivo - 1) = rango!desde.ToString
                                Else
                                    rangosPositivosD(rangoPositivo - 1) = horaDesde
                                End If
                            Else
                                rangosPositivosD(rangoPositivo - 1) = rango!desde.ToString
                            End If
                            rangosPositivosH(rangoPositivo - 1) = rango!hasta.ToString
                            procesoEspecifico = rango!proceso <> 0
                            fechaEspecifica = rango!dia = 9
                            If procesoEspecifico And fechaEspecifica Then
                                combinacion = 1
                            ElseIf procesoEspecifico Then
                                combinacion = 2
                            ElseIf fechaEspecifica Then
                                combinacion = 3
                            Else
                                combinacion = 4
                            End If
                        End If
                    Else
                        If sumando And rango!tipo = "N" Then
                            sumando = False
                            rangoNegativo = rangoNegativo + 1
                            If fechaEstimada.date = fecha.date Then
                                If rango!desde.ToString > horaDesde Then
                                    rangosNegativosD(rangoNegativo - 1) = rango!desde.ToString
                                Else
                                    rangosNegativosH(rangoNegativo - 1) = horaDesde
                                End If
                            Else
                                rangosNegativosD(rangoNegativo - 1) = rango!desde.ToString
                            End If
                            rangosNegativosH(rangoNegativo - 1) = rango!hasta.ToString
                            procesoEspecifico = rango!proceso <> 0
                            fechaEspecifica = rango!dia = 9
                            If procesoEspecifico And fechaEspecifica Then
                                combinacion = 1
                            ElseIf procesoEspecifico Then
                                combinacion = 2
                            ElseIf fechaEspecifica Then
                                combinacion = 3
                            Else
                                combinacion = 4
                            End If
                        Else
                            If combinacion = 1 Then
                                continuar = rango!proceso <> 0 And rango!dia <> 9
                            ElseIf combinacion = 2 Then
                                continuar = rango!proceso <> 0
                            ElseIf combinacion = 3 Then
                                continuar = rango!dia = 9
                            Else
                                continuar = True
                            End If
                        End If
                        If continuar Then
                            If sumando Then
                                rangoPositivo = rangoPositivo + 1
                                ReDim Preserve rangosPositivosD(rangoPositivo)
                                ReDim Preserve rangosPositivosH(rangoPositivo)
                                rangosPositivosD(rangoPositivo - 1) = rango!desde.ToString
                                rangosPositivosH(rangoPositivo - 1) = rango!hasta.ToString
                            Else
                                rangoNegativo = rangoNegativo + 1
                                ReDim Preserve rangosNegativosD(rangoNegativo)
                                ReDim Preserve rangosNegativosH(rangoNegativo)
                                rangosNegativosD(rangoNegativo - 1) = rango!desde.ToString
                                rangosNegativosH(rangoNegativo - 1) = rango!hasta.ToString
                            End If
                        End If
                    End If
                Next
            End If
            'Se crear un registro único por día
            If rangoPositivo > 0 Then
                Dim arreDefD(0) As String
                Dim arreDefH(0) As String
                Dim arreDefP(0) As String
                Dim totalItems = 1
                arreDefD(0) = rangosPositivosD(0)
                arreDefH(0) = rangosPositivosH(0)
                arreDefP(0) = "S"
                For i = 0 To rangoPositivo - 1
                    If rangosPositivosD(i) > arreDefD(totalItems - 1) Then
                        totalItems = totalItems + 1
                        ReDim Preserve arreDefD(totalItems)
                        ReDim Preserve arreDefH(totalItems)
                        ReDim Preserve arreDefP(totalItems)
                        arreDefD(totalItems - 1) = rangosPositivosD(i)
                        arreDefH(totalItems - 1) = rangosPositivosH(i)
                        arreDefP(totalItems - 1) = "S"
                    ElseIf rangosPositivosH(i) > arreDefH(totalItems - 1) Then
                        arreDefH(totalItems - 1) = rangosPositivosH(i)
                    End If
                Next
                If rangoNegativo > 0 Then
                    For i = 0 To rangoNegativo - 1
                        For j = 0 To totalItems - 1
                            If rangosNegativosD(i) <= arreDefD(j) And rangosNegativosH(i) >= arreDefH(j) Then
                                arreDefP(j) = "N"
                            End If
                            If rangosNegativosD(i) <= arreDefD(j) And rangosNegativosH(i) >= arreDefD(j) Then
                                arreDefD(j) = rangosNegativosH(i)
                            End If
                            If rangosNegativosD(i) >= arreDefD(j) And rangosNegativosD(i) < arreDefH(j) And rangosNegativosH(i) > arreDefH(j) Then
                                arreDefH(j) = rangosNegativosD(i)
                            End If
                            If rangosNegativosD(i) > arreDefD(j) And rangosNegativosH(i) < arreDefH(j) Then
                                totalItems = totalItems + 1
                                ReDim Preserve arreDefD(totalItems)
                                ReDim Preserve arreDefH(totalItems)
                                ReDim Preserve arreDefP(totalItems)
                                arreDefD(totalItems - 1) = rangosNegativosH(i)
                                arreDefH(totalItems - 1) = arreDefH(j)
                                arreDefP(totalItems - 1) = "S"
                                arreDefH(j) = rangosNegativosD(i)
                            End If
                        Next
                    Next
                End If
                If totalItems > 0 Then
                    Dim swap1 = 0
                    Dim swap2 = 0
                    Dim swap3 = 0
                    For i = 0 To totalItems - 1
                        For j = 0 To totalItems - 2
                            If arreDefD(j) > arreDefD(j + 1) Then
                                swap1 = arreDefD(j)
                                swap2 = arreDefH(j)
                                swap3 = arreDefP(j)
                                arreDefD(j) = arreDefD(j + 1)
                                arreDefH(j) = arreDefH(j + 1)
                                arreDefP(j) = arreDefP(i + 1)
                                arreDefD(j + 1) = swap1
                                arreDefH(j + 1) = swap2
                                arreDefP(j + 1) = swap3
                            End If
                        Next
                    Next


                    Dim tiempoDisponible = 0
                    For i = 0 To totalItems - 1
                        If arreDefP(i) = "S" Then
                            horaDesde = arreDefD(i)
                            tiempoDisponible = DateDiff(DateInterval.Second, Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " " & arreDefD(i)), Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " " & arreDefH(i)))
                            If tiempoDisponible > tiempoNecesario Then
                                'Se cubrió
                                completado = True

                                fechaEstimada = DateAdd(DateInterval.Second, tiempoNecesario, fechaEstimada)
                                tiempoNecesario = 0
                            Else
                                tiempoNecesario = tiempoNecesario - tiempoDisponible
                                fechaEstimada = Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " " & arreDefH(i))
                            End If
                        End If
                    Next
                    If Not completado Then
                        fechaEstimada = DateAdd(DateInterval.Day, 1, fechaEstimada)
                        fechaEstimada = Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " 00:00:00")
                    End If
                End If
            Else
                fechaEstimada = DateAdd(DateInterval.Day, 1, fechaEstimada)
                fechaEstimada = Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " 00:00:00")
            End If
            If diasContados > MaximoDias Then completado = True
        Loop
        If tiempoNecesario > 0 Then
            'Es la misma fecha, se debe sumar obligatoriamente
            fechaEstimada = DateAdd(DateInterval.Second, tiempoNecesario, fechaEstimada)
        End If
        calcularFechaEstimada = fechaEstimada

    End Function

    Function calcularFechaEstimadaAntes(fecha, tiempoNecesario, proceso)
        calcularFechaEstimadaAntes = fecha
        If tiempoNecesario = 0 Then Exit Function
        Dim diaSemana = 1
        Dim primera As Boolean = True
        Dim fechaEspecifica As Boolean = False
        Dim procesoEspecifico As Boolean = False
        Dim diaSemanaEspecifico = -1
        Dim remanente = 0
        Dim completado = False
        Dim fechaEstimada = fecha
        Dim franja = 86400
        Dim segundos = 0

        Do While Not completado
            'Recorrido por día

            diaSemana = DateAndTime.Weekday(fechaEstimada) - 1
            Dim cadSQL = "SELECT desde, hasta, dia, proceso FROM sigma.horarios WHERE (dia = " & diaSemana & " OR fecha = '" & Format(fechaEstimada, "yyyy/MM/dd") & "') AND (proceso = 0 OR proceso = " & proceso & ") AND hasta > '" & Format(fechaEstimada, "HH:mm:ss") & "' ORDER BY proceso DESC, dia DESC, desde"
            Dim horarios As DataSet = consultaSEL(cadSQL)
            If horarios.Tables(0).Rows.Count > 0 Then

                For Each rango In horarios.Tables(0).Rows
                    If Not completado Then
                        If rango!dia <> 9 And fechaEspecifica And diaSemanaEspecifico = DateAndTime.Weekday(fechaEstimada) - 1 Then
                            'Se salta
                            fechaEspecifica = False
                            procesoEspecifico = False
                            segundos = DateDiff(DateInterval.Second, fechaEstimada, Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " 23:59:59"))
                            fechaEstimada = DateAdd(DateInterval.Day, 1, fechaEstimada)
                            fechaEstimada = Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " 00:00:00")
                        ElseIf rango!proceso = 0 And procesoEspecifico Then
                            'Se salta
                            fechaEspecifica = False
                            procesoEspecifico = False
                            segundos = DateDiff(DateInterval.Second, fechaEstimada, Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " 23:59:59"))
                            fechaEstimada = DateAdd(DateInterval.Day, 1, fechaEstimada)
                            fechaEstimada = Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " 00:00:00")
                        Else
                            If rango!dia = 9 And Not fechaEspecifica Then
                                fechaEspecifica = True
                                diaSemanaEspecifico = DateAndTime.Weekday(fechaEstimada) - 1
                            End If
                            fechaEspecifica = rango!dia = 9
                            If rango!proceso = 0 Then
                                procesoEspecifico = False
                            Else
                                procesoEspecifico = True
                            End If
                            If fecha.date() = fechaEstimada.Date() And rango!hasta.ToString > Format(fecha, "HH:mm:ss") Or fecha.date() <> fechaEstimada.Date() Then
                                primera = False
                                If fecha.date() = fechaEstimada.Date() And rango!desde.ToString < Format(fecha, "HH:mm:ss") Then

                                    'Parcial
                                    remanente = 0
                                    segundos = DateDiff(DateInterval.Second, fecha, Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " " & rango!hasta.ToString))
                                Else
                                    segundos = DateDiff(DateInterval.Second, Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " " & rango!desde.ToString), Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " " & rango!hasta.ToString))
                                    remanente = DateDiff(DateInterval.Second, fechaEstimada, Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " " & rango!desde.ToString))

                                End If
                                If segundos >= tiempoNecesario Then
                                    completado = True
                                    fechaEstimada = DateAdd(DateInterval.Second, tiempoNecesario + remanente, fechaEstimada)
                                    tiempoNecesario = 0
                                Else
                                    fechaEstimada = Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " " & rango!hasta.ToString)
                                    tiempoNecesario = tiempoNecesario - segundos
                                End If

                            End If

                        End If
                    End If
                Next
            Else
                fechaEspecifica = False
                procesoEspecifico = False
                segundos = DateDiff(DateInterval.Second, fechaEstimada, Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " 23:59:59"))
                fechaEstimada = DateAdd(DateInterval.Day, 1, fechaEstimada)
                fechaEstimada = Convert.ToDateTime(Format(fechaEstimada, "yyyy/MM/dd") & " 00:00:00")

            End If
        Loop
        calcularFechaEstimadaAntes = fechaEstimada
    End Function


    Private Sub alertaSO()
        Dim regsAfectados = 0
        Dim veces = 0
        Dim pases = 0
        Dim cadSQL = "SELECT a.id, a.lote, a.proceso, e.referencia, e.nombre AS producto, b.numero, IFNULL((SELECT MIN(orden) FROM sigma.prioridades WHERE parte = b.parte AND fecha >= NOW() AND estatus = 'A'), 100) AS prioridad, a.ruta_secuencia, a.ruta_secuencia_antes, IFNULL(c.nombre, 'N/A') AS ruta_antes, IFNULL(d.nombre, 'N/A') AS ruta_despues FROM sigma.lotes_historia a INNER JOIN sigma.lotes b ON a.lote = b.id LEFT JOIN sigma.det_rutas c ON a.ruta_detalle_anterior = c.id LEFT JOIN sigma.det_rutas d ON a.ruta_detalle = d.id LEFT JOIN sigma.cat_partes e ON b.parte = e.id  WHERE a.alarma_so = 'S'"

        Dim falla As DataSet = consultaSEL(cadSQL)
        If falla.Tables(0).Rows.Count > 0 Then
            For Each lotes In falla.Tables(0).Rows
                Dim loteID = lotes!lote
                Dim loteHID = lotes!id
                Dim procesoID = lotes!proceso

                cadSQL = "SELECT * FROM sigma.cat_alertas WHERE tipo = 4 AND (proceso = 0 or proceso = " & procesoID & ") AND estatus = 'A' ORDER BY proceso DESC"
                Dim alerta As DataSet = consultaSEL(cadSQL)
                Dim uID = 0

                If alerta.Tables(0).Rows.Count > 0 Then

                    Dim idAlerta = alerta.Tables(0).Rows(0)!id
                    Dim fechaDesde
                    Dim crearReporte As Boolean = False


                    Dim porAcumulacion = False
                    If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "N" Then
                        'Se pregunta si hay un rperte activo y si es solapable
                        'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                        crearReporte = True
                        'Else
                        'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                        'Dim solapar As DataSet = consultaSEL(cadSQL)
                        'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                        'End If

                    Else
                        porAcumulacion = True
                        If ValNull(alerta.Tables(0).Rows(0)!acumular_inicializar, "A") = "S" Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 "
                            End If
                        Else
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta
                            End If
                        End If

                        Dim acumulado = 0
                        Dim acum As DataSet = consultaSEL(cadSQL)
                        If acum.Tables(0).Rows.Count > 0 Then
                            acumulado = acum.Tables(0).Rows(0)!cuenta
                        End If
                        If acumulado + 1 >= alerta.Tables(0).Rows(0)!acumular_veces Then
                            veces = acumulado + 1
                            'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                            crearReporte = True
                            'Else
                            'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                            'Dim solapar As DataSet = consultaSEL(cadSQL)
                            'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                            'End If
                        End If
                    End If
                    If crearReporte Then
                        regsAfectados = consultaACT("INSERT INTO sigma.vw_reportes (alerta, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, estado) SELECT id, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, 1 FROM sigma.cat_alertas WHERE id = " & alerta.Tables(0).Rows(0)!id)
                        'Se obtieneel último ID
                        cadSQL = "SELECT MAX(id) as ultimo FROM sigma.vw_reportes"
                        Dim ultimo As DataSet = consultaSEL(cadSQL)
                        If ultimo.Tables(0).Rows.Count > 0 Then
                            uID = ultimo.Tables(0).Rows(0)!ultimo
                        End If


                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, lote_historico, inicio, alerta, reporte, accion) VALUES (4, " & procesoID & ", " & loteID & ", " & loteHID & ", NOW(), " & idAlerta & ", " & uID & ", 1)")
                        If porAcumulacion Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 And inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "' AND accion = 0")
                            Else
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 AND accion = 0")
                            End If
                        End If
                    Else
                        'Se crear la alarma suelta

                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, lote_historico, inicio, alerta, accion) VALUES (4, " & procesoID & ", " & loteID & ", " & loteHID & ", NOW(), " & idAlerta & ", " & IIf(porAcumulacion, 0, 4) & ")")

                    End If

                    If crearReporte Then
                        pases = pases + 1
                        'Se generan los mensajes a enviar
                        Dim mensajeMMCall As String = Microsoft.VisualBasic.Strings.Left("SALTO. LOTE: " & lotes!numero & ". REF: " + lotes!referencia, 40).Trim
                        Dim mensaje As String = "SALTO DE OPERACION" & vbCrLf & vbCrLf & "Datos del lote" & vbCrLf & "Número: " & lotes!numero & vbCrLf & "Referencia del artículo: " & lotes!referencia & vbCrLf & "Descripción del artículo: " & lotes!producto & vbCrLf & vbCrLf & "Datos del salto de operación" & vbCrLf & "Desde la operación: " & lotes!ruta_antes & ". Secuencia: " & lotes!ruta_secuencia_antes & vbCrLf & "Hasta la operación: " & lotes!ruta_despues & ". Secuencia: " & lotes!ruta_secuencia

                        If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "S" Then
                            If ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "T" Then
                                mensaje = "Hay " & veces & " SALTO(S) DE OPERACIÓN por atender"
                                mensajeMMCall = "Hay " & veces & " SALTO(S) DE OPERACIÓN por atender"
                            ElseIf ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "P" Then
                                mensaje = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 200)
                                mensajeMMCall = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 40)
                            End If
                        End If
                        'Se cambian los caracteres especiales
                        mensajeMMCall = UCase(mensajeMMCall)
                        mensajeMMCall = Replace(mensajeMMCall, "Á", "A")
                        mensajeMMCall = Replace(mensajeMMCall, "É", "E")
                        mensajeMMCall = Replace(mensajeMMCall, "Í", "I")
                        mensajeMMCall = Replace(mensajeMMCall, "Ó", "O")
                        mensajeMMCall = Replace(mensajeMMCall, "Ú", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ü", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ñ", "~")
                        mensajeMMCall = Replace(mensajeMMCall, ":", " ")


                        If mensaje.Length = 0 Then
                            mensaje = "Hay salto(s) de operación por atender"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        If mensajeMMCall.Length = 0 Then
                            mensajeMMCall = "Hay salto/operacion"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje para MMCall definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        'If ValNull(alerta.Tables(0).Rows(0)!log, "A") = "S" Then
                        ' regsAfectados = consultaACT("INSERT INTO sigma.log (aplicacion, tipo, alerta, texto) VALUES (10, 1, " & idAlerta '& ", '" & mensaje & "')")
                        'End If

                        If ValNull(alerta.Tables(0).Rows(0)!llamada, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 1, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!sms, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 2, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!correo, "A") = "S" Then agregarMensaje("correos", alerta.Tables(0).Rows(0)!lista, uID, 0, 3, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!mmcall, "A") = "S" Then agregarMensaje("mmcall", alerta.Tables(0).Rows(0)!lista, uID, 0, 4, 0, mensajeMMCall)
                        agregarLOG("Se ha creado el reporte: " & uID & IIf(porAcumulacion, " por acumulación de saltos de operación", ""), 1, uID)
                    End If

                    regsAfectados = consultaACT("UPDATE sigma.lotes_historia SET alarma_so = '0', alarma_so_rep = NOW() WHERE id = " & lotes!id)
                    regsAfectados = consultaACT("UPDATE sigma.lotes SET alarmas = alarmas + 1 WHERE id = " & loteID)

                End If
            Next
            If pases > 0 Then agregarSolo("Se generaron " & pases & " alarma(s) por Salto de operación")
        End If
    End Sub

    Private Sub alertaTSE()
        Dim regsAfectados = 0
        Dim tiempo_holgura = 0
        Dim veces = 0
        Dim pases = 0
        Dim cadSQL As String = "SELECT * FROM sigma.configuracion"
        Dim readerDS As DataSet = consultaSEL(cadSQL)
        If readerDS.Tables(0).Rows.Count > 0 Then
            Dim reader As DataRow = readerDS.Tables(0).Rows(0)
            tiempo_holgura = ValNull(reader!tiempo_holgura, "N")
        End If
        cadSQL = "SELECT a.id, a.proceso, a.fecha, a.hasta, a.numero, a.ruta_secuencia, c.referencia, c.nombre AS producto, IFNULL(b.nombre, 'N/A') AS ruta_actual, IFNULL(d.nombre, 'N/A') as nproceso, DATE_ADD(hasta, INTERVAL " & tiempo_holgura & " SECOND) as vence FROM sigma.lotes a LEFT JOIN sigma.det_rutas b ON a.ruta_detalle = b.id LEFT JOIN sigma.cat_partes c ON a.parte = c.id LEFT JOIN sigma.cat_procesos d ON a.proceso = d.id WHERE estado = 20 AND alarma_tse <> 'S' AND DATE_ADD(hasta, INTERVAL " & tiempo_holgura & " SECOND) <= NOW()"
        Dim falla As DataSet = consultaSEL(cadSQL)
        If falla.Tables(0).Rows.Count > 0 Then
            For Each lotes In falla.Tables(0).Rows
                Dim loteID = lotes!id
                Dim procesoID = lotes!proceso

                cadSQL = "SELECT * FROM sigma.cat_alertas WHERE tipo = 1 AND (proceso = 0 or proceso = " & procesoID & ") AND estatus = 'A' ORDER BY proceso DESC"
                Dim alerta As DataSet = consultaSEL(cadSQL)
                Dim uID = 0

                If alerta.Tables(0).Rows.Count > 0 Then
                    regsAfectados = consultaACT("UPDATE sigma.alarmas SET fin = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), inicio)) WHERE lote = " & loteID & " AND tipo = 5")
                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET estado = 9, atendida = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), activada)) WHERE id NOT IN (SELECT reporte FROM sigma.alarmas WHERE tiempo = 0) AND estado <> 9;")

                    Dim idAlerta = alerta.Tables(0).Rows(0)!id
                    Dim fechaDesde
                    Dim crearReporte As Boolean = False


                    Dim porAcumulacion = False
                    If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "N" Then
                        'Se pregunta si hay un rperte activo y si es solapable
                        'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                        crearReporte = True
                        'Else
                        'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                        'Dim solapar As DataSet = consultaSEL(cadSQL)
                        'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                        'End If

                    Else
                        porAcumulacion = True
                        If ValNull(alerta.Tables(0).Rows(0)!acumular_inicializar, "A") = "S" Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 "
                            End If
                        Else
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta
                            End If
                        End If

                        Dim acumulado = 0
                        Dim acum As DataSet = consultaSEL(cadSQL)
                        If acum.Tables(0).Rows.Count > 0 Then
                            acumulado = acum.Tables(0).Rows(0)!cuenta
                        End If
                        If acumulado + 1 >= alerta.Tables(0).Rows(0)!acumular_veces Then
                            veces = acumulado + 1
                            'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                            crearReporte = True
                            'Else
                            'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                            'Dim solapar As DataSet = consultaSEL(cadSQL)
                            'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                            'End If
                        End If
                    End If
                    If crearReporte Then
                        regsAfectados = consultaACT("INSERT INTO sigma.vw_reportes (alerta, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, estado) SELECT id, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, 1 FROM sigma.cat_alertas WHERE id = " & alerta.Tables(0).Rows(0)!id)
                        'Se obtieneel último ID
                        cadSQL = "SELECT MAX(id) as ultimo FROM sigma.vw_reportes"
                        Dim ultimo As DataSet = consultaSEL(cadSQL)
                        If ultimo.Tables(0).Rows.Count > 0 Then
                            uID = ultimo.Tables(0).Rows(0)!ultimo
                        End If


                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, reporte, accion) VALUES (1, " & procesoID & ", " & loteID & ", NOW(), " & idAlerta & ", " & uID & ", 1)")
                        If porAcumulacion Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 And inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "' AND accion = 0")
                            Else
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 AND accion = 0")
                            End If
                        End If
                    Else
                        'Se crear la alarma suelta

                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, accion) VALUES (1, " & procesoID & ", " & loteID & ", NOW(), " & idAlerta & ", " & IIf(porAcumulacion, 0, 4) & ")")

                    End If

                    If crearReporte Then
                        pases = pases + 1
                        'Se generan los mensajes a enviar
                        Dim mensajeMMCall As String = Microsoft.VisualBasic.Strings.Left("STOCK/EXCED L-" & lotes!numero, 40).Trim
                        Dim mensaje As String = "TIEMPO DE STOCK EXCEDIDO" & vbCrLf & vbCrLf & "Datos del lote" & vbCrLf & "Número: " & lotes!numero & vbCrLf & "Referencia del artículo: " & lotes!referencia & vbCrLf & "Descripción del artículo: " & lotes!producto & vbCrLf & vbCrLf & "Datos del proceso" & vbCrLf & "Nombre: " & lotes!nproceso & vbCrLf & "Operación de la ruta asociada: " & lotes!ruta_actual & vbCrLf & "Secuencia de la operación en la ruta: " & lotes!ruta_secuencia & vbCrLf & vbCrLf & "Datos de la demora" & vbCrLf & "Fecha de entrada en stock: " & Format(lotes!fecha, "dd/MM/yyyy HH:mm:ss") & vbCrLf & "Fecha estimada de salida: " & Format(lotes!hasta, "dd/MM/yyyy HH:mm:ss") & vbCrLf & "Demora (H:MM:SS): " & calcularTiempoCad(DateAndTime.DateDiff(DateInterval.Second, lotes!hasta, DateAndTime.Now)) & vbCrLf & vbCrLf & "Activación de la alarma: " & Format(lotes!vence, "dd/MM/yyyy HH:mm:ss") & IIf(tiempo_holgura > 0, " (incluye una holgura de " & tiempo_holgura & " segundos)", "")
                        mensaje = mensaje.Trim
                        If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "S" Then
                            If ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "T" Then
                                mensaje = "Hay " & veces & " mensaje(s) de TIEMPO DE STOCK EXCEDIDO por atender"
                                mensajeMMCall = "Hay " & veces & " TIEMPO(s) STOCK/EXCED"
                            ElseIf ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "P" Then
                                mensaje = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 200)
                                mensajeMMCall = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 40)
                            End If
                        End If
                        'Se cambian los caracteres especiales
                        mensajeMMCall = UCase(mensajeMMCall)
                        mensajeMMCall = Replace(mensajeMMCall, "Á", "A")
                        mensajeMMCall = Replace(mensajeMMCall, "É", "E")
                        mensajeMMCall = Replace(mensajeMMCall, "Í", "I")
                        mensajeMMCall = Replace(mensajeMMCall, "Ó", "O")
                        mensajeMMCall = Replace(mensajeMMCall, "Ú", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ü", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ñ", "~")
                        mensajeMMCall = Replace(mensajeMMCall, ":", " ")

                        If mensaje.Length = 0 Then
                            mensaje = "Hay mensajes por tiempo de stock excedido"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        If mensajeMMCall.Length = 0 Then
                            mensajeMMCall = "Hay mensajes stock/exced"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje para MMCall definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        'If ValNull(alerta.Tables(0).Rows(0)!log, "A") = "S" Then
                        ' regsAfectados = consultaACT("INSERT INTO sigma.log (aplicacion, tipo, alerta, texto) VALUES (10, 1, " & idAlerta '& ", '" & mensaje & "')")
                        'End If


                        If ValNull(alerta.Tables(0).Rows(0)!llamada, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 1, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!sms, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 2, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!correo, "A") = "S" Then agregarMensaje("correos", alerta.Tables(0).Rows(0)!lista, uID, 0, 3, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!mmcall, "A") = "S" Then agregarMensaje("mmcall", alerta.Tables(0).Rows(0)!lista, uID, 0, 4, 0, mensajeMMCall)
                        agregarLOG("Se ha creado el reporte: " & uID & IIf(porAcumulacion, " por acumulación de saltos de operación", ""), 1, uID)
                    End If

                    regsAfectados = consultaACT("UPDATE sigma.lotes SET alarma_tse = 'S', alarmas = alarmas + 1 WHERE id = " & loteID)
                End If
            Next
            If pases > 0 Then agregarSolo("Se generaron " & pases & " alarma(s) por Tiempo de stock excedido")
        End If
    End Sub

    Private Sub alertaTSEAnticipado()
        Dim regsAfectados = 0
        Dim tiempo_holgura = 0
        Dim veces = 0
        Dim pases = 0
        Dim cadSQL = "SELECT a.id, a.proceso, a.fecha, a.hasta, a.numero, TIME_TO_SEC(TIMEDIFF(a.hasta, NOW())) AS previo, a.ruta_secuencia, c.referencia, c.nombre AS producto, IFNULL(b.nombre, 'N/A') AS ruta_actual, IFNULL(d.nombre, 'N/A') as nproceso, hasta FROM sigma.lotes a LEFT JOIN sigma.det_rutas b ON a.ruta_detalle = b.id LEFT JOIN sigma.cat_partes c ON a.parte = c.id LEFT JOIN sigma.cat_procesos d ON a.proceso = d.id WHERE estado = 20 AND alarma_tse_p <> 'S' AND TIME_TO_SEC(TIMEDIFF(a.hasta,NOW())) > 0 AND TIME_TO_SEC(TIMEDIFF(a.hasta,NOW())) <= (SELECT MAX(tiempo0) FROM sigma.cat_alertas WHERE tipo = 5 AND estatus = 'A' AND (proceso = 0 OR proceso = b.proceso))"
        Dim falla As DataSet = consultaSEL(cadSQL)
        If falla.Tables(0).Rows.Count > 0 Then
            For Each lotes In falla.Tables(0).Rows
                Dim loteID = lotes!id
                Dim procesoID = lotes!proceso

                cadSQL = "SELECT * FROM sigma.cat_alertas WHERE tipo = 5 AND estatus = 'A' AND (proceso = 0 OR proceso = " & procesoID & ") ORDER BY tiempo0 DESC LIMIT 1"
                Dim alerta As DataSet = consultaSEL(cadSQL)
                Dim uID = 0

                If alerta.Tables(0).Rows.Count > 0 Then

                    Dim idAlerta = alerta.Tables(0).Rows(0)!id
                    Dim fechaDesde
                    Dim crearReporte As Boolean = False


                    Dim porAcumulacion = False
                    If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "N" Then
                        'Se pregunta si hay un rperte activo y si es solapable
                        'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                        crearReporte = True
                        'Else
                        'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                        'Dim solapar As DataSet = consultaSEL(cadSQL)
                        'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                        'End If

                    Else
                        porAcumulacion = True
                        If ValNull(alerta.Tables(0).Rows(0)!acumular_inicializar, "A") = "S" Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 "
                            End If
                        Else
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta
                            End If
                        End If

                        Dim acumulado = 0
                        Dim acum As DataSet = consultaSEL(cadSQL)
                        If acum.Tables(0).Rows.Count > 0 Then
                            acumulado = acum.Tables(0).Rows(0)!cuenta
                        End If
                        If acumulado + 1 >= alerta.Tables(0).Rows(0)!acumular_veces Then
                            veces = acumulado + 1
                            'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                            crearReporte = True
                            'Else
                            'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                            'Dim solapar As DataSet = consultaSEL(cadSQL)
                            'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                            'End If
                        End If
                    End If
                    If crearReporte Then
                        regsAfectados = consultaACT("INSERT INTO sigma.vw_reportes (alerta, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, estado) SELECT id, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, 1 FROM sigma.cat_alertas WHERE id = " & alerta.Tables(0).Rows(0)!id)
                        'Se obtieneel último ID
                        cadSQL = "SELECT MAX(id) as ultimo FROM sigma.vw_reportes"
                        Dim ultimo As DataSet = consultaSEL(cadSQL)
                        If ultimo.Tables(0).Rows.Count > 0 Then
                            uID = ultimo.Tables(0).Rows(0)!ultimo
                        End If


                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, reporte, accion) VALUES (5, " & procesoID & ", " & loteID & ", NOW(), " & idAlerta & ", " & uID & ", 1)")
                        If porAcumulacion Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 And inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "' AND accion = 0")
                            Else
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 AND accion = 0")
                            End If
                        End If
                    Else
                        'Se crear la alarma suelta

                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, accion) VALUES (5, " & procesoID & ", " & loteID & ", NOW(), " & idAlerta & ", " & IIf(porAcumulacion, 0, 4) & ")")

                    End If

                    If crearReporte Then
                        pases = pases + 1
                        'Se generan los mensajes a enviar
                        Dim mensajeMMCall As String = Microsoft.VisualBasic.Strings.Left("STOCK POR EXCED L-" & lotes!numero, 40).Trim
                        Dim mensaje As String = "TIEMPO DE STOCK PRONTO A EXCEDER" & vbCrLf & vbCrLf & "Datos del lote" & vbCrLf & "Número: " & lotes!numero & vbCrLf & "Referencia del artículo: " & lotes!referencia & vbCrLf & "Descripción del artículo: " & lotes!producto & vbCrLf & vbCrLf & "Datos del proceso" & vbCrLf & "Nombre: " & lotes!nproceso & vbCrLf & "Operación de la ruta asociada: " & lotes!ruta_actual & vbCrLf & "Secuencia de la operación en la ruta: " & lotes!ruta_secuencia & vbCrLf & vbCrLf & "Datos de la demora" & vbCrLf & "Fecha de entrada en stock: " & Format(lotes!fecha, "dd/MM/yyyy HH:mm:ss") & vbCrLf & "Fecha estimada de salida: " & Format(lotes!hasta, "dd/MM/yyyy HH:mm:ss") & vbCrLf & "Alarma anticipada en (H:MM:SS): " & calcularTiempoCad(lotes!previo)
                        mensaje = mensaje.Trim
                        If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "S" Then
                            If ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "T" Then
                                mensaje = "Hay " & veces & " mensaje(s) de ANTIPACION DE STOCK EXCEDIDO por atender"
                                mensajeMMCall = "Hay " & veces & " ANTICIP STOCK/EXCED"
                            ElseIf ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "P" Then
                                mensaje = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 200)
                                mensajeMMCall = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 40)
                            End If
                        End If
                        'Se cambian los caracteres especiales
                        mensajeMMCall = UCase(mensajeMMCall)
                        mensajeMMCall = Replace(mensajeMMCall, "Á", "A")
                        mensajeMMCall = Replace(mensajeMMCall, "É", "E")
                        mensajeMMCall = Replace(mensajeMMCall, "Í", "I")
                        mensajeMMCall = Replace(mensajeMMCall, "Ó", "O")
                        mensajeMMCall = Replace(mensajeMMCall, "Ú", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ü", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ñ", "~")
                        mensajeMMCall = Replace(mensajeMMCall, ":", " ")

                        If mensaje.Length = 0 Then
                            mensaje = "Hay mensajes de anticipación por tiempo de stock excedido"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        If mensajeMMCall.Length = 0 Then
                            mensajeMMCall = "Hay mensajes anticip stock/exced"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje para MMCall definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        'If ValNull(alerta.Tables(0).Rows(0)!log, "A") = "S" Then
                        ' regsAfectados = consultaACT("INSERT INTO sigma.log (aplicacion, tipo, alerta, texto) VALUES (10, 1, " & idAlerta '& ", '" & mensaje & "')")
                        'End If


                        If ValNull(alerta.Tables(0).Rows(0)!llamada, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 1, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!sms, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 2, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!correo, "A") = "S" Then agregarMensaje("correos", alerta.Tables(0).Rows(0)!lista, uID, 0, 3, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!mmcall, "A") = "S" Then agregarMensaje("mmcall", alerta.Tables(0).Rows(0)!lista, uID, 0, 4, 0, mensajeMMCall)
                        agregarLOG("Se ha creado el reporte: " & uID & IIf(porAcumulacion, " por anticipación de tiempo de stock excedido", ""), 1, uID)
                    End If
                    regsAfectados = consultaACT("UPDATE sigma.lotes SET alarma_tse_p = 'S' WHERE id = " & loteID)
                End If
            Next
            If pases > 0 Then agregarSolo("Se generaron " & pases & " alarma(s) por Anticipación de tiempo de stock excedido")
        End If
    End Sub

    Private Sub alertaTPE()
        Dim regsAfectados = 0
        Dim tiempo_holgura = 0
        Dim veces = 0
        Dim pases = 0
        Dim cadSQL As String = "SELECT * FROM sigma.configuracion"
        Dim readerDS As DataSet = consultaSEL(cadSQL)
        If readerDS.Tables(0).Rows.Count > 0 Then
            Dim reader As DataRow = readerDS.Tables(0).Rows(0)
            tiempo_holgura = ValNull(reader!tiempo_holgura, "N")
        End If
        cadSQL = "SELECT a.id, a.proceso, a.fecha, a.hasta, a.numero, IFNULL(d.nombre, 'N/A') as equipo, IFNULL(e.nombre, 'N/A') as nproceso, a.ruta_secuencia, c.referencia, c.nombre AS producto, IFNULL(b.nombre, 'N/A') AS ruta_actual, DATE_ADD(hasta, INTERVAL " & tiempo_holgura & " SECOND) as vence FROM sigma.lotes a LEFT JOIN sigma.det_rutas b ON a.ruta_detalle = b.id LEFT JOIN sigma.cat_partes c ON a.parte = c.id LEFT JOIN sigma.det_procesos d ON a.equipo = d.id LEFT JOIN sigma.cat_procesos e ON a.proceso = e.id WHERE estado = 50 AND alarma_tpe <> 'S' AND DATE_ADD(hasta, INTERVAL " & tiempo_holgura & " SECOND) <= NOW()"
        Dim falla As DataSet = consultaSEL(cadSQL)
        If falla.Tables(0).Rows.Count > 0 Then
            For Each lotes In falla.Tables(0).Rows
                Dim loteID = lotes!id
                Dim procesoID = lotes!proceso

                cadSQL = "SELECT * FROM sigma.cat_alertas WHERE tipo = 2 AND (proceso = 0 or proceso = " & procesoID & ") AND estatus = 'A' ORDER BY proceso DESC"
                Dim alerta As DataSet = consultaSEL(cadSQL)
                Dim uID = 0

                If alerta.Tables(0).Rows.Count > 0 Then

                    Dim idAlerta = alerta.Tables(0).Rows(0)!id
                    Dim fechaDesde
                    Dim crearReporte As Boolean = False

                    regsAfectados = consultaACT("UPDATE sigma.alarmas SET fin = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), inicio)) WHERE lote = " & loteID & " AND tipo = 6")
                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET estado = 9, atendida = NOW(), tiempo = TIME_TO_SEC(TIMEDIFF(NOW(), activada)) WHERE id NOT IN (SELECT reporte FROM sigma.alarmas WHERE tiempo = 0) AND estado <> 9;")

                    Dim porAcumulacion = False
                    If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "N" Then
                        'Se pregunta si hay un rperte activo y si es solapable
                        'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                        crearReporte = True
                        'Else
                        'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                        'Dim solapar As DataSet = consultaSEL(cadSQL)
                        'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                        'End If

                    Else
                        porAcumulacion = True
                        If ValNull(alerta.Tables(0).Rows(0)!acumular_inicializar, "A") = "S" Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 "
                            End If
                        Else
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta
                            End If
                        End If

                        Dim acumulado = 0
                        Dim acum As DataSet = consultaSEL(cadSQL)
                        If acum.Tables(0).Rows.Count > 0 Then
                            acumulado = acum.Tables(0).Rows(0)!cuenta
                        End If
                        If acumulado + 1 >= alerta.Tables(0).Rows(0)!acumular_veces Then
                            veces = acumulado + 1
                            'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                            crearReporte = True
                            'Else
                            'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                            'Dim solapar As DataSet = consultaSEL(cadSQL)
                            'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                            'End If
                        End If
                    End If
                    If crearReporte Then
                        regsAfectados = consultaACT("INSERT INTO sigma.vw_reportes (alerta, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, estado) SELECT id, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, 1 FROM sigma.cat_alertas WHERE id = " & alerta.Tables(0).Rows(0)!id)
                        'Se obtieneel último ID
                        cadSQL = "SELECT MAX(id) as ultimo FROM sigma.vw_reportes"
                        Dim ultimo As DataSet = consultaSEL(cadSQL)
                        If ultimo.Tables(0).Rows.Count > 0 Then
                            uID = ultimo.Tables(0).Rows(0)!ultimo
                        End If


                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, reporte, accion) VALUES (2, " & procesoID & ", " & loteID & ", NOW(), " & idAlerta & ", " & uID & ", 1)")
                        If porAcumulacion Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 And inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "' AND accion = 0")
                            Else
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 AND accion = 0")
                            End If
                        End If
                    Else
                        'Se crear la alarma suelta

                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, accion) VALUES (2, " & procesoID & ", " & loteID & ", NOW(), " & idAlerta & ", " & IIf(porAcumulacion, 0, 4) & ")")

                    End If

                    If crearReporte Then
                        pases = pases + 1
                        'Se generan los mensajes a enviar
                        Dim mensajeMMCall As String = Microsoft.VisualBasic.Strings.Left(Microsoft.VisualBasic.Strings.Left(lotes!equipo, 20) & " Lote " & lotes!numero & " EXCED", 40).Trim
                        Dim mensaje As String = "TIEMPO DE PROCESO EXCEDIDO" & vbCrLf & vbCrLf & "Datos del lote" & vbCrLf & "Número: " & lotes!numero & vbCrLf & "Referencia del artículo: " & lotes!referencia & vbCrLf & "Descripción del artículo: " & lotes!producto & vbCrLf & vbCrLf & "Datos del proceso" & vbCrLf & "Nombre: " & lotes!nproceso & vbCrLf & "Operación de la ruta asociada: " & lotes!ruta_actual & vbCrLf & "Secuencia de la operación en la ruta: " & lotes!ruta_secuencia & vbCrLf & "Equipo asociado: " & lotes!equipo & vbCrLf & vbCrLf & "Datos de la demora" & vbCrLf & "Fecha de entrada en proceso: " & Format(lotes!fecha, "dd/MM/yyyy HH:mm:ss") & vbCrLf & "Fecha estimada de salida: " & Format(lotes!hasta, "dd/MM/yyyy HH:mm:ss") & vbCrLf & "Demora (H:MM:SS): " & calcularTiempoCad(DateAndTime.DateDiff(DateInterval.Second, lotes!hasta, DateAndTime.Now)) & vbCrLf & vbCrLf & "Activación de la alarma: " & Format(lotes!vence, "dd/MM/yyyy HH:mm:ss") & IIf(tiempo_holgura > 0, " (incluye una holgura de " & tiempo_holgura & " segundos)", "")

                        mensaje = mensaje.Trim
                        If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "S" Then
                            If ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "T" Then
                                mensaje = "Hay " & veces & " mensaje(s) de TIEMPO DE PROCESO EXCEDIDO por atender"
                                mensajeMMCall = "Hay " & veces & " TIEMPO(s) PROC/EXCED"
                            ElseIf ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "P" Then
                                mensaje = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 200)
                                mensajeMMCall = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 40)
                            End If
                        End If
                        'Se cambian los caracteres especiales
                        mensajeMMCall = UCase(mensajeMMCall)
                        mensajeMMCall = Replace(mensajeMMCall, "Á", "A")
                        mensajeMMCall = Replace(mensajeMMCall, "É", "E")
                        mensajeMMCall = Replace(mensajeMMCall, "Í", "I")
                        mensajeMMCall = Replace(mensajeMMCall, "Ó", "O")
                        mensajeMMCall = Replace(mensajeMMCall, "Ú", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ü", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ñ", "~")
                        mensajeMMCall = Replace(mensajeMMCall, ":", " ")


                        If mensaje.Length = 0 Then
                            mensaje = "Hay mensajes por tiempo de proceso excedido"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        If mensajeMMCall.Length = 0 Then
                            mensajeMMCall = "Hay mensajes proc/exced"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje para MMCall definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        'If ValNull(alerta.Tables(0).Rows(0)!log, "A") = "S" Then
                        ' regsAfectados = consultaACT("INSERT INTO sigma.log (aplicacion, tipo, alerta, texto) VALUES (10, 1, " & idAlerta '& ", '" & mensaje & "')")
                        'End If

                        If ValNull(alerta.Tables(0).Rows(0)!llamada, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 1, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!sms, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 2, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!correo, "A") = "S" Then agregarMensaje("correos", alerta.Tables(0).Rows(0)!lista, uID, 0, 3, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!mmcall, "A") = "S" Then agregarMensaje("mmcall", alerta.Tables(0).Rows(0)!lista, uID, 0, 4, 0, mensajeMMCall)
                        agregarLOG("Se ha creado el reporte: " & uID & IIf(porAcumulacion, " por acumulación de tiempos excedidos de proceso", ""), 1, uID)
                    End If

                    regsAfectados = consultaACT("UPDATE sigma.lotes SET alarma_tpe = 'S', alarmas = alarmas + 1 WHERE id = " & loteID)

                End If
            Next
            If pases > 0 Then agregarSolo("Se generaron " & pases & " alarma(s) por Tiempo de proceso excedido")
        End If
    End Sub

    Private Sub alertaTPEAnticipado()
        Dim regsAfectados = 0
        Dim tiempo_holgura = 0
        Dim veces = 0
        Dim pases = 0

        Dim cadSQL = "SELECT a.id, a.proceso, a.fecha, a.hasta, a.numero, IFNULL(d.nombre, 'N/A') as equipo, IFNULL(e.nombre, 'N/A') as nproceso, TIME_TO_SEC(TIMEDIFF(a.hasta, NOW())) AS previo, a.ruta_secuencia, c.referencia, c.nombre AS producto, IFNULL(b.nombre, 'N/A') AS ruta_actual FROM sigma.lotes a LEFT JOIN sigma.det_rutas b ON a.ruta_detalle = b.id LEFT JOIN sigma.cat_partes c ON a.parte = c.id LEFT JOIN sigma.det_procesos d ON a.equipo = d.id LEFT JOIN sigma.cat_procesos e ON a.proceso = e.id WHERE estado = 50 AND alarma_tpe_p <> 'S' AND TIME_TO_SEC(TIMEDIFF(a.hasta, NOW())) > 0 AND TIME_TO_SEC(TIMEDIFF(a.hasta, NOW())) <= (SELECT MAX(tiempo0) FROM sigma.cat_alertas WHERE tipo = 6 AND estatus = 'A' AND (proceso = 0 OR proceso = b.proceso))"


        Dim falla As DataSet = consultaSEL(cadSQL)
        If falla.Tables(0).Rows.Count > 0 Then
            For Each lotes In falla.Tables(0).Rows
                Dim loteID = lotes!id
                Dim procesoID = lotes!proceso

                cadSQL = "SELECT * FROM sigma.cat_alertas WHERE tipo = 6 AND estatus = 'A' AND (proceso = 0 OR proceso = " & procesoID & ") ORDER BY tiempo0 DESC LIMIT 1"
                Dim alerta As DataSet = consultaSEL(cadSQL)
                Dim uID = 0

                If alerta.Tables(0).Rows.Count > 0 Then

                    Dim idAlerta = alerta.Tables(0).Rows(0)!id
                    Dim fechaDesde
                    Dim crearReporte As Boolean = False


                    Dim porAcumulacion = False
                    If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "N" Then
                        'Se pregunta si hay un rperte activo y si es solapable
                        'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                        crearReporte = True
                        'Else
                        'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                        'Dim solapar As DataSet = consultaSEL(cadSQL)
                        'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                        'End If

                    Else
                        porAcumulacion = True
                        If ValNull(alerta.Tables(0).Rows(0)!acumular_inicializar, "A") = "S" Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND reporte = 0 AND accion = 0 "
                            End If
                        Else
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                fechaDesde = DateAdd(DateInterval.Second, alerta.Tables(0).Rows(0)!acumular_tiempo * -1, Now)
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta & " AND inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "'"
                            Else
                                cadSQL = "SELECT COUNT(*) as cuenta FROM sigma.alarmas WHERE alerta = " & idAlerta
                            End If
                        End If

                        Dim acumulado = 0
                        Dim acum As DataSet = consultaSEL(cadSQL)
                        If acum.Tables(0).Rows.Count > 0 Then
                            acumulado = acum.Tables(0).Rows(0)!cuenta
                        End If
                        If acumulado + 1 >= alerta.Tables(0).Rows(0)!acumular_veces Then
                            veces = acumulado + 1
                            'If ValNull(alerta.Tables(0).Rows(0)!solapar, "A") = "S" Then
                            crearReporte = True
                            'Else
                            'cadSQL = "SELECT * FROM sigma.vw_reportes WHERE vw_reportes.alerta = " & idAlerta & " AND estado <> 9 "
                            'Dim solapar As DataSet = consultaSEL(cadSQL)
                            'crearReporte = Not solapar.Tables(0).Rows.Count > 0
                            'End If
                        End If
                    End If
                    If crearReporte Then
                        regsAfectados = consultaACT("INSERT INTO sigma.vw_reportes (alerta, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, estado) SELECT id, informar_resolucion, log, sms, correo, llamada, mmcall, lista, escalar1, tiempo1, lista1, log1, sms1, correo1, llamada1, mmcall1, repetir1, escalar2, tiempo2, lista2, log2, sms2, correo2, llamada2, mmcall2, repetir2, escalar3, tiempo3, lista3, log3, sms3, correo3, llamada3, mmcall3, repetir3, escalar4, tiempo4, lista4, log4, sms4, correo4, llamada4, mmcall4, repetir4, escalar5, tiempo5, lista5, log5, sms5, correo5, llamada5, mmcall5, repetir5, repetir, repetir_tiempo, repetir_log, repetir_sms, repetir_correo, repetir_llamada, repetir_mmcall, 1 FROM sigma.cat_alertas WHERE id = " & alerta.Tables(0).Rows(0)!id)
                        'Se obtieneel último ID
                        cadSQL = "SELECT MAX(id) as ultimo FROM sigma.vw_reportes"
                        Dim ultimo As DataSet = consultaSEL(cadSQL)
                        If ultimo.Tables(0).Rows.Count > 0 Then
                            uID = ultimo.Tables(0).Rows(0)!ultimo
                        End If


                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, reporte, accion) VALUES (6, " & procesoID & ", " & loteID & ", NOW(), " & idAlerta & ", " & uID & ", 1)")
                        If porAcumulacion Then
                            If alerta.Tables(0).Rows(0)!acumular_tiempo > 0 Then
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 And inicio >= '" & Format(fechaDesde, "yyyy/MM/dd HH:mm:ss") & "' AND accion = 0")
                            Else
                                regsAfectados = consultaACT("UPDATE sigma.alarmas SET reporte = " & uID & " WHERE alerta = " & idAlerta & " And reporte = 0 AND accion = 0")
                            End If
                        End If
                    Else
                        'Se crear la alarma suelta

                        regsAfectados = consultaACT("INSERT INTO sigma.alarmas (tipo, proceso, lote, inicio, alerta, accion) VALUES (6, " & procesoID & ", " & loteID & ", NOW(), " & idAlerta & ", " & IIf(porAcumulacion, 0, 4) & ")")

                    End If

                    If crearReporte Then
                        pases = pases + 1
                        'Se generan los mensajes a enviar
                        Dim mensajeMMCall As String = Microsoft.VisualBasic.Strings.Left("PROCESO/POR EXCED L-" & lotes!numero, 40).Trim

                        Dim mensaje As String = "TIEMPO DE PROCESO PRONTO A EXCEDER" & vbCrLf & vbCrLf & "Datos del lote" & vbCrLf & "Número: " & lotes!numero & vbCrLf & "Referencia del artículo: " & lotes!referencia & vbCrLf & "Descripción del artículo: " & lotes!producto & vbCrLf & vbCrLf & "Datos del proceso" & vbCrLf & "Nombre: " & lotes!nproceso & vbCrLf & "Operación de la ruta asociada: " & lotes!ruta_actual & vbCrLf & "Secuencia de la operación en la ruta: " & lotes!ruta_secuencia & vbCrLf & "Equipo asociado: " & lotes!equipo & vbCrLf & vbCrLf & "Datos de la demora" & vbCrLf & "Fecha de entrada en proceso: " & Format(lotes!fecha, "dd/MM/yyyy HH:mm:ss") & vbCrLf & "Fecha estimada de salida: " & Format(lotes!hasta, "dd/MM/yyyy HH:mm:ss") & vbCrLf & "Alarma anticipada en (H:MM:SS): " & calcularTiempoCad(lotes!previo)

                        mensaje = mensaje.Trim
                        If ValNull(alerta.Tables(0).Rows(0)!acumular, "A") = "S" Then
                            If ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "T" Then
                                mensaje = "Hay " & veces & " mensaje(s) de ANTIPACION DE PROCESO EXCEDIDO por atender"
                                mensajeMMCall = "Hay " & veces & " ANTICIP PROCESO/EXCED"
                            ElseIf ValNull(alerta.Tables(0).Rows(0)!acumular_tipo_mensaje, "A") = "P" Then
                                mensaje = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 200)
                                mensajeMMCall = Microsoft.VisualBasic.Strings.Left(ValNull(alerta.Tables(0).Rows(0)!acumular_mensaje, "A"), 40)
                            End If
                        End If
                        'Se cambian los caracteres especiales
                        mensajeMMCall = UCase(mensajeMMCall)
                        mensajeMMCall = Replace(mensajeMMCall, "Á", "A")
                        mensajeMMCall = Replace(mensajeMMCall, "É", "E")
                        mensajeMMCall = Replace(mensajeMMCall, "Í", "I")
                        mensajeMMCall = Replace(mensajeMMCall, "Ó", "O")
                        mensajeMMCall = Replace(mensajeMMCall, "Ú", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ü", "U")
                        mensajeMMCall = Replace(mensajeMMCall, "Ñ", "~")
                        mensajeMMCall = Replace(mensajeMMCall, ":", " ")

                        If mensaje.Length = 0 Then
                            mensaje = "Hay mensajes de anticipación por tiempo de proceso excedido"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        If mensajeMMCall.Length = 0 Then
                            mensajeMMCall = "Hay mensajes anticip proceso/exced"
                            agregarLOG("La alerta" & idAlerta & " no tiene un mensaje para MMCall definido se tomó el mensaje por defecto", 1, 2)
                        End If
                        'If ValNull(alerta.Tables(0).Rows(0)!log, "A") = "S" Then
                        ' regsAfectados = consultaACT("INSERT INTO sigma.log (aplicacion, tipo, alerta, texto) VALUES (10, 1, " & idAlerta '& ", '" & mensaje & "')")
                        'End If


                        If ValNull(alerta.Tables(0).Rows(0)!llamada, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 1, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!sms, "A") = "S" Then agregarMensaje("telefonos", alerta.Tables(0).Rows(0)!lista, uID, 0, 2, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!correo, "A") = "S" Then agregarMensaje("correos", alerta.Tables(0).Rows(0)!lista, uID, 0, 3, 0, mensaje)
                        If ValNull(alerta.Tables(0).Rows(0)!mmcall, "A") = "S" Then agregarMensaje("mmcall", alerta.Tables(0).Rows(0)!lista, uID, 0, 4, 0, mensajeMMCall)
                        agregarLOG("Se ha creado el reporte: " & uID & IIf(porAcumulacion, " por anticipación de tiempo de proceso excedido", ""), 1, uID)
                    End If
                    regsAfectados = consultaACT("UPDATE sigma.lotes SET alarma_tpe_p = 'S' WHERE id = " & loteID)
                End If
            Next
            If pases > 0 Then agregarSolo("Se generaron " & pases & " alarma(s) por Anticipación de tiempo de proceso excedido")
        End If
    End Sub

    Private Sub calcularRevision()
        Dim cadSQL As String = "SELECT revisar_cada FROM sigma.configuracion"
        Dim reader As DataSet = consultaSEL(cadSQL)
        If errorBD.Length > 0 Then
            agregarLOG("Ocurrió un error al intentar leer MySQL. Error: " + errorBD, 9, 0)
        Else
            If reader.Tables(0).Rows.Count > 0 Then
                If ValNull(reader.Tables(0).Rows(0)!revisar_cada, "N") = 0 Then
                    eSegundos = 60
                    Dim regsAfectados = consultaACT("UPDATE sigma.configuracion SET revisar_cada = 60")
                    mensajes.Interval = 1000
                    mensajes.Enabled = False
                    mensajes.Enabled = True
                Else
                    eSegundos = ValNull(reader.Tables(0).Rows(0)!revisar_cada, "N")
                    If mensajes.Interval <> eSegundos * 1000 Then
                        mensajes.Interval = eSegundos * 1000
                        mensajes.Enabled = False
                        mensajes.Enabled = True
                    End If
                End If

            End If
        End If
        BarManager1.Items(1).Caption = "Conectado (cada " & eSegundos & " segundos)"
    End Sub

    Private Sub procesarMensajes()
        Dim regsAfectados = 0
        BarManager1.Items(1).Caption = "Conectado (procesando mensajes...)"
        agregarSolo("Revisando mensajes a enviar")
        'Escalada 4
        Dim miError As String = ""
        Dim optimizar_llamada As Boolean = False
        Dim optimizar_sms As Boolean = False
        Dim optimizar_correo As Boolean = False
        Dim optimizar_mmcall As Boolean = False
        Dim mantenerPrioridad As Boolean = False
        Dim rutaSMS
        Dim correo_titulo_falla As Boolean
        Dim correo_titulo As String
        Dim correo_cuerpo As String
        Dim correo_firma As String
        Dim correo_cuenta As String
        Dim correo_puerto As String
        Dim correo_ssl As Boolean
        Dim correo_clave As String
        Dim correo_host As String
        Dim voz_audio As String
        Dim mensajeGenerado As Boolean = False
        Dim escape_mmcall As Boolean = False
        Dim escape_mmcall_mensaje As String = ""
        Dim escape_mmcall_lista = 0
        Dim escape_mmcall_cancelar As Boolean = True
        Dim utilizar_arduino As Boolean = True
        Dim traducir As Boolean = False
        Dim server_mmcall As String = ""

        Dim rutaAudios
        Dim cadSQL As String = "SELECT * FROM sigma.configuracion"
        Dim readerDS As DataSet = consultaSEL(cadSQL)
        If readerDS.Tables(0).Rows.Count > 0 Then
            Dim reader As DataRow = readerDS.Tables(0).Rows(0)
            optimizar_llamada = ValNull(reader!optimizar_llamada, "A") = "S"
            optimizar_sms = ValNull(reader!optimizar_sms, "A") = "S"
            optimizar_correo = ValNull(reader!optimizar_correo, "A") = "S"
            optimizar_mmcall = ValNull(reader!optimizar_mmcall, "A") = "S"
            mantenerPrioridad = ValNull(reader!optimizar_mmcall, "A") = "S"
            rutaSMS = ValNull(reader!ruta_sms, "A")
            rutaAudios = ValNull(reader!ruta_audios, "A")
            correo_titulo_falla = ValNull(reader!correo_titulo_falla, "A") = "S"
            correo_titulo = ValNull(reader!correo_titulo, "A")
            correo_cuerpo = ValNull(reader!correo_cuerpo, "A")
            correo_firma = ValNull(reader!correo_firma, "A")
            correo_cuenta = ValNull(reader!correo_cuenta, "A")
            correo_clave = ValNull(reader!correo_clave, "A")
            correo_puerto = ValNull(reader!correo_puerto, "A")
            correo_ssl = ValNull(reader!correo_ssl, "A") = "S"
            correo_host = ValNull(reader!correo_host, "A")
            server_mmcall = ValNull(reader!server_mmcall, "A")
            voz_audio = ValNull(reader!voz_predeterminada, "A")
            escape_mmcall = ValNull(reader!escape_mmcall, "A") = "S"
            traducir = ValNull(reader!traducir, "A") = "S"
            escape_mmcall_cancelar = ValNull(reader!escape_mmcall_cancelar, "A") = "S"
            escape_mmcall_mensaje = ValNull(reader!escape_mmcall_mensaje, "A")
            escape_mmcall_lista = ValNull(reader!escape_mmcall_lista, "A")
            utilizar_arduino = ValNull(reader!utilizar_arduino, "A") = "S"
        End If
        If escape_mmcall_mensaje.Length = 0 Then escape_mmcall_mensaje = "TODOS LOS REQUESTERS DE MMCALL OCUPADOS..."

        If Not estadoPrograma Then
            Exit Sub
        End If
        'Llamadas telefónicas
        If Not My.Computer.FileSystem.DirectoryExists(rutaAudios) Then
            rutaAudios = My.Computer.FileSystem.SpecialDirectories.MyDocuments
        End If
        If Not optimizar_llamada Then
            cadSQL = "SELECT *, 1 as cuenta  FROM sigma.mensajes WHERE canal = 1 AND estatus = 'A' ORDER BY prioridad DESC"
        ElseIf mantenerPrioridad Then
            cadSQL = "SELECT prioridad, canal, destino, count(*) as cuenta FROM sigma.mensajes WHERE canal = 1 AND estatus = 'A' GROUP BY prioridad, canal, destino ORDER BY prioridad DESC"
        Else
            cadSQL = "SELECT canal, destino, count(*) as cuenta FROM sigma.mensajes WHERE canal = 1 AND estatus = 'A' GROUP BY canal, destino ORDER BY prioridad DESC"
        End If
        'Se preselecciona la voz
        Dim indice = 0

        Dim mensajesDS As DataSet = consultaSEL(cadSQL)
        Dim eMensaje = ""
        Dim audiosGen = 0
        Dim audiosNGen = 0
        Dim mTotal = 0

        If mensajesDS.Tables(0).Rows.Count > 0 Then
            Dim indiceVoz = 0
            Dim primeraVoz As String
            Dim synthesizer As New SpeechSynthesizer()
            For Each voice In synthesizer.GetInstalledVoices
                indiceVoz = indiceVoz + 1
                Dim info As VoiceInfo
                info = voice.VoiceInfo
                If voz_audio = info.Name Then
                    indiceVoz = -1
                    Exit For
                End If
                If indiceVoz = 1 Then primeraVoz = info.Name
            Next
            If indiceVoz > 0 Then
                agregarLOG("La voz especificada en el archivo de configuración NO esta registrada en el sistema, se tomará la voz por defecto del PC", 1, 0)
                voz_audio = primeraVoz
            ElseIf indiceVoz = 0 Then
                agregarLOG("No se generaron audios para llamadas porque no se encontró alguna voz para reproducir audios en la PC. Por favor revise e intente de nuevo", 1, 0)
            End If
            If indiceVoz <> 0 Then
                indice = 0
                For Each elmensaje In mensajesDS.Tables(0).Rows
                    indice = indice + 1
                    If optimizar_llamada Then
                        If elmensaje!cuenta = 1 Then
                            Dim fPrioridad = ""
                            If mantenerPrioridad Then
                                fPrioridad = " AND (prioridad = '" & elmensaje!prioridad & "' OR ISNULL(prioridad)) "
                            End If
                            'Doble cic en el mensaje
                            cadSQL = "SELECT mensaje FROM sigma.mensajes WHERE canal = 1 AND destino = '" & elmensaje!destino & "' AND estatus = 'A' " & fPrioridad & " "
                            Dim dbMensajes As DataSet = consultaSEL(cadSQL)
                            If dbMensajes.Tables(0).Rows.Count > 0 Then
                                eMensaje = ValNull(dbMensajes.Tables(0).Rows(0)!mensaje, "A")
                            End If
                        Else
                            eMensaje = "USTED TIENE " & elmensaje!cuenta & " mensaje(s) POR ATENDER"
                        End If
                    Else
                        eMensaje = ValNull(elmensaje!mensaje, "A")
                    End If
                    mTotal = mTotal + elmensaje!cuenta
                    'Se crea el audio
                    If eMensaje.Length > 0 Then
                        mensajeGenerado = False
                        Try
                            Dim synthesizer0 As New SpeechSynthesizer()
                            synthesizer0.SetOutputToWaveFile(rutaAudios & "\" & elmensaje!destino & Format(Now, "hhmmss") & indice & "_1.wav")
                            synthesizer0.SelectVoice(voz_audio)
                            synthesizer0.Volume = 100 '  // 0...100
                            synthesizer0.Rate = 0 '     // -10...10
                            Dim builder2 As New PromptBuilder()
                            If traducir Then eMensaje = traducirMensaje(eMensaje)
                            builder2.AppendText(eMensaje)
                            builder2.Culture = synthesizer0.Voice.Culture
                            synthesizer0.Speak(builder2)
                            synthesizer0.SetOutputToDefaultAudioDevice()
                            mensajeGenerado = True
                            audiosGen = audiosGen + 1
                        Catch ex As Exception
                            miError = ex.Message
                            audiosNGen = audiosNGen + 1
                        End Try
                    Else
                        mensajeGenerado = True
                    End If
                    If mensajeGenerado Then
                        If optimizar_llamada Then
                            Dim fPrioridad = ""
                            If mantenerPrioridad Then
                                fPrioridad = " AND (prioridad = '" & elmensaje!prioridad & "' OR ISNULL(prioridad)) "
                            End If
                            'Doble cic en el mensaje
                            regsAfectados = consultaACT("UPDATE sigma.mensajes SET estatus = 'Z' WHERE canal = 1 AND destino = '" & elmensaje!destino & "' AND estatus = 'A' " & fPrioridad)
                        Else
                            regsAfectados = consultaACT("UPDATE sigma.mensajes SET estatus = 'Z' WHERE id = " & elmensaje!id)
                        End If
                    End If
                Next
                If audiosGen > 0 Then
                    agregarLOG("Se generaron " & audiosGen & " audio(s) para llamada de voz (" & mTotal & " notifación(es))" & IIf(audiosNGen > 0, " No se generaron " & audiosNGen & " audio(s) ", ""), 1, 0)
                Else
                    If audiosNGen > 0 Then
                        agregarLOG("Errores en la conversión de audios. No se generaron " & audiosNGen & " audio(s) para llamada por voz. Error: " & miError, 1, 0)
                    End If
                End If
            End If
        End If

        If Not estadoPrograma Then
            Exit Sub
        End If
        ''
        miError = ""
        'elmensaje de texto
        If Not My.Computer.FileSystem.DirectoryExists(rutaSMS) Then
            rutaSMS = My.Computer.FileSystem.SpecialDirectories.MyDocuments
        End If
        If Not optimizar_sms Then
            cadSQL = "SELECT *, 1 as cuenta  FROM sigma.mensajes WHERE canal = 2 AND estatus = 'A' ORDER BY prioridad DESC"
        ElseIf mantenerPrioridad Then
            cadSQL = "SELECT prioridad, canal, destino, count(*) as cuenta FROM sigma.mensajes WHERE canal = 2 AND estatus = 'A' GROUP BY prioridad, canal, destino ORDER BY prioridad DESC"
        Else
            cadSQL = "SELECT canal, destino, count(*) as cuenta FROM sigma.mensajes WHERE canal = 2 AND estatus = 'A' GROUP BY canal, destino ORDER BY prioridad DESC"
        End If
        'Se preselecciona la voz
        mensajesDS = consultaSEL(cadSQL)
        eMensaje = ""
        audiosGen = 0
        audiosNGen = 0
        mTotal = 0
        indice = 0

        If mensajesDS.Tables(0).Rows.Count > 0 Then
            For Each elmensaje In mensajesDS.Tables(0).Rows
                indice = indice + 1
                If optimizar_sms Then
                    If elmensaje!cuenta = 1 Then
                        Dim fPrioridad = ""
                        If mantenerPrioridad Then
                            fPrioridad = " AND (prioridad = '" & elmensaje!prioridad & "' OR ISNULL(prioridad)) "
                        End If
                        'Doble cic en el mensaje
                        cadSQL = "SELECT mensaje FROM sigma.mensajes WHERE canal = 2 AND destino = '" & elmensaje!destino & "' AND estatus = 'A' " & fPrioridad & " "
                        Dim dbMensajes As DataSet = consultaSEL(cadSQL)
                        If dbMensajes.Tables(0).Rows.Count > 0 Then

                            eMensaje = ValNull(dbMensajes.Tables(0).Rows(0)!mensaje, "A")
                        End If

                    Else
                        eMensaje = "USTED TIENE " & elmensaje!cuenta & " mensaje(s) POR ATENDER"
                    End If
                Else
                    eMensaje = ValNull(elmensaje!mensaje, "A")
                End If
                mTotal = mTotal + elmensaje!cuenta
                'Se crea el audio
                mensajeGenerado = False
                If eMensaje.Length > 0 Then
                    Try
                        System.IO.File.Create(rutaSMS & "\" & elmensaje!destino & Format(Now, "hhmmss") & indice & ".txt").Dispose()
                        Dim objWriter As New System.IO.StreamWriter(rutaSMS & "\" & elmensaje!destino & Format(Now, "hhmmss") & indice & ".txt", True)
                        objWriter.WriteLine(eMensaje)
                        objWriter.Close()
                        audiosGen = audiosGen + 1
                        mensajeGenerado = True
                    Catch ex As Exception
                        audiosNGen = audiosNGen + 1
                        miError = ex.Message
                    End Try
                Else
                    mensajeGenerado = True
                End If
                If mensajeGenerado Then
                    If optimizar_sms Then
                        Dim fPrioridad = ""
                        If mantenerPrioridad Then
                            fPrioridad = " AND (prioridad = '" & elmensaje!prioridad & "' OR ISNULL(prioridad)) "
                        End If
                        'Doble cic en el mensaje
                        regsAfectados = consultaACT("UPDATE sigma.mensajes SET estatus = 'Z' WHERE canal = 2 AND destino = '" & elmensaje!destino & "' AND estatus = 'A' " & fPrioridad)
                    Else
                        regsAfectados = consultaACT("UPDATE sigma.mensajes SET estatus = 'Z' WHERE id = " & elmensaje!id)
                    End If
                End If
            Next
            If audiosGen > 0 Then
                agregarLOG("Se generaron " & audiosGen & " mensaje(s) de texto (" & mTotal & " notifación(es))" & IIf(audiosNGen > 0, " No se generaron " & audiosNGen & " audio(s) ", ""), 1, 0)
            Else
                If audiosNGen > 0 Then
                    agregarLOG("Errores en la generación de mensaje(s) de texto. No se generaron " & audiosNGen & " mensaje(s) de texto para llamada por voz. Error: " & miError, 1, 0)
                End If
            End If
        End If


        If Not estadoPrograma Then
            Exit Sub
        End If


        Try
            'agregarSolo("Se inicia la aplicación de Envío de correos")
            'Shell(Application.StartupPath & "\tnCorreos.exe", AppWinStyle.MinimizedNoFocus)
        Catch ex As Exception
            agregarLOG("Error en la ejecución de la aplicación de envío de correos. Error: " & ex.Message, 7, 0)
        End Try

        'Se copia el codigo en el sub EC

        If Not estadoPrograma Then
            Exit Sub
        End If


        If Not optimizar_mmcall Then
            cadSQL = "SELECT *, 1 as cuenta  FROM sigma.mensajes WHERE canal = 4 AND estatus = 'A' ORDER BY prioridad DESC"
        ElseIf mantenerPrioridad Then
            cadSQL = "SELECT prioridad, canal, destino, count(*) as cuenta FROM sigma.mensajes WHERE canal = 4 AND estatus = 'A' GROUP BY prioridad, canal, destino ORDER BY prioridad DESC"
        Else
            cadSQL = "SELECT canal, destino, count(*) as cuenta FROM sigma.mensajes WHERE canal = 4 AND estatus = 'A' GROUP BY canal, destino ORDER BY prioridad DESC"
        End If
        'Se preselecciona la voz
        mensajesDS = consultaSEL(cadSQL)
        eMensaje = ""
        audiosGen = 0
        audiosNGen = 0
        mTotal = 0

        If mensajesDS.Tables(0).Rows.Count > 0 Then
            For Each elmensaje In mensajesDS.Tables(0).Rows
                Dim tituloMensaje = "Monitor de alertas"
                If optimizar_mmcall Then
                    If elmensaje!cuenta = 1 Then
                        Dim fPrioridad = ""
                        If mantenerPrioridad Then
                            fPrioridad = " AND (prioridad = '" & elmensaje!prioridad & "' OR ISNULL(prioridad)) "
                        End If
                        'Doble cic en el mensaje


                        cadSQL = "SELECT mensaje FROM sigma.mensajes WHERE canal = 4 AND destino = '" & elmensaje!destino & "' AND estatus = 'A' " & fPrioridad & " "
                        Dim dbMensajes As DataSet = consultaSEL(cadSQL)
                        If dbMensajes.Tables(0).Rows.Count > 0 Then

                            eMensaje = ValNull(dbMensajes.Tables(0).Rows(0)!mensaje, "A")
                        End If

                    Else
                        eMensaje = "USTED TIENE " & elmensaje!cuenta & " mensaje(s) POR ATENDER"
                    End If
                Else
                    eMensaje = ValNull(elmensaje!mensaje, "A")
                End If
                mTotal = mTotal + elmensaje!cuenta
                'Se crea el audio
                Dim cadena = ""

                mensajeGenerado = False
                Dim escapado As Boolean = False
                If eMensaje.Length > 0 Then
                    'Se busca un requester activo para la división
                    'Se busca la división en MMCall

                    'SE CAMBIA POR EL ENVIO DE MENSAJES
                    'cadSQL = "SELECT a.CODE FROM mmcall.requesters AS a WHERE (a.NAME LIKE '" & elmensaje!destino & "%' OR NAME = '" & elmensaje!destino & "') AND (SELECT COUNT(*) FROM mmcall.records WHERE records.requester = a.CODE AND ISNULL(end_time)) = 0 order by a.CODE LIMIT 1 "
                    'Se preselecciona la voz
                    'Dim requesters = consultaSEL(cadSQL)
                    'Dim elRequester = ""
                    'If requesters.Tables(0).Rows.Count > 0 Then
                    ' elRequester = requesters.Tables(0).Rows(0)!code
                    ' mensajeGenerado = False
                    'Dim cadAdicional As String = "/locations/integration/page/number="
                    'Dim mDestino = elmensaje!destino
                    'Dim serverIndividual = Microsoft.VisualBasic.Strings.Left(elmensaje!destino, Microsoft.VisualBasic.Strings.InSt'r(elmensaje!destino, ")"))
                    'Dim miDestino = ""
                    'If serverIndividual.Length > 0 Then
                    'miDestino = Microsoft.VisualBasic.Strings.Mid(elmensaje!destino, serverIndividual.Length + 1)
                    'serverIndividual = Microsoft.VisualBasic.Strings.Mid(serverIndividual, 2, serverIndividual.Length - 2)
                    'Else
                    'serverIndividual = server_mmcall
                    'miDestino = elmensaje!destino
                    'End If
                    'If Microsoft.VisualBasic.Strings.Left(miDestino, 1) = "D" Then
                    'cadAdicional = "/locations/integration/group_message/division="
                    'mDestino = Microsoft.VisualBasic.Strings.Mid(miDestino, 2)
                    'Else
                    'mDestino = miDestino
                    'End If
                    Try
                        'Se intenta enviar al beeper indicado
                        'MsgBox("Se enviará este mensaje: " & server_mmcall & cadAdicional & mDestino & "&message=" & eMensaje)
                        agregarLOG("Se consume servicio de MMCall: " & elmensaje!destino & "&message=" & eMensaje, 1, 0)
                        'If serverIndividual.Length = 0 Then serverIndividual = ""

                        Dim fr As System.Net.HttpWebRequest
                        'Dim targetURI As New Uri(serverIndividual & cadAdicional & mDestino & "&message=" & eMensaje)
                        Dim targetURI As New Uri(elmensaje!destino & "&message=" & eMensaje)

                        fr = DirectCast(HttpWebRequest.Create(targetURI), System.Net.HttpWebRequest)
                        If (fr.GetResponse().ContentLength > 0) Then
                            Dim str As New System.IO.StreamReader(fr.GetResponse().GetResponseStream())
                            cadena = str.ReadToEnd
                            str.Close()
                        End If
                        mensajeGenerado = cadena = "success"
                        If mensajeGenerado Then audiosGen = audiosGen + 1

                    Catch ex As System.Net.WebException
                        audiosNGen = audiosNGen + 1
                        miError = ex.Message
                    End Try
                End If
                If mensajeGenerado Then
                    If optimizar_mmcall Then
                        Dim fPrioridad = ""
                        If mantenerPrioridad Then
                            fPrioridad = " AND (prioridad = '" & elmensaje!prioridad & "' OR ISNULL(prioridad)) "
                        End If
                        'Doble cic en el mensaje
                        regsAfectados = consultaACT("UPDATE sigma.mensajes SET estatus = 'Z' WHERE canal = 4 AND destino = '" & elmensaje!destino & "' AND estatus = 'A' " & fPrioridad)
                    Else
                        regsAfectados = consultaACT("UPDATE sigma.mensajes SET estatus = 'Z' WHERE id = " & elmensaje!id)
                    End If
                ElseIf cadena <> "success" Then
                    agregarLOG("Errores en la generación de llamada a MMCall. No se generaron " & audiosNGen & " llamada(s) a MMCall. Error: " & cadena, 1, 0)
                End If
            Next
            If audiosGen > 0 Then
                agregarLOG("Se generaron " & audiosGen & " mensaje(s) a MMCall (" & mTotal & " notifación(es))" & IIf(audiosNGen > 0, " No se generaron " & audiosNGen & " mensaje(s) a MMCall ", ""), 1, 0)
            Else
                If audiosNGen > 0 Then
                    agregarLOG("Errores en la generación de llamada a MMCall. No se generaron " & audiosNGen & " llamada(s) a MMCall. Error: " & miError, 1, 0)
                End If
            End If
        End If
        BarManager1.Items(1).Caption = "Conectado (cada " & eSegundos & " segundos)"
        If utilizar_arduino Then
            Try
                'agregarSolo("Se inicia la aplicación de Arduino(r) ")
                'elvis Shell(Application.StartupPath & "\vwArduino.exe", AppWinStyle.MinimizedNoFocus)
            Catch ex As Exception
                agregarLOG("Error en la ejecución de la aplicación de llamadas y SMS a Arduino. Error: " & ex.Message, 7, 0)
            End Try

            'generarLlamadas()
        End If
    End Sub


    Function calcularTiempo(Seg) As String
        calcularTiempo = ""
        If Seg < 60 Then
            calcularTiempo = Seg & " seg"
        ElseIf Seg < 3600 Then
            calcularTiempo = Math.Round(Seg / 60, 1) & " min"
        Else
            calcularTiempo = Math.Round(Seg / 3600, 1) & " hr"
        End If
    End Function


    Function calcularTiempoCad(Seg) As String
        calcularTiempoCad = "-"
        Dim horas = Math.Floor(Seg / 3600)
        Dim minutos = Math.Floor((Seg Mod 3600) / 60)
        Dim segundos = (Seg Mod 3600) Mod 60
        calcularTiempoCad = horas & ":" & Format(minutos, "00") & ":" & Format(segundos, "00")
    End Function

    Sub agregarMensaje(campo As String, LD As Integer, reporte As Integer, tipo As Integer, canal As Integer, prioridad As String, mensaje As String)

        Dim canales As DataSet
        Dim cadSQL = "SELECT " & campo & " as cadena FROM sigma.cat_distribucion WHERE id = " & LD & " AND estatus = 'A'"
        canales = consultaSEL(cadSQL)
        If canales.Tables(0).Rows.Count > 0 Then
            Dim todosCanales As String()
            Dim tempArray As String()
            Dim totalItems = 0
            Dim cadCanales As String = ValNull(canales.Tables(0).Rows(0)!cadena, "A")
            If cadCanales.Length > 0 Then
                Dim arreCanales = cadCanales.Split(New Char() {";"c})
                For i = LBound(arreCanales) To UBound(arreCanales)
                    'Redimensionamos el Array temporal y preservamos el valor  
                    ReDim Preserve todosCanales(totalItems + i)
                    todosCanales(totalItems + i) = arreCanales(i)
                Next
                tempArray = todosCanales
                totalItems = todosCanales.Length

                Dim x As Integer, y As Integer
                Dim z As Integer

                For x = 0 To UBound(todosCanales)
                    z = 0
                    For y = 0 To UBound(todosCanales) - 1
                        'Si el elemento del array es igual al array temporal  
                        If todosCanales(x) = tempArray(z) And y <> x Then
                            'Entonces Eliminamos el valor duplicado  
                            todosCanales(y) = ""
                        End If
                        z = z + 1
                    Next y
                Next x

                For Each movil In todosCanales
                    If movil.Length > 0 Then
                        Dim regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, tipo, canal, prioridad, destino, mensaje, lista) VALUES (" & reporte & ", " & tipo & ", " & canal & ", '" & prioridad & "', '" & movil & "', '" & mensaje.Trim & "', " & LD & ")")
                    End If
                Next

            End If

        End If
    End Sub

    Private Sub escalamiento_Tick(sender As Object, e As EventArgs) Handles escalamiento.Tick
        If procesandoEscalamientos Or Not estadoPrograma Then Exit Sub
        escalamiento.Enabled = False

        BarManager1.Items(1).Caption = "Conectado (revisando escalamientos...)"
        procesandoEscalamientos = True
        Dim regsAfectados = 0
        Dim cadSQL = ""

        'Escalada 5
        cadSQL = "SELECT sigma.vw_reportes.*, sigma.vw_alertas.nombre FROM sigma.vw_reportes LEFT JOIN sigma.vw_alertas ON vw_reportes.alerta = vw_alertas.id WHERE vw_reportes.escalar1 <> 'N' AND vw_reportes.escalar2 <> 'N' AND vw_reportes.escalar3 <> 'N' AND vw_reportes.escalar4 <> 'N' AND vw_reportes.escalar5 <> 'N' AND ((vw_reportes.estado = 5) OR (vw_reportes.estado >= 5 AND vw_reportes.estado < 9 AND vw_reportes.repetir5 = 'S'))"
        Dim alertaDS As DataSet = consultaSEL(cadSQL)
        If alertaDS.Tables(0).Rows.Count > 0 Then

            For Each alerta In alertaDS.Tables(0).Rows
                If Not estadoPrograma Then
                    procesandoEscalamientos = False
                    escalamiento.Enabled = True
                    Exit Sub
                End If
                Dim repeticiones As Integer = alerta!es5
                If alerta!estado > 5 Then
                    repeticiones = repeticiones + 1
                End If

                Dim segundos = 0
                Dim activarEscalada As Boolean = False
                Dim uID = alerta!id
                'Se verifica que no se haya repetido antes
                If alerta!escalada5.Equals(System.DBNull.Value) Then
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada4, "yyyy/MM/dd HH:mm:ss")), Now)
                Else
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada5, "yyyy/MM/dd HH:mm:ss")), Now)
                End If
                Dim tiempoCad = ""
                If segundos >= alerta!tiempo5 Then
                    agregarSolo("Generando escalamientos...")
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!activada, "yyyy/MM/dd HH:mm:ss")), Now)
                    tiempoCad = calcularTiempoCad(segundos)

                    'Se generan los mensajes a enviar
                    'Se busca una copia del mensaje anterior

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal <> 4 LIMIT 1"
                    Dim EMensaje As String
                    Dim miMensaje As DataSet = consultaSEL(cadSQL)
                    Dim prioridad = "0"
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        prioridad = ValNull(miMensaje.Tables(0).Rows(0)!prioridad, "A")
                        EMensaje = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E5 " & tiempoCad
                    End If
                    EMensaje = EMensaje & IIf(alerta!estado > 5, " *R" & repeticiones, "")

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " And tipo = 0 And canal = 4 LIMIT 1"
                    Dim EMensajeMMCall As String = "MENSAJE ESCALADO *E5 " & tiempoCad
                    miMensaje = consultaSEL(cadSQL)
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        EMensajeMMCall = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E5 " & tiempoCad
                    Else
                        EMensajeMMCall = EMensaje
                    End If
                    EMensajeMMCall = EMensajeMMCall & IIf(alerta!estado > 5, " *R" & repeticiones, "")
                    EMensajeMMCall = Microsoft.VisualBasic.Strings.Left(EMensajeMMCall, 40)
                    If EMensaje.Length = 0 Then EMensaje = EMensajeMMCall

                    If ValNull(alerta!escalar5, "A") = "T" And alerta!estado = 5 Then
                        'Se valida si se repite el mesaje para el nivel anterior
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 15, canal, prioridad, destino, '" & EMensaje & "' FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo <= 4 and canal <> 4;INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 15, canal, prioridad, destino, '" & EMensajeMMCall & "' FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo <= 4 and canal = 4")
                    End If


                    If ValNull(alerta!llamada5, "A") = "S" Then agregarMensaje("telefonos", alerta!lista5, uID, 5, 1, prioridad, EMensaje)
                    If ValNull(alerta!sms5, "A") = "S" Then agregarMensaje("telefonos", alerta!lista5, uID, 5, 2, prioridad, EMensaje)
                    If ValNull(alerta!correo5, "A") = "S" Then agregarMensaje("correos", alerta!lista5, uID, 5, 3, prioridad, EMensaje)
                    If ValNull(alerta!mmcall5, "A") = "S" Then agregarMensaje("mmcall", alerta!lista5, uID, 5, 4, prioridad, EMensajeMMCall)
                    Dim cadAdic = ""

                    If alerta!estado > 5 Then
                        agregarLOG("Se crea una repetición " & repeticiones & " del escalamiento de NIVEL 5 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    Else
                        cadAdic = ", estado = 6"

                        agregarLOG("Se crea escalamiento de NIVEL 5 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    End If
                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET escalamientos = 5, escalada5 = '" & Format(Now, "yyyy/MM/dd HH:mm:ss") & "', es5 = " & repeticiones & cadAdic & " WHERE id = " & alerta!id)
                End If
            Next
        End If

        regsAfectados = 0
        'Escalada 4
        cadSQL = "SELECT sigma.vw_reportes.*, sigma.vw_alertas.nombre FROM sigma.vw_reportes LEFT JOIN sigma.vw_alertas ON vw_reportes.alerta = vw_alertas.id WHERE vw_reportes.escalar1 <> 'N' AND vw_reportes.escalar2 <> 'N' AND vw_reportes.escalar3 <> 'N' AND vw_reportes.escalar4 <> 'N' AND ((vw_reportes.estado = 4) OR (vw_reportes.estado >= 4 AND vw_reportes.estado < 9 AND vw_reportes.repetir4 = 'S'))"
        alertaDS = consultaSEL(cadSQL)
        If alertaDS.Tables(0).Rows.Count > 0 Then
            For Each alerta In alertaDS.Tables(0).Rows
                If Not estadoPrograma Then
                    procesandoEscalamientos = False
                    escalamiento.Enabled = True
                    Exit Sub
                End If
                Application.DoEvents()
                Dim repeticiones As Integer = alerta!es4
                If alerta!estado > 4 Then
                    repeticiones = repeticiones + 1
                End If

                Dim segundos = 0
                Dim activarEscalada As Boolean = False
                Dim uID = alerta!id
                'Se verifica que no se haya repetido antes
                If alerta!escalada4.Equals(System.DBNull.Value) Then
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada3, "yyyy/MM/dd HH:mm:ss")), Now)
                Else
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada4, "yyyy/MM/dd HH:mm:ss")), Now)
                End If
                Dim tiempoCad = ""
                If segundos >= alerta!tiempo4 Then
                    agregarSolo("Generando escalamientos...")
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!activada, "yyyy/MM/dd HH:mm:ss")), Now)
                    tiempoCad = calcularTiempoCad(segundos)

                    'Se generan los mensajes a enviar
                    'Se busca una copia del mensaje anterior

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal <> 4 LIMIT 1"
                    Dim EMensaje As String
                    Dim miMensaje As DataSet = consultaSEL(cadSQL)
                    Dim prioridad = "0"
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        prioridad = ValNull(miMensaje.Tables(0).Rows(0)!prioridad, "A")
                        EMensaje = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E4 " & tiempoCad
                    End If
                    EMensaje = EMensaje & IIf(alerta!estado > 4, " *R" & repeticiones, "")

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " And tipo = 0 And canal = 4 LIMIT 1"
                    Dim EMensajeMMCall As String = "MENSAJE ESCALADO *E4 " & tiempoCad
                    miMensaje = consultaSEL(cadSQL)
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        EMensajeMMCall = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E4 " & tiempoCad
                    Else
                        EMensajeMMCall = EMensaje
                    End If
                    EMensajeMMCall = EMensajeMMCall & IIf(alerta!estado > 4, " *R" & repeticiones, "")
                    EMensajeMMCall = Microsoft.VisualBasic.Strings.Left(EMensajeMMCall, 40)
                    If EMensaje.Length = 0 Then EMensaje = EMensajeMMCall

                    If ValNull(alerta!escalar4, "A") = "T" And alerta!estado = 4 Then
                        'Se valida si se repite el mesaje para el nivel anterior
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 14, canal, prioridad, destino, '" & EMensaje & "' FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo <= 3 and canal <> 4;INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 14, canal, prioridad, destino, '" & EMensajeMMCall & "' FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo <= 3 and canal = 4")
                    End If


                    If ValNull(alerta!llamada4, "A") = "S" Then agregarMensaje("telefonos", alerta!lista4, uID, 4, 1, prioridad, EMensaje)
                    If ValNull(alerta!sms4, "A") = "S" Then agregarMensaje("telefonos", alerta!lista4, uID, 4, 2, prioridad, EMensaje)
                    If ValNull(alerta!correo4, "A") = "S" Then agregarMensaje("correos", alerta!lista4, uID, 4, 3, prioridad, EMensaje)
                    If ValNull(alerta!mmcall4, "A") = "S" Then agregarMensaje("mmcall", alerta!lista4, uID, 4, 4, prioridad, EMensajeMMCall)
                    Dim cadAdic = ""

                    If alerta!estado > 4 Then
                        agregarLOG("Se crea una repetición " & repeticiones & " del escalamiento de NIVEL 4 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    Else
                        agregarLOG("Se crea escalamiento de NIVEL 4 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                        cadAdic = ", estado = 5"

                    End If
                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET escalamientos = 4, escalada4 = '" & Format(Now, "yyyy/MM/dd HH:mm:ss") & "', es4 = " & repeticiones & cadAdic & " WHERE id = " & alerta!id)
                End If
            Next
        End If

        regsAfectados = 0
        'Escalada 3
        cadSQL = "SELECT sigma.vw_reportes.*, sigma.vw_alertas.nombre FROM sigma.vw_reportes LEFT JOIN sigma.vw_alertas ON vw_reportes.alerta = vw_alertas.id WHERE vw_reportes.escalar1 <> 'N' AND vw_reportes.escalar2 <> 'N' AND vw_reportes.escalar3 <> 'N' AND ((vw_reportes.estado = 3) OR (vw_reportes.estado >= 3 AND vw_reportes.estado < 9 AND vw_reportes.repetir3 = 'S'))"
        alertaDS = consultaSEL(cadSQL)
        If alertaDS.Tables(0).Rows.Count > 0 Then

            For Each alerta In alertaDS.Tables(0).Rows
                If Not estadoPrograma Then
                    procesandoEscalamientos = False
                    escalamiento.Enabled = True
                    Exit Sub
                End If
                Application.DoEvents()
                Dim repeticiones As Integer = alerta!es3
                If alerta!estado > 3 Then
                    repeticiones = repeticiones + 1
                End If

                Dim segundos = 0
                Dim activarEscalada As Boolean = False
                Dim uID = alerta!id
                'Se verifica que no se haya repetido antes
                If alerta!escalada3.Equals(System.DBNull.Value) Then
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada2, "yyyy/MM/dd HH:mm:ss")), Now)
                Else
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada3, "yyyy/MM/dd HH:mm:ss")), Now)
                End If
                Dim tiempoCad = ""
                If segundos >= alerta!tiempo3 Then
                    agregarSolo("Generando escalamientos...")
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!activada, "yyyy/MM/dd HH:mm:ss")), Now)
                    tiempoCad = calcularTiempoCad(segundos)

                    'Se generan los mensajes a enviar
                    'Se busca una copia del mensaje anterior

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal <> 4 LIMIT 1"
                    Dim EMensaje As String
                    Dim miMensaje As DataSet = consultaSEL(cadSQL)
                    Dim prioridad = "0"
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        prioridad = ValNull(miMensaje.Tables(0).Rows(0)!prioridad, "A")
                        EMensaje = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E3 " & tiempoCad
                    End If
                    EMensaje = EMensaje & IIf(alerta!estado > 3, " *R" & repeticiones, "")

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " And tipo = 0 And canal = 4 LIMIT 1"
                    Dim EMensajeMMCall As String = "MENSAJE ESCALADO *E3 " & tiempoCad
                    miMensaje = consultaSEL(cadSQL)
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        EMensajeMMCall = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E3 " & tiempoCad
                    Else
                        EMensajeMMCall = EMensaje
                    End If
                    EMensajeMMCall = EMensajeMMCall & IIf(alerta!estado > 3, " *R" & repeticiones, "")
                    EMensajeMMCall = Microsoft.VisualBasic.Strings.Left(EMensajeMMCall, 40)
                    If EMensaje.Length = 0 Then EMensaje = EMensajeMMCall

                    If ValNull(alerta!escalar3, "A") = "T" And alerta!estado = 3 Then
                        'Se valida si se repite el mesaje para el nivel anterior
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 13, canal, prioridad, destino, '" & EMensaje & "' FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo <= 2 and canal <> 4;INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 13, canal, prioridad, destino, '" & EMensajeMMCall & "' FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo <= 2 and canal = 4")
                    End If


                    If ValNull(alerta!llamada3, "A") = "S" Then agregarMensaje("telefonos", alerta!lista3, uID, 3, 1, prioridad, EMensaje)
                    If ValNull(alerta!sms3, "A") = "S" Then agregarMensaje("telefonos", alerta!lista3, uID, 3, 2, prioridad, EMensaje)
                    If ValNull(alerta!correo3, "A") = "S" Then agregarMensaje("correos", alerta!lista3, uID, 3, 3, prioridad, EMensaje)
                    If ValNull(alerta!mmcall3, "A") = "S" Then agregarMensaje("mmcall", alerta!lista3, uID, 3, 4, prioridad, EMensajeMMCall)
                    Dim cadAdic = ""

                    If alerta!estado > 3 Then
                        agregarLOG("Se crea una repetición " & repeticiones & " del escalamiento de NIVEL 3 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    Else
                        cadAdic = ", estado = 4"

                        agregarLOG("Se crea escalamiento de NIVEL 3 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    End If
                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET escalamientos = 3, escalada3 = '" & Format(Now, "yyyy/MM/dd HH:mm:ss") & "', es3 = " & repeticiones & cadAdic & " WHERE id = " & alerta!id)
                End If
            Next
        End If

        regsAfectados = 0
        'Escalada 2
        cadSQL = "Select sigma.vw_reportes.*, sigma.vw_alertas.nombre FROM sigma.vw_reportes LEFT JOIN sigma.vw_alertas ON vw_reportes.alerta = vw_alertas.id WHERE vw_reportes.escalar1 <> 'N' AND vw_reportes.escalar2 <> 'N' AND ((vw_reportes.estado = 2) OR (vw_reportes.estado >= 2 AND vw_reportes.estado < 9 AND vw_reportes.repetir2 = 'S'))"
        alertaDS = consultaSEL(cadSQL)
        If alertaDS.Tables(0).Rows.Count > 0 Then

            For Each alerta In alertaDS.Tables(0).Rows
                If Not estadoPrograma Then
                    procesandoEscalamientos = False
                    escalamiento.Enabled = True
                    Exit Sub
                End If
                Application.DoEvents()
                Dim repeticiones As Integer = alerta!es2
                If alerta!estado > 2 Then
                    repeticiones = repeticiones + 1
                End If

                Dim segundos = 0
                Dim activarEscalada As Boolean = False
                Dim uID = alerta!id
                'Se verifica que no se haya repetido antes
                If alerta!escalada2.Equals(System.DBNull.Value) Then
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada1, "yyyy/MM/dd HH:mm:ss")), Now)
                Else
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada2, "yyyy/MM/dd HH:mm:ss")), Now)
                End If
                Dim tiempoCad = ""
                If segundos >= alerta!tiempo2 Then
                    agregarSolo("Generando escalamientos...")
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!activada, "yyyy/MM/dd HH:mm:ss")), Now)
                    tiempoCad = calcularTiempoCad(segundos)

                    'Se generan los mensajes a enviar
                    'Se busca una copia del mensaje anterior

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal <> 4 LIMIT 1"
                    Dim EMensaje As String
                    Dim miMensaje As DataSet = consultaSEL(cadSQL)
                    Dim prioridad = "0"
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        prioridad = ValNull(miMensaje.Tables(0).Rows(0)!prioridad, "A")
                        EMensaje = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E2 " & tiempoCad
                    End If
                    EMensaje = EMensaje & IIf(alerta!estado > 2, " *R" & repeticiones, "")

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " And tipo = 0 And canal = 4 LIMIT 1"
                    Dim EMensajeMMCall As String = "MENSAJE ESCALADO *E2 " & tiempoCad
                    miMensaje = consultaSEL(cadSQL)
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        EMensajeMMCall = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E2 " & tiempoCad
                    Else
                        EMensajeMMCall = EMensaje
                    End If
                    EMensajeMMCall = EMensajeMMCall & IIf(alerta!estado > 2, " *R" & repeticiones, "")
                    EMensajeMMCall = Microsoft.VisualBasic.Strings.Left(EMensajeMMCall, 40)
                    If EMensaje.Length = 0 Then EMensaje = EMensajeMMCall

                    If ValNull(alerta!escalar2, "A") = "T" And alerta!estado = 2 Then
                        'Se valida si se repite el mesaje para el nivel anterior
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 12, canal, prioridad, destino, '" & EMensaje & "' FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo <= 1 and canal <> 4;INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 12, canal, prioridad, destino, '" & EMensajeMMCall & "' FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo <= 1 and canal = 4")
                    End If


                    If ValNull(alerta!llamada2, "A") = "S" Then agregarMensaje("telefonos", alerta!lista2, uID, 2, 1, prioridad, EMensaje)
                    If ValNull(alerta!sms2, "A") = "S" Then agregarMensaje("telefonos", alerta!lista2, uID, 2, 2, prioridad, EMensaje)
                    If ValNull(alerta!correo2, "A") = "S" Then agregarMensaje("correos", alerta!lista2, uID, 2, 3, prioridad, EMensaje)
                    If ValNull(alerta!mmcall2, "A") = "S" Then agregarMensaje("mmcall", alerta!lista2, uID, 2, 4, prioridad, EMensajeMMCall)
                    Dim cadAdic = ""

                    If alerta!estado > 2 Then
                        agregarLOG("Se crea una repetición " & repeticiones & " del escalamiento de NIVEL 2 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    Else
                        cadAdic = ", estado = 3"

                        agregarLOG("Se crea escalamiento de NIVEL 2 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    End If
                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET escalamientos = 2, escalada2 = '" & Format(Now, "yyyy/MM/dd HH:mm:ss") & "', es2 = " & repeticiones & cadAdic & " WHERE id = " & alerta!id)
                End If
            Next
        End If

        'Escalada 1
        cadSQL = "Select sigma.vw_reportes.*, sigma.vw_alertas.nombre FROM sigma.vw_reportes LEFT JOIN sigma.vw_alertas On vw_reportes.alerta = vw_alertas.id WHERE vw_reportes.escalar1 <> 'N' AND ((vw_reportes.estado = 1) OR (vw_reportes.estado >= 1 AND vw_reportes.estado < 9 AND vw_reportes.repetir1 = 'S'))"
        alertaDS = consultaSEL(cadSQL)
        If alertaDS.Tables(0).Rows.Count > 0 Then
            For Each alerta In alertaDS.Tables(0).Rows
                If Not estadoPrograma Then
                    procesandoEscalamientos = False
                    escalamiento.Enabled = True
                    Exit Sub
                End If
                Application.DoEvents()
                Dim repeticiones As Integer = alerta!es1
                If alerta!estado > 1 Then
                    repeticiones = repeticiones + 1
                End If
                Dim segundos = 0
                Dim activarEscalada As Boolean = False
                Dim uID = alerta!id
                'Se verifica que no se haya repetido antes
                If alerta!escalada1.Equals(System.DBNull.Value) Then
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!activada, "yyyy/MM/dd HH:mm:ss")), Now)
                Else
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!escalada1, "yyyy/MM/dd HH:mm:ss")), Now)
                End If
                Dim tiempoCad = ""
                If segundos >= alerta!tiempo1 Then
                    agregarSolo("Generando escalamientos...")
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!activada, "yyyy/MM/dd HH:mm:ss")), Now)
                    tiempoCad = calcularTiempoCad(segundos)
                    Dim tiempoCad2 = calcularTiempo(segundos)

                    'Se generan los mensajes a enviar
                    'Se busca una copia del mensaje anterior

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal <> 4 LIMIT 1"
                    Dim EMensaje As String
                    Dim miMensaje As DataSet = consultaSEL(cadSQL)
                    Dim prioridad = "0"
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        prioridad = ValNull(miMensaje.Tables(0).Rows(0)!prioridad, "A")
                        EMensaje = "PRIMER ESCALAMIENTO en " & tiempoCad & vbCrLf & ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A")
                    End If
                    EMensaje = EMensaje & IIf(alerta!estado > 1, " *R" & repeticiones, "")

                    cadSQL = "Select * FROM sigma.mensajes WHERE alerta = " & alerta!id & " And tipo = 0 And canal = 4 LIMIT 1"
                    Dim EMensajeMMCall As String = "MENSAJE ESCALADO *E1 " & tiempoCad
                    miMensaje = consultaSEL(cadSQL)
                    If miMensaje.Tables(0).Rows.Count > 0 Then

                        EMensajeMMCall = ValNull(miMensaje.Tables(0).Rows(0)!mensaje, "A") & " *E1 " & tiempoCad2
                    Else
                        EMensajeMMCall = EMensaje
                    End If
                    EMensajeMMCall = EMensajeMMCall & IIf(alerta!estado > 1, " *R" & repeticiones, "")
                    EMensajeMMCall = Microsoft.VisualBasic.Strings.Left(EMensajeMMCall, 40)
                    If EMensaje.Length = 0 Then EMensaje = EMensajeMMCall


                    If ValNull(alerta!escalar1, "A") = "T" And alerta!estado = 1 Then
                        'Se valida si se repite el mesaje para el nivel anterior
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) Select alerta, lista, 11, canal, prioridad, destino, CONCAT(mensaje, ' *E1 " & tiempoCad & "') FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0")
                    End If


                    If ValNull(alerta!llamada1, "A") = "S" Then agregarMensaje("telefonos", alerta!lista1, uID, 1, 1, prioridad, EMensaje)
                    If ValNull(alerta!sms1, "A") = "S" Then agregarMensaje("telefonos", alerta!lista1, uID, 1, 2, prioridad, EMensaje)
                    If ValNull(alerta!correo1, "A") = "S" Then agregarMensaje("correos", alerta!lista1, uID, 1, 3, prioridad, EMensaje)
                    If ValNull(alerta!mmcall1, "A") = "S" Then agregarMensaje("mmcall", alerta!lista1, uID, 1, 4, prioridad, EMensajeMMCall)
                    Dim cadAdic = ""
                    If alerta!estado > 1 Then
                        agregarLOG("Se crea una repetición " & repeticiones & " del escalamiento de NIVEL 1 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    Else
                        cadAdic = ", estado = 2"
                        agregarLOG("Se crea escalamiento de NIVEL 1 en el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, alerta!id, 10)
                    End If
                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET escalamientos = 1, escalada1 = '" & Format(Now, "yyyy/MM/dd HH:mm:ss") & "', es1 = " & repeticiones & cadAdic & " WHERE id = " & alerta!id)
                End If
            Next
        End If

        regsAfectados = 0
        cadSQL = "SELECT sigma.vw_reportes.*, sigma.vw_alertas.nombre FROM sigma.vw_reportes LEFT JOIN sigma.vw_alertas ON vw_reportes.alerta = vw_alertas.id WHERE ((vw_reportes.estado = 1 AND vw_reportes.repetir = 'S') OR (vw_reportes.estado >= 1 AND vw_reportes.estado < 9 AND vw_reportes.repetir = 'T'))  AND vw_reportes.repetir_tiempo > 0"
        alertaDS = consultaSEL(cadSQL)
        If alertaDS.Tables(0).Rows.Count > 0 Then

            Dim segundos = 0
            For Each alerta In alertaDS.Tables(0).Rows
                If Not estadoPrograma Then
                    procesandoEscalamientos = False
                    escalamiento.Enabled = True
                    Exit Sub
                End If

                Application.DoEvents()
                Dim repeticiones As Integer = alerta!repeticiones + 1
                'Se verifica que no se haya repetido antes
                If alerta!repetida.Equals(System.DBNull.Value) Then
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!activada, "yyyy/MM/dd HH:mm:ss")), Now)
                Else
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!repetida, "yyyy/MM/dd HH:mm:ss")), Now)
                End If
                If segundos >= alerta!repetir_tiempo Then
                    'Se generan los mensajes a enviar
                    'Se busca una copia del mensaje anterior
                    agregarSolo("Generando repeticiones...")
                    segundos = DateDiff(DateInterval.Second, CDate(Format(alerta!activada, "yyyy/MM/dd HH:mm:ss")), Now)
                    Dim tiempoCad = calcularTiempoCad(segundos)
                    If ValNull(alerta!llamada, "A") = "S" Then
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 9, canal, prioridad, destino, CONCAT(mensaje, ' *R" & repeticiones & " " & tiempoCad & "') FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal = 1")
                    End If
                    If ValNull(alerta!sms, "A") = "S" Then
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 9, canal, prioridad, destino, CONCAT(mensaje, ' *R" & repeticiones & " " & tiempoCad & "') FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal = 2")
                    End If
                    If ValNull(alerta!correo, "A") = "S" Then
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 9, canal, prioridad, destino, CONCAT('REPETICION " & repeticiones & " tiempo transcurrido: " & tiempoCad & vbCrLf & "', mensaje) FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal = 3")
                    End If
                    If ValNull(alerta!mmcall, "A") = "S" Then
                        regsAfectados = consultaACT("INSERT INTO sigma.mensajes (alerta, lista, tipo, canal, prioridad, destino, mensaje) SELECT alerta, lista, 9, canal, prioridad, destino, CONCAT(mensaje, ' *R" & repeticiones & " " & tiempoCad & "') FROM sigma.mensajes WHERE alerta = " & alerta!id & " AND tipo = 0 AND canal = 4")
                    End If
                    agregarLOG("Se envía repetición " & repeticiones & " de alerta para el reporte: " & alerta!id & "-" & alerta!nombre & " a " & tiempoCad, 1, 1, 10)

                    regsAfectados = consultaACT("UPDATE sigma.vw_reportes SET repetida = '" & Format(Now, "yyyy/MM/dd HH:mm:ss") & "', repeticiones = repeticiones + 1 WHERE id = " & alerta!id)
                End If
            Next
        End If

        escalamiento.Enabled = True
        procesandoEscalamientos = False
        BarManager1.Items(1).Caption = "Conectado (cada " & eSegundos & " segundos)"
    End Sub

    Private Sub SerialPort1_DataReceived(sender As Object, e As SerialDataReceivedEventArgs) Handles SerialPort1.DataReceived
        MensajeLlamada = SerialPort1.ReadLine
    End Sub

    Private Sub NotifyIcon1_MouseDoubleClick(sender As Object, e As MouseEventArgs) Handles NotifyIcon1.MouseDoubleClick
        Try
            Me.Visible = True
            NotifyIcon1.Visible = False
            Me.WindowState = FormWindowState.Maximized
        Catch ex As Exception

        End Try

    End Sub

    Private Sub ContextMenuStrip1_Opening(sender As Object, e As System.ComponentModel.CancelEventArgs) Handles ContextMenuStrip1.Opening

    End Sub

    Private Sub XtraForm1_Shown(sender As Object, e As EventArgs) Handles Me.Shown
        Me.Visible = False
        NotifyIcon1.Visible = True
    End Sub

    Private Sub VerElLogToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles VerElLogToolStripMenuItem.Click
        Try
            Me.Visible = True
            NotifyIcon1.Visible = False
            Me.WindowState = FormWindowState.Maximized
        Catch ex As Exception

        End Try
    End Sub

    Private Sub ReanudarElMonitorToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles ReanudarElMonitorToolStripMenuItem.Click
        If XtraMessageBox.Show("Esta acción reanudará el envío de alertas. ¿Desea reanudar el monitoreo de las fallas?", "Reanudar la aplicación", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) <> DialogResult.No Then
            Estado = 1
            SimpleButton3.Visible = True
            SimpleButton2.Visible = False
            ContextMenuStrip1.Items(1).Enabled = True
            ContextMenuStrip1.Items(2).Enabled = False
            estadoPrograma = True
            agregarLOG("La interfaz ha sido reanudada por un usuario", 9, 0)
        End If
    End Sub

    Private Sub ToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItem1.Click
        If XtraMessageBox.Show("Esta acción detendrá el envío de alertas. ¿Desea detener el monitor de las fallas?", "Detener la aplicación", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) <> DialogResult.No Then
            Estado = 1
            SimpleButton3.Visible = False
            SimpleButton2.Visible = True
            ContextMenuStrip1.Items(1).Enabled = False
            ContextMenuStrip1.Items(2).Enabled = True
            estadoPrograma = False
            agregarLOG("La interfaz ha sido detenida por un usuario", 9, 0)
        End If
    End Sub

    Private Sub XtraForm1_Resize(sender As Object, e As EventArgs) Handles Me.Resize
        Dim f As Form
        f = sender

        'Check if the form is minimized
        If f.WindowState = FormWindowState.Minimized Then
            Me.Visible = False
            NotifyIcon1.Visible = True
        End If

    End Sub

    'Sub smtpClient_SendCompleted(sender As Object, e As System.ComponentModel.AsyncCompletedEventArgs)
    '  Dim mail As MailMessage = e.UserState
    '  If Not e.Cancelled Then
    '  Dim emonteo = 1
    '  End If
    '  End Sub

    Function traducirMensaje(mensaje As String) As String
        traducirMensaje = mensaje
        Dim cadCanales As String = ValNull(mensaje, "A")
        If cadCanales.Length > 0 Then
            traducirMensaje = ""
            Dim arreCanales = cadCanales.Split(New Char() {" "c})
            For i = LBound(arreCanales) To UBound(arreCanales)
                'Redimensionamos el Array temporal y preservamos el valor  
                Dim cadSQL As String = "SELECT traduccion FROM sigma.traduccion WHERE literal = '" & arreCanales(i) & "'"
                Dim reader As DataSet = consultaSEL(cadSQL)
                If reader.Tables(0).Rows.Count > 0 Then
                    traducirMensaje = traducirMensaje & " " & ValNull(reader.Tables(0).Rows(0)!traduccion, "A")
                Else
                    traducirMensaje = traducirMensaje & " " & arreCanales(i)
                End If
            Next
        End If


    End Function

    Private Sub XtraForm1_Closing(sender As Object, e As CancelEventArgs) Handles Me.Closing
        autenticado = False
        Dim Forma As New XtraForm2
        Forma.Text = "Detener aplicación"
        Forma.ShowDialog()
        If autenticado Then
            If XtraMessageBox.Show("Esta acción CERRARÁ la aplicación para el envío de alertas. ¿Desea CERRAR el monitor de las fallas?", "Detener la aplicación", MessageBoxButtons.YesNo, MessageBoxIcon.Stop) <> DialogResult.No Then
                agregarLOG("La aplicación se cerró el usuario: " & usuarioCerrar, 9, 0)
            Else
                e.Cancel = True
            End If
        Else
            e.Cancel = True
        End If
    End Sub

    Private Sub correos_Tick(sender As Object, e As EventArgs) Handles correos.Tick
        'Se envía correo
        If procesandoCorreos Or Not estadoPrograma Then Exit Sub
        If Format(Now, "mm") >= "05" Then Exit Sub
        correos.Enabled = False
        procesandoCorreos = True
        enviarCorreos()
        procesandoCorreos = False
        correos.Enabled = True
    End Sub

    Private Sub mensajes_Tick(sender As Object, e As EventArgs) Handles mensajes.Tick
        If procesandoMensajes Or Not estadoPrograma Then Exit Sub
        mensajes.Enabled = False
        procesandoMensajes = True
        procesarMensajes()
        procesandoMensajes = False
        mensajes.Enabled = True
    End Sub
    Sub agregarSolo(cadena As String)
        ListBoxControl1.Items.Insert(0, "MONITOR: " & Format(Now, "dd-MMM HH:mm:ss") & ": " & cadena)
        ContarLOG()
    End Sub

    Sub enviarCorreos()
        Try
            agregarSolo("Se inicia la aplicación de Envío de reportes por correo")
            'elvis Shell(Application.StartupPath & "\vwReportes.exe", AppWinStyle.MinimizedNoFocus)
        Catch ex As Exception
            agregarLOG("Error en la ejecución de la aplicación de envío de correos. Error: " & ex.Message, 7, 0)
        End Try

    End Sub

    Sub depurar()
        'Se depura la BD
        Dim cadSQL As String = "SELECT gestion_meses, gestion_log FROM sigma.configuracion WHERE gestion_meses > 0 AND (ISNULL(gestion_log) OR gestion_log < '" & Format(Now(), "yyyyMM") & "')"
        Dim reader As DataSet = consultaSEL(cadSQL)
        Dim regsAfectados = 0
        Dim eliminados = 0
        If reader.Tables(0).Rows.Count > 0 Then
            Dim mesesAtras = reader.Tables(0).Rows(0)!gestion_meses
            regsAfectados = consultaACT("DELETE FROM sigma.vw_reportes WHERE atendida < '" & Format(DateAndTime.DateAdd(DateInterval.Month, mesesAtras * -1, Now()), "yyyy/MM") & "/01 00:00:00' AND estado = 9")
            eliminados = eliminados + regsAfectados
            regsAfectados = consultaACT("DELETE FROM sigma.lotes WHERE finaliza < '" & Format(DateAndTime.DateAdd(DateInterval.Month, mesesAtras * -1, Now()), "yyyy/MM") & "/01 00:00:00' AND estado = 99")
            eliminados = eliminados + regsAfectados
            regsAfectados = consultaACT("DELETE FROM sigma.lotes_historia WHERE lote NOT IN (SELECT id FROM sigma.lotes)")
            eliminados = eliminados + regsAfectados
            regsAfectados = consultaACT("DELETE FROM sigma.alarmas WHERE fin < '" & Format(DateAndTime.DateAdd(DateInterval.Month, mesesAtras * -1, Now()), "yyyy/MM") & "/01 00:00:00'")
            eliminados = eliminados + regsAfectados
            regsAfectados = consultaACT("DELETE FROM sigma.log WHERE fecha < '" & Format(DateAndTime.DateAdd(DateInterval.Month, mesesAtras * -1, Now()), "yyyy/MM") & "/01 00:00:00'")
            eliminados = eliminados + regsAfectados
            regsAfectados = consultaACT("DELETE FROM sigma.vw_control WHERE fecha < '" & Format(DateAndTime.DateAdd(DateInterval.Month,
mesesAtras * -1, Now()), "yyyyMM") & "0100'")
            regsAfectados = consultaACT("DELETE FROM sigma.prioridades WHERE fecha < '" & Format(DateAndTime.DateAdd(DateInterval.Month,
mesesAtras * -1, Now()), "yyyyMM") & "0100'")
            regsAfectados = consultaACT("DELETE FROM sigma.programacion WHERE carga NOT IN (SELECT id FROM sigma.cargas)")
            eliminados = eliminados + regsAfectados
            agregarLOG("Se ejecutó la depuración de la base de datos para el período " & Format(Now(), "MMMM-yyyy") & " (todo lo anterior al día: " & Format(DateAndTime.DateAdd(DateInterval.Month, mesesAtras * -1, Now()), "yyyy/MM") & "/01). Se eliminaron permanentemente " & eliminados & " registro(s)", 7, 0)
            regsAfectados = consultaACT("UPDATE sigma.configuracion SET gestion_log = '" & Format(Now(), "yyyyMM") & "'")

        End If

    End Sub

End Class

