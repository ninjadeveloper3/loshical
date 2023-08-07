import 'package:hooks_riverpod/hooks_riverpod.dart';

final resultProvider =
    StateProvider<ResultState>((ref) => ResultState(false, 0));

class ResultState {
  final bool isCorrect;
  final int answerId;

  ResultState(this.isCorrect, this.answerId);
}
