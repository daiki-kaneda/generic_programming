// リストのリストに対して、内部のリスト構造を解消して連結する関数concat
List<T> concat<T>(List<List<T>> lss){
  return [
    for(final ls in lss)
    ...ls
  ];
}

// リストの要素の順序を変えない部分リスト全体を返す
List<List<T>> subs<T>(List<T> ls){
  if(ls.isEmpty){
    return [[]];
  }else{
    final (x,xs)=(ls.first,ls.getRange(1, ls.length).toList());
    final yss = subs<T>(xs);
    return yss..addAll(yss.map((ys)=>[x,...ys]).toList());
  }
}

// 要素aとリストlsを受け取って、lsにaをひとつ挿入したリスト全体を返す関数
List<List<T>> interleave<T>(T t,List<T> ls){
  if(ls.isEmpty){
    return [[t]];
  }else{
    final (x,xs) = (ls.first,ls.getRange(1, ls.length).toList());
    return [
      [t,x,...xs],
      ...interleave(t, xs).map(
        (l)=>[x,...l]
      )
    ];
  }
}

// リストを受け取り、そのリストを空でない二つのリストに分割して組にしたもの全体を返す関数(順序は変えない)
List<(List<T>,List<T>)> split<T>(List<T> ls){
  if(ls.length<2){
    return [];
  }else{
    final (x,xs)=(ls.first,ls.getRange(1, ls.length).toList());
    return [
      ([x],xs),
      ...split(xs).map(
        (t)=>([x,...t.$1],t.$2)
      )
    ];
  }
}

// リストを受け取って、その要素を使った順列全体を返す。すなわち、要素を高々一つずつ選んだ組の順列全体を返す
List<List<T>> choices<T>(List<T> ls){
  return concat(subs(ls).map(
    (l)=>perms(l)
  ).toList());
}

// リストを受け取って、その要素の順列全体のリストを返す関数
List<List<T>> perms<T>(List<T> ls){
  if(ls.isEmpty){
    return [[]];
  }else{
    final (x,xs)=(ls.first,ls.getRange(1, ls.length).toList());
    return concat (perms(xs).map(
      (l)=>interleave(x, l)
    ).toList());
  }
}
