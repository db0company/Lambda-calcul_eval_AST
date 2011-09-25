(*									     *)
(*	Filename	lambdacalcul.ml					     *)
(*	Project		Lambda-calcul_eval_AST				     *)
(*	Authors		Idriss Moutawakil, Noëlie Sylvain, Barbara Lepage    *)
(*									     *)

(*	Lambda-calcul_eval_AST is a λ-calcul interpretor.		     *)


(*									     *)
(* ## Types								     *)
(*									     *)

type e =				(* ## Expression :		     *)
  | Var		of string		(* Identifier (value)		     *)
  | Const	of int			(* Constant number		     *)
  | App		of (e * e)		(* Application of a function	     *)
  | Abs		of (string * e)		(* Abstraction (function declaration)*)

type env = ((string * e) list)		(* ## Environment :		     *)
					(* list of identifier + expression   *)

type res =				(* ## Result of an eval		     *)
  | Rconst	of int			(* Constant number		     *)
  | Closure	of (string * e * env)	(* Closure (identifier, expression   *)
					(*          and current environment) *)
  | Error	of string		(* Error string			     *)


(*									     *)
(* ## Environment tools : get and set					     *)
(*									     *)

(* val getInEnv : string -> env -> e					     *)
let rec getInEnv x = function
  | []			-> raise (Failure "Undefined identifier")
  | (str, exp)::rest	-> if str = x then exp else getInEnv x rest

(* val setInEnv : env -> string -> e -> env				     *)
let setInEnv env str e = (str, e)::env


(*									     *)
(* ## Details of the evaluator : deconstruction and applications functions   *)
(*									     *)

(* val dec : res -> e							     *)
let dec = function
  | Closure (str, e, env)	-> e
  | Rconst r			-> Const r
  | _				-> raise (Failure "Closure application error")

(* val apply : res -> res -> env -> res					     *)
let rec apply res1 res2 env = match res1 with
  | Closure (str, e, env)	-> eval_lambda (setInEnv env str (dec res2)) e
  | _				-> Error ("Expression is not a Closure")

(*									     *)
(* ## Evaluator								     *)
(*									     *)

(* val eval_lambda : env -> e -> res					     *)
and eval_lambda env = function
  | Const n		-> Rconst n
  | Var x		-> eval_lambda env (getInEnv x env)
  | Abs (str, exp)	-> Closure (str, exp, env)
  | App (e1, e2)	-> apply (eval_lambda env e1) (eval_lambda env e2) env
