package model.statements;

import exceptions.InvalidArguments;
import exceptions.TypeCheckException;
import model.ProgramState;
import model.expressions.Expression;
import model.types.BooleanType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;

public class ConditionalAssignmentStatement implements IStatement{

    private final String variableName;
    private final Expression condition;
    private final Expression case1;
    private final Expression case2;

    public ConditionalAssignmentStatement(String variableName, Expression condition, Expression case1, Expression case2) {
        this.variableName = variableName;
        this.condition = condition;
        this.case1 = case1;
        this.case2 = case2;
    }

    @Override
    public ProgramState execute(ProgramState state) {
        if(!state.getSymbolTable().containsKey(variableName))
            throw new InvalidArguments("the variable was not declared");

        IStatement conditionalAssignment = new IfStatement(
                condition,
                new AssignmentStatement("v", case1),
                new AssignmentStatement("v", case2)
        );
        state.getExecutionStack().push(conditionalAssignment);

        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!condition.typecheck(typeEnvironment).equals(new BooleanType()))
            throw new TypeCheckException("invalid type for condition");
        if(!(typeEnvironment.lookUp(variableName).equals(case1.typecheck(typeEnvironment)) && typeEnvironment.lookUp(variableName).equals(case2.typecheck(typeEnvironment))))
            throw new TypeCheckException("the types do not coincide");
        return typeEnvironment;
    }

    @Override
    public String toString() {
        return variableName + "=" +
                condition +
                "?" + case1 +
                " : " + case2;
    }
}
