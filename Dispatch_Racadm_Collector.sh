#!/bin/bash

#########################################################################################################################
# Input 1 : $1 Tempo de execucao - TEMPO em Segundos
# Input 2 : $2 collect_energy_time[True-> 1, False-> 0] - Captura tempo da execucao de cada coleta de Racadm
#
# Output: Arquivo log com :
# --> tempo de Execucao por coleta de Racadmin
# --> tempo de Execucao total do loop de coleta
# --> Entrada (10s), saida media (20s)
# --> Collect Call Energy time? (Boolean)
#########################################################################################################################

today=`date +%Y-%m-%d-%H:%M:%S`

collect_call_energy_time=$2

if [ "$collect_call_energy_time" = "debug" ] ; then
	
time for((i==0 ; i< $1 ; i++  )) 
	    do 
		     now=`date +%H:%M:%S`
		     echo $now 
		     time racadm get system.Power.Realtime.Power 
            done

elif [ "$collect_call_energy_time" = "csv" ] ; then
for((i==0 ; i< $1 ; i++  ))
	do 
           now=`date +%H:%M:%S`
           # echo $now
	   energy_data=$(racadm get system.Power.Realtime.Power | head -1)
           echo $now " , "  $energy_data
   	   done

elif [ "$collect_call_energy_time" = "pipe" ] ; then 
for((i==0 ; i< $1 ; i++  ))
	        do
	           now=`date +%H:%M:%S`
                   # echo $now
                   energy_data=$(racadm get system.Power.Realtime.Power | head -1)
	           echo $now " | "  $energy_data
	           done

elif [ "$collect_call_energy_time" = "tab" ]; then
	for((i==0 ; i< $1 ; i++  ))
	         do 
          	 now=`date +%H:%M:%S`
	         # echo $now
                 energy_data=$(racadm get system.Power.Realtime.Power | head -1)
                 echo -e  $now ' \t '  $energy_data
		 done

	   
fi

