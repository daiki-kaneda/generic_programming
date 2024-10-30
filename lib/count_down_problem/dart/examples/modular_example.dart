import 'package:generic_programming/count_down_problem/dart/count_down_problem_generic.dart';
import 'package:generic_programming/count_down_problem/dart/models.dart';

class ModuloInt{
  const ModuloInt(this.value,this.modulus);
  final int value;
  final int modulus;

  int get rep=>value % modulus;

  bool valid(ModuloInt other){
    return modulus==other.modulus;
  }

  ModuloInt operator +(ModuloInt other){
    if(!valid(other))throw UnsupportedError('must be same modulus');
    return ModuloInt(value+other.value, modulus);
  }

  ModuloInt operator -(ModuloInt other){
    if(!valid(other))throw UnsupportedError('must be same modulus');
    return ModuloInt(value-other.value, modulus);
  }

  ModuloInt operator *(ModuloInt other){
    if(!valid(other))throw UnsupportedError('must be same modulus');
    return ModuloInt(value*other.value, modulus);
  }

  @override
  int get hashCode => rep.hashCode;

  @override
  bool operator ==(Object other) {
    return other is ModuloInt && rep==other.rep && modulus==other.modulus;
  }

  @override
  String toString() => '[$rep]';
}

class CountDownProblemModuloSolver extends CountDownProblemGenericSolver<ModuloInt>{
  CountDownProblemModuloSolver():super({
    Op('+',(m,n)=>m+n,(m,n)=>m.value>=n.value&&m.rep!=0&&n.rep!=0),
    Op('-',(m,n)=>m-n,(m,n)=>n.rep!=0),
    Op('*',(m,n)=>m*n,(m,n)=>m.value>=n.value&&m.rep!=1&&n.rep!=1),
  });
}