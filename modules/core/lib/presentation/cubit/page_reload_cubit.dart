import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_reload_state.dart';

class PageReloadCubit extends Cubit<PageReloadState> {
  PageReloadCubit() : super(const PageReloadState(false));

  void reload() => emit(const PageReloadState(true));

  void finish() => emit(const PageReloadState(false));
}
