(*						*)
(*	Made by		db0			*)
(*	Contact		db0company@gmail.com	*)
(*	Website		http://db0.fr		*)
(*						*)


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

val getInEnv	: string -> env	   -> e
val setInEnv	: env	 -> string -> e		-> env
val apply	: res	 -> res	   -> env	-> res
val eval_lambda	: env	 -> e	   -> res

