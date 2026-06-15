// data/repository/ProductRepositoryImpl.kt
package com.shopapp.data.repository

import com.shopapp.data.remote.api.ProductApi
import com.shopapp.data.remote.dto.RestockRequestDto
import com.shopapp.data.remote.dto.toDomain
import com.shopapp.data.remote.dto.toRequest
import com.shopapp.domain.model.Product
import com.shopapp.domain.model.ProductFilters
import com.shopapp.domain.model.ProductPayload
import com.shopapp.domain.model.ProductStats
import com.shopapp.domain.repository.ProductRepository
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.toRequestBody
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ProductRepositoryImpl @Inject constructor(
    private val api: ProductApi,
) : ProductRepository {

    override suspend fun getProducts(filters: ProductFilters): Result<Pair<List<Product>, Int>> =
        runCatching {
            val params = buildMap<String, String> {
                filters.search?.let   { put("search",    it) }
                filters.category?.let { put("category",  it.toString()) }
                filters.priceMin?.let { put("price_min", it.toString()) }
                filters.priceMax?.let { put("price_max", it.toString()) }
                filters.stockMin?.let { put("stock_min", it.toString()) }
                filters.isActive?.let { put("is_active", it.toString()) }
                filters.ordering?.let { put("ordering",  it) }
                put("page",      filters.page.toString())
                put("page_size", filters.pageSize.toString())
            }
            val response = api.getProducts(params)
            if (response.isSuccessful) {
                val body = response.body()!!
                Pair(body.results.map { it.toDomain() }, body.count)
            } else error("Error ${response.code()}")
        }

    override suspend fun getProduct(id: Int): Result<Product> = runCatching {
        val response = api.getProduct(id)
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}")
    }

    override suspend fun createProduct(payload: ProductPayload): Result<Product> = runCatching {
        val bytes = payload.imageBytes
        if (bytes != null) {
            val imagePart = MultipartBody.Part.createFormData(
                "image", "photo.jpg", bytes.toRequestBody("image/*".toMediaTypeOrNull()),
            )
            val response = api.createProductWithImage(
                name        = payload.name.toRequestBody("text/plain".toMediaTypeOrNull()),
                description = payload.description.toRequestBody("text/plain".toMediaTypeOrNull()),
                price       = payload.price.toString().toRequestBody("text/plain".toMediaTypeOrNull()),
                stock       = payload.stock.toString().toRequestBody("text/plain".toMediaTypeOrNull()),
                isActive    = payload.isActive.toString().toRequestBody("text/plain".toMediaTypeOrNull()),
                categoryId  = payload.categoryId.toString().toRequestBody("text/plain".toMediaTypeOrNull()),
                image       = imagePart,
            )
            if (response.isSuccessful) response.body()!!.toDomain()
            else error("Error ${response.code()}: ${response.errorBody()?.string()}")
        } else {
            val response = api.createProduct(payload.toRequest())
            if (response.isSuccessful) response.body()!!.toDomain()
            else error("Error ${response.code()}: ${response.errorBody()?.string()}")
        }
    }

    override suspend fun updateProduct(id: Int, payload: ProductPayload): Result<Product> =
        runCatching {
            val bytes = payload.imageBytes
            if (bytes != null) {
                val imagePart = MultipartBody.Part.createFormData(
                    "image", "photo.jpg", bytes.toRequestBody("image/*".toMediaTypeOrNull()),
                )
                val response = api.updateProductWithImage(
                    id          = id,
                    name        = payload.name.toRequestBody("text/plain".toMediaTypeOrNull()),
                    description = payload.description.toRequestBody("text/plain".toMediaTypeOrNull()),
                    price       = payload.price.toString().toRequestBody("text/plain".toMediaTypeOrNull()),
                    stock       = payload.stock.toString().toRequestBody("text/plain".toMediaTypeOrNull()),
                    isActive    = payload.isActive.toString().toRequestBody("text/plain".toMediaTypeOrNull()),
                    categoryId  = payload.categoryId.toString().toRequestBody("text/plain".toMediaTypeOrNull()),
                    image       = imagePart,
                )
                if (response.isSuccessful) response.body()!!.toDomain()
                else error("Error ${response.code()}: ${response.errorBody()?.string()}")
            } else {
                val response = api.updateProduct(id, payload.toRequest())
                if (response.isSuccessful) response.body()!!.toDomain()
                else error("Error ${response.code()}: ${response.errorBody()?.string()}")
            }
        }

    override suspend fun deleteProduct(id: Int): Result<Unit> = runCatching {
        val response = api.deleteProduct(id)
        if (!response.isSuccessful) error("Error ${response.code()}")
    }

    override suspend fun restock(id: Int, quantity: Int): Result<Int> = runCatching {
        val response = api.restock(id, RestockRequestDto(quantity))
        if (response.isSuccessful) response.body()!!.newStock
        else error("Error ${response.code()}")
    }

    override suspend fun getStats(): Result<ProductStats> = runCatching {
        val response = api.getStats()
        if (response.isSuccessful) {
            val s = response.body()!!
            ProductStats(
                totalActive   = s.totalActive,
                totalInactive = s.totalInactive,
                avgPrice      = s.avgPrice ?: 0.0,
                maxPrice      = s.maxPrice,
                minPrice      = s.minPrice,
                totalStock    = s.totalStock ?: 0,
                outOfStock    = s.outOfStock,
            )
        } else error("Error ${response.code()}")
    }
}