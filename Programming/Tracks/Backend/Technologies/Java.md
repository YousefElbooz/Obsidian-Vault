# #Java Course:

this is the start point to java project:
"Don't Forget the Extension Pack for Java on Vscode."
```java
public class App {
    public static void main(String[] args) throws Exception {
        System.out.println("Hello, World!");
    }
}
```
- ## Basics 
	- ### #Variables:
		- [x] #Instance_Variables  [completion:: 2026-03-07]
		- [x] #Local_Variables  [completion:: 2026-03-07]
	```Java
	public class App {
	    // instance variable
	    int mySalary = 20000;
	    public static void main(String[] args) throws Exception {
	        // Local Variables
	        int age;
	        age=20;
	        System.out.println(age);
	    }
	}
	```
	- ### #DataTypes:
	- ![[data_types_in_java.webp]]
	  - [x] #Primitive_Types :  [completion:: 2026-03-07]
	    - Integer:
		    - byte
		    - short
		    - int 
		    - long
	    - float
	    - Double
	    - Char
	    - Boolean
	  - [x] #Non-Primitive_Types  [completion:: 2026-03-07]
		  - String
		  - Array
		  - Class
		  - Interface
	```Java
	package Basics;
	import java.util.ArrayList;
	public class DataTypes {
	    // Premitive Types:
	    public byte smallest; // (-128 --> 127 )
	    public short small; // (-32768 --> 32767 )
	    public int regral; // Whole Numbers ( -2147493648 --> 2147493647 )
	    public long bigist; //  ( -9223372036854775808 --> 9223372036854775807 )
	    public float decimal; // 7 decimal digits
	    public double gpa; // 16 deciaml digits Floating-point numbers
	    public char department; // Single Character or multyiple characters if array
	    public boolean success; // logical value [true,False]
	    // Non-Primitive
	    public String name; // Text ......etc
	    public ArrayList<String> Courses; // Array msh M7taga 7aga
	}
	```
	- ### #Operators :
		- [x] **Arithmetic:**  [completion:: 2026-03-07]
			- `+`, `-`, `*`, `/`, `%` (Modulus/Remainder)  
		- [x] **Comparison:**  [completion:: 2026-03-07]
			- == (Equal to), `!=` (Not equal), `>`, `<`, `>=`, `<=`
		- [x] **Logical:**  [completion:: 2026-03-07]
			- `&&` (Logical AND), `||` (Logical OR), `!` (Logical NOT)
	- ### #User_Input and #Scanner  :
	```java
	package Basics;
	import java.util.Scanner;
	public class InputsAndScanner {
	    public  InputsAndScanner() {
	    Scanner sc = new Scanner(System.in)
	    System.out.println("Enter your name:");
	    String name = sc.nextLine(); // Reads a string
	    System.out.println("Enter your age:");
	    int age = sc.nextInt();      // Reads an integer
	    }
	}
	```
	
- ### #OOP 
	![[OOP]]