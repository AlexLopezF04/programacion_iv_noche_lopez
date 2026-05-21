// ui/Paso01_TextField.kt
package com.example.compose.material

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ShoppingCart
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun Paso01ProductoScreen() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .verticalScroll(rememberScrollState()),
        verticalArrangement = Arrangement.spacedBy(24.dp)
    ) {

        Text(
            text = "Sistema de Compras",
            style = MaterialTheme.typography.titleMedium
        )

        HorizontalDivider()

        CompraProducto()
    }
}

@Composable
private fun CompraProducto() {

    // Variables
    var producto by remember { mutableStateOf("") }
    var cantidad by remember { mutableStateOf("") }
    var precio by remember { mutableStateOf("") }

    var subtotal by remember { mutableStateOf(0.0) }
    var descuento by remember { mutableStateOf(0.0) }
    var total by remember { mutableStateOf(0.0) }

    Column(
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {

        Text(
            text = "Formulario de compra",
            style = MaterialTheme.typography.labelLarge,
            color = MaterialTheme.colorScheme.primary
        )

        // Nombre del producto
        OutlinedTextField(
            value = producto,
            onValueChange = { producto = it },
            label = { Text("Nombre del producto") },
            leadingIcon = {
                Icon(Icons.Default.ShoppingCart, contentDescription = null)
            },
            keyboardOptions = KeyboardOptions(
                imeAction = ImeAction.Next
            ),
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        // Cantidad comprada
        OutlinedTextField(
            value = cantidad,
            onValueChange = { cantidad = it },
            label = { Text("Cantidad comprada") },
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Number,
                imeAction = ImeAction.Next
            ),
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        // Precio unitario
        OutlinedTextField(
            value = precio,
            onValueChange = { precio = it },
            label = { Text("Precio unitario") },
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Decimal,
                imeAction = ImeAction.Done
            ),
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        // Botón calcular
        Button(
            onClick = {

                val cantidadInt = cantidad.toIntOrNull() ?: 0
                val precioDouble = precio.toDoubleOrNull() ?: 0.0

                // Calcular subtotal
                subtotal = cantidadInt * precioDouble

                // Aplicar descuento
                descuento = when {
                    subtotal > 50 -> subtotal * 0.10
                    subtotal in 20.0..50.0 -> subtotal * 0.05
                    else -> 0.0
                }

                // Total a pagar
                total = subtotal - descuento
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Calcular")
        }

        HorizontalDivider()

        // Resultados
        Text("Producto: $producto")
        Text("Subtotal: $subtotal")
        Text("Descuento aplicado: $descuento")
        Text("Total a pagar: $total")
    }
}

@Preview(showBackground = true)
@Composable
fun Paso01ProductoPreview() {
    MaterialTheme {
        Paso01ProductoScreen()
    }
}