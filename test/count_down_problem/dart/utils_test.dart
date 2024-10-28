import 'package:generic_programming/count_down_problem/dart/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Test start', () => {
    test('subs test', (){
      expect((subs<int>([1,2])), {[],[1],[2],[1,2]});
      expect((subs<String>(['a','b'])),{[],['a'],['b'],['a','b']});
      expect((subs<int>([1,1,2])), {[],[1],[1],[2],[1,1],[1,2],[1,2],[1,1,2]});
    })
  });
}
