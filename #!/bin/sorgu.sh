#!/bin/bash

#totalSorgu()=>Sistemdeki paket sayısını getirir

totalSorgu(){
    paket=$(dpkg -l | wc -l)
    echo "Sistemdeki paket sayısı: $paket"
}

#tekSorgu()=> paket: kurulu, değil; dependencies: kurulu, değil kontrolü yapar

tekSorgu(){
    # paket adı $1
    installedDepends=()
    notInstalledDepends=()
    dependsList=()
    paketK=$(dpkg -s $1 2>&1)
    install=$(echo $paketK | grep "is not installed")
    #echo ${#install}
    if [ ${#install} -eq 0 ];then
        echo " $1 paketi sistemde kuruludur."
    else
        echo " $1 paketi sistemde kurulu degildir."

        depends=$(apt-cache depends $1 | grep "Depends:" | cut -d ":" -f 2 )
        dependsCount=$(apt-cache depends $1 | grep "Depends:" | wc -l)
        echo " "
        echo "Paket için gerekli bağımlılıkların sayısı: $dependsCount"

        for word in $depends
        do
            dependsList+=($word)
            paketKontrol=$(dpkg -s $word 2>&1)
            installFlag=$(echo $paketKontrol | grep "is not installed")
            if [ ${#installFlag} -eq 0 ];then
                installedDepends+=($word)
            else
                notInstalledDepends+=($word)
            fi 
        done
        echo " "
        echo "Dependencies:"
        for (( i = 0 ; i < ${#dependsList[@]} ; i++ )); do               
            echo ${dependsList[i]}                                       
        done 
        echo " "
        echo "Dependencies on System:"
        for (( i = 0 ; i < ${#installedDepends[@]} ; i++ )); do               
            echo ${installedDepends[i]}                                       
        done
        echo " "
        echo "Dependencies must be downloaded :"
        for (( i = 0 ; i < ${#notInstalledDepends[@]} ; i++ )); do               
            echo ${notInstalledDepends[i]}                                       
        done

        echo " "
        echo "number of dependencies:${#notInstalledDepends[@]}"
    fi
  
}
