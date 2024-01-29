import 'package:bloc/bloc.dart';
import 'package:fl_news/src/domain/model/article.dart';
import 'package:fl_news/src/domain/usecases/get_top_headlines.dart';
import 'package:injectable/injectable.dart';

import '../ui_state.dart';



class ErrorState<T> implements UiState<T> {
  final String? message;

  ErrorState(this.message);
}

@injectable
class NewsCubit extends Cubit<UiState<List<Article>>> {
  NewsCubit(this._getTopHeadlines) : super(InitialState());

  final GetTopHeadlines _getTopHeadlines;

  Future<void> fetchTopHeadlines(String? country) async {
    if (country == null || country.isEmpty) return;

    emit(LoadingState());

    final result = await _getTopHeadlines.execute(country);

    return result.fold(
      (l) {
        emit(ErrorState(l.toString()));
      },
      (r) {
        emit(SuccessState<List<Article>>(r));
      },
    );
  }
}
