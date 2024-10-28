// リストの要素の順序を変えない部分リスト全体を返す
Set<List<T>> subs<T>(List<T> ls){
  if(ls.isEmpty){
    return {[]};
  }else{
    final (x,xs)=(ls.first,ls.getRange(1, ls.length).toList());
    final yss = subs<T>(xs);
    return yss.union(yss.map((ys)=>[x,...ys]).toSet());
  }
}

// 要素aとリストlsを受け取って、lsにaをひとつ挿入したリスト全体を返す関数

// -- 役に立つリストについての関数の定義
// -- subs::リストの部分リストを返す,interleave::ある要素をリストに挿入して返す,perms::リストの要素に対する順列を返す
// subs :: [a]->[[a]]
// subs [] = [[]]
// subs (x:xs) = yss ++ (map (x:) yss) where yss = subs xs

// interleave :: a->[a]->[[a]]
// interleave x [] = [[x]]
// interleave x (y:ys) = (x:y:ys) : map (y:) (interleave x ys)

// perms :: [a]->[[a]]
// perms [] = [[]]
// perms (x:xs) = concat (map (interleave x) (perms xs))

// -- リストを受け取って、選択肢全てを返す(任意の部分リストをとって、その順列全体を求め、それらを連結したものを返す）関数choiceの定義
// choices :: [a]->[[a]]
// choices l = concat (map perms (subs l))



// -- リストを受け取り、そのリストを空でない二つのリストに分割して組にしたもの全体を返す関数splitの定義(順序を変えずに)
// split :: [a] -> [([a],[a])]
// split [] =[]
// split [_] =[]
// split (x:xs) = ([x],xs):[((x:ls),rs)|(ls,rs)<-split xs]