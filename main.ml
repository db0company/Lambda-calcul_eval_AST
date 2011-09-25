(*									     *)
(*	Filename	lambdacalcul.ml					     *)
(*	Project		Lambda-calcul_eval_AST				     *)
(*	Authors		Idriss Moutawakil, Noëlie Sylvain, Barbara Lepage    *)
(*									     *)

(*	main of the lambda evaluator					     *)

(*									     *)
(* ## Main, example of simple AST (λx.x)2				     *)
(*									     *)

let main () =
  (* let e = Lambdacalcul.App *)
  (*   (Lambdacalcul.Abs ("x", Lambdacalcul.Var "x"), Lambdacalcul.Const 2) and *)
  (* let f = Lambdacalcul.App *)
  (*   (Lambdacalcul.App (Lambdacalcul.Abs *)
  (* 			 ("x", Lambdacalcul.Abs ("y", Lambdacalcul.Var "x")), *)
  (* 		       Lambdacalcul.Const 1), *)
  (*    Lambdacalcul.Const 3) in *)
  let e = Lambdacalcul.Abs ("x", Lambdacalcul.Var "x") in
  let resultat = Lambdacalcul.eval_lambda [] e in
    match resultat with
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
	  
let _ = main ()

