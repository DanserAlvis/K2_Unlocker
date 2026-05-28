# ============================================================
#  WINDOWS 11 HIDDEN FEATURES & LOW LATENCY UNLOCKER PRO
#  Gestor Avanzado de ViveTool con Verificacion de Entorno
# ============================================================

#region AUTO-ELEVACION DE PRIVILEGIOS (DOBLE COMPROBACION)
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    $ScriptPath = $null
    if ($PSCommandPath) { $ScriptPath = $PSCommandPath }
    elseif ($MyInvocation.MyCommand.Path) { $ScriptPath = $MyInvocation.MyCommand.Path }

    if ($ScriptPath) {
        $a = "-NoProfile -STA -ExecutionPolicy Bypass -File `"$ScriptPath`""
        Start-Process powershell.exe -ArgumentList $a -Verb RunAs
        exit
    } else {
        Write-Warning "ERROR: No se pudo detectar la ruta. Guarda este archivo como .ps1 y ejecutalo con clic derecho -> 'Ejecutar con PowerShell'."
        Start-Sleep -Seconds 5
        exit
    }
}
#endregion

#region ENSAMBLADOS WPF
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
#endregion

#region VARIABLES GLOBALES Y GRUPOS DE IDs
$ViveToolDir = "C:\ViveTool"
$ViveToolExe = "$ViveToolDir\vivetool.exe"

# Grupos de Funciones de Windows 11
$Grp0_IDs = "60716524,61391826"                               # Proyecto K2: Perfil de Baja Latencia Core
$Grp1_IDs = "47205210,49221331,49402389,48433719,49381526,49820095,55495322" # Menu Inicio Redisenado por Categorias
$Grp2_IDs = "57048216,49453572"                               # Nuevo Explorador de Archivos Moderno
$Grp3_IDs = "52580392,50902630"                               # Modo XBOX Full Screen Experience
#endregion

#region INTERFAZ GRAFICA (XAML)
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Windows 11 Features &amp; Low Latency Unlocker Pro" Height="820" Width="850" 
        WindowStartupLocation="CenterScreen" Background="#0D1117" 
        FontFamily="Segoe UI" ResizeMode="NoResize">
    
    <Window.Resources>
        <Style TargetType="Border" x:Key="CardStyle">
            <Setter Property="Background" Value="#161B22"/>
            <Setter Property="BorderThickness" Value="3,1,1,1"/>
            <Setter Property="CornerRadius" Value="0,4,4,0"/>
            <Setter Property="Margin" Value="0,0,0,10"/>
            <Setter Property="Padding" Value="15"/>
        </Style>

        <Style TargetType="Button" x:Key="ModernButton">
            <Setter Property="Background" Value="#1F6FEB"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Padding" Value="10,6"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="4">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="65"/> 
            <RowDefinition Height="*"/>  
            <RowDefinition Height="140"/> 
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#161B22" BorderBrush="#21262D" BorderThickness="0,0,0,1">
            <Grid Margin="20,0">
                <StackPanel Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock Text="W11 Features &amp; Low Latency Unlocker" Foreground="#E6EDF3" FontSize="18" FontWeight="Bold"/>
                    <TextBlock Text="PRO EDITION" Foreground="#58A6FF" FontSize="11" Margin="8,0,0,6" VerticalAlignment="Bottom" FontWeight="Bold"/>
                </StackPanel>
            </Grid>
        </Border>

        <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto" Margin="20,15">
            <StackPanel>
                
                <Border Background="#2A1414" BorderBrush="#DA3633" BorderThickness="1,1,1,3" CornerRadius="4" Padding="12" Margin="0,0,0,15">
                    <StackPanel>
                        <TextBlock Text="ADVERTENCIA DE RIESGO Y EFECTOS SECUNDARIOS" Foreground="#DA3633" FontWeight="Bold" FontSize="11" Margin="0,0,0,4"/>
                        <TextBlock Text="El Modo de Baja Latencia (Proyecto K2) elimina los tiempos de rampa progresiva de frecuencias del procesador, forzando picos maximos instantaneos al abrir menus o apps. Esto incrementa la temperatura de los nucleos del CPU, aumentara el ruido/revolucion de los ventiladores y mermara de manera severa la autonomia de la bateria en equipos portatiles. Use con discrecion." Foreground="#F0AAAA" FontSize="11" TextWrapping="Wrap"/>
                    </StackPanel>
                </Border>

                <TextBlock Text="COMPATIBILIDAD DEL SISTEMA Y HARDWARE" Foreground="#8B949E" FontSize="11" FontWeight="Bold" Margin="0,0,0,8"/>
                <Border Style="{StaticResource CardStyle}" BorderBrush="#58A6FF" Padding="12" Margin="0,0,0,15">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0" Margin="0,0,10,0">
                            <TextBlock x:Name="TxtCompat" Text="Verificando compatibilidad de OS..." Foreground="#E3B341" FontWeight="Bold" FontSize="12" Margin="0,0,0,4"/>
                            <TextBlock x:Name="TxtBuild" Text="Build: ..." Foreground="#8B949E" FontSize="11"/>
                        </StackPanel>
                        <StackPanel Grid.Column="1">
                            <TextBlock x:Name="TxtHardware" Text="Verificando tipo de chasis..." Foreground="#E3B341" FontWeight="Bold" FontSize="12" Margin="0,0,0,4"/>
                            <TextBlock x:Name="TxtCpu" Text="CPU: ..." Foreground="#8B949E" FontSize="11" TextWrapping="NoWrap"/>
                        </StackPanel>
                    </Grid>
                </Border>

                <TextBlock Text="PREPARACION DEL ENTORNO" Foreground="#8B949E" FontSize="11" FontWeight="Bold" Margin="0,0,0,8"/>
                <Border Style="{StaticResource CardStyle}" BorderBrush="#1F6FEB">
                    <Grid>
                        <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="Auto"/><ColumnDefinition Width="110"/></Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <TextBlock Text="Motor ViveTool" Foreground="#E6EDF3" FontWeight="Bold" FontSize="13"/>
                            <TextBlock Text="Binario indispensable para interactuar de forma nativa con los feature IDs ocultos." Foreground="#8B949E" FontSize="11" TextWrapping="Wrap" Margin="0,2,0,0"/>
                        </StackPanel>
                        <TextBlock x:Name="StatVive" Grid.Column="1" Text="PENDIENTE" Foreground="#8B949E" FontWeight="Bold" FontSize="11" VerticalAlignment="Center" Margin="0,0,15,0"/>
                        <Button x:Name="BtnVive" Grid.Column="2" Content="INSTALAR" Style="{StaticResource ModernButton}"/>
                    </Grid>
                </Border>

                <Border Style="{StaticResource CardStyle}" BorderBrush="#E3B341">
                    <Grid>
                        <Grid.ColumnDefinitions><ColumnDefinition Width="*"/><ColumnDefinition Width="Auto"/><ColumnDefinition Width="110"/></Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0">
                            <TextBlock Text="Punto de Restauracion del Sistema" Foreground="#E6EDF3" FontWeight="Bold" FontSize="13"/>
                            <TextBlock Text="Altamente recomendado. Crea un respaldo del registro por seguridad antes de aplicar cambios." Foreground="#8B949E" FontSize="11" TextWrapping="Wrap" Margin="0,2,0,0"/>
                        </StackPanel>
                        <TextBlock x:Name="StatRestore" Grid.Column="1" Text="OPCIONAL" Foreground="#8B949E" FontWeight="Bold" FontSize="11" VerticalAlignment="Center" Margin="0,0,15,0"/>
                        <Button x:Name="BtnRestore" Grid.Column="2" Content="CREAR" Style="{StaticResource ModernButton}"/>
                    </Grid>
                </Border>

                <TextBlock Text="SELECTOR INDEPENDIENTE DE FUNCIONES" Foreground="#8B949E" FontSize="11" FontWeight="Bold" Margin="0,15,0,8"/>
                
                <Border Style="{StaticResource CardStyle}" BorderBrush="#FF7B72">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="95"/>
                            <ColumnDefinition Width="85"/>
                            <ColumnDefinition Width="105"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0" Margin="0,0,10,0">
                            <TextBlock Text="Modo de Baja Latencia (Proyecto K2 Core)" Foreground="#E6EDF3" FontWeight="Bold" FontSize="13"/>
                            <TextBlock Text="Elimina retrasos en el kernel y acelera el lanzamiento/respuesta de apps." Foreground="#8B949E" FontSize="11" TextWrapping="Wrap" Margin="0,2,0,0"/>
                        </StackPanel>
                        <TextBlock x:Name="StatF0" Grid.Column="1" Text="LEYENDO..." Foreground="#8B949E" FontWeight="Bold" FontSize="11" VerticalAlignment="Center" HorizontalAlignment="Center"/>
                        <Button x:Name="BtnEn0" Grid.Column="2" Content="ACTIVAR" Style="{StaticResource ModernButton}" Margin="5,0"/>
                        <Button x:Name="BtnDis0" Grid.Column="3" Content="DESACTIVAR" Style="{StaticResource ModernButton}" Background="#DA3633"/>
                    </Grid>
                </Border>

                <Border Style="{StaticResource CardStyle}" BorderBrush="#238636">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="95"/>
                            <ColumnDefinition Width="85"/>
                            <ColumnDefinition Width="105"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0" Margin="0,0,10,0">
                            <TextBlock Text="1. Nuevo Menu de Inicio y Phone Link" Foreground="#E6EDF3" FontWeight="Bold" FontSize="13"/>
                            <TextBlock Text="Activa la organizacion nativa por categorias y barra lateral inteligente." Foreground="#8B949E" FontSize="11" TextWrapping="Wrap" Margin="0,2,0,0"/>
                        </StackPanel>
                        <TextBlock x:Name="StatF1" Grid.Column="1" Text="LEYENDO..." Foreground="#8B949E" FontWeight="Bold" FontSize="11" VerticalAlignment="Center" HorizontalAlignment="Center"/>
                        <Button x:Name="BtnEn1" Grid.Column="2" Content="ACTIVAR" Style="{StaticResource ModernButton}" Margin="5,0"/>
                        <Button x:Name="BtnDis1" Grid.Column="3" Content="DESACTIVAR" Style="{StaticResource ModernButton}" Background="#DA3633"/>
                    </Grid>
                </Border>

                <Border Style="{StaticResource CardStyle}" BorderBrush="#238636">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="95"/>
                            <ColumnDefinition Width="85"/>
                            <ColumnDefinition Width="105"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0" Margin="0,0,10,0">
                            <TextBlock Text="2. Modernizacion de Explorador" Foreground="#E6EDF3" FontWeight="Bold" FontSize="13"/>
                            <TextBlock Text="Habilita la nueva interfaz XAML optimizada de archivos." Foreground="#8B949E" FontSize="11" TextWrapping="Wrap" Margin="0,2,0,0"/>
                        </StackPanel>
                        <TextBlock x:Name="StatF2" Grid.Column="1" Text="LEYENDO..." Foreground="#8B949E" FontWeight="Bold" FontSize="11" VerticalAlignment="Center" HorizontalAlignment="Center"/>
                        <Button x:Name="BtnEn2" Grid.Column="2" Content="ACTIVAR" Style="{StaticResource ModernButton}" Margin="5,0"/>
                        <Button x:Name="BtnDis2" Grid.Column="3" Content="DESACTIVAR" Style="{StaticResource ModernButton}" Background="#DA3633"/>
                    </Grid>
                </Border>

                <Border Style="{StaticResource CardStyle}" BorderBrush="#238636">
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="95"/>
                            <ColumnDefinition Width="85"/>
                            <ColumnDefinition Width="105"/>
                        </Grid.ColumnDefinitions>
                        <StackPanel Grid.Column="0" Margin="0,0,10,0">
                            <TextBlock Text="3. Modo XBOX (Full Screen Experience)" Foreground="#E6EDF3" FontWeight="Bold" FontSize="13"/>
                            <TextBlock Text="Habilita entorno envolvente tipo consola para gamepads o ROG Ally." Foreground="#8B949E" FontSize="11" TextWrapping="Wrap" Margin="0,2,0,0"/>
                        </StackPanel>
                        <TextBlock x:Name="StatF3" Grid.Column="1" Text="LEYENDO..." Foreground="#8B949E" FontWeight="Bold" FontSize="11" VerticalAlignment="Center" HorizontalAlignment="Center"/>
                        <Button x:Name="BtnEn3" Grid.Column="2" Content="ACTIVAR" Style="{StaticResource ModernButton}" Margin="5,0"/>
                        <Button x:Name="BtnDis3" Grid.Column="3" Content="DESACTIVAR" Style="{StaticResource ModernButton}" Background="#DA3633"/>
                    </Grid>
                </Border>

            </StackPanel>
        </ScrollViewer>

        <Border Grid.Row="2" Background="#010409" BorderBrush="#21262D" BorderThickness="0,1,0,0">
            <Grid>
                <Grid.RowDefinitions>
                    <RowDefinition Height="25"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>
                <TextBlock Text="REGISTRO DE PROCESOS EN VIVO" Foreground="#8B949E" FontSize="10" FontWeight="Bold" Margin="20,8,0,0"/>
                <TextBox x:Name="ConsoleOutput" Grid.Row="1" Background="Transparent" Foreground="#8B949E" BorderThickness="0" 
                         FontFamily="Consolas" IsReadOnly="True" TextWrapping="Wrap" VerticalScrollBarVisibility="Auto" Margin="15,5,15,10" FontSize="11"/>
            </Grid>
        </Border>
    </Grid>
</Window>
"@
#endregion

#region INICIALIZACION Y MAPEADO
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try { $Window = [Windows.Markup.XamlReader]::Load($reader) } catch { Write-Warning "Error fatal cargando XAML"; exit }

$ConsoleOutput = $Window.FindName("ConsoleOutput")
$BtnVive       = $Window.FindName("BtnVive")
$StatVive      = $Window.FindName("StatVive")
$BtnRestore    = $Window.FindName("BtnRestore")
$StatRestore   = $Window.FindName("StatRestore")

$TxtCompat     = $Window.FindName("TxtCompat")
$TxtBuild      = $Window.FindName("TxtBuild")
$TxtHardware   = $Window.FindName("TxtHardware")
$TxtCpu        = $Window.FindName("TxtCpu")

$StatF0 = $Window.FindName("StatF0"); $BtnEn0 = $Window.FindName("BtnEn0"); $BtnDis0 = $Window.FindName("BtnDis0")
$StatF1 = $Window.FindName("StatF1"); $BtnEn1 = $Window.FindName("BtnEn1"); $BtnDis1 = $Window.FindName("BtnDis1")
$StatF2 = $Window.FindName("StatF2"); $BtnEn2 = $Window.FindName("BtnEn2"); $BtnDis2 = $Window.FindName("BtnDis2")
$StatF3 = $Window.FindName("StatF3"); $BtnEn3 = $Window.FindName("BtnEn3"); $BtnDis3 = $Window.FindName("BtnDis3")
#endregion

#region LOGICA Y FUNCIONES CORE
function Do-WpfEvents {
    $frame = New-Object System.Windows.Threading.DispatcherFrame
    [System.Windows.Threading.Dispatcher]::CurrentDispatcher.BeginInvoke(
        [System.Windows.Threading.DispatcherPriority]::Background,
        [Action]{ $frame.Continue = $false }
    ) | Out-Null
    [System.Windows.Threading.Dispatcher]::PushFrame($frame)
}

function Write-Log {
    param([string]$Msg, [string]$Lvl = "INFO")
    $timestamp = Get-Date -Format "HH:mm:ss"
    $ConsoleOutput.AppendText("$timestamp [$Lvl] $Msg`n")
    $ConsoleOutput.ScrollToEnd()
    Do-WpfEvents
}

function Set-UIStatus {
    param($Label, $Button, $Text, $ColorHex, $BtnText, $BtnEnabled)
    $Label.Text = $Text
    $Label.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString($ColorHex)))
    $Button.Content = $BtnText
    $Button.IsEnabled = $BtnEnabled
    Do-WpfEvents
}

function Get-FeatureState {
    param($Id)
    if (-not (Test-Path $ViveToolExe)) { return "DESCONOCIDO" }
    
    $out = & $ViveToolExe /query /id:$Id 2>&1 | Out-String
    if ($out -match "Enabled") { return "ACTIVADO" }
    if ($out -match "Disabled") { return "DESACTIVADO" }
    return "DEFECTO"
}

function Set-UIStateText {
    param($Label, $State)
    $Label.Text = $State
    if ($State -eq "ACTIVADO") { $Label.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#238636"))) }
    elseif ($State -eq "DESACTIVADO") { $Label.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#DA3633"))) }
    else { $Label.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#E3B341"))) }
    Do-WpfEvents
}

function Update-FeatureStates {
    if (-not (Test-Path $ViveToolExe)) { return }
    Write-Log "Consultando registro de estados reales con ViveTool..." "INFO"
    
    Set-UIStateText $StatF0 (Get-FeatureState "60716524")
    Set-UIStateText $StatF1 (Get-FeatureState "47205210")
    Set-UIStateText $StatF2 (Get-FeatureState "57048216")
    Set-UIStateText $StatF3 (Get-FeatureState "52580392")
}

function Run-ViveToolCommand {
    param([string]$ArgsToRun, [string]$LogMsg)
    Write-Log $LogMsg "INFO"
    try {
        $process = Start-Process -FilePath $ViveToolExe -ArgumentList $ArgsToRun -NoNewWindow -Wait -PassThru
        if ($process.ExitCode -eq 0) {
            Write-Log "Estado inyectado correctamente. Se requiere reinicio del sistema." "OK"
        } else {
            Write-Log "ViveTool retorno codigo de error: $($process.ExitCode)" "ERR"
        }
    } catch {
        Write-Log "Fallo critico al llamar al ejecutable: $($_.Exception.Message)" "ERR"
    }
}

function Check-ViveTool {
    if (Test-Path $ViveToolExe) {
        Set-UIStatus $StatVive $BtnVive "INSTALADO" "#238636" "LISTO" $false
        Write-Log "Motor ViveTool verificado en su ruta ($ViveToolExe)." "OK"
        
        $BtnEn0.IsEnabled = $true; $BtnDis0.IsEnabled = $true
        $BtnEn1.IsEnabled = $true; $BtnDis1.IsEnabled = $true
        $BtnEn2.IsEnabled = $true; $BtnDis2.IsEnabled = $true
        $BtnEn3.IsEnabled = $true; $BtnDis3.IsEnabled = $true
        
        Update-FeatureStates
    } else {
        Set-UIStatus $StatVive $BtnVive "FALTANTE" "#DA3633" "DESCARGAR" $true
        Write-Log "No se encontro ViveTool. Por favor instale el motor central." "WARN"
        
        $BtnEn0.IsEnabled = $false; $BtnDis0.IsEnabled = $false
        $BtnEn1.IsEnabled = $false; $BtnDis1.IsEnabled = $false
        $BtnEn2.IsEnabled = $false; $BtnDis2.IsEnabled = $false
        $BtnEn3.IsEnabled = $false; $BtnDis3.IsEnabled = $false
        
        $StatF0.Text = "BLOQUEADO"; $StatF1.Text = "BLOQUEADO"; $StatF2.Text = "BLOQUEADO"; $StatF3.Text = "BLOQUEADO"
    }
}
#endregion

#region LOGICA DE COMPATIBILIDAD HARDWARE / BUILD
function Run-CompatibilityChecks {
    Write-Log "Ejecutando suite de analisis de compatibilidad..." "INFO"
    
    $buildStr = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild
    $TxtBuild.Text = "Build detectada: Windows 11 ($buildStr)"
    
    if ([int]$buildStr -lt 22000) {
        $TxtCompat.Text = "SISTEMA INCOMPATIBLE"
        $TxtCompat.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#DA3633")))
        Write-Log "CRITICO: Este optimizador requiere Windows 11 de base." "ERR"
    } elseif ([int]$buildStr -lt 26100) {
        $TxtCompat.Text = "COMPATIBILIDAD LIMITADA"
        $TxtCompat.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#E3B341")))
        Write-Log "ADVERTENCIA: Build inferior a 26100. K2 podria no ser reconocido en su totalidad." "WARN"
    } else {
        $TxtCompat.Text = "SISTEMA TOTALMENTE COMPATIBLE"
        $TxtCompat.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#238636")))
        Write-Log "OS verificado correctamente: Build $buildStr." "OK"
    }

    try {
        $cpuInfo = (Get-CimInstance -ClassName Win32_Processor).Name
        $TxtCpu.Text = "Procesador: $cpuInfo"
    } catch {
        $TxtCpu.Text = "Procesador: Desconocido"
    }
    
    $isLaptop = $false
    try {
        $battery = Get-CimInstance -ClassName Win32_Battery -ErrorAction SilentlyContinue
        if ($battery) { $isLaptop = $true }
    } catch { $isLaptop = $false }

    if ($isLaptop) {
        $TxtHardware.Text = "DETECTADO: EQUIPO PORTATIL (LAPTOP)"
        $TxtHardware.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#E3B341")))
        Write-Log "ADVERTENCIA EN HARDWARE: Al ser Laptop, el modo K2 aumentara temperatura y uso de bateria." "WARN"
    } else {
        $TxtHardware.Text = "DETECTADO: COMPUTADORA DE ESCRITORIO"
        $TxtHardware.Foreground = (New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.ColorConverter]::ConvertFromString("#238636")))
        Write-Log "Hardware verificado: Estacion fija con disipacion estable." "OK"
    }
}
#endregion

#region LOGICA DE ENTORNO (DESCARGA Y SNAPSHOT)
$BtnVive.Add_Click({
    Set-UIStatus $StatVive $BtnVive "DESCARGANDO..." "#E3B341" "ESPERE" $false
    try {
        Write-Log "Contactando API publica de GitHub para ViVeTool..." "INFO"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/thebookisclosed/ViVe/releases/latest"
        
        if ($env:PROCESSOR_ARCHITECTURE -match "ARM") {
            $asset = $release.assets | Where-Object { $_.name -match "Arm" -and $_.name -like "ViVeTool*.zip" } | Select-Object -First 1
        } else {
            $asset = $release.assets | Where-Object { ($_.name -match "IntelAmd" -or $_.name -notmatch "Arm") -and $_.name -like "ViVeTool*.zip" } | Select-Object -First 1
        }
        
        $zipUrl = $asset.browser_download_url
        $tempZip = "$env:TEMP\vivetool_latest.zip"
        
        Write-Log "Descargando empaquetado: $($asset.name)..." "INFO"
        Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip
        
        if (-not (Test-Path $ViveToolDir)) { New-Item -ItemType Directory -Path $ViveToolDir -Force | Out-Null }
        
        Write-Log "Descomprimiendo archivos en $ViveToolDir..." "INFO"
        Expand-Archive -Path $tempZip -DestinationPath $ViveToolDir -Force
        Remove-Item -Path $tempZip -Force
        
        Write-Log "ViveTool desplegado con exito." "OK"
        Check-ViveTool
    } catch {
        Write-Log "Fallo en descarga: $($_.Exception.Message)" "ERR"
        Set-UIStatus $StatVive $BtnVive "ERROR" "#DA3633" "REINTENTAR" $true
    }
})

$BtnRestore.Add_Click({
    Set-UIStatus $StatRestore $BtnRestore "PROCESANDO..." "#E3B341" "ESPERE" $false
    Write-Log "Iniciando snapshot VSS a traves de System Restore..." "INFO"
    try {
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        Checkpoint-Computer -Description "K2_Unlocker_Pro_Backup" -RestorePointType MODIFY_SETTINGS -ErrorAction Stop
        Write-Log "Punto de restauracion creado con exito." "OK"
        Set-UIStatus $StatRestore $BtnRestore "CREADO" "#238636" "LISTO" $false
    } catch {
        Write-Log "Fallo al instanciar punto de control: $($_.Exception.Message)" "ERR"
        Set-UIStatus $StatRestore $BtnRestore "ERROR" "#DA3633" "REINTENTAR" $true
    }
})
#endregion

#region LOGICA INTERACTIVA DE CLICS (BOTONES DE FEATURES)
$BtnEn0.Add_Click({ Run-ViveToolCommand "/enable /id:$Grp0_IDs" "Inyectando Perfil K2..."; Update-FeatureStates })
$BtnDis0.Add_Click({ Run-ViveToolCommand "/disable /id:$Grp0_IDs" "Removiendo Perfil K2..."; Update-FeatureStates })

$BtnEn1.Add_Click({ Run-ViveToolCommand "/enable /id:$Grp1_IDs" "Inyectando Nuevo Menu de Inicio..."; Update-FeatureStates })
$BtnDis1.Add_Click({ Run-ViveToolCommand "/disable /id:$Grp1_IDs" "Removiendo Nuevo Menu de Inicio..."; Update-FeatureStates })

$BtnEn2.Add_Click({ Run-ViveToolCommand "/enable /id:$Grp2_IDs" "Inyectando Explorador XAML..."; Update-FeatureStates })
$BtnDis2.Add_Click({ Run-ViveToolCommand "/disable /id:$Grp2_IDs" "Removiendo Explorador XAML..."; Update-FeatureStates })

$BtnEn3.Add_Click({ Run-ViveToolCommand "/enable /id:$Grp3_IDs" "Inyectando entorno Xbox..."; Update-FeatureStates })
$BtnDis3.Add_Click({ Run-ViveToolCommand "/disable /id:$Grp3_IDs" "Removiendo entorno Xbox..."; Update-FeatureStates })
#endregion

#region ENTRADA EN COLA / CARGA
$Window.Add_Loaded({
    Run-CompatibilityChecks
    Check-ViveTool
})

$Window.ShowDialog() | Out-Null
#endregion