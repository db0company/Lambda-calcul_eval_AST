(*						*)
(*	Made by		db0			*)
(*	Contact		db0company@gmail.com	*)
(*	Website		http://db0.fr		*)
(*						*)

(*	λx.x					*)
(*	=> Abs("x", Var x)			*)
(*	(λx.x)2					*)
(*	=> App(Abs("x", Var x), Const 2)	*)

type e =
  | Var		of string
  | Const	of int
  | App		of (e * e)
  | Abs		of (string * e)

type env = ((string * e) list)

type res =
  | Rconst	of int
  | Closure	of (string * e * env)
  | Error	of string

let rec getInEnv x = function
  | []			-> raise (Failure "Undefined identifier")
  | (str, exp)::rest	-> if str = x then exp else getInEnv x rest

let setInEnv env str e = (str, e)::env

let isVar = function
  | Var	v	-> true
  | _		-> false

let isClosure = function
  | Const c		-> true
  | Abs	(s, e)		-> true
  | _			-> false

let apply e1 e2 = match e1 with
  | Closure (str, e, env)	-> aux (setInEnv str e) e2
  | _				-> Error ("Expression is not a Closure, U MAD BRO, OH AND BTW... U JUST LOST IT *troll face*")

let eval_lambda e =
  let rec aux env = function
    | Const n		-> Rconst n
    | Var x		-> aux env ( getInEnv x env)
    | Abs (str, exp)	-> Closure (str, exp, env)
    | App (e1, e2)	-> apply (aux env e1) (aux env e2)
in aux [] e

let main () =
  let e = App (Abs ("x", "x"), Const 2) in
    eval_lambda e

let _ = main ()

