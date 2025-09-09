import 'rocket_launch.dart';

abstract class AbstractRocketLaunchRepository {
  Future<List<RocketLaunch>> getLaunchesByRocketId(String rocketId);
}