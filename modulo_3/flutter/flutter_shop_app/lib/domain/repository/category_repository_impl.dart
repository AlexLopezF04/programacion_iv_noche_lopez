import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/remote/api/category_remote_datasource.dart';
import '../model/category.dart';
import 'category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource _datasource;

  CategoryRepositoryImpl(this._datasource);

  @override
  Future<List<Category>> getCategories() => _datasource.getCategories();

  @override
  Future<Category> getCategory(int id) => _datasource.getCategory(id);

  @override
  Future<Category> createCategory(Map<String, dynamic> payload) =>
      _datasource.createCategory(payload);

  @override
  Future<Category> updateCategory(int id, Map<String, dynamic> payload) =>
      _datasource.updateCategory(id, payload);

  @override
  Future<void> deleteCategory(int id) => _datasource.deleteCategory(id);

  @override
  Future<Map<String, dynamic>> getStats() => _datasource.getStats();
}

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final datasource = ref.watch(categoryDatasourceProvider);
  return CategoryRepositoryImpl(datasource);
});
