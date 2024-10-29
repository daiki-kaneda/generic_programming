typedef Op = String;

abstract class Expr<T>{
  const Expr();
}

class Value<T> extends Expr<T>{
  const Value(this.value);
  final T value;
}

class App<T> extends Expr<T>{
  const App(this.op,this.l,this.r);
  
  final Op op;
  final Expr<T> l;
  final Expr<T> r;
}