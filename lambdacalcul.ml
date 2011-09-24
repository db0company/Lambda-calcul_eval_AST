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

type env =
    ((string * e) list)

type res =
  | Rconst	of int
  | Closure	of (string * e * env)
  | Error	of string


let rec getInEnv x = function
  | []			-> raise (Failure "Undefined identifier")
  | (str, exp)::rest	-> raise (Failure "Undefined identifier")
(*      begin
	if str = x
	then
	  exp
	else
	  getInEnv x rest
      end*)

let setInEnv env str e =
  (str, e)::env

(*let eval_lambda e = 42
  let rec aux env = function
    | Const n		-> Rconst n
    | Var x		-> aux env ( get x env)
    | Abs (str, exp)	-> Closure (str, exp, env)
    | App (e1, e2)	-> Error ("Pas fini")
  in aux [] e*)

(*let main () =
  begin
    let x = 42;
    let e = App (Abs ("x", Var x), Const 2);
    eval_lambda e
  end*)
(*let _ = main ()*)

