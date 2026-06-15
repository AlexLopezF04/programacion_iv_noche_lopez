package com.shopapp.domain.model

data class Product(
    val id: Int,
    val name: String,
    val description: String,
    val price: Double,
    val priceWithTax: Double,
    val stock: Int,
    val inStock: Boolean,
    val isActive: Boolean,
    val imageUrl: String?,
    val categoryId: Int?,
    val categoryName: String?,
    val createdAt: String,
    val updatedAt: String,
)

data class ProductPayload(
    val name: String,
    val description: String,
    val price: Double,
    val stock: Int,
    val isActive: Boolean,
    val categoryId: Int,
    val imageBytes: ByteArray? = null,
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other !is ProductPayload) return false
        return name == other.name && description == other.description &&
               price == other.price && stock == other.stock &&
               isActive == other.isActive && categoryId == other.categoryId &&
               imageBytes.contentEquals(other.imageBytes)
    }
    override fun hashCode(): Int {
        var result = name.hashCode()
        result = 31 * result + description.hashCode()
        result = 31 * result + price.hashCode()
        result = 31 * result + stock.hashCode()
        result = 31 * result + isActive.hashCode()
        result = 31 * result + categoryId.hashCode()
        result = 31 * result + (imageBytes?.contentHashCode() ?: 0)
        return result
    }
}

data class ProductStats(
    val totalActive:   Int,
    val totalInactive: Int,
    val avgPrice:      Double,
    val maxPrice:      Double?,
    val minPrice:      Double?,
    val totalStock:    Int,
    val outOfStock:    Int,
)

data class ProductFilters(
    val search: String? = null,
    val category: Int? = null,
    val priceMin: Double? = null,
    val priceMax: Double? = null,
    val stockMin: Int? = null,
    val isActive: Boolean? = null,
    val ordering: String? = null,
    val page: Int = 1,
    val pageSize: Int = 12,
)