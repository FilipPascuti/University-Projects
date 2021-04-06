package model.statements;

import exceptions.InvalidArguments;
import exceptions.TypeCheckException;
import javafx.util.Pair;
import model.ProgramState;
import model.types.IntType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;
import model.values.IntValue;
import model.values.Value;

import java.util.ArrayList;

public class AcquireStatement implements IStatement{

    private final String var;

    public AcquireStatement(String var) {
        this.var = var;
    }

    @Override
    public synchronized ProgramState execute(ProgramState state) {
        synchronized (state.getSemaphoreTable()){

            var symbolTable = state.getSymbolTable();
            var semaphoreTable = state.getSemaphoreTable();

            if(!symbolTable.containsKey(var))
                throw new InvalidArguments("var was not declared");
            if(!symbolTable.lookUp(var).getType().equals(new IntType()))
                throw new InvalidArguments("var must be IntType");
            int fountIndex = ((IntValue)symbolTable.lookUp(var)).getValue();
            if(!semaphoreTable.containsKey(fountIndex))
                throw new InvalidArguments("semaphore was not declared");
            var entry = semaphoreTable.lookUp(fountIndex);
            var n1 = entry.getKey();
            var list1 = entry.getValue();
            var len = list1.size();
            if(n1 > len){
                if(!list1.contains(state.getProgramId()))
                    list1.add(state.getProgramId());
            } else {
                state.getExecutionStack().push(this);
            }

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
        return "acquire(" + var + ")";
    }
}
