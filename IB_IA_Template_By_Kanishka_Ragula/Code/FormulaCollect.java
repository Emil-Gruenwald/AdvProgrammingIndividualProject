import java.math.BigInteger;

/**<h1>FormulaCollect<h1>
 * Stores the data and methods for the steps needed in order to find the Empirical Formula
 * 
 * @author Kanishka Ragula
 * @version 0.3.1
 * @since 16-03-2017
 *
 */
public class FormulaCollect {
	
	/**Return the molar mass of the element entered
	 *  
	 * @param elem Element to find the molar mass of
	 * @return Molar mass of element if exists or throws IllegalArgumentException it does not exist.
	 */
	public static float molarMass(String elem){
		elem = Element.toCorrectSymbol(elem);
		if(Element.exists(elem)){
			return Element.getBySymbol(elem).getAtomicMass();
			
		} else {
			throw new IllegalArgumentException("Please enter the correct symbol!!!!!!!");
			
		}
		
	}
	/**Returns the amount of moles of the element that would be in 100 g of the compound
	 * 
	 * @param perc Percent of compound that this element makes up
	 * @param mm Molar mass of the element
	 * @return Result of percent divided by mass, telling how many moles of that specific element would be in 100 g of the compound
	 */
	public static float calcRatio(float perc, float mm){
		return perc/mm;
	}
	
	/**Returns the smallest amount of moles of the compound in the array
	 * 
	 * @param array Array to be sorted
	 * @return Smallest number in array
	 */
	public static float findSmallest(float[] array){
		float lowest = array[0];
		for(float a: array){
			if(a<lowest){
				lowest = a;
			}
		}
		return lowest;
	}
	/**Returns the final number for the element's amount in the compound
	 * 
	 * @param origin Original number of moles in 100 g
	 * @param dividBy Number to divide original by in order to get final number
	 * @return Number for element's makeup in compound
	 */
	public static float finalWrapup(float origin, float dividBy){
		//Multiplied by 2 to account for rounding errors that could happen.
			return Math.round(2*origin/dividBy);
	}
	
	/**Returns the greatest common divisor of two given values
	 * 
	 * @param a First value to find the greatest common divisor
	 * @param b Second value to find the greatest common divisor
	 * @return Greatest common divisor of two numbers entered
	 */
	private static int gcd(int a, int b) {
	    BigInteger b1 = BigInteger.valueOf(a);
	    BigInteger b2 = BigInteger.valueOf(b);
	    BigInteger gcd = b1.gcd(b2);
	    return gcd.intValue();
	}
	
	/** Fixes the format of the result to have the elements with their
	 * 	lowest coefficient
	  * 
	  * @return Re-formated array
	  */
	public static float[] fixFormat(float[] arrayToFix){
		float result = arrayToFix[0];
		for(float val: arrayToFix){
			result = gcd( (int) result, (int) val);
		}
		for(int i=0; i<arrayToFix.length; i++){
			arrayToFix[i] /= result;
		}
		return arrayToFix;
		
	}
	
	
	
}