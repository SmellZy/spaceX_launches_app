// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:rockets_app/repositories/rocket_launches/models/rocket_launch_model.dart';
import 'package:rockets_app/repositories/rocket_launches/rocket_launch.dart';

class RocketLaunchesRepository implements AbstractRocketLaunchRepository {
  final Dio dio;
  RocketLaunchesRepository({
    required this.dio,
  });

  @override
  Future<List<RocketLaunch>> getLaunchesByRocketId(String rocketId) async {
  final res = await dio.get('https://api.spacexdata.com/v3/launches', queryParameters: {
    'rocket_id': rocketId,
  });
  final list = (res.data as List).cast<Map<String, dynamic>>();
  return list.map((j) => RocketLaunch.fromJson(j)).toList();
  }
}

