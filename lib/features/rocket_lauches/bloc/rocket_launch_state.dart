part of 'rocket_launch_bloc.dart';

@immutable
sealed class RocketLaunchState {}

final class RocketLaunchInitial extends RocketLaunchState {}

final class RocketLaunchLoading extends RocketLaunchState {}

final class RocketLaunchLoaded extends RocketLaunchState {
  RocketLaunchLoaded({required this.launchList});

  final List<RocketLaunch> launchList;
}

final class RocketLaunchLoadingError extends RocketLaunchState {
  RocketLaunchLoadingError(this.error);
  final String error;
}
