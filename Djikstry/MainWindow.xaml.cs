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
        public MainWindow()
        {
            InitializeComponent();
            Input11.Text = "1";
            Input12.Text = "2";
            Input13.Text = "3";
            Input14.Text = "4";

            Input21.Text = "2";
            Input22.Text = "2";
            Input23.Text = "2";
            Input24.Text = "2";
        }

        private void Execute(int type, out float[] t)
        {
            var x1 = new float[] { 
                float.Parse(Input11.Text), 
                float.Parse(Input12.Text),
                float.Parse(Input13.Text),
                float.Parse(Input14.Text),
            };

            var x2 = new float[] {
                float.Parse(Input21.Text),
                float.Parse(Input22.Text),
                float.Parse(Input23.Text),
                float.Parse(Input24.Text),
            };
            var transferData = new InputData(x1, x2, type);
            var djikstryAlgorithmAssembly = new DjikstryAssemblyAlgorithm();
            djikstryAlgorithmAssembly.WrapSolve(transferData, out float[] result);
            t = result;
        }

        private void SetResult(float[] results)
        {
            string text = "";
            text += $"Result 1: {results[0]} \n";
            text += $"Result 2: {results[1]} \n";
            text += $"Result 3: {results[2]} \n";
            text += $"Result 4: {results[3]} \n";
            Result.Text = text;

        }

        private void PlusButton_Click(object sender, RoutedEventArgs e)
        {
            Execute(0, out float[] result);
            SetResult(result);
        }

        private void MinusButton_Click(object sender, RoutedEventArgs e)
        {
            Execute(1, out float[] result);
            SetResult(result);
        }

        private void MultipleButton_Click(object sender, RoutedEventArgs e)
        {
            Execute(2, out float[] result);
            SetResult(result);
        }

        private void DivideButton_Click(object sender, RoutedEventArgs e)
        {
            Execute(3, out float[] result);
            SetResult(result);
        }
    }
}
#pragma warning restore