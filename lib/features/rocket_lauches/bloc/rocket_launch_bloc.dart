import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rockets_app/repositories/rocket_launches/abstract_rocket_launch_repository.dart';
import 'package:rockets_app/repositories/rocket_launches/models/rocket_launch_model.dart';

part 'rocket_launch_event.dart';
part 'rocket_launch_state.dart';

class RocketLaunchBloc extends Bloc<RocketLaunchEvent, RocketLaunchState> {
  RocketLaunchBloc(this.rocketLaunchRepository) : super(RocketLaunchInitial()) {
    on<GetRocketLaunchesById>((event, emit) async {
      try {
        if (state is! RocketLaunchLoaded) {
          emit(RocketLaunchLoading());
        }
        final rocketLaunchList = await rocketLaunchRepository
            .getLaunchesByRocketId(event.rocketId);
        emit(RocketLaunchLoaded(launchList: rocketLaunchList));
      } catch (error) {
        emit(RocketLaunchLoadingError(error.toString()));
      }
    });
  }

  final AbstractRocketLaunchRepository rocketLaunchRepository;
}
