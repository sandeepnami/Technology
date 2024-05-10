package com.jwhh;

import java.io.IOException;

/**
 * Created by Jim on 1/9/2016.
 */
public class MyAutoCloseable implements AutoCloseable {
    public void saySomething() throws IOException{
        System.out.println("Something");
    }
    @Override
    public void close() throws IOException {
        System.out.println("close");
    }
}
