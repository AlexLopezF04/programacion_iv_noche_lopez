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

class MainActivityCicloVidaResume : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        Log.d("CicloVida", "onCreate")
        setContent {
            TechDashTheme {
                Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text("Rota la pantalla y observa Logcat")
                }
            }
        }
    }
    override fun onStart()   { super.onStart();   Log.d("CicloVida", "onStart") }
    override fun onResume()  { super.onResume();  Log.d("CicloVida", "onResume") }
    override fun onPause()   { super.onPause();   Log.d("CicloVida", "onPause") }
    override fun onStop()    { super.onStop();    Log.d("CicloVida", "onStop") }
    override fun onDestroy() { super.onDestroy(); Log.d("CicloVida", "onDestroy") }
    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        Log.d("CicloVida", "onSaveInstanceState")
    }
}