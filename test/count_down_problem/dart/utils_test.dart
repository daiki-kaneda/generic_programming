import 'package:collection/collection.dart';
import 'package:generic_programming/count_down_problem/dart/utils.dart';
import 'package:test/test.dart';

void main() {
  group(
      'Test start',
      () => {
            test('concat test', () {
              expect(
                  (concat<int>([
                    [1, 2],
                    [3],
                    [4]
                  ])),
                  [1, 2, 3, 4]);
            }),
            test('subs test', () {
              expect((subs<int>([1, 2])), [
                [],
                [2],
                [1],
                [1, 2]
              ]);
              expect((subs<String>(['a', 'b'])), [
                [],
                ['b'],
                ['a'],
                ['a', 'b']
              ]);
            }),
            test('interleaves test', () {
              expect((interleave<int>(1, [1, 2])), [
                [1, 1, 2],
                [1, 1, 2],
                [1, 2, 1]
              ]);
              expect(
                  (interleave<int>(0, [
                    1,
                    2,
                  ])),
                  [
                    [0, 1, 2],
                    [1, 0, 2],
                    [1, 2, 0]
                  ]);
            }),
            test('perms test', () {
              expect((perms<int>([1, 2, 3])), [
                [1, 2, 3],
                [2, 1, 3],
                [2, 3, 1],
                [1, 3, 2],
                [3, 1, 2],
                [3, 2, 1]
              ]);
            }),
            test('choices test', () {
              expect((choices<int>([1, 2, 3])), [
                [],
                [3],
                [2],
                [2, 3],
                [3, 2],
                [1],
                [1, 3],
                [3, 1],
                [1, 2],
                [2, 1],
                [1, 2, 3],
                [2, 1, 3],
                [2, 3, 1],
                [1, 3, 2],
                [3, 1, 2],
                [3, 2, 1]
              ]);
            }),
            test('split test', () {
              // expect(split([1,2,3]), [([1], [2,3]), ([1,2], [3])]);
              final actual = split([1,2,3]);
              final expected = [
                ([1], [2, 3]),
                ([1, 2], [3])
              ];
              expect(actual.toString(),expected.toString());
            })
          });
}
