import 'package:built_collection/built_collection.dart';
import 'package:generic_programming/count_down_problem/dart/examples/modular_example.dart';
import 'package:generic_programming/count_down_problem/dart/examples/set_example.dart';
import 'package:generic_programming/count_down_problem/dart/models.dart';
import 'package:test/test.dart';

void main(){
  group('modulo_example test start', (){
    final solver = CountDownProblemModuloSolver();
    
    final add = solver.op('+');
    final sub = solver.op('-');
    final mul = solver.op('*');

    const modulus = 11;
    const n1 = ModuloInt(5, modulus);
    const n2 = ModuloInt(2, modulus);
    const n3 = ModuloInt(8, modulus);
    const n4 = ModuloInt(1, modulus);
    test('equality test', (){
      expect(n1==const ModuloInt(16, modulus), true);
    });

    test('solutions test', (){
      expect(solver.solutions([n1,n2,n4], const ModuloInt(0, modulus)),[
        App(add,App(mul, const Value(ModuloInt(5, modulus)), const Value(ModuloInt(2, modulus))),const Value(ModuloInt(1, modulus))),
      ]);
    });
  });
}