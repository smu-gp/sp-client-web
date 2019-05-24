import 'package:sp_client/model/history.dart';
import 'package:sp_client/repository/repository.dart';

class RemoteHistoryRepository implements HistoryRepository {
  RemoteHistoryRepository();

  @override
  Future<History> create(History newData) async {
    return null;
  }

  @override
  Future<History> readById(int id) async {
    return null;
  }

  @override
  Future<List<History>> readAll(
      {String sortColumn, bool sortAscending = true}) async {
    return [];
  }

  @override
  Future<bool> update(History history) async {
    return false;
  }

  @override
  Future<bool> delete(int id) async {
    return false;
  }
}
