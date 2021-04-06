package model.statements;

import exceptions.TypeCheckException;
import model.ProgramState;
import model.expressions.Expression;
import model.expressions.RelationalExpression;
import model.types.Type;
import model.utilities.ADTs.IDictionary;

public class SwitchStatement implements IStatement{

    private Expression expression;
    private Expression case1;
    private Expression case2;
    private IStatement statement1;
    private IStatement statement2;
    private IStatement statement3;


    public SwitchStatement(Expression expression, Expression case1,  IStatement statement1,Expression case2, IStatement statement2, IStatement statement3) {
        this.expression = expression;
        this.case1 = case1;
        this.case2 = case2;
        this.statement1 = statement1;
        this.statement2 = statement2;
        this.statement3 = statement3;
    }

    @Override
    public ProgramState execute(ProgramState state) {

        IStatement switchStatement = new IfStatement(
                new RelationalExpression(expression, case1, "=="),
                statement1,
                new IfStatement(
                        new RelationalExpression(expression, case2, "=="),
                        statement2,
                        statement3
                )
                );
        state.getExecutionStack().push(switchStatement);

        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!expression.typecheck(typeEnvironment).equals(case1.typecheck(typeEnvironment)))
            throw new TypeCheckException("types not matching");
        if(!expression.typecheck(typeEnvironment).equals(case2.typecheck(typeEnvironment)))
            throw new TypeCheckException("types not matching");

        statement1.typecheck(typeEnvironment.deepCopy());
        statement2.typecheck(typeEnvironment.deepCopy());
        statement3.typecheck(typeEnvironment.deepCopy());
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "switch(" + expression +
                ") {" + case1 +
                ":" + statement1 +
                ";" + case2 +
                ":" + statement2 +
                "; default:" + statement3 +
                '}';
    }
}
