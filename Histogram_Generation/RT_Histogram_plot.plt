
set terminal pdf
set output "histo.pdf"
set style data linespoints
set title "ResponseTime Data"
set xlabel "Response Time"
set ylabel "Count Per RT"
set grid

plot "RT_Histogram_data.txt" using 1:2 with linespoint title "50%" lw 3, '' with labels center offset .5,.5 notitle,"RT_Histogram_data.txt" using 1:3 with linespoint title "90%" lw 3, '' with labels center offset .5,.5 notitle,"RT_Histogram_data.txt" using 1:4 with linespoint title "95%" lw 3, '' with labels center offset .5,.5 notitle
