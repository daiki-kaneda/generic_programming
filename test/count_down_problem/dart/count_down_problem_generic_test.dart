import 'package:generic_programming/count_down_problem/dart/count_down_problem_generic.dart';
import 'package:generic_programming/count_down_problem/dart/models.dart';
import 'package:test/test.dart';

void main() {
  group('count_down_problem_generic Test start', () {
    final add = Op<int>('+', (m, n) => m + n, (m, n) => m >= n);
    final mul = Op<int>('*', (m, n) => m * n, (m, n) => m >= n);

    final solver = CountDownProblemGenericSolver<int>({
      add,
      mul,
    });
    test('combine test', () {
      expect(
          solver.combine((
            const Value(2),
            2
          ), (
            App(solver.ops.first, const Value(3), const Value(4)),
            2
          )).toString(),
          [
            (
              App(add, const Value(2),
                  App(solver.ops.first, const Value(3), const Value(4))),
              9
            ),
            (
              App(mul, const Value(2),
                  App(solver.ops.first, const Value(3), const Value(4))),
              -5
            ),
          ].toString());
    });

    test('results test', () {
      expect(
          solver.results([1, 2, 3]).toString(),
          [
            (
              App(add, const Value(1),
                  App(add, const Value(2), const Value(3))),
              6
            ),
            (
              App(mul, const Value(1),
                  App(add, const Value(2), const Value(3))),
              5
            ),
            (
              App(add, const Value(1),
                  App(mul, const Value(2), const Value(3))),
              7
            ),
            (
              App(mul, const Value(1),
                  App(mul, const Value(2), const Value(3))),
              6
            ),
            (
              App(add, App(add, const Value(1), const Value(2)),
                  const Value(3)),
              6
            ),
            (
              App(mul, App(add, const Value(1), const Value(2)),
                  const Value(3)),
              9
            ),
            (
              App(add, App(mul, const Value(1), const Value(2)),
                  const Value(3)),
              5
            ),
            (
              App(mul, App(mul, const Value(1), const Value(2)),
                  const Value(3)),
              6
            )
          ].toString());
    });

    test('solutions test', () {
      expect(solver.solutions([2, 3], 6), [
        App(mul, const Value(3), const Value(2))
      ]);
    });

    test('solutions test2', () {
      expect(solver.solutions([1,2], 1), [
       const Value(1)
      ]);
    });

    test('solutions test3', () {
      expect(solver.solutions([1,2,3], 7), [
       App(add, App(mul, const Value(3), const Value(2)), const Value(1))
      ]);
    });

  });
}
