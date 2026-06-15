// presentation/viewmodel/AuthViewModel.kt
package com.shopapp.presentation.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.shopapp.data.local.TokenDataStore
import com.shopapp.domain.model.LoggedUser
import com.shopapp.domain.model.UserPayload
import com.shopapp.domain.repository.AuthRepository
import com.shopapp.domain.repository.UserRepository
import com.shopapp.presentation.ui.auth.AuthUiState
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class AuthViewModel @Inject constructor(
    private val authRepository: AuthRepository,
    private val tokenDataStore: TokenDataStore,
    private val userRepository: UserRepository,
) : ViewModel() {

    // ── Estado de la UI ───────────────────────────────────────
    private val _uiState = MutableStateFlow<AuthUiState>(AuthUiState.Idle)
    val uiState: StateFlow<AuthUiState> = _uiState.asStateFlow()

    // ── Usuario logueado (Flow reactivo) ──────────────────────
    private val _currentUser = MutableStateFlow<LoggedUser?>(null)
    val currentUser: StateFlow<LoggedUser?> = _currentUser.asStateFlow()

    val isAuthenticated: StateFlow<Boolean> = _currentUser
        .map { it != null }
        .stateIn(viewModelScope, SharingStarted.Eagerly, false)

    val isStaff: StateFlow<Boolean> = _currentUser
        .map { it?.isStaff == true }
        .stateIn(viewModelScope, SharingStarted.Eagerly, false)

    // ── Estado de carga inicial ───────────────────────────────
    private val _isCheckingSession = MutableStateFlow(true)
    val isCheckingSession: StateFlow<Boolean> = _isCheckingSession.asStateFlow()

    init {
        restoreSession()
    }

    // Restaurar sesión desde DataStore al arrancar la app
    private fun restoreSession() {
        viewModelScope.launch {
            try {
                val snapshot = authRepository.getStoredUser()
                if (snapshot != null && authRepository.isLoggedIn()) {
                    _currentUser.value = LoggedUser(
                        id       = snapshot.id,
                        username = snapshot.username,
                        email    = snapshot.email,
                        isStaff  = snapshot.isStaff,
                    )
                }
            } finally {
                _isCheckingSession.value = false
            }
        }
    }

    // ── Login ─────────────────────────────────────────────────
    fun login(username: String, password: String) {
        if (_uiState.value is AuthUiState.Loading) return
        viewModelScope.launch {
            _uiState.value = AuthUiState.Loading
            authRepository.login(username.trim(), password)
                .onSuccess { user ->
                    _currentUser.value = user
                    _uiState.value     = AuthUiState.Success(user)
                }
                .onFailure { e ->
                    _uiState.value = AuthUiState.Error(e.message ?: "Error al iniciar sesión")
                }
        }
    }

    // ── Registro ──────────────────────────────────────────────
    fun register(username: String, email: String, password: String, password2: String) {
        if (_uiState.value is AuthUiState.Loading) return
        viewModelScope.launch {
            _uiState.value = AuthUiState.Loading
            authRepository.register(username.trim(), email.trim(), password, password2)
                .onSuccess { user ->
                    _currentUser.value = user
                    _uiState.value     = AuthUiState.Success(user)
                }
                .onFailure { e ->
                    _uiState.value = AuthUiState.Error(e.message ?: "Error al registrarse")
                }
        }
    }

    // ── Logout ────────────────────────────────────────────────
    fun logout() {
        viewModelScope.launch {
            authRepository.logout()
            _currentUser.value = null
            _uiState.value     = AuthUiState.Idle
        }
    }

    fun clearError() {
        if (_uiState.value is AuthUiState.Error) {
            _uiState.value = AuthUiState.Idle
        }
    }

    // ── Solicitar acceso administrador ─────────────────────────
    private val _staffRequestState = MutableStateFlow<String?>(null)
    val staffRequestState: StateFlow<String?> = _staffRequestState.asStateFlow()

    fun requestStaffAccess() {
        val user = _currentUser.value ?: return
        if (_staffRequestState.value != null) return
        viewModelScope.launch {
            _staffRequestState.value = "Solicitando..."
            userRepository.updateUser(
                user.id,
                UserPayload(
                    username  = user.username,
                    email     = user.email,
                    firstName = "",
                    lastName  = "",
                    isActive  = true,
                    isStaff   = true,
                )
            ).onSuccess {
                val newUser = user.copy(isStaff = true)
                _currentUser.value = newUser
                tokenDataStore.saveUser(user.id, user.username, user.email, true)
                _staffRequestState.value = "¡Acceso de administrador activado! Vuelve a iniciar sesión."
            }.onFailure {
                _staffRequestState.value = "No se pudo activar: ${it.message}"
            }
        }
    }

    fun clearStaffRequest() { _staffRequestState.value = null }
}