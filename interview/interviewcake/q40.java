import java.util.*;

public class q40 {
   public static int find_duplicate(int[] a) {
      int top = a.length - 1;
      int bottom = 0;

      while (bottom < top) {
         int midpoint = (top - bottom) / 2;

         int count_expected = midpoint - bottom + 1;

         int count_bottom = 0;
         for (int i = 0; i < a.length; i++) {
            if ( a[i] >= bottom && a[i] <= midpoint) {
               count_bottom++;
            }
         }

         if ( count_bottom > count_expected ) {
            // bottom range contains duplicate
            top = midpoint + bottom;
         }
         else {
            bottom = bottom + midpoint + 1;
         }
         System.out.println(bottom + "~" + top);
      }
      return top; //==bottom
   }

   public static void main(String[] args) {
      int[] input = new int[] { 1,2,4,4,5,6,7,7};

      int actual = find_duplicate(input);
      System.out.println(actual);
   }
}
