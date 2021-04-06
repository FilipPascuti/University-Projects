package exceptions;

import model.expressions.Expression;
import model.types.BooleanType;
import model.types.Type;
import model.utilities.ADTs.IDictionary;
import model.utilities.ADTs.IHeap;
import model.values.BooleanValue;
import model.values.Value;

public class NegationExpression implements Expression {
    private final Expression condition;

    public NegationExpression(Expression condition) {
        this.condition = condition;
    }

    @Override
    public Value evaluate(IDictionary<String, Value> symbolTable, IHeap<Value> heap) {
        Value value = condition.evaluate(symbolTable, heap);
        if(!value.getType().equals(new BooleanType()))
            throw new InvalidArguments("the condition must return BooleanType");
        return new BooleanValue(!((BooleanValue) value).getValue());
    }

    @Override
    public Type typecheck(IDictionary<String, Type> typeEnvironment) {
        if(!condition.typecheck(typeEnvironment).equals(new BooleanType()))
            throw new TypeCheckException("the condition should return a BooleanType");
        return new BooleanType();
    }

    @Override
    public String toString() {
        return "not(" + condition + ")";
    }
}
