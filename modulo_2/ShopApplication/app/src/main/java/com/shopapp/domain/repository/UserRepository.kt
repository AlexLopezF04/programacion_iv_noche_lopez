// domain/repository/UserRepository.kt
package com.shopapp.domain.repository

import com.shopapp.domain.model.User
import com.shopapp.domain.model.UserPayload
import com.shopapp.domain.model.NotificationResult
import com.shopapp.domain.model.UserStats

interface UserRepository {
    suspend fun getUsers(
        search:   String?  = null,
        isStaff:  Boolean? = null,
        isActive: Boolean? = null,
        page:     Int?     = null,
    ): Result<Pair<List<User>, Int>>
    suspend fun getUser(id: Int): Result<User>
    suspend fun createUser(payload: UserPayload): Result<User>
    suspend fun updateUser(id: Int, payload: UserPayload): Result<User>
    suspend fun deleteUser(id: Int): Result<Unit>
    suspend fun toggleActive(id: Int): Result<Boolean>
    suspend fun getStats(): Result<UserStats>

    // ── Notificaciones de staff ───────────────────────────────
    suspend fun sendNotification(
        subject: String,
        message: String,
        userId: Int? = null,
    ): Result<NotificationResult>
}