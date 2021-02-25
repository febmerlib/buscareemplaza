#!/bin/bash
SCRIPT=$(readlink -f $0);
dir_base=`dirname $SCRIPT`;
 

dir=$1 # 1st parameter
if [ -d $dir ];
then
	echo $dir
#echo "Sí, sí existe."
#largo_dir=${#dir}
#larg=$((largo_dir - 1))
#ult_caracter=${dir:$larg:1}
#echo $ult_caracter


	while :
	do

	read -p "Introduce busqueda: " busqueda
	read -p "Introduce reemplazo: " reemplazo
	echo "" > /tmp/5
	grep -R -w "$busqueda" $dir > /tmp/5 #-l
	cont=0
		while IFS= read -r linea; 
		#while IFS=':' read -ra linea
		do

			#echo "${linea[1]}/n"
			line[cont]=$linea
			archivo[cont]=${linea%%:*}
			info[cont]=${linea#*:}
			cont=$((cont + 1))
		done < /tmp/5
		echo "Se han encontrado $cont coincidencias."
		cl="32m"
		for (( c=0; c<cont; c++ ))
		do  
			 echo ${info[c]}
			 echo -n -e "Sustituir \e[$cl $busqueda \e[0m por \e[$cl $reemplazo \e[0m en: \e[$cl ${archivo[c]} \e[0m s/n :  " 
			 read confirmacion
			if [ $confirmacion == "s" -o $confirmacion == "n" ] ;then
				fh=$(date +"%d-%m-%y %T")
				if [ $confirmacion == "s" ];then
					cadena="s/$busqueda/$reemplazo/g"
					sed -i "$cadena" ${archivo[c]}
					echo -e "\e[33m modificación OK \e[0m"
					echo "$fh OK ${archivo[c]}!|$busqueda!|$reemplazo" >> $dir_base/buscareemplaza.log
				else
					echo -e "\e[31m NO modificado \e[0m"
					echo "$fh NO ${archivo[c]}!|$busqueda!|$reemplazo" >> $dir_base/buscareemplaza.log
				fi
				#if [ $cl == "32m" ];then
				#	cl="33m"
				#else 
				#	cl="32m"
				#fi
			else
				echo "Debe seleccionar s o n"
				c=$((c - 1))
			fi
		done
	done

else
echo "directorio no existe"
fi

#por Jafet Montilla
