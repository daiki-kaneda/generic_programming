import 'package:generic_programming/count_down_problem/dart/examples/set_example.dart';
import 'package:test/test.dart';

void main(){
  group('set_example test start', (){
    final solver = CountDownProblemSetSolver<int>();

    final set1 = {1,2,3,4};
    final set2 = {2,5,7};
    final set3 = {1,7};
    final set4 = {11};
    test('solutions test', (){
      expect(solver.solutions([
        set1,set2,set3,set4
      ], {7,11}), []);
    });
  });
}