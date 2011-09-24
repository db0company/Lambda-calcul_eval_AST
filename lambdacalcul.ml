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

(* let isVar = function *)
(*   | Var	v	-> true *)
(*   | _		-> false *)

(* let isClosure = function *)
(*   | Const c		-> true *)
(*   | Abs	(s, e)		-> true *)
(*   | _			-> false *)

let dec = function
  | Closure (str, e, env)	-> e
  | Rconst r			-> Const r
  | _				-> raise (Failure "tata foobar toto test bite")

let rec apply res1 res2 env = match res1 with
  | Closure (str, e, env)	-> eval_lambda (setInEnv env str (dec res2)) e
  | _				-> Error ("Expression is not a Closure, U MAD BRO, OH AND BTW... U JUST LOST IT *troll face*")

and eval_lambda env = function
  | Const n		-> Rconst n
  | Var x		-> eval_lambda env (getInEnv x env)
  | Abs (str, exp)	-> Closure (str, exp, env)
  | App (e1, e2)	-> apply
      (eval_lambda env e1)
	(eval_lambda env e2) env

let main () =
  let e = App (Abs ("x", Var "x"), Const 2) in
      let resultat = eval_lambda [] e in
	match resultat with
	  | Rconst n	-> print_int n
	  | Closure c	-> print_endline "closure"
	  | Error err	-> print_endline err

let _ = main ()

