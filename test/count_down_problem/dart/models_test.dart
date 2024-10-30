import 'package:generic_programming/count_down_problem/dart/models.dart';
import 'package:generic_programming/count_down_problem/dart/utils.dart';
import 'package:test/test.dart';

void main(){
  group('models_test.dart Test start', (){
    final add = Op<int>('+',(m,n)=>m+n,);
    final sub = Op<int>('-',(m,n)=>m-n);
    final mul = Op<int>('*', (m,n)=>m*n);
    final div = Op<int>('/', (m,n)=>m~/n,(_,n)=>n!=0);

    final expr = App<int>(
      mul, 
      App(add, const Value<int>(5), const Value<int>(5)),
      App(sub, const Value<int>(8), const Value<int>(2)));

    final expr2 = App<int>(
      mul, 
      App(add, const Value<int>(5), const Value<int>(5)),
      App(sub, const Value<int>(8), const Value<int>(2)));

    final expr3 = App<int>(
      mul, 
      App(add, const Value<int>(4), const Value<int>(2)),
      App(div, const Value<int>(8), const Value<int>(2)));

    print('expr:$expr');

    test('equality test', (){
      expect(expr==expr2, true);
    });
    test('values test', (){
      expect(expr.values(), [5,5,8,2]);
    });
    test('eval test', (){
      expect(expr.eval(), 60);
    });

    test('solution test', (){
      const choices = [5,2,5,9,8];
      expect(expr.solution(choices, 60), true);
      expect(expr.solution([5,2,9,8], 60), false);
    });
  });
}