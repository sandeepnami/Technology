package com.pluralsight.slidecommandlineexample;

public class Main {
    /*
    *******************************************************
    * NOTE: You can set command-line argument values within
    * IntelliJ so that you can test your code without having
    * to go out to a command prompt. You can simply run the
    * code within IntelliJ as you would normally.
    *
    * To set the command line argument values...
    * On the IntelliJ menu choose:
    *   - Run
    *   - Edit Configurations...
    *
    * In the dialog box that opens you can specify command-
    * line arguments in the field labeled "Program arguments".
    * I've set the initial program arguments to
    *    Hello "Mary Ann"
    *
    * - Jim
    ********************************************************
     */
    public static void main(String[] args) {
        if(args.length < 1)
            System.out.println("No args provided");
        else
            for(String arg : args)
                System.out.println(arg);

    }
}
