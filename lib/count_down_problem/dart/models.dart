import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:generic_programming/count_down_problem/dart/utils.dart';

typedef Result<T> = (Expr<T>, T);

class Op<T> {
  Op(this.name, this.apply, [this.valid = _defaultValid]);
  final String name;
  final T Function(T, T) apply;
  final bool Function(T, T) valid;

  static bool _defaultValid(_, __) {
    return true;
  }

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    return other is Op<T> && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

sealed class Expr<T> {
  const Expr();

  //static final exprTypeError = UnsupportedError('Expr must be Value or App');

  List<T> values() {
    switch (this) {
      case Value<T>():
        return [(this as Value<T>).value];
      case App<T>():
        {
          final app = this as App<T>;
          return app.l.values() + app.r.values();
        }
    }
  }

  T eval() {
    switch (this) {
      case Value<T>():
        return (this as Value<T>).value;
      case App<T>():
        {
          final app = this as App<T>;
          return app.op.apply(app.l.eval(), app.r.eval());
        }
    }
  }

  bool solution(List<T> ts, t) {
    return choices(ts)
            .where((l) => (const ListEquality()).equals(l, values()))
            .isNotEmpty &&
        eval() == t;
  }

  @override
  String toString() {
    switch (this) {
      case Value<T>():
        return (this as Value).value.toString();
      case App<T>():
        {
          final app = this as App<T>;
          final isLValue = app.l is Value;
          final isRValue = app.r is Value;
          final leftParenthesisOfL = isLValue ? '' : '(';
          final rightParenthesisOfL = isLValue ? '' : ')';
          final leftParenthesisOfR = isRValue ? '' : '(';
          final rightParenthesisOfR = isRValue ? '' : ')';

          return leftParenthesisOfL +
              app.l.toString() +
              rightParenthesisOfL +
              app.op.toString() +
              leftParenthesisOfR +
              app.r.toString() +
              rightParenthesisOfR;
        }
    }
  }
}

class Value<T> extends Expr<T> {
  const Value(this.value);
  final T value;

  @override
  bool operator ==(Object other) {
    return other is Value<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

class App<T> extends Expr<T> {
  const App(this.op, this.l, this.r);

  final Op<T> op;
  final Expr<T> l;
  final Expr<T> r;

  @override
  bool operator ==(Object other) {
    return other is App<T> && other.op == op && other.l == l && other.r == r;
  }

  @override
  int get hashCode => op.hashCode & l.hashCode & r.hashCode;
}
