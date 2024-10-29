class CountDownProblemGenericSolver<T>{
  const CountDownProblemGenericSolver(this.binaryOperations);

  final Set<(String,T Function(T,T))> binaryOperations;

  
}