/*
 * Ethan Silver
 * March 3rd, 2023
 */

/**
 * @author ethansilver
 */
public class Add_Generator {

    public static void main(String[] args) {
        System.out.println(block_generator(64));
    }
    public static String block_generator(int x) {
        String temp = "assign c[0] = Cin;\n";
        for(int i = 0; i < x; i++) {
            temp+= "assign c["+(i+1)+"] = " + line_generator(i) + ";\n";
        }
        return temp;
    }

    public static String line_generator(int x) {
        String temp = "";
        temp+="G["+x+"] | (";
        for(int q = x-1; q >= 0; q--) {
            for(int i = x; i > q; i--) {
                temp += "P["+i+"]&";
            }
            temp+="G["+(q)+"]) | (";
        }
        for(int i = x; i >= 0; i--) {
            temp += "P["+i+"]&";
        }
        temp+="c[0])";
        return temp;
    }
}