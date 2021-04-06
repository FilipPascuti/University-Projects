package model.statements;

import exceptions.InvalidArguments;
import exceptions.TypeCheckException;
import javafx.util.Pair;
import model.ProgramState;
import model.expressions.Expression;
import model.types.IntType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;
import model.values.IntValue;
import model.values.Value;

import java.util.ArrayList;

public class CreateSemaphoreStatement implements IStatement{

    private final String var;
    private final Expression expression;

    public CreateSemaphoreStatement(String var, Expression expression) {
        this.var = var;
        this.expression = expression;
    }

    @Override
    public synchronized ProgramState execute(ProgramState state) {

        synchronized (state.getSemaphoreTable()){

            var symbolTable = state.getSymbolTable();
            var semaphoreTable = state.getSemaphoreTable();

            Value value = expression.evaluate(symbolTable, state.getHeap());
            if(!value.getType().equals(new IntType()))
                throw new InvalidArguments("expression must evaluate to IntType");
            if(!symbolTable.containsKey(var))
                throw new InvalidArguments("var was not declared");
            if(!symbolTable.lookUp(var).getType().equals(new IntType()))
                throw new InvalidArguments("var must be IntType");
            int number = ((IntValue) value).getValue();
            int location = semaphoreTable.getFreeLocation();
            semaphoreTable.put(location, new Pair<>(number, new ArrayList<>()));
            symbolTable.put(var, new IntValue(location));

        }

        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!expression.typecheck(typeEnvironment).equals(new IntType()))
            throw new TypeCheckException("expression must evaluate to IntType");
        if(!typeEnvironment.containsKey(var))
            throw new TypeCheckException("var was not declared");
        if(!typeEnvironment.lookUp(var).equals(new IntType()))
            throw new TypeCheckException("var must be IntType");
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "createSemaphore(" + var + ", " + expression + ")";
    }
}
