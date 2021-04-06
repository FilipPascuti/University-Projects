package model.statements;

import exceptions.TypeCheckException;
import model.ProgramState;
import model.expressions.Expression;
import model.expressions.ValueExpression;
import model.types.IntType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;
import model.values.IntValue;

public class SleepStatement implements IStatement{

    private final Expression expression;

    public SleepStatement(Expression expression) {
        this.expression = expression;
    }

    @Override
    public ProgramState execute(ProgramState state) {

        int number = ((IntValue) expression.evaluate(state.getSymbolTable(),state.getHeap())).getValue();

        if(number > 0)
            state.getExecutionStack().push(new SleepStatement(new ValueExpression(new IntValue(number - 1))));

        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!expression.typecheck(typeEnvironment).equals(new IntType()))
            throw new TypeCheckException("invalid type");
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "sleep(" + expression + ")";
    }
}
