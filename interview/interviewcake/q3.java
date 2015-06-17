import java.util.*;

public class q3 {

   public static void pushPositive(ArrayList<Integer> a, int value, int limit) {

      if (value >= 0) {
         // bubble sort it up if needed
         if (a.size() < limit) {
            a.add(value);
         }
         else {
            for (int i = 0; i < a.size(); i++) {
               if (value > a.get(i)) {
                  int temporary = a.get(i);
                  a.set(i, value);
                  value = temporary;
               }
            }
         }
      }
   }

   public static void pushNegative(ArrayList<Integer> a, int value, int limit) {

      if (value < 0) {

         if (a.size() < limit) {
            a.add(value);
         }
         else {
            for (int i = 0; i < a.size(); i++) {
               if (value < a.get(i)) {
                  int temporary = a.get(i);
                  a.set(i, value);
                  value = temporary;
               }
            }
         }
      }
   }

   public static int compute_highest(int[] a) {
      if (null == a) {
         throw new IllegalArgumentException("Input is null");
      }


      int length = a.length;
      int max = 0;

      if (length < 3) {
         throw new IllegalArgumentException("Input needs 3 ints minimum. ");
      }
      else if (length == 3) {
         max = a[0] * a[1] * a[2];
      }
      else {

         // Go thru array, find 3 maximum numbers
         // Max combinations: (- - +) (+ + +)
         // So also need to track lowest 2 negatives
         ArrayList<Integer> top = new ArrayList<Integer>();
         ArrayList<Integer> bottom = new ArrayList<Integer>();

         int LIMIT_LENGTH = 3;

         for (int i = 0; i < length; i++) {
            int current = a[i];

            pushPositive(top, a[i], LIMIT_LENGTH);
            pushNegative(bottom, a[i], LIMIT_LENGTH);
         }

         for (int i = 0; i < top.size(); i++) {
            System.out.print(top.get(i) + " " );
         }
         System.out.println(" POSITIVES");

         for (int j = 0; j < bottom.size(); j++) {
            System.out.print(bottom.get(j) + " ");
         }
         System.out.println(" NEGATIVES");


         if (top.isEmpty()) {
            max = bottom.get(0) * bottom.get(1) * bottom.get(2);
         }
         else if (bottom.size() < 2) {
            max = top.get(0) * top.get(1) * top.get(2);
         }
         else {

            int topMax = top.get(0);
            if (top.size() >= 2) {
               topMax = Math.max(max, top.get(1));
            }
            if (top.size() == 3) {
               topMax = Math.max(max, top.get(2));
            }

            int bottom1 = Math.min(bottom.get(0), bottom.get(1));

            int bottom2 = Math.max(bottom.get(0), bottom.get(1));
            if (bottom.size() == 3) {
               bottom2 = Math.min(bottom2, bottom.get(2));
            }

            int productOfBottom2 = bottom1 * bottom2;
            max  = topMax * productOfBottom2;

            if (top.size() > 2) {
               int productTop3 = top.get(0) * top.get(1) * top.get(2);
               if (productTop3 > max) {
                  max = productTop3;
               }
            }
         }
      }

      return max;
   }

   public static void assertEqual(int expected, int actual) {
      if (expected != actual) {
         System.out.println("Expected: " + expected + ", actual: " + actual);
      }
   }

   public static void main(String[] args) {

      ArrayList<int[]> testCases = new ArrayList<int[]>();
      ArrayList<Integer> expected = new ArrayList<Integer>();

      testCases.add( new int[]{1,2,3,4,5} );
      expected.add(60);

      testCases.add( new int[]{-1, -4 ,2,3,4,5} );
      expected.add(60);

      testCases.add( new int[]{1,2,3,4,-5} );
      expected.add(24);

      testCases.add( new int[]{1,2,3} );
      expected.add(6);

      testCases.add( new int[]{-4, -5, -3, -4, -3} );
      expected.add(-80);

      testCases.add( new int[]{-4, -5, -3} );
      expected.add(-60);

      testCases.add( new int[]{-4, -5, -3, 1, 2, 3} );
      expected.add(60);

      testCases.add( new int[]{-4, -5, -3, 1, 2, 10} );
      expected.add(200);

      testCases.add( new int[]{-4, -5, -3, 1, 2} );
      expected.add(40);

      // testCases.add( new int[]{4958, 2034} );
      // expected.add(0);

      // testCases.add( null );
      // expected.add(0);

      for (int i = 0; i < testCases.size(); i++ ) {
         int actual = compute_highest( testCases.get(i) );
         assertEqual(expected.get(i), actual);
         System.out.println();
      }

   }


}


