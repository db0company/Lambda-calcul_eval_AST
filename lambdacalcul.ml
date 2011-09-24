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

let eval_lambda e =
  let rec aux env = function
    | Const n		-> Rconst n
    | Var x		-> aux env ( get x env)
    | Abs (str, exp)	-> Closure (str, exp, env)
    | App (e1, e2)	-> Error ("Pas fini")
  in aux [] e

let main () =
  let x = 42 in
  let e = App (Abs ("x", Var x), Const 2) in
    eval_lambda e

let _ = main ()

