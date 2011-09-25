(*									     *)
(*	Filename	main.ml						     *)
(*	Project		Lambda-calcul_eval_AST				     *)
(*	Authors		Idriss Moutawakil, Noëlie Sylvain, Barbara Lepage    *)
(*									     *)

(*	test main of the lambda evaluator				     *)

(*									     *)
(* ## Main, examples of AST						     *)
(*									     *)

(* val show : res -> unit						     *)
let show = function
  | Lambdacalcul.Rconst n		->
    begin
      print_int n;
      print_endline ""
    end
  | Lambdacalcul.Closure (str, e, env)	->
    begin
      print_string "Closure ";
      print_endline str
    end
  | Lambdacalcul.Error err		-> print_endline err
    
(* val main : unit -> unit						     *)
let main () =
  let env = [] in
  begin

    (* λx.x								     *)
    show (Lambdacalcul.eval_lambda env
	    (Lambdacalcul.Abs ("x", Lambdacalcul.Var "x")));

    (* (λy.y)2								     *)
    show (Lambdacalcul.eval_lambda env
	    (Lambdacalcul.App(Lambdacalcul.Abs ("y", Lambdacalcul.Var "y"),
			      Lambdacalcul.Const 2)));

    (* ((λw.(λz.w))1)3							     *)
    show (Lambdacalcul.eval_lambda env
	    (Lambdacalcul.App
	       ((Lambdacalcul.App
		   (Lambdacalcul.Abs
		      ("x",Lambdacalcul.Abs ("y",Lambdacalcul.Var "x")),
		    Lambdacalcul.Const 1), Lambdacalcul.Const 3))));

  end

let _ = main ()

