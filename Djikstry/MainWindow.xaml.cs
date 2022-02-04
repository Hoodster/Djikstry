using System.Windows;
using System;

namespace Djikstry
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void CheckInputToProcess(object sender, RoutedEventArgs e)
        {
            SolveButton.IsEnabled = NumberOfVertexes.Text.Length != 0
                && MatrixInput.Text.Length != 0 
                && StartingPoint.Text.Length != 0;
        }

        private void SolveButton_Click(object sender, RoutedEventArgs e)
        {
            var matrixLength = int.Parse(NumberOfVertexes.Text);
            var matrix = MapMatrixInput(MatrixInput.Text, matrixLength);
            var djikstryAlgorithm = new DjikstryCSHarp.DjikstryAlgorithm();
            var result = djikstryAlgorithm.Solve(matrix, int.Parse(StartingPoint.Text));
            Console.Write(result);
        }

        private static int[,] MapMatrixInput(string input, int matrixLength)
        {
            int i = 0;
            int[,] output;
            var rowsString = input.Split("\r\n");
            output = new int[matrixLength, matrixLength];
            foreach (var rowInput in rowsString)
            {
                var row = rowInput.Split(" ");
                int l = 0;
                foreach (var colInput in row)
                {
                    output[i, l] = int.Parse(colInput.ToString());
                    l++;
                }
                i++;
            }
            return output;
        }
    }
}
