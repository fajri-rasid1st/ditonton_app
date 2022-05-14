part of 'bottom_nav_cubit.dart';

enum BottomNavItem { movie, tvShow, collection }

class BottomNavState extends Equatable {
  final BottomNavItem navItem;
  final int index;
  final String title;

  const BottomNavState(this.navItem, this.index, this.title);

  @override
  List<Object> get props => [navItem, index, title];
}
