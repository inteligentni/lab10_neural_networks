package is.fon.vezbe1;

import org.neuroph.core.Neuron;
import org.neuroph.core.transfer.Sigmoid;
import org.neuroph.nnet.comp.neuron.InputNeuron;

/**
 * Simple artificial neuron example.
 */
public class ArtificialNeuron {

    public static void main(String[] args) {
        Neuron myNeuron = new Neuron();
        InputNeuron inNeuron = new InputNeuron();
        myNeuron.addInputConnection(inNeuron);
        myNeuron.setTransferFunction(new Sigmoid());

        inNeuron.setInput(0.5);
        myNeuron.calculate();
        System.out.println("Neuron's out: "+myNeuron.getOutput());
    }

}
