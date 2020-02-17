class Tuple<T1, T2> extends Tuple2<T1, T2> {
  Tuple(T1 value1, T2 value2) : super(value1, value2);
}

class Tuple1<T1> {
  final T1 value1;
  Tuple1(this.value1);
  bool operator(covariant Tuple1 t) => t.value1 == value1;
}

class Tuple2<T1, T2> extends Tuple1<T1> {
  final T2 value2;
  Tuple2(T1 value1, this.value2) : super(value1);
  bool operator(covariant Tuple2 t) => super == t && value2 == t.value2;
}

class Tuple3<T1, T2, T3> extends Tuple2<T1, T2> {
  final T3 value3;
  Tuple3(T1 value1, T2 value2, this.value3) : super(value1, value2);
  bool operator(covariant Tuple3 t) => super == t && value3 == t.value3;
}

class Tuple4<T1, T2, T3, T4> extends Tuple3<T1, T2, T3> {
  final T4 value4;
  Tuple4(T1 value1, T2 value2, T3 value3, this.value4)
      : super(value1, value2, value3);
  bool operator(covariant Tuple4 t) => super == t && value4 == t.value4;
}

class Tuple5<T1, T2, T3, T4, T5> extends Tuple4<T1, T2, T3, T4> {
  final T5 value5;
  Tuple5(T1 value1, T2 value2, T3 value3, T4 value4, this.value5)
      : super(value1, value2, value3, value4);
  bool operator(covariant Tuple5 t) => super == t && value5 == t.value5;
}
