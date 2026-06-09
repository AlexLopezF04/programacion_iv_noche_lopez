package com.ute.techdash

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Text
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import com.ute.techdash.ui.theme.TechDashTheme

class MainActivityCicloVidaLog : ComponentActivity() {

    private val TAG = "CicloVida"

    // Se llama al CREAR la actividad — o tras rotación
    // Aquí: inflar la UI, inicializar el ViewModel
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        Log.d(TAG, "onCreate — savedInstanceState: ${savedInstanceState != null}")

        // Restaurar estado si la actividad fue recreada
        val textoGuardado = savedInstanceState?.getString("texto_usuario")
        Log.d(TAG, "Texto restaurado: $textoGuardado")

        setContent {
            TechDashTheme {
                Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Rota la pantalla y observa Logcat")
                }
            }
        }
    }

    // La actividad se vuelve VISIBLE
    override fun onStart() {
        super.onStart()
        Log.d(TAG, "onStart — actividad visible")
    }

    // La actividad pasa al PRIMER PLANO — usuario puede interactuar
    // Aquí: reanudar animaciones, cámara, GPS, sensores
    override fun onResume() {
        super.onResume()
        Log.d(TAG, "onResume — primer plano")
    }

    // Otra actividad toma el foco PARCIALMENTE (diálogo, permiso)
    // Aquí: pausar animaciones, liberar cámara si exclusiva
    override fun onPause() {
        super.onPause()
        Log.d(TAG, "onPause — foco parcialmente perdido")
    }

    // La actividad ya NO es visible (app al fondo, otra app encima)
    // Aquí: guardar datos, detener operaciones costosas
    override fun onStop() {
        super.onStop()
        Log.d(TAG, "onStop — actividad no visible")
    }

    // Guardar estado ANTES de que la actividad sea destruida
    // Se llama antes de onStop — sobrevive a rotaciones
    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putString("texto_usuario", "dato importante")
        Log.d(TAG, "onSaveInstanceState — guardando estado")
    }

    // La actividad es DESTRUIDA definitivamente
    // Aquí: liberar recursos finales (no el ViewModel — él sobrevive)
    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "onDestroy — actividad destruida")
    }
}