package com.pluralsight.calcengine;

public class Divider extends CalculateBase {
    @Override
    public void calculate() {
        double value = getLeftVal() / getRightVal();
        setResult(value);
    }
}
