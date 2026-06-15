// data/remote/dto/PaginatedDto.kt
package com.shopapp.data.remote.dto

import com.google.gson.annotations.SerializedName

data class PaginatedDto<T>(
    // data/remote/dto/ProductDto.kt — fragmento (ya existe, verificar)
    @SerializedName("image_url") val imageUrl: String?,
    val count:    Int,
    val next:     String?,
    val previous: String?,
    val results:  List<T>,
)

