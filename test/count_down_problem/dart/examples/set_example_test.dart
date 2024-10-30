import 'package:built_collection/built_collection.dart';
import 'package:generic_programming/count_down_problem/dart/examples/set_example.dart';
import 'package:generic_programming/count_down_problem/dart/models.dart';
import 'package:test/test.dart';

void main(){
  group('set_example test start', (){
    final solver = CountDownProblemSetSolver<int>();
    
    final add = solver.op('+');
    final mul = solver.op('*');
    final sd = solver.op('^');

    final set1 = {1,2,3,4}.toBuiltSet();
    final set2 = {2,5,7}.toBuiltSet();
    final set3 = {1,7}.toBuiltSet();
    final set4 = {11}.toBuiltSet();

    test('equality test', (){
      expect({1,2}=={1,2}, false);
      expect({1,2}.toBuiltSet()=={1,2}.toBuiltSet(), true);
    });

    test('solutions test', (){
      expect(solver.solutions([
        set1,set2,set3,set4
      ], {1,2,11}.toBuiltSet()), [
        App(add, Value(set4), App(mul, Value(set1), App(add, Value(set2), Value(set3)))),
        App(add, Value(set4), App(mul,App(sd, Value(set2), Value(set3)),Value(set1)))
      ]);
    });
  });
}