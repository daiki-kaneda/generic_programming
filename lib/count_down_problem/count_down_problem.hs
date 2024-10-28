module Solutions where
  
import Data.List (nub, sort)
  
-- 演算子の型の定義
data Op = Add|Sub|Mul|Div|Pow
-- 演算子を適用したときに、有効な値を返すかどうかを確かめる関数valid
-- validの定義において、代数の性質を活かして、加法の交換法則、乗法の交換法則、単位元の存在に注目して効率化する
valid :: Op->Integer->Integer->Bool;
valid Add x y = x>=y;
valid Sub x y = x>y;
valid Mul x y = x>=y && (x/=1&&y/=1);
valid Div x y = x `mod` y == 0 && y/=1
valid Pow x y = x/=1&&y/=1
-- 演算子を適用して、期待通りの結果を得るための関数apply
apply :: Op->Integer->Integer->Integer;
apply Add x y = x+y;
apply Sub x y = x-y;
apply Mul x y = x*y;
apply Div x y = x`div`y
apply Pow x y = x^y

-- 数式の型の定義(数式は自然数か演算子が施された二つの数式の形）
data Expr = Val Integer | App Op Expr Expr
-- 式の中の自然数をリストにして返す関数valuesと式全体の値(高々一つの自然数を含むリスト）を返す関数evalを定義する
values :: Expr -> [Integer];
values (Val n) = [n];
values (App _ s t) = values s ++ values t

eval :: Expr -> [Integer];
eval (Val n) = [n|n>0];
eval (App r s t) = [apply r x y|x<-(eval s),y<-(eval t),valid r x y]

-- 役に立つリストについての関数の定義
-- subs::リストの部分リストを返す,interleave::ある要素をリストに挿入して返す,perms::リストの要素に対する順列を返す
subs :: [a]->[[a]]
subs [] = [[]]
subs (x:xs) = yss ++ (map (x:) yss) where yss = subs xs

interleave :: a->[a]->[[a]]
interleave x [] = [[x]]
interleave x (y:ys) = (x:y:ys) : map (y:) (interleave x ys)

perms :: [a]->[[a]]
perms [] = [[]]
perms (x:xs) = concat (map (interleave x) (perms xs))

-- リストを受け取って、選択肢全てを返す(任意の部分リストをとって、その順列全体を求め、それらを連結したものを返す）関数choiceの定義
choices :: [a]->[[a]]
choices l = concat (map perms (subs l))

-- 数式、自然数のリスト、目標の値を受け取って、その数式に使われている自然数が自然数のリストから取られたもので、数式の値が目標の値に等しいかを確かめる関数solution
-- solutionは切手番号遊びの解の最終チェックに使われるだろう
solution :: Expr->[Integer]->Integer->Bool
solution e xs n = elem (values e) (choices xs) && eval e == [n]

-- リストを受け取り、そのリストを空でない二つのリストに分割して組にしたもの全体を返す関数splitの定義(順序を変えずに)
split :: [a] -> [([a],[a])]
split [] =[]
split [_] =[]
split (x:xs) = ([x],xs):[((x:ls),rs)|(ls,rs)<-split xs]

-- 自然数のリストを受け取って、そのうちの数値を一つずつ使って（順序を変えずに）できる数式全体を返す関数exprs(重要）の定義

-- 準備

{-ops :: [Op]
ops = [Add,Sub,Mul,Div]
combine :: Expr->Expr->[Expr]
combine s t = [App o s t|o<-ops]

exprs :: [Int]->[Expr]
exprs [] = []
exprs [n] = [Val n]
exprs ns = [e|(ls,rs)<-split ns,s<-exprs ls,t<-exprs rs,e<-combine s t]
-}

{-
solutions :: [Int]->Int->[Expr]
solutions ns n =[e|ns'<-choices ns,e<-exprs ns',solution e ns' n]
-}
-- 結構時間がかかっているので効率化を考えよう。効率化のアイデアとしては、関数exprsで余分に計算してしまっている数式を少なくすること、具体的には、関数combineの中にvalid関数を入れ込む。ただここで、valid関数はOp->Int->Int->Boolなので、数式とその結果をまとめて扱うようにしたい。そこで次の型Resultを定義する

type Result = (Expr,Integer)
-- 改良版
ops :: [Op]
ops = [Add,Sub,Mul,Div]
combine' :: Result->Result->[Result]
combine' (l,x) (r,y) = [(App o l r,apply o x y)|o<-ops,valid o x y]

-- exprsの改良版
results :: [Integer]->[Result]
results [] = []
results [n] = [(Val n,n)|n>0]
results ns = [res|(ls,rs)<-(split ns),lx<-(results ls),ry<-(results rs),res<-combine' lx ry]

-- solutionの改良版
solutions' :: [Integer]->Integer->[Expr]
solutions' ns n = [e|ns'<-choices ns,(e,m)<-results ns',n==m]

