package com.ute.techdash.ui.permisos

import android.content.pm.PackageManager
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Cancel
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.core.content.ContextCompat

@Composable
fun SolicitarPermisosMultiples() {
    val context = LocalContext.current

    val permisos = arrayOf(
        android.Manifest.permission.CAMERA,
        android.Manifest.permission.ACCESS_FINE_LOCATION,
        android.Manifest.permission.RECORD_AUDIO
    )

    // Estado de cada permiso
    var estadoPermisos by remember {
        mutableStateOf(
            permisos.associateWith { permiso ->
                ContextCompat.checkSelfPermission(context, permiso) ==
                        PackageManager.PERMISSION_GRANTED
            }
        )
    }

    // Launcher para múltiples permisos
    val lanzador = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.RequestMultiplePermissions()
    ) { resultados ->
        estadoPermisos = resultados
    }

    val nombresPermisos = mapOf(
        android.Manifest.permission.CAMERA             to "Cámara",
        android.Manifest.permission.ACCESS_FINE_LOCATION to "Ubicación precisa",
        android.Manifest.permission.RECORD_AUDIO        to "Micrófono"
    )

    Column(Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Text("Estado de permisos", style = MaterialTheme.typography.titleLarge,
            fontWeight = FontWeight.Bold)

        estadoPermisos.forEach { (permiso, concedido) ->
            Row(
                Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment     = Alignment.CenterVertically
            ) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(
                        imageVector = if (concedido) Icons.Default.CheckCircle
                        else Icons.Default.Cancel,
                        contentDescription = null,
                        tint = if (concedido) MaterialTheme.colorScheme.primary
                        else MaterialTheme.colorScheme.error,
                        modifier = Modifier.size(20.dp)
                    )
                    Spacer(Modifier.width(8.dp))
                    Text(nombresPermisos[permiso] ?: permiso.substringAfterLast("."))
                }
                Text(
                    if (concedido) "Concedido" else "Denegado",
                    style = MaterialTheme.typography.bodySmall,
                    color = if (concedido) MaterialTheme.colorScheme.primary
                    else MaterialTheme.colorScheme.error
                )
            }
            HorizontalDivider()
        }

        val todosConcedidos = estadoPermisos.values.all { it }
        if (!todosConcedidos) {
            Button(
                onClick  = { lanzador.launch(permisos) },
                modifier = Modifier.fillMaxWidth()
            ) {
                Text("Solicitar permisos pendientes")
            }
        } else {
            Card(
                colors   = CardDefaults.cardColors(
                    containerColor = MaterialTheme.colorScheme.primaryContainer
                ),
                modifier = Modifier.fillMaxWidth()
            ) {
                Text(
                    "✅ Todos los permisos concedidos",
                    modifier = Modifier.padding(16.dp),
                    fontWeight = FontWeight.SemiBold
                )
            }
        }
    }
}