package model;

import exceptions.StackIsEmptyException;
import model.statements.IStatement;
import model.utilities.ADTs.*;
import model.values.Value;

public class ProgramState {
    private IStack<IStatement> executionStack;
    private IDictionary<String, Value> symbolTable;
    private IList<Value> output;
    private IFileTable fileTable;
    private IStatement originalProgram;
    private IHeap<Value> heap;
    public static int lastId = 0;
    private final int programId;

    private ILatchTable<Integer, Integer> latchTable;

    public ProgramState(IStack<IStatement> executionStack, IDictionary<String, Value> symbolTable, IList<Value> output, IFileTable fileTable, IStatement originalProgram, IHeap<Value> heap, ILatchTable<Integer, Integer> latchTable) {
        this.executionStack = executionStack;
        this.symbolTable = symbolTable;
        this.output = output;
        this.fileTable = fileTable;
        this.originalProgram = originalProgram;
        this.heap = heap;
        this.executionStack.push(originalProgram);
        this.programId = getNewProgramStateId();

        this.latchTable = latchTable;

    }

    public static synchronized int getNewProgramStateId() {
        lastId++;
        return lastId;
    }

    public IStack<IStatement> getExecutionStack() {
        return executionStack;
    }

    public void setExecutionStack(IStack<IStatement> executionStack) {
        this.executionStack = executionStack;
    }

    public IDictionary<String, Value> getSymbolTable() {
        return symbolTable;
    }

    public void setSymbolTable(IDictionary<String, Value> symbolTable) {
        this.symbolTable = symbolTable;
    }

    public IList<Value> getOutput() {
        return output;
    }

    public void setOutput(IList<Value> output) {
        this.output = output;
    }

    public IStatement getOriginalProgram() {
        return originalProgram;
    }

    public void setOriginalProgram(IStatement originalProgram) {
        this.originalProgram = originalProgram;
    }

    public IFileTable getFileTable() {
        return fileTable;
    }

    public void setFileTable(IFileTable fileTable) {
        this.fileTable = fileTable;
    }

    public IHeap<Value> getHeap() { return heap; }

    public void setHeap(IHeap<Value> heap) { this.heap = heap; }

    public boolean isNotCompleted(){
        return !this.executionStack.isEmpty();
    }

    public ProgramState oneStep(){
        if(this.executionStack.isEmpty())
            throw new StackIsEmptyException("The execution stack is empty.\n");
        IStatement currentStatement = executionStack.pop();
        return currentStatement.execute(this);
    }

    public int getProgramId() {
        return programId;
    }


    public ILatchTable<Integer, Integer> getLatchTable() {
        return latchTable;
    }

    public void setLatchTable(ILatchTable<Integer, Integer> latchTable) {
        this.latchTable = latchTable;
    }

    @Override
    public String toString() {
        return  "ID: " + programId +
                "\nExecution Stack: " + executionStack +
                "\nSymbol Table: " + symbolTable +
                "\nOutput: " + output +
                "\nFileTable: " + fileTable +
                "\nHeap: " + heap + "\n";
    }
}
