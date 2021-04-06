package model.statements;

import exceptions.InvalidArguments;
import exceptions.TypeCheckException;
import model.ProgramState;
import model.types.IntType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;
import model.values.IntValue;

public class LockStatement implements IStatement{

    private final String variableName;

    public LockStatement(String variableName) {
        this.variableName = variableName;
    }

    @Override
    public synchronized ProgramState execute(ProgramState state) {
        synchronized (state.getLockTable()) {
            var symbolTable = state.getSymbolTable();
            var lockTable = state.getLockTable();

            if (!symbolTable.containsKey(variableName))
                throw new InvalidArguments("the variable was not declared");
            if (!symbolTable.lookUp(variableName).getType().equals(new IntType()))
                throw new InvalidArguments("the variable must be IntType");

            int foundIndex = ((IntValue) symbolTable.lookUp(variableName)).getValue();
            if (!lockTable.containsKey(foundIndex))
                throw new InvalidArguments("the lock was not created");
            if (lockTable.lookUp(foundIndex) == -1)
                lockTable.replace(foundIndex, state.getProgramId());
            else
                state.getExecutionStack().push(this);
        }
        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!typeEnvironment.containsKey(variableName))
            throw new TypeCheckException("variable not declared");
        if(!typeEnvironment.lookUp(variableName).equals(new IntType()))
            throw new TypeCheckException("variable must to IntType");
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "lock(" + variableName + ")";
    }
}
