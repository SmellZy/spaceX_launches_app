import 'package:dio/dio.dart';
import 'package:rockets_app/repositories/rocket_launches/models/rocket_launch_model.dart';

class RocketLaunchesRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.spacexdata.com'));

  Future<List<RocketLaunch>> getLaunches() async {
    final res = await _dio.get('/v3/launches');
    final list = (res.data as List).cast<Map<String, dynamic>>();
    return list.map((j) => RocketLaunch.fromJson(j)).toList();
  }
}
