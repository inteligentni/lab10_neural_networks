package is.fon.vezbe1;

import org.neuroph.core.data.DataSet;
import org.neuroph.core.data.DataSetRow;
import org.neuroph.core.events.LearningEvent;
import org.neuroph.core.events.LearningEventListener;
import org.neuroph.nnet.MultiLayerPerceptron;
import org.neuroph.nnet.learning.BackPropagation;

/**
 * Multi Layer Perceptron for logical XOR example.
 */
public class XorMlpExample {
    public static void main(String[] args) {
        DataSet trainingSet = new DataSet(2, 1);
        trainingSet.add(new DataSetRow(new double[] {0, 0}, new double[]{0}));
        trainingSet.add(new DataSetRow(new double[] {0, 1}, new double[]{1}));
        trainingSet.add(new DataSetRow(new double[] {1, 0}, new double[]{1}));
        trainingSet.add(new DataSetRow(new double[] {1, 1}, new double[]{0}));

        MultiLayerPerceptron mlp = new MultiLayerPerceptron(2, 3, 1);

        BackPropagation bp = mlp.getLearningRule();
        bp.setMaxError(0.1);
        bp.addListener(new LearningEventListener() {
            @Override
            public void handleLearningEvent(LearningEvent event) {
                BackPropagation bp1 = (BackPropagation) event.getSource();
                System.out.println("Iteration: " + bp1.getCurrentIteration());
                System.out.println("Error: " + bp1.getTotalNetworkError());
            }
        });

        mlp.learn(trainingSet);

    }
}
