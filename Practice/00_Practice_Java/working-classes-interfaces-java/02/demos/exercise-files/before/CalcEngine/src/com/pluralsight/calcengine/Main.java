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
 *       when the build fails. This will open a project
 *       configuration dialog. On the project configuration dialog,
 *       select the appropriate JDK version for your setup
 ************************************************************************
 */
public class Main {

    public static void main(String[] args) {
        performCalculations();
    }

    static void performCalculations() {
        double[] leftVals = {100.0d, 25.0d, 225.0d, 11.0d};
        double[] rightVals = {50.0d, 92.0d, 17.0d, 3.0d};
        char[] opCodes = {'d', 'a', 's', 'm'};
        double[] results = new double[opCodes.length];

        for (int i = 0; i < opCodes.length; i++) {
            results[i] = execute(opCodes[i], leftVals[i], rightVals[i]);
        }
        for (double currentResult : results)
            System.out.println("result = " + currentResult);

    }

    static double execute(char opCode, double leftVal, double rightVal) {
        double result;
        switch (opCode) {
            case 'a':
                result = leftVal + rightVal;
                break;
            case 's':
                result = leftVal - rightVal;
                break;
            case 'm':
                result = leftVal * rightVal;
                break;
            case 'd':
                result = rightVal != 0 ? leftVal / rightVal : 0.0d;
                break;
            default:
                System.out.println("Invalid opCode: " + opCode);
                result = 0.0d;
                break;
        }
        return result;
    }
}



















