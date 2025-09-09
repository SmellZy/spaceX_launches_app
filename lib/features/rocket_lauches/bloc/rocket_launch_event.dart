part of 'rocket_launch_bloc.dart';

@immutable
sealed class RocketLaunchEvent {}

final class GetRocketLaunchesById extends RocketLaunchEvent {
  GetRocketLaunchesById(this.rocketId);

  final String rocketId;
}
