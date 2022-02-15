#region MetaHeader
//Temat: Algorytm Djikstry
//Opis: sample opis
//Data implementacji: 13.02.2022
//
//Członkowie:
#endregion

using System.Windows;
using System;
using Djikstry.Services;
using Newtonsoft.Json;
using DjikstryCSHarp;
#pragma warning disable CS8602
namespace Djikstry
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private Func<Node[]> executingFunction;
        private bool _isCSharpLibrary = true;

        public MainWindow()
        {
            InitializeComponent();
            string[] args = Environment.GetCommandLineArgs();
            if (args.Length == 2)
            {
                var inputArgsObject = JsonConvert.DeserializeObject<InputData>(args[0]);
                if (inputArgsObject == null)
                {
                    return;
                }
                StartingPoint.Text =  inputArgsObject.FirstNode;
                NumberOfVertexes.Text = inputArgsObject.NumberOfVertexes;

                string matrixInputText = "";
                foreach (var matrixRow in inputArgsObject.Matrix)

                {
                    matrixInputText += matrixRow.ToString() + "\r\n";
                }
                MatrixInput.Text = matrixInputText;
            } else if (args.Length == 4)
            {
                StartingPoint.Text = args[0];
                NumberOfVertexes.Text = args[1];
                MatrixInput.Text = args[2];
            }
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

            
            executingFunction = SetExecutingLibrary(_isCSharpLibrary, matrix, int.Parse(StartingPoint.Text));

            Watch<Node[]> watchdog = new Watch<Node[]>();
            watchdog.RunOnWatch(() => executingFunction());
            var executionTimeResult = watchdog.GetExecutionTime();
            var dataResult = watchdog.GetData();
            var resultString = $"Punkt początkowy: {StartingPoint.Text} \n\n";
            int i = 0;
            foreach(var node in dataResult)
            {
                resultString += $"{i}: {node.Distance}, poprzednik: {node.Predeccessor} \n";
            }
            resultString += $"Czas wykonania: {executionTimeResult}ms";
            results.Text = resultString;
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

        private static Func<Node[]> SetExecutingLibrary(bool isCSharpLibrary, int[,] matrix, int startingPoint)
        {
            if (isCSharpLibrary)
            {
                return () => DjikstryAlgorithm.Solve(matrix, startingPoint);
            }
            else
            {
                var djikstryAlgorithmAssembly = new DjikstryAssemblyAlgorithm();
                return () => djikstryAlgorithmAssembly.WrapSolve(matrix, matrix.GetLength(0), startingPoint);
            }

        }

        private void AlgorithmChoiceCombo_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            _isCSharpLibrary = AlgorithmChoiceCombo.SelectedIndex == 0;
        }
    }
}
#pragma warning restore