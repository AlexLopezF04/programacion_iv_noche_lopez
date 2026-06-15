// data/remote/api/ProductApi.kt
package com.shopapp.data.remote.api

import com.shopapp.data.remote.dto.*
import okhttp3.MultipartBody
import okhttp3.RequestBody
import retrofit2.Response
import retrofit2.http.*

interface ProductApi {
    @GET("products/")
    suspend fun getProducts(
        @QueryMap filters: Map<String, String>,
    ): Response<PaginatedDto<ProductDto>>

    @GET("products/{id}/")
    suspend fun getProduct(@Path("id") id: Int): Response<ProductDto>

    @GET("products/available/")
    suspend fun getAvailable(): Response<PaginatedDto<ProductDto>>

    @POST("products/")
    suspend fun createProduct(@Body body: ProductRequestDto): Response<ProductDto>

    @PATCH("products/{id}/")
    suspend fun updateProduct(
        @Path("id") id: Int,
        @Body body: ProductRequestDto,
    ): Response<ProductDto>

    @DELETE("products/{id}/")
    suspend fun deleteProduct(@Path("id") id: Int): Response<Unit>

    @POST("products/{id}/restock/")
    suspend fun restock(
        @Path("id") id: Int,
        @Body body: RestockRequestDto,
    ): Response<RestockResponseDto>

    @GET("products/stats/")
    suspend fun getStats(): Response<ProductStatsDto>

    // ── Multipart (con imagen) ─────────────────────────────────

    @Multipart
    @POST("products/")
    suspend fun createProductWithImage(
        @Part("name")        name:        RequestBody,
        @Part("description") description: RequestBody,
        @Part("price")       price:       RequestBody,
        @Part("stock")       stock:       RequestBody,
        @Part("is_active")   isActive:    RequestBody,
        @Part("category_id") categoryId:  RequestBody,
        @Part               image:       MultipartBody.Part,
    ): Response<ProductDto>

    @Multipart
    @PATCH("products/{id}/")
    suspend fun updateProductWithImage(
        @Path("id")          id:          Int,
        @Part("name")        name:        RequestBody,
        @Part("description") description: RequestBody,
        @Part("price")       price:       RequestBody,
        @Part("stock")       stock:       RequestBody,
        @Part("is_active")   isActive:    RequestBody,
        @Part("category_id") categoryId:  RequestBody,
        @Part               image:       MultipartBody.Part,
    ): Response<ProductDto>
}