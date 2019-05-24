import 'package:sp_client/model/result.dart';
import 'package:sp_client/repository/repository.dart';

class RemoteResultRepository implements ResultRepository {
  @override
  Future<Result> create(Result newData) async {
    return null;
  }

  @override
  Future<Result> readById(int id) async {
    return null;
  }

  @override
  Future<List<Result>> readByHistoryId(int historyId) async {
    return [];
  }

  @override
  Future<int> deleteByHistoryId(int historyId) async {
    return 0;
  }

  @override
  Future<bool> delete(int id) async {
    return false;
  }
}
