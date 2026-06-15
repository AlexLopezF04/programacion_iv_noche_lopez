// presentation/navigation/NavGraph.kt
package com.shopapp.presentation.navigation

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.*
import androidx.navigation.compose.*
import com.shopapp.presentation.components.LoadingScreen
import com.shopapp.presentation.ui.admin.AdminScaffold
import com.shopapp.presentation.ui.admin.categories.CategoriesAdminScreen
import com.shopapp.presentation.ui.admin.dashboard.DashboardScreen
import com.shopapp.presentation.ui.admin.orders.OrderAdminDetailScreen
import com.shopapp.presentation.ui.admin.orders.OrdersAdminScreen
import com.shopapp.presentation.ui.admin.products.ProductsAdminScreen
import com.shopapp.presentation.ui.admin.users.UsersAdminScreen
import com.shopapp.presentation.ui.auth.ForgotPasswordScreen
import com.shopapp.presentation.ui.auth.LoginScreen
import com.shopapp.presentation.ui.auth.RegisterScreen
import com.shopapp.presentation.ui.auth.ResetPasswordConfirmScreen
import com.shopapp.presentation.ui.admin.users.SendNotificationScreen
import com.shopapp.presentation.ui.client.orders.OrderDetailScreen
import com.shopapp.presentation.ui.client.orders.OrdersScreen
import com.shopapp.presentation.ui.client.profile.ProfileScreen
import com.shopapp.presentation.ui.uipublic.cart.CartBottomSheet
import com.shopapp.presentation.ui.uipublic.catalog.CatalogScreen
import com.shopapp.presentation.ui.uipublic.home.HomeScreen
import com.shopapp.presentation.ui.uipublic.product.ProductDetailScreen
import com.shopapp.presentation.viewmodel.AuthViewModel
import com.shopapp.presentation.viewmodel.CartViewModel
import com.shopapp.presentation.viewmodel.OrdersAdminViewModel
import com.shopapp.domain.model.LoggedUser
import com.shopapp.theme.Surface
import com.shopapp.theme.TextSecondary

private fun NavGraphBuilder.adminRoute(
    route:         String,
    title:         String,
    isStaff:       Boolean,
    currentUser:   LoggedUser?,
    authViewModel: AuthViewModel,
    navController: NavHostController,
    content:       @Composable () -> Unit,
) {
    composable(route) {
        if (!isStaff) {
            LaunchedEffect(Unit) { navController.navigate(Screen.Home.route) { popUpTo(0) } }
            return@composable
        }
        AdminScaffold(
            currentRoute = route, user = currentUser, title = title,
            onNavClick = { navController.navigate(it) { launchSingleTop = true; restoreState = true } },
            onStoreClick = { navController.navigate(Screen.Home.route) },
            onLogout = { authViewModel.logout(); navController.navigate(Screen.Login.route) { popUpTo(0) { inclusive = true } } },
        ) { padding -> Box(Modifier.padding(padding)) { content() } }
    }
}

@Composable
fun NavGraph(
    authViewModel: AuthViewModel,
    cartViewModel: CartViewModel = hiltViewModel(),
) {
    val navController     = rememberNavController()
    val isCheckingSession by authViewModel.isCheckingSession.collectAsState()
    val isAuthenticated   by authViewModel.isAuthenticated.collectAsState()
    val isStaff           by authViewModel.isStaff.collectAsState()
    val cartCount         by cartViewModel.totalItems.collectAsState()
    val currentUser       by authViewModel.currentUser.collectAsState()

    var showCart         by remember { mutableStateOf(false) }
    var confirmedOrderId by remember { mutableStateOf<Int?>(null) }

    if (isCheckingSession) {
        LoadingScreen("Iniciando ShopApp...")
        return
    }

    val startDestination = when {
        !isAuthenticated -> Screen.Login.route
        isStaff          -> Screen.AdminDashboard.route
        else             -> Screen.Home.route
    }

    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute      = navBackStackEntry?.destination?.route

    val showBottomBar = currentRoute in listOf(
        Screen.Home.route,
        Screen.Catalog.route,
        Screen.Orders.route,
        Screen.Profile.route,
    )

    Scaffold(
        containerColor = Surface,
        bottomBar = {
            if (showBottomBar) {
                BottomNavBar(
                    navController = navController,
                    cartCount     = cartCount,
                    onCartClick   = { showCart = true },
                )
            }
        },
    ) { innerPadding ->

        // ── BottomSheet carrito
        if (showCart) {
            CartBottomSheet(
                cartViewModel   = cartViewModel,
                isAuthenticated = isAuthenticated,
                onDismiss       = { showCart = false },
                onLoginRequired = {
                    showCart = false
                    navController.navigate(Screen.Login.route)
                },
                onOrderSuccess = { orderId ->
                    confirmedOrderId = orderId
                    showCart = false
                },
            )
        }

        NavHost(
            navController    = navController,
            startDestination = startDestination,
            modifier         = Modifier.padding(innerPadding),
        ) {

            // ── LOGIN ───────────────────────────────
            composable(Screen.Login.route) {
                LoginScreen(
                    onLoginSuccess = { staff ->
                        val dest = if (staff) Screen.AdminDashboard.route else Screen.Home.route
                        navController.navigate(dest) {
                            popUpTo(Screen.Login.route) { inclusive = true }
                        }
                    },
                    onNavigateToRegister = { navController.navigate(Screen.Register.route) },
                    onForgotPassword     = { navController.navigate(Screen.ForgotPassword.route) },
                    viewModel            = authViewModel,
                )
            }

            // ── RECUPERACIÓN DE CONTRASEÑA ──────────
            composable(Screen.ForgotPassword.route) {
                ForgotPasswordScreen(
                    onBack        = { navController.popBackStack() },
                    onGoToConfirm = { navController.navigate(Screen.ResetPasswordConfirm.route) },
                )
            }

            composable(Screen.ResetPasswordConfirm.route) {
                ResetPasswordConfirmScreen(
                    onBack         = { navController.popBackStack() },
                    onResetSuccess = {
                        navController.navigate(Screen.Login.route) {
                            popUpTo(Screen.Login.route) { inclusive = true }
                        }
                    },
                )
            }

            // ── REGISTER ────────────────────────────
            composable(Screen.Register.route) {
                RegisterScreen(
                    onRegisterSuccess = { staff ->
                        val dest = if (staff) Screen.AdminDashboard.route else Screen.Home.route
                        navController.navigate(dest) {
                            popUpTo(Screen.Login.route) { inclusive = true }
                        }
                    },
                    onNavigateToLogin = { navController.popBackStack() },
                    viewModel         = authViewModel,
                )
            }

            // ── HOME ───────────────────────────────
            composable(Screen.Home.route) {
                HomeScreen(
                    onProductClick = { id -> navController.navigate("product/$id") },
                    onCatalogClick = { navController.navigate(Screen.Catalog.route) },
                )
            }

            // ── CATALOGO ───────────────────────────
            composable(Screen.Catalog.route) {
                CatalogScreen(
                    onProductClick = { id -> navController.navigate("product/$id") },
                )
            }

            // ── DETALLE PRODUCTO ───────────────────
            composable(
                route     = "product/{id}",
                arguments = listOf(navArgument("id") { type = NavType.IntType }),
            ) { backStackEntry ->
                val id = backStackEntry.arguments?.getInt("id") ?: return@composable
                ProductDetailScreen(
                    productId     = id,
                    onBack        = { navController.popBackStack() },
                    cartViewModel = cartViewModel,
                )
            }

            // ── ORDERS CLIENT ──────────────────────
            composable(Screen.Orders.route) {
                if (!isAuthenticated) {
                    LaunchedEffect(Unit) {
                        navController.navigate(Screen.Login.route) {
                            popUpTo(Screen.Home.route)
                        }
                    }
                } else {
                    OrdersScreen(
                        onOrderClick = { id -> navController.navigate("orders/$id") },
                    )
                }
            }

            // ── ORDER DETAIL CLIENT ────────────────
            composable(
                route     = "orders/{id}",
                arguments = listOf(navArgument("id") { type = NavType.IntType }),
            ) { backStackEntry ->
                val id = backStackEntry.arguments?.getInt("id") ?: return@composable
                OrderDetailScreen(
                    orderId = id,
                    onBack  = { navController.popBackStack() },
                )
            }

            // ── PROFILE ────────────────────────────
            composable(Screen.Profile.route) {
                if (!isAuthenticated) {
                    LaunchedEffect(Unit) {
                        navController.navigate(Screen.Login.route) {
                            popUpTo(Screen.Home.route)
                        }
                    }
                } else {
                    ProfileScreen(
                        authViewModel      = authViewModel,
                        onLogout = {
                            navController.navigate(Screen.Login.route) {
                                popUpTo(0) { inclusive = true }
                            }
                        },
                        onSendNotification = { navController.navigate(Screen.SendNotification.route) },
                    )
                }
            }

            // ── RUTAS ADMIN ─────────────────────────
            adminRoute(
                route = Screen.AdminDashboard.route,
                title = "Dashboard",
                isStaff = isStaff,
                currentUser = currentUser,
                authViewModel = authViewModel,
                navController = navController,
            ) {
                DashboardScreen(onNavigate = { route -> navController.navigate(route) })
            }

            adminRoute(
                route = "admin/categories",
                title = "Categorías",
                isStaff = isStaff,
                currentUser = currentUser,
                authViewModel = authViewModel,
                navController = navController,
            ) {
                CategoriesAdminScreen()
            }

            adminRoute(
                route = "admin/products",
                title = "Productos",
                isStaff = isStaff,
                currentUser = currentUser,
                authViewModel = authViewModel,
                navController = navController,
            ) {
                ProductsAdminScreen()
            }

            composable("admin/orders") {
                if (!isStaff) { LaunchedEffect(Unit) { navController.navigate(Screen.Home.route) { popUpTo(0) } }; return@composable }
                val ordersAdminVm: OrdersAdminViewModel = hiltViewModel()
                AdminScaffold(
                    currentRoute = "admin/orders", user = currentUser, title = "Pedidos",
                    onNavClick = { navController.navigate(it) { launchSingleTop = true } },
                    onStoreClick = { navController.navigate(Screen.Home.route) },
                    onLogout = { authViewModel.logout(); navController.navigate(Screen.Login.route) { popUpTo(0) { inclusive = true } } },
                ) { padding ->
                    Box(Modifier.padding(padding)) {
                        OrdersAdminScreen(onOrderDetail = { navController.navigate("admin/orders/$it") }, viewModel = ordersAdminVm)
                    }
                }
            }

            composable(
                route = "admin/orders/{id}",
                arguments = listOf(navArgument("id") { type = NavType.IntType }),
            ) { backStackEntry ->
                val id = backStackEntry.arguments?.getInt("id") ?: return@composable
                if (!isStaff) { LaunchedEffect(Unit) { navController.navigate(Screen.Home.route) { popUpTo(0) } }; return@composable }
                val ordersAdminVm: OrdersAdminViewModel = hiltViewModel(remember(backStackEntry) { navController.getBackStackEntry("admin/orders") })
                AdminScaffold(
                    currentRoute = "admin/orders", user = currentUser, title = "Detalle pedido #$id",
                    onNavClick = { navController.navigate(it) { launchSingleTop = true } },
                    onStoreClick = { navController.navigate(Screen.Home.route) },
                    onLogout = { authViewModel.logout(); navController.navigate(Screen.Login.route) { popUpTo(0) { inclusive = true } } },
                ) { padding ->
                    Box(Modifier.padding(padding)) {
                        OrderAdminDetailScreen(orderId = id, onBack = { navController.popBackStack() }, onStatusChange = { ordId, s -> ordersAdminVm.changeStatus(ordId, s) })
                    }
                }
            }

            adminRoute(
                route = "admin/users",
                title = "Usuarios",
                isStaff = isStaff,
                currentUser = currentUser,
                authViewModel = authViewModel,
                navController = navController,
            ) {
                UsersAdminScreen()
            }

            // ── NOTIFICACIONES DE STAFF ────────────
            composable(Screen.SendNotification.route) {
                if (!isStaff) { LaunchedEffect(Unit) { navController.popBackStack() }; return@composable }
                SendNotificationScreen(onBack = { navController.popBackStack() })
            }
        }
    }
}

