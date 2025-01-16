import «DMTL4».Library.propLogicWithArith.syntax
import «DMTL4».Library.propLogicWithArith.domain
import «DMTL4».Library.natArithmetic.semantics

/-!
# Semantics of Propositional Logic with Arithmetic Relations
-/

namespace DMTL4.propLogicwithArith.semantics

open DMTL4.propLogicWithArith.syntax


def evalUnOp : UnOp → (Bool → Bool)
| (UnOp.not) => not


def evalBinOp : BinOp → (Bool → Bool → Bool)
| BinOp.and => and    -- Bool and operator, &&, from Lean
| BinOp.or => or      -- Bool or operator, ||, from Lean
| BinOp.imp => DMTL4.propLogicwithArith.domain.imp
| BinOp.iff => domain.iff --shortened qualifier works


abbrev BoolInterp := Var → Bool -- boolVarInterp would be better name


abbrev ArithInterp := natArithmetic.syntax.Var → Nat


-- Semantic evaluation of PLA Expressions under *two* variable interpretations
def evalPLAExpr : PLAExpr → BoolInterp → ArithInterp → Bool
| (PLAExpr.lit_expr b),             _, _ => b
| (PLAExpr.var_expr v),           i, _ => i v
| (PLAExpr.un_op_expr op e),      i, a => (evalUnOp op) (evalPLAExpr e i a)
| (PLAExpr.bin_op_expr op e1 e2), i, a => (evalBinOp op) (evalPLAExpr e1 i a) (evalPLAExpr e2 i a)
| (PLAExpr.rel_op_expr re),       _, a => (natArithmetic.semantics.evalRelExpr re a)

end DMTL4.propLogicwithArith.semantics
