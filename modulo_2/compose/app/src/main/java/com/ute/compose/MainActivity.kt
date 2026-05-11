// MainActivity.kt
package com.ute.compose

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import com.ute.compose.screens.*
import com.ute.compose.material.*

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                // ◀ CAMBIA AQUÍ para probar cada sección:
                // S01SaludoScreen()
                //S02TextScreen()
                //S03ButtonScreen()
                //S04LayoutScreen()
                //S05ModifierScreen()
                //S06EstadoScreen()
                //S07StateHoistingScreen()
                // S08BienvenidaScreen()

                // Componentes Material 3: TextField, Card, LazyColumn, Scaffold y diálogos
                // ◀ CAMBIA AQUÍ para probar cada paso:
                //Paso01TextFieldScreen()
                Paso01SumaScreen()
                // Paso02CardScreen()
                // Paso03_LazyColumnScreen()
                // Paso04_ScaffoldScreen()
                // Paso05_NavBarScreen()
                // Paso06_DialogosScreen()   // ← paso activo
            }
        }
    }
}