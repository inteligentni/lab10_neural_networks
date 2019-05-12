package is.fon.vezbe1;

import org.neuroph.core.data.DataSet;
import org.neuroph.core.data.DataSetRow;
import org.neuroph.nnet.Perceptron;

/**
 * Pereptron to learn two input logical AND, OR function.
 */
public class PerceptronExample {
    public static void main(String[] args) {

        DataSet trainingSet = new DataSet(2, 1);
        trainingSet.add(new DataSetRow(new double[] {0, 0}, new double[]{0}));
        trainingSet.add(new DataSetRow(new double[] {0, 1}, new double[]{1}));
        trainingSet.add(new DataSetRow(new double[] {1, 0}, new double[]{1}));
        trainingSet.add(new DataSetRow(new double[] {1, 1}, new double[]{1}));

        Perceptron perc = new Perceptron(2, 1);
        perc.learn(trainingSet);

        perc.setInput(1, 0);
        perc.calculate();
        System.out.println("Out:" + perc.getOutput()[0]);



    }
}
