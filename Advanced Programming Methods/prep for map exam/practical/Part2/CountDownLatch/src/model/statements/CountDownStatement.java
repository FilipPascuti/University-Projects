package model.statements;

import exceptions.InvalidArguments;
import exceptions.TypeCheckException;
import model.ProgramState;
import model.types.IntType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;
import model.values.IntValue;
import model.values.Value;

public class CountDownStatement implements IStatement{

    private final String var;

    public CountDownStatement(String var) {
        this.var = var;
    }

    @Override
    public synchronized ProgramState execute(ProgramState state) {

        synchronized (state.getLatchTable()){

            var symbolTable = state.getSymbolTable();
            var latchTable = state.getLatchTable();

            if(!symbolTable.containsKey(var))
                throw new InvalidArguments("var was not declared");
            if(!symbolTable.lookUp(var).getType().equals(new IntType()))
                throw new InvalidArguments("var must be IntType");
            Integer foundIndex = ((IntValue) symbolTable.lookUp(var)).getValue();
            if(!latchTable.containsKey(foundIndex))
                throw new InvalidArguments("the latch was not created");
            if(latchTable.lookUp(foundIndex) > 0)
                latchTable.replace(foundIndex, latchTable.lookUp(foundIndex) - 1);
            state.getOutput().add(new IntValue(state.getProgramId()));
        }

        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!typeEnvironment.containsKey(var))
            throw new TypeCheckException("var was not declared");
        if(!typeEnvironment.lookUp(var).equals(new IntType()))
            throw new TypeCheckException("var must be IntType");
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "countDown(" + var + ")";
    }
}
