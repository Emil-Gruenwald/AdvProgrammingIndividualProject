import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.ScrollPane;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

/**
 * Main Class for the Empirical Formula Calculator. Takes in percents of each element in a compound and return the compound's empirical formula
 *
 * @author Kanishka Ragula
 * @version 0.2.1
 * @since 03-18-2017
 */
public class EmpirMain {

    private JComboBox entryOptions;
    private JFrame mainFrame, entry, instructions;
    private JLabel headerLabel, headerLabel1;
    private JLabel statusLabel;
    private JPanel[] elements;
    private JPanel controlPanel, element1, element2, backPanel, instrPanel;
    private JTable inst4Empir;
    private float[] elemPercsVals;
    // private float elemPercFloat1, elemPercFloat2;
    private float[][] elemVals;
    private boolean redo = false, calculationsDone = false;
    ;
    private String[] options = {"1", "2", "3", "4", "5"};
    private String[] elementEnter;
    private int elemInForm;
    public boolean needsDouble;
    
    /**Constructor to call the prepareGui method and launch application
     * 
     */
    public EmpirMain() {
        prepareGui();
    }
    
    /**Main method for class
     * 
     * @param args
     * @return nothing
     */
    public static void main(String[] args) {
        EmpirMain empirSolver = new EmpirMain();
        empirSolver.welcome();
    }
    
    /**Prepares the Gui elements for the application.  Adds the basic
     * components to the panels.
     * 
     */
    private void prepareGui() {
        headerLabel1 = new JLabel("Empirical Formula Calculator", JLabel.CENTER);
        headerLabel1.setFont(new Font(headerLabel1.getFont().getName(), Font.PLAIN, 30));

        entryOptions = new JComboBox(options);
        entryOptions.setSelectedIndex(1);
        entry = new JFrame("Empirical Formula Calculator");
        entry.setSize(500, 200);
        entry.setLayout(new GridLayout(4, 1));
        entry.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        entry.add(headerLabel1);
        entry.add(new JLabel("Please select how many elements you have and click \"Next\""));
        entry.add(entryOptions);
        entry.setVisible(true);
        entry.setResizable(false);

        mainFrame = new JFrame("Empirical Formula Calculator");
        mainFrame.setSize(600, 600);
        mainFrame.setLayout(new GridLayout(7, 1));

        headerLabel = new JLabel("Empirical Formula Calculator", JLabel.CENTER);
        headerLabel.setFont(new Font(headerLabel.getFont().getName(), Font.PLAIN, 30));
        statusLabel = new JLabel("Please Enter Values (percents as whole percents without % e.g. 4.5 for 4.5%)",
                JLabel.CENTER);
        statusLabel.setFont(new Font(statusLabel.getFont().getName(), Font.PLAIN, 15));
        statusLabel.setSize(10, 20);

        element1 = new JPanel();
        element1.setLayout(new FlowLayout());
        element2 = new JPanel();
        element2.setLayout(new FlowLayout());
        backPanel = new JPanel();
        backPanel.setLayout(new FlowLayout());
        instrPanel = new JPanel();
        instrPanel.setLayout(new FlowLayout());

        controlPanel = new JPanel();
        controlPanel.setLayout(new FlowLayout());

        mainFrame.add(headerLabel);

        mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        instructions = new JFrame("Instructions for Calculating Empirical");
        instructions.setSize(700, 700);
        instructions.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        instructions.setLayout(new BorderLayout());

    }
    
    /**Prepares the text for the multiple screens in the application
     * as well as populates the multiple components on the Main screen.
     * 
     */
    private void prepareText() {
        elementEnter = new String[elemInForm];
        elemPercsVals = new float[elemInForm];
        elements = new JPanel[elemInForm];
        JLabel[] elemAsks = new JLabel[elemInForm];
        JLabel[] percAsks = new JLabel[elemInForm];
        final JTextField[] elemEn = new JTextField[elemInForm];
        final JTextField[] elemPercs = new JTextField[elemInForm];
        for (int i = 0; i < elements.length; i++) {
            elements[i] = new JPanel();
            elements[i].setLayout(new FlowLayout());
            elemAsks[i] = new JLabel("Element Symbol: ", JLabel.LEFT);
            percAsks[i] = new JLabel("Percent Mass: ", JLabel.RIGHT);
            elemEn[i] = new JTextField(3);
            elemPercs[i] = new JTextField(5);
            elements[i].add(elemAsks[i]);
            elements[i].add(elemEn[i]);
            elements[i].add(percAsks[i]);
            elements[i].add(elemPercs[i]);

        }

        JLabel elemAsk = new JLabel("Element Symbol: ", JLabel.LEFT);
        JLabel percAsk = new JLabel("Percent Mass: ", JLabel.RIGHT);
        JLabel elemAsk2 = new JLabel("Element Symbol: ", JLabel.LEFT);
        JLabel percAsk2 = new JLabel("Percent Mass: ", JLabel.RIGHT);
        final JTextField elem1 = new JTextField(3);
        final JTextField elem1Perc = new JTextField(5);
        final JTextField elem2 = new JTextField(3);
        final JTextField elem2Perc = new JTextField(5);

        element1.add(elemAsk);
        element1.add(elem1);
        element1.add(percAsk);
        element1.add(elem1Perc);

        element2.add(elemAsk2);
        element2.add(elem2);
        element2.add(percAsk2);
        element2.add(elem2Perc);
        mainFrame.setLayout(new GridLayout(elemInForm + 5, 0));

        for (JPanel pan : elements) {
            mainFrame.add(pan);
        }
        mainFrame.add(controlPanel);
        mainFrame.add(statusLabel);
        mainFrame.add(backPanel);
        mainFrame.add(instrPanel);
        mainFrame.setVisible(true);

        JButton calcButton = new JButton("Calculate");

        // Action Listener for Button Click
        calcButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
            	needsDouble = false;
                redo = false;
                try {
                    for (JTextField field : elemEn) {
                        if (field.getText().equals("")) {
                            redo = true;
                            System.out.println("This works");
                        }
                    }
                    float total = 0;
                    for (JTextField field : elemPercs) {
                        total += Float.valueOf(field.getText());
                    }

                    if (total != 100) {
                        if (redo) {
                            statusLabel.setText("Please enter all the elements and make sure percents add to 100");
                        } else {
                            redo = true;
                            statusLabel.setText("Please make percents add up to 100");
                        }
                    }

                    if (!redo) {

                        for (int i = 0; i < elemPercsVals.length; i++) {
                            elemPercsVals[i] = Float.valueOf(elemPercs[i].getText());
                        }

                        elemVals = new float[5][elemInForm];

                        System.arraycopy(elemPercsVals, 0, elemVals[0], 0, elemInForm);

                        try {
                            for (int i = 0; i < elemInForm; i++) {
                                elemVals[1][i] = FormulaCollect.molarMass(elemEn[i].getText());
                                elementEnter[i] = Element.toCorrectSymbol(elemEn[i].getText());

                            }
                            //Catches exception if the entered value doesn't match an element
                        } catch (IllegalArgumentException err) {
                            statusLabel.setText("Please enter correct symbols");
                            redo = true;
                        }
                        if (!redo) {

                            for (int i = 0; i < elemVals[0].length; i++) {
                                elemVals[2][i] = FormulaCollect.calcRatio(elemVals[0][i], elemVals[1][i]);
                            }

                            for (int i = 0; i < elemVals[0].length; i++) {
                                elemVals[3][i] = FormulaCollect.findSmallest(elemVals[2]);
                                elemVals[4][i] = FormulaCollect.finalWrapup(elemVals[2][i], elemVals[3][i]);
                            }
                            elemVals[4] = FormulaCollect.fixFormat(elemVals[4]);

                            String displayText = "<html>";
                            for (int i = 0; i < elemInForm; i++) {
                                displayText += Element.toCorrectSymbol(elemEn[i].getText());
                                displayText += "<sub>";
                                displayText += (int) elemVals[4][i];
                                displayText += "</sub>";
                            }
                            displayText += "</html>";

                            statusLabel.setText(displayText);

                            for (int i = 0; i < elemVals[0].length; i++) {
                                for (int j = 0; j < elemVals.length; j++) {
                                    System.out.print(elemVals[j][i] + " ");
                                }
                                System.out.println();
                            }
                            calculationsDone = !redo;
                        }
                    } else {

                    }
                    //Catches an exception if a value is not entered.
                } catch (NumberFormatException ex) {
                    statusLabel.setText("Please enter all values or change number of elements");
                }
            }
        });
        
        //Returns to the element screen.
        JButton back = new JButton("Return to Number of Elements");
        back.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent ae) {
                mainFrame.dispose();
                prepareGui();
                welcome();
            }
        });
        
        //Show the calculations used to get to the result
        JButton goToInstr = new JButton("Show Calculations");
        goToInstr.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent ae) {
                if (calculationsDone) {
                    giveInstructions();
                }
            }
        });

        controlPanel.add(calcButton);
        backPanel.add(back);
        instrPanel.add(goToInstr);

        mainFrame.setVisible(true);

    }

    /**
     * Method to close the welcome screen when the button is pressed and open the calculator screen
     *
     */
    public void welcome() {
        JButton start = new JButton("Next");
        start.addActionListener(new ActionListener() {

            public void actionPerformed(ActionEvent e) {
                elemInForm = entryOptions.getSelectedIndex() + 1;
                entry.dispose();
                mainFrame.setVisible(true);
                prepareText();
            }

        });
        entry.add(start);

    }

/** Method to render the JTable for the display to show instructions
 * used to get to the result
 * 
 */
    public void giveInstructions() {
        String[] columnNames = new String[]{"Atom", "Percent", "Molar Mass", "Divide by Molar Mass", "Divide by Smallest Moles",
            "Coefficient"};

        Object[][] data = new Object[elemInForm][6];

        for (int i = 0; i < elemInForm; i++) {
            data[i][0] = elementEnter[i];
        }

        for (int i = 0; i < elemInForm; i++) {
            for (int j = 1; j < 6; j++) {
                data[i][j] = Float.valueOf(elemVals[j - 1][i]);
            }
        }
        inst4Empir = new JTable(data, columnNames);
        inst4Empir.setPreferredScrollableViewportSize(new Dimension(600, 600));
        inst4Empir.setFillsViewportHeight(true);

        instructions.add(inst4Empir.getTableHeader(), BorderLayout.PAGE_START);
        instructions.add(inst4Empir, BorderLayout.CENTER);
        // instructions.pack();
        instructions.setVisible(true);
    }

}
