package model.statements;

import exceptions.InvalidArguments;
import exceptions.TypeCheckException;
import model.ProgramState;
import model.expressions.Expression;
import model.types.IntType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;
import model.values.IntValue;
import model.values.Value;

public class NewLatchStatement implements IStatement{

    private final String var;
    private final Expression expression;

    public NewLatchStatement(String var, Expression expression) {
        this.var = var;
        this.expression = expression;
    }

    @Override
    public synchronized ProgramState execute(ProgramState state) {

        synchronized (state.getLatchTable()){

            var symbolTable = state.getSymbolTable();
            var latchTable = state.getLatchTable();

            Value value = expression.evaluate(symbolTable,state.getHeap());
            if(!value.getType().equals(new IntType()))
                throw new InvalidArguments("the expresion must evaluate to IntType");
            if(!symbolTable.containsKey(var))
                throw new InvalidArguments("var was not declared");
            if(!symbolTable.lookUp(var).getType().equals(new IntType()))
                throw new InvalidArguments("var must be IntType");
            int location = latchTable.getFreeLocation();
            latchTable.put(location, ((IntValue) value).getValue());
            symbolTable.replace(var, new IntValue(location));

        }

        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!typeEnvironment.containsKey(var))
            throw new TypeCheckException("var was not declared");
        if(!typeEnvironment.lookUp(var).equals(new IntType()))
            throw new TypeCheckException("var must be IntType");
        if(!expression.typecheck(typeEnvironment).equals(new IntType()))
            throw new TypeCheckException("expression must evaluate to IntType");
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "latch(" + var + ", " + expression + ")";
    }
}
