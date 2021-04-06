package model.statements;

import exceptions.TypeCheckException;
import model.ProgramState;
import model.expressions.Expression;
import model.expressions.RelationalExpression;
import model.expressions.VarExpression;
import model.types.IntType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;

public class ForStatement implements IStatement{

    private  Expression expression1;
    private  Expression expression2;
    private  Expression expression3;
    private  IStatement statement;

    public ForStatement(Expression expression1, Expression expression2, Expression expression3, IStatement statement) {
        this.expression1 = expression1;
        this.expression2 = expression2;
        this.expression3 = expression3;
        this.statement = statement;
    }

    @Override
    public ProgramState execute(ProgramState state) {

        IStatement forStatement = new CompoundStatement(
                new VariableDeclarationStatement("v", new IntType()),
                new CompoundStatement(
                        new AssignmentStatement("v",expression1),
                            new WhileStatement(
                                    new RelationalExpression(new VarExpression("v"),expression2,"<"),
                                    new CompoundStatement(
                                            statement,
                                            new AssignmentStatement("v", expression3)
                                    )
                            )
                        )
                );

        state.getExecutionStack().push(forStatement);

        return null;
    }

    @Override
    public IDictionary<String, Type> typecheck(IDictionary<String, Type> typeEnvironment) {
        typeEnvironment.put("v", new IntType());
        if(!expression1.typecheck(typeEnvironment.deepCopy()).equals(new IntType()))
            throw new TypeCheckException("expression must evaluate to IntType");
        if(!expression2.typecheck(typeEnvironment.deepCopy()).equals(new IntType()))
            throw new TypeCheckException("expression must evaluate to IntType");
        if(!expression3.typecheck(typeEnvironment.deepCopy()).equals(new IntType()))
            throw new TypeCheckException("expression must evaluate to IntType");

        return typeEnvironment;
    }

    @Override
    public String toString() {
        return "for(v=" +
                expression1 +
                ",v < " + expression2 +
                ",v=" + expression3 +
                "{" + statement +
                '}';
    }
}
