import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit()
      : super(const BottomNavState(BottomNavItem.movie, 0, 'Movies'));

  void getBottomNavItem(BottomNavItem navItem) {
    switch (navItem) {
      case BottomNavItem.movie:
        emit(const BottomNavState(BottomNavItem.movie, 0, 'Movies'));
        break;
      case BottomNavItem.tvShow:
        emit(const BottomNavState(BottomNavItem.tvShow, 1, 'Tv Shows'));
        break;
      case BottomNavItem.collection:
        emit(const BottomNavState(BottomNavItem.collection, 2, 'Collection'));
        break;
    }
  }
}
