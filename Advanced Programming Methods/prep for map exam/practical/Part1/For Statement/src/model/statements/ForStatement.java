package model.statements;

import exceptions.TypeCheckException;
import model.ProgramState;
import model.expressions.Expression;
import model.expressions.RelationalExpression;
import model.expressions.VarExpression;
import model.types.BooleanType;
import model.types.IntType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;

public class ForStatement implements IStatement{

    private IStatement statement1;
    private Expression condition;
    private IStatement statement2;
    private IStatement statement;

    public ForStatement(IStatement statement1, Expression condition, IStatement statement2, IStatement statement) {
        this.statement1 = statement1;
        this.condition = condition;
        this.statement2 = statement2;
        this.statement = statement;
    }

    @Override
    public ProgramState execute(ProgramState state) {
        IStatement newWhile = new WhileStatement(condition, new CompoundStatement(statement, statement2));
        state.getExecutionStack().push(newWhile);
        state.getExecutionStack().push(statement1);

        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        var innerTypeEnvironment = statement1.typecheck(typeEnvironment);
        if(!condition.typecheck(innerTypeEnvironment).equals(new BooleanType()))
            throw new TypeCheckException("invalid condition");
        statement2.typecheck(innerTypeEnvironment);

        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "for(" + statement1 + "," + condition + ", " + statement2 + ") {" + statement + "}";
    }
}
