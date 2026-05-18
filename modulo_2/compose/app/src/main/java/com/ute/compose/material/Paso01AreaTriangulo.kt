package com.ute.compose.material

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun Paso01AreaTrianguloScreen() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .verticalScroll(rememberScrollState()),
        verticalArrangement = Arrangement.spacedBy(24.dp)
    ) {
        Text("Paso 1 · TextField y OutlinedTextField",
            style = MaterialTheme.typography.titleMedium)
        HorizontalDivider()
        SumaNumeros()
    }
}

// ── Suma de dos numeros ───────────────────────────────
@Composable
private fun SumaNumeros() {
    var base     by remember { mutableStateOf("0") }
    var altura      by remember { mutableStateOf("0") }
    var resultado   by remember { mutableStateOf("0") }


    Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Text("Formulario nuevo contacto",
            style = MaterialTheme.typography.labelLarge,
            color = MaterialTheme.colorScheme.primary)

        // Nombre — validación básica de longitud
        OutlinedTextField(
            value           = base,
            onValueChange   = { base = it },
            label           = { Text("Base") },
            leadingIcon     = { Icon(Icons.Default.Person, contentDescription = null) },
            // keyboardOptions configura el teclado del sistema operativo
            keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next),
            singleLine      = true,
            modifier        = Modifier.fillMaxWidth()
        )

        // Nombre — validación básica de longitud
        OutlinedTextField(
            value           = altura,
            onValueChange   = { altura = it },
            label           = { Text("Altura") },
            leadingIcon     = { Icon(Icons.Default.Person, contentDescription = null) },
            // keyboardOptions configura el teclado del sistema operativo
            keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next),
            singleLine      = true,
            modifier        = Modifier.fillMaxWidth()
        )


        Button(
            onClick  = {
                val numero1Double = base.toDoubleOrNull()?:0.0
                val numero2Double = altura .toDoubleOrNull()?:0.0
                resultado = (numero1Double + numero2Double / 2).toString()
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text( text = "Area del tiangulo")
        }
        Text( text = "Resultado de $base +$altura = $resultado")
    }
}

@Preview(showBackground = true)
@Composable
fun Paso01AreaTrianguloPreview() {
    MaterialTheme { Paso01AreaTrianguloScreen() }
}