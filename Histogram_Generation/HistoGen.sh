yum list installed | grep "gnuplot"
if [ $? == 0 ]
then
echo "GNUPlot is already installed in this system"
else
echo "GNUPlot is being installed in this system"
sudo yum install gnuplot -y
fi
v_resp_time=( $(grep -B1 "Everything looks good" log.txt |grep "PID" | awk '{print $5}'| cut -d "[" -f2 |cut -d "m" -f1 | xargs) )
# captured only success response times into an array
echo "Generating Hisogram Feed..."

for i in ${v_resp_time[@]}; do echo $i; done | sort | uniq -c| awk '{print $2 " " $1*0.50 " " $1*0.90 " " $1*0.95  }' > RT_Histogram_data.txt

echo "Generating Hisogram Plot..."

echo "
set terminal pdf
set output \"histo.pdf\"
set style data linespoints
set title \"ResponseTime Data\"
set xlabel \"Response Time\"
set ylabel \"Count Per RT\"
set grid

plot \"RT_Histogram_data.txt\" using 1:2 with linespoint title \"50%\" lw 3, '' with labels center offset .5,.5 notitle,\"RT_Histogram_data.txt\" using 1:3 with linespoint title \"90%\" lw 3, '' with labels center offset .5,.5 notitle,\"RT_Histogram_data.txt\" using 1:4 with linespoint title \"95%\" lw 3, '' with labels center offset .5,.5 notitle" > RT_Histogram_plot.plt

sudo gnuplot RT_Histogram_plot.plt
if [ $? == 0 ]
then
echo "Check The Generated Histogram In The Same Directory"
else
echo "Something Has Gone Wrong"
fi

