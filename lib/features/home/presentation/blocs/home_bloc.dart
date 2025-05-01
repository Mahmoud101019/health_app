import 'package:bloc/bloc.dart';
import 'package:health_app/core/constants/assets.dart';
import '../../data/models/home_card.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      //  API Call  
      await Future.delayed(
        const Duration(seconds: 1),
      ); 

      final Map<String, Map<String, dynamic>> stats = {
        'Optimal': {'percentage': 48, 'count': 12},
        'At Risk': {'percentage': 24, 'count': 6},
        'Underperforming': {'percentage': 16, 'count': 4},
        'Recovering': {'percentage': 12, 'count': 3},
      };

      final List<HomeCard> cards = [
        HomeCard(
          image: AppAssets.tempImagePSbIHF,
          title: 'Handwashing Can Protect Your Health',
          subtitle: 'Why it matters and tips for how to do it well.',
        ),
        HomeCard(
          image: AppAssets.tempImage32JCyO,
          title: 'Common Concerns About Mental Health',
          subtitle:
              'Learn about common mental health conditions and what to pay attention to.',
        ),
        HomeCard(
          image: AppAssets.tempImageF9Hilt,
          title: 'Why Sleep Is So Important',
          subtitle: 'Learn about how sleep helps the body.',
        ),
        HomeCard(
          image: AppAssets.tempImageFTOVrI,
          title: 'Understanding Your Vitals',
          subtitle:
              'Certain metrics can give you a sense of how the body is doing.',
        ),
      ];

      emit(HomeLoaded(stats, cards));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
