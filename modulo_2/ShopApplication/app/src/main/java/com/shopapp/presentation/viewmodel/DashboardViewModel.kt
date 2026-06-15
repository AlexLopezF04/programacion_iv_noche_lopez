// presentation/viewmodel/DashboardViewModel.kt
package com.shopapp.presentation.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.shopapp.domain.model.Product
import com.shopapp.domain.model.ProductFilters
import com.shopapp.domain.repository.*
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.async
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

data class DashboardStats(
    val totalActiveProducts:   Int    = 0,
    val outOfStockProducts:    Int    = 0,
    val totalStock:            Int    = 0,
    val avgPrice:              Double = 0.0,
    val activeCategories:      Int    = 0,
    val totalCategories:       Int    = 0,
    val totalOrders:           Int    = 0,
    val totalRevenue:          Double = 0.0,
    val pendingOrders:         Int    = 0,
    val ordersByStatus:        Map<String, Int> = emptyMap(),
    val activeUsers:           Int    = 0,
    val totalUsers:            Int    = 0,
    val staffUsers:            Int    = 0,
    val lowStockProducts:      List<Product> = emptyList(),
)

sealed interface DashboardUiState {
    data object Loading                          : DashboardUiState
    data class  Success(val stats: DashboardStats) : DashboardUiState
    data class  Error(val message: String)       : DashboardUiState
}

@HiltViewModel
class DashboardViewModel @Inject constructor(
    private val productRepository:  ProductRepository,
    private val categoryRepository: CategoryRepository,
    private val orderRepository:    OrderRepository,
    private val userRepository:     UserRepository,
) : ViewModel() {

    private val _state = MutableStateFlow<DashboardUiState>(DashboardUiState.Loading)
    val state: StateFlow<DashboardUiState> = _state.asStateFlow()

    private val _lastUpdated = MutableStateFlow<Long>(0L)
    val lastUpdated: StateFlow<Long> = _lastUpdated.asStateFlow()

    init { load() }

    fun load() {
        viewModelScope.launch {
            _state.value = DashboardUiState.Loading

            try {
                // Todas las llamadas en paralelo con async
                val productStatsDeferred  = async { productRepository.getStats() }
                val categoryStatsDeferred = async { categoryRepository.getStats() }
                val orderStatsDeferred    = async { orderRepository.getStats() }
                val userStatsDeferred     = async { userRepository.getStats() }
                val lowStockDeferred      = async {
                    productRepository.getProducts(
                        ProductFilters(isActive = true, ordering = "stock", pageSize = 5)
                    )
                }

                val productStats  = productStatsDeferred.await().getOrThrow()
                val categoryStats = categoryStatsDeferred.await().getOrThrow()
                val orderStats    = orderStatsDeferred.await().getOrThrow()
                val userStats     = userStatsDeferred.await().getOrThrow()
                val lowStock      = lowStockDeferred.await().getOrNull()

                val stats = DashboardStats(
                    totalActiveProducts  = productStats.totalActive,
                    outOfStockProducts   = productStats.outOfStock,
                    totalStock           = productStats.totalStock,
                    avgPrice             = productStats.avgPrice,
                    activeCategories     = categoryStats.active,
                    totalCategories      = categoryStats.total,
                    totalOrders          = orderStats.totalOrders,
                    totalRevenue         = orderStats.totalRevenue,
                    pendingOrders        = orderStats.byStatus["pending"] ?: 0,
                    ordersByStatus       = orderStats.byStatus,
                    activeUsers          = userStats.active,
                    totalUsers           = userStats.total,
                    staffUsers           = userStats.staff,
                    lowStockProducts     = lowStock?.first
                        ?.filter { it.stock < 5 }
                        ?.take(5)
                        ?: emptyList(),
                )

                _state.value       = DashboardUiState.Success(stats)
                _lastUpdated.value = System.currentTimeMillis()

            } catch (e: Exception) {
                _state.value = DashboardUiState.Error(e.message ?: "Error al cargar el dashboard")
            }
        }
    }
}