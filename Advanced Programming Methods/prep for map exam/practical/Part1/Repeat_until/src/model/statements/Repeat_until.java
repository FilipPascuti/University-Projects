package model.statements;

import exceptions.InvalidArguments;
import exceptions.NegationExpression;
import exceptions.TypeCheckException;
import model.ProgramState;
import model.expressions.Expression;
import model.expressions.RelationalExpression;
import model.types.BooleanType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;
import model.utilities.ADTs.IHeap;
import model.utilities.ADTs.IStack;
import model.values.Value;

public class Repeat_until implements IStatement{

    private final IStatement statement;
    private final Expression condition;

    public Repeat_until(IStatement statement, Expression condition) {
        this.statement = statement;
        this.condition = condition;
    }

    @Override
    public ProgramState execute(ProgramState state) {
        IStack<IStatement> executionStack = state.getExecutionStack();
        Expression not_condition = new NegationExpression(condition);
        CompoundStatement new_statement = new CompoundStatement(
                statement,
                new WhileStatement(not_condition, statement)
        );
        executionStack.push(new_statement);
        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!condition.typecheck(typeEnvironment).equals(new BooleanType()))
            throw new TypeCheckException("the condition should be BooleanType");
        statement.typecheck(typeEnvironment.deepCopy());
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "repeat("+ statement +
                ") until(" + condition + ") ";
    }
}
