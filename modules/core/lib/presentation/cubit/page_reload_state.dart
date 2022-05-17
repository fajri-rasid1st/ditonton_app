part of 'page_reload_cubit.dart';

class PageReloadState extends Equatable {
  final bool isPageReload;

  const PageReloadState(this.isPageReload);

  @override
  List<Object> get props => [isPageReload];
}
