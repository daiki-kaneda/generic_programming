import 'package:generic_programming/count_down_problem/dart/count_down_problem_generic.dart';
import 'package:generic_programming/count_down_problem/dart/models.dart';

class CountDownProblemSetSolver<T>
    extends CountDownProblemGenericSolver<Set<T>> {
  CountDownProblemSetSolver()
      : super({
          Op<Set<T>>('+', (s1, s2) => s1.union(s2),(s1,s2)=>s1.isNotEmpty && s2.isNotEmpty && s1!=s2), // 集合の和
          Op<Set<T>>('\\', (s1, s2) => s1.difference(s2),(s1,s2)=>s2.isNotEmpty), // 集合の差
          Op<Set<T>>('*', (s1, s2) => s1.intersection(s2),(s1,s2)=>s1!=s2), //　集合の積
          Op<Set<T>>(
              '^',
              (s1, s2) =>
                  s1.union(s2).difference(s1.intersection(s2)),(s1,s2)=>s1.isNotEmpty && s2.isNotEmpty && s1!=s2 && s1.intersection(s2).isNotEmpty), // 集合の対称差
        });
}
