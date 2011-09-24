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
    Var		of string
  | Const	of int
  | App		of (e * e)
  | Abs		of (string * e)

type env =
    ((string * e) list)

let main () =
  begin
    print_endline "Comment ça marche OCaml, déjà ?"
  end

let _ = main ()

