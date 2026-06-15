package com.ute.techdash.ui.multimedia

import android.net.Uri
import androidx.camera.core.CameraSelector
import androidx.camera.core.ImageCapture
import androidx.camera.core.ImageCaptureException
import androidx.camera.core.Preview
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.view.PreviewView
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Cameraswitch
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.FlashOff
import androidx.compose.material.icons.filled.FlashOn
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.lifecycle.compose.LocalLifecycleOwner
import java.io.File
import java.text.SimpleDateFormat
import java.util.Locale

@Composable
fun PantallaCamara(
    onFotoTomada: (Uri) -> Unit,
    onCerrar:     () -> Unit
) {
    val context        = LocalContext.current
    val lifecycleOwner = LocalLifecycleOwner.current

    // Referencia a la cámara para disparar la foto
    var capturaImagen by remember { mutableStateOf<ImageCapture?>(null) }
    var usarCamaraFrontal by remember { mutableStateOf(false) }
    var flashActivo   by remember { mutableStateOf(false) }
    var tomandoFoto   by remember { mutableStateOf(false) }

    // Función para inicializar CameraX
    fun iniciarCamara(vistaPrevia: PreviewView) {
        val proveedorFuturo = ProcessCameraProvider.getInstance(context)
        proveedorFuturo.addListener({
            val proveedor = proveedorFuturo.get()

            // Selector de cámara
            val selectorCamara = if (usarCamaraFrontal)
                CameraSelector.DEFAULT_FRONT_CAMERA
            else
                CameraSelector.DEFAULT_BACK_CAMERA

            // Preview — lo que ve el usuario en pantalla
            val preview = Preview.Builder().build().also {
                it.surfaceProvider = vistaPrevia.surfaceProvider
            }

            // ImageCapture — para tomar la foto
            val imageCapture = ImageCapture.Builder()
                .setFlashMode(
                    if (flashActivo) ImageCapture.FLASH_MODE_ON
                    else             ImageCapture.FLASH_MODE_OFF
                )
                .setCaptureMode(ImageCapture.CAPTURE_MODE_MAXIMIZE_QUALITY)
                .build()

            capturaImagen = imageCapture

            try {
                proveedor.unbindAll()
                proveedor.bindToLifecycle(
                    lifecycleOwner,
                    selectorCamara,
                    preview,
                    imageCapture
                )
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }, ContextCompat.getMainExecutor(context))
    }

    // Función para tomar la foto
    fun tomarFoto() {
        val captura = capturaImagen ?: return
        tomandoFoto = true

        // Crear archivo de destino en caché
        val archivo = File(
            context.cacheDir.resolve("images").also { it.mkdirs() },
            SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(System.currentTimeMillis()) + ".jpg"
        )

        val opcionesGuardado = ImageCapture.OutputFileOptions.Builder(archivo).build()

        captura.takePicture(
            opcionesGuardado,
            ContextCompat.getMainExecutor(context),
            object : ImageCapture.OnImageSavedCallback {
                override fun onImageSaved(output: ImageCapture.OutputFileResults) {
                    tomandoFoto = false
                    val uri = androidx.core.content.FileProvider.getUriForFile(
                        context,
                        "${context.packageName}.fileprovider",
                        archivo
                    )
                    onFotoTomada(uri)
                }
                override fun onError(exc: ImageCaptureException) {
                    tomandoFoto = false
                    exc.printStackTrace()
                }
            }
        )
    }

    Box(modifier = Modifier.fillMaxSize().background(Color.Black)) {

        // Vista previa de la cámara — AndroidView para componentes de Android clásico
        AndroidView(
            factory  = { ctx ->
                PreviewView(ctx).also { vistaPrevia ->
                    vistaPrevia.scaleType = PreviewView.ScaleType.FILL_CENTER
                    iniciarCamara(vistaPrevia)
                }
            },
            update   = { vistaPrevia -> iniciarCamara(vistaPrevia) },
            modifier = Modifier.fillMaxSize()
        )

        // Controles superpuestos
        Column(
            modifier              = Modifier.align(Alignment.BottomCenter).padding(32.dp),
            horizontalAlignment   = Alignment.CenterHorizontally,
            verticalArrangement   = Arrangement.spacedBy(16.dp)
        ) {
            // Botones superiores
            Row(
                Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                // Cerrar
                IconButton(
                    onClick  = onCerrar,
                    modifier = Modifier
                        .size(48.dp)
                        .clip(CircleShape)
                        .background(Color.Black.copy(alpha = 0.5f))
                ) {
                    Icon(Icons.Default.Close, "Cerrar", tint = Color.White)
                }

                // Flash
                IconButton(
                    onClick  = { flashActivo = !flashActivo },
                    modifier = Modifier
                        .size(48.dp)
                        .clip(CircleShape)
                        .background(Color.Black.copy(alpha = 0.5f))
                ) {
                    Icon(
                        if (flashActivo) Icons.Default.FlashOn else Icons.Default.FlashOff,
                        "Flash",
                        tint = if (flashActivo) Color.Yellow else Color.White
                    )
                }
            }

            // Botón disparador
            Box(contentAlignment = Alignment.Center) {
                if (tomandoFoto) {
                    CircularProgressIndicator(color = Color.White, modifier = Modifier.size(80.dp))
                } else {
                    Box(
                        modifier = Modifier
                            .size(80.dp)
                            .clip(CircleShape)
                            .background(Color.White)
                            .clickable { tomarFoto() }
                    )
                }
            }

            // Cambiar cámara
            TextButton(onClick = { usarCamaraFrontal = !usarCamaraFrontal }) {
                Icon(Icons.Default.Cameraswitch, null, tint = Color.White)
                Spacer(Modifier.width(4.dp))
                Text(
                    if (usarCamaraFrontal) "Frontal" else "Trasera",
                    color = Color.White
                )
            }
        }
    }
}