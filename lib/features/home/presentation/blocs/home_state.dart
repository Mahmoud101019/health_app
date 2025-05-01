import '../../data/models/home_card.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Map<String, Map<String, dynamic>> stats;
  final List<HomeCard> cards;

  HomeLoaded(this.stats, this.cards);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}