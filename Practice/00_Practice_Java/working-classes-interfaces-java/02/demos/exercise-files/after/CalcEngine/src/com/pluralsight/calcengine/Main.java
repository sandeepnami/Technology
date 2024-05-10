package com.pluralsight.calcengine;

import java.time.LocalDate;
import java.util.Scanner;

/*
************************************************************************
* Note: If you have difficulty building the code, it's probably due to
*       a difference in the version of the JDK used to create this
*       project and the JDK version you have installed.
*
*       To fix the JDK simply click "OK" on the dialog that appears
*       indicating that the build failed. This will open a project
*       configuration dialog. On the project configuration dialog,
*       select the appropriate JDK version for your setup
 ************************************************************************
 */
public class Main {

    public static void main(String[] args) {
        performCalculations();
    }

    static void performCalculations() {
        MathEquation[] equations = new MathEquation[4];
        equations[0] = create(100.0d, 50.0d, 'd');
        equations[1] = create(25.0d, 92.0d, 'a');
        equations[2] = create(225.0d, 17.0d, 's');
        equations[3] = create(11.0d, 3.0d, 'm');

        for(MathEquation equation : equations) {
            equation.execute();
            System.out.println("result = " + equation.getResult());
        }

    }

    private static MathEquation create(double leftVal, double rightVal, char opCode) {
        MathEquation equation = new MathEquation();
        equation.setLeftVal(leftVal);
        equation.setRightVal(rightVal);
        equation.setOpCode(opCode);
        return equation;
    }


}



















