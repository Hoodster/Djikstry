﻿using System.Windows;
using System;
using DjikstryCSHarp;
using Djikstry.Services;
using Newtonsoft.Json;
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
            if (args.Length == 1)
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
            } else if (args.Length == 3)
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
                var djikstryAlgorithmCSharp = new DjikstryAlgorithm();
                return () => DjikstryAlgorithm.Solve(matrix, startingPoint);
            } else
            {
                var djikstryAlgorithmAssembly = new DjikstryAssemblyAlgorithm();
                return () => djikstryAlgorithmAssembly.WrapSolve(matrix, startingPoint);
            }
            
        }

        private void AlgorithmChoiceCombo_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            _isCSharpLibrary = AlgorithmChoiceCombo.SelectedIndex == 0;
        }
    }
}
#pragma warning restore