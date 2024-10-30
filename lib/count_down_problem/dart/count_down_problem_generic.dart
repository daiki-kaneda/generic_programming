import 'package:generic_programming/count_down_problem/dart/models.dart';
import 'package:generic_programming/count_down_problem/dart/utils.dart';

class CountDownProblemGenericSolver<T> {
  const CountDownProblemGenericSolver(this.ops);

  final Set<Op<T>> ops;

  // using Result and valid instead of Expr for efficiency
  // utility
  // 左右のResult（式とその値の組）の間に演算子を入れた有効なResult全体を返す
  List<Result<T>> combine(Result<T> l, Result<T> r) {
    return ops
        .map((op) {
          if (op.valid(l.$2, r.$2)) {
            final expr = App<T>(op, l.$1, r.$1);
            return (expr, expr.eval());
          } else {
            return null;
          }
        })
        .whereType<Result<T>>()
        .toList();
  }
  // 受け取ったT型のリストの要素を（順序を変えずに)使って、できるResult(式と値の組)全体を返す
  List<Result<T>> results(List<T> list) {
    if(list.isEmpty){
      return [];
    }else if (list.length==1){
      final value = list.first;
      return [(Value<T>(value),value)];
    }else{
      return [
      for(final (ls,rs) in split(list))
      for(final le in results(ls))
      for(final re in results(rs))
      ...combine(le, re)
    ];
    }
  }

  List<Expr<T>> solutions(List<T> xs,T x){
    return [
      for(final ys in choices(xs))
      for(final r in results(ys))
      if(r.$2==x)
      r.$1
    ];
  }
}
