##
## Made by	db0
## Contact	db0company@gmail.com
## Site		http://db0.fr/
##

NAME		=	lambdacalcul
CAMFLAGS	+=	-w Aelz -warn-error A

OCAMLOPT	?=	ocamlopt
OCAMLC		?=	ocamlc
OCAMLDEP	?=	ocamldep

SRCS		=	lambdacalcul.ml
MLI		=	lambdacalcul.mli

CMI		=	${MLI:.mli=.cmi}
OBJS		=	${SRCS:.ml=.cmo}
OPTOBJS		=	${SRCS:.ml=.cmx}

all		:	${NAME}

.SUFFIXES	:	.ml .cmo .cmx .mli .cmi

.ml.cmo		:
			${OCAMLC} ${CAMFLAGS} -c $<

.ml.cmx		:
			${OCAMLOPT} ${CAMFLAGS} -c $<

.mli.cmi	:
			${OCAMLC} ${CAMFLAGS} -c $<

.depend		:
			${OCAMLDEP} ${SRCS} ${MLI} > .depend

opt		:	${NAME}.opt

${NAME}		:	.depend ${CMI} ${OBJS}
			${OCAMLC} unix.cma ${OBJS} -o ${NAME}

${NAME}.opt	:	.depend ${CMI} ${OPTOBJS}
			${OCAMLOPT} ${OPTOBJS} -o ${NAME}

clean		:
			rm -f *.cm[iox] *.o
			rm -f .depend
			rm -f ${NAME}
