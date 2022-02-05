using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

namespace Djikstry.Services
{
    public class Watch<T>
    {
        private Stopwatch stopWatch;
        private double duration;
        private T data;

        public Watch()
        {
            stopWatch = new Stopwatch();
        }

        public void RunOnWatch(Func<T> executable)
        { 
            executable(); // first execution to remove background noise
            stopWatch.Start();
            data = executable();
            stopWatch.Stop();
            duration = stopWatch.Elapsed.TotalMilliseconds;
        }

        public double GetExecutionTime()
        {
            return duration;
        }

        public T GetData()
        {
            return data;
        }
    }
}
