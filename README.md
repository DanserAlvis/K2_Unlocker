<img width="831" height="819" alt="image" src="https://github.com/user-attachments/assets/d86d88b2-7b9e-4e32-9d92-ecd7bdac96eb" />

# 🚀 Windows 11 Features & Low Latency Unlocker PRO

Una herramienta avanzada basada en PowerShell con interfaz gráfica moderna (WPF) que automatiza el uso de **ViVeTool** para desbloquear funciones ocultas en Windows 11, incluyendo el modo experimental de baja latencia (Proyecto K2).

---

## ✨ Características Principales

* **Interfaz Gráfica Moderna (GUI):** Construida de forma nativa con WPF dentro de PowerShell, sin necesidad de instalar frameworks pesados.
* **Auto-Elevación Inteligente:** Detecta si posee privilegios de administrador y, de no ser así, solicita los permisos automáticamente al ejecutarse.
* **Comprobación de Hardware y OS:** Analiza tu versión de Windows 11 (Build) y detecta si usas un equipo portátil o de escritorio para advertirte sobre el consumo energético.
* **Instalación Automatizada de ViVeTool:** Conecta con la API de GitHub para descargar e instalar automáticamente la última versión de ViVeTool adecuada para tu arquitectura (x64 o ARM).
* **Seguridad Integrada:** Botón dedicado para crear un Punto de Restauración del Sistema (Snapshot VSS) antes de aplicar cualquier cambio.
* **Selector Independiente de Funciones:** Activa o desactiva de forma individual:
  * ⚡ **Proyecto K2 Core:** Modo de baja latencia extrema.
  * 🗂️ **Nuevo Menú de Inicio:** Organización por categorías y barra lateral.
  * 📁 **Explorador XAML Moderno:** Nueva interfaz optimizada de archivos.
  * 🎮 **Modo Xbox Full Screen:** Experiencia envolvente ideal para consolas portátiles (ej. ROG Ally) o uso exclusivo con mando.
* **Consola de Registros en Vivo:** Visualiza cada proceso, error o éxito directamente en la herramienta.

---

## ⚠️ DESCARGO DE RESPONSABILIDAD (DISCLAIMER)

> **ATENCIÓN:** El uso de esta herramienta modifica parámetros ocultos del kernel y la interfaz de Windows 11.
> 
> **Sobre el Modo de Baja Latencia (Proyecto K2):** Esta función elimina los tiempos de rampa progresiva de las frecuencias del procesador, forzando picos máximos instantáneos para acelerar la respuesta del sistema. Esto provocará:
> * Incremento notable en la temperatura de los núcleos del CPU.
> * Aumento en la velocidad y ruido de los ventiladores del sistema.
> * **Reducción severa en la autonomía de la batería** en equipos portátiles (laptops/handhelds).
> 
> **Términos de uso:** El autor de este script no se hace responsable por daños al hardware, inestabilidad del sistema operativo, pérdida de datos o degradación de la batería. **Úsalo bajo tu propio riesgo y discreción.** Se recomienda encarecidamente utilizar el botón "Crear Punto de Restauración" antes de activar cualquier función.

---

## ⚙️ Cómo utilizarlo

1. Descarga el archivo `K2_Unlocker_Pro.ps1` (o clona este repositorio).
2. Haz clic derecho sobre el archivo `.ps1` y selecciona **"Ejecutar con PowerShell"**.
3. Acepta el cuadro de diálogo de Control de Cuentas de Usuario (UAC) para otorgar permisos de administrador.
4. En la interfaz gráfica:
   * Revisa el estado de tu hardware en el panel superior.
   * Haz clic en **INSTALAR** en el módulo de *Motor ViVeTool*.
   * (Opcional pero recomendado) Haz clic en **CREAR** un punto de restauración.
   * Selecciona **ACTIVAR** en las características que desees implementar.
5. **Reinicia tu computadora** para que los cambios de ViVeTool surtan efecto en el registro de Windows.

---

## 🤝 Créditos y Agradecimientos

* Toda la lógica de inyección de IDs es posible gracias a [ViVeTool](https://github.com/thebookisclosed/ViVe) desarrollado por **thebookisclosed**. Este script actúa como una interfaz automatizada para dicha herramienta.
