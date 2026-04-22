using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;

namespace HOLLOW_OCTAGONAL_PYRAMID_CALCULATOR.Pages
{
    public class IndexModel : PageModel
    {
        [BindProperty]
        public double OuterEdge { get; set; } = 10; // Default value
        [BindProperty]
        public double OuterHeight { get; set; } = 15;
        [BindProperty]
        public double InnerEdge { get; set; } = 7;
        [BindProperty]
        public double InnerHeight { get; set; } = 10;

        public double OuterVol { get; set; }
        public double InnerVol { get; set; }
        public double TotalVolume { get; set; }
        public bool IsCalculated { get; set; } = false;

        public void OnGet()
        {
            Calculate(); // Run once on load
        }

        public void OnPost()
        {
            Calculate();
            IsCalculated = true;
        }

        private void Calculate()
        {
            // Formula for area of regular octagon: 2 * (1 + sqrt(2)) * side^2
            double multiplier = 2 * (1 + Math.Sqrt(2));

            // Outer Pyramid Volume: (1/3) * BaseArea * Height
            OuterVol = (1.0 / 3.0) * (multiplier * Math.Pow(OuterEdge, 2)) * OuterHeight;

            // Inner Pyramid Volume (The hollow part)
            InnerVol = (1.0 / 3.0) * (multiplier * Math.Pow(InnerEdge, 2)) * InnerHeight;

            // Resulting solid material volume
            TotalVolume = Math.Max(0, OuterVol - InnerVol);
        }
    }
}