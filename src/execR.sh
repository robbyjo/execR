#!/bin/bash
# execR 0.0.1
# execR
# Version: 0.0.1
# By: Roby Joehanes
#
# Copyright 2016-2017 Roby Joehanes
# This file is distributed under the GNU General Public License version 3.0.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Do not forget to do this:
# sudo chmod 666 /var/run/docker.sock
# dx-docker add-to-applet robbyjo/r-mkl-bioconductor:3.4.1 assoctool

main() {
    echo "Value of r_code: '$r_code'"
    echo "Value of output_file: '$output_file'"

    mkdir -p /data/
    r_code_file_name=`dx ls "$r_code"`
    echo "Real name of r_code file: $r_code_file_name"
    dx download "$r_code" -o "/data/${r_code_file_name}" &
    PARMS+=(--r_code=/data/${r_code_file_name})

# Required parameters
    PARMS+=(--output_file=/data/results)

# Optional parameters
    if [[ "$param_str" != "" ]] ; then
        echo "Value of param_str: '$param_str'"
        PARMS+=(--param_str="'$param_str'")
    fi
 
    if [[ "$debug" != "" ]] ; then
        echo "Value of debug: '$debug'"
        PARMS+=(--debug="$debug")
    else
        echo "Value of debug is not set. Setting to zero."
        debug=0
        PARMS+=(--debug="0")
    fi

    if [[ "$prologue_shell" != "" ]] ; then
        echo "Value of prologue_shell: '$prologue_shell'"
        prologue_shell_file_name=`dx ls "$prologue_shell"`
        echo "Real name of prologue shell file: $prologue_shell_file_name"
        dx download "$prologue_shell" -o "/data/${prologue_shell_file_name}" &
        PARMS+=(--prologue_shell="/data/${prologue_shell_file_name}")
    fi
    if [[ "$epilogue_shell" != "" ]] ; then
        echo "Value of epilogue_shell: '$epilogue_shell'"
        epilogue_shell_file_name=`dx ls "$epilogue_shell"`
        echo "Real name of epilogue shell file: $epilogue_shell_file_name"
        dx download "$epilogue_shell" -o "/data/${epilogue_shell_file_name}" &
        PARMS+=(--epilogue_shell="/data/${epilogue_shell_file_name}")
    fi

    if [[ "$input_file1" != "" ]] ; then
        echo "Value of input_file1: '$input_file1'"
        input_file1_name=`dx ls "$input_file1"`
        echo "Real name of input_file1: $input_file1_name"
        dx download "$input_file1" -o "/data/${input_file1_name}" &
        PARMS+=(--input_file1="/data/${input_file1_name}")
    fi
    if [[ "$input_file2" != "" ]] ; then
        echo "Value of input_file2: '$input_file2'"
        input_file2_name=`dx ls "$input_file2"`
        echo "Real name of input_file2: $input_file2_name"
        dx download "$input_file2" -o "/data/${input_file2_name}" &
        PARMS+=(--input_file2="/data/${input_file2_name}")
    fi
    if [[ "$input_file3" != "" ]] ; then
        echo "Value of input_file3: '$input_file3'"
        input_file3_name=`dx ls "$input_file3"`
        echo "Real name of input_file3: $input_file3_name"
        dx download "$input_file3" -o "/data/${input_file3_name}" &
        PARMS+=(--input_file3="/data/${input_file3_name}")
    fi
    if [[ "$input_file4" != "" ]] ; then
        echo "Value of input_file4: '$input_file4'"
        input_file4_name=`dx ls "$input_file4"`
        echo "Real name of input_file4: $input_file4_name"
        dx download "$input_file4" -o "/data/${input_file4_name}" &
        PARMS+=(--input_file4="/data/${input_file4_name}")
    fi
    if [[ "$input_file5" != "" ]] ; then
        echo "Value of input_file5: '$input_file5'"
        input_file5_name=`dx ls "$input_file5"`
        echo "Real name of input_file5: $input_file5_name"
        dx download "$input_file5" -o "/data/${input_file5_name}" &
        PARMS+=(--input_file5="/data/${input_file5_name}")
    fi
    if [[ "$input_file6" != "" ]] ; then
        echo "Value of input_file6: '$input_file6'"
        input_file6_name=`dx ls "$input_file6"`
        echo "Real name of input_file6: $input_file6_name"
        dx download "$input_file6" -o "/data/${input_file6_name}" &
        PARMS+=(--input_file6="/data/${input_file6_name}")
    fi
    if [[ "$input_file7" != "" ]] ; then
        echo "Value of input_file7: '$input_file7'"
        input_file7_name=`dx ls "$input_file7"`
        echo "Real name of input_file7: $input_file7_name"
        dx download "$input_file7" -o "/data/${input_file7_name}" &
        PARMS+=(--input_file7="/data/${input_file7_name}")
    fi
    if [[ "$input_file8" != "" ]] ; then
        echo "Value of input_file8: '$input_file8'"
        input_file8_name=`dx ls "$input_file8"`
        echo "Real name of input_file8: $input_file8_name"
        dx download "$input_file8" -o "/data/${input_file8_name}" &
        PARMS+=(--input_file8="/data/${input_file8_name}")
    fi
    if [[ "$input_file9" != "" ]] ; then
        echo "Value of input_file9: '$input_file9'"
        input_file9_name=`dx ls "$input_file9"`
        echo "Real name of input_file9: $input_file9_name"
        dx download "$input_file9" -o "/data/${input_file9_name}" &
        PARMS+=(--input_file9="/data/${input_file9_name}")
    fi
    if [[ "$input_file10" != "" ]] ; then
        echo "Value of input_file10: '$input_file10'"
        input_file10_name=`dx ls "$input_file10"`
        echo "Real name of input_file10: $input_file10_name"
        dx download "$input_file10" -o "/data/${input_file10_name}" &
        PARMS+=(--input_file10="/data/${input_file10_name}")
    fi

    echo "Waiting for all file transfers to complete..."
    wait
    sudo chmod o+rw /tmp

    if [ ${r_code_file_name: -7} == ".tar.gz" ] ; then
        echo "R code is in .tar.gz format. Extracting..."
        echo "tar zxvf /data/${r_code_file_name} -C /data"
        tar zxvf /data/${r_code_file_name} -C /data
    elif [ ${r_code_file_name: -8} == ".tar.bz2" ] ; then
        echo "R code is in .tar.bz2 format. Extracting..."
        echo "tar jxvf /data/${r_code_file_name} -C /data"
        tar jxvf /data/${r_code_file_name} -C /data
    else
        echo "R code is assumed in an R format, renaming to /data/main.R"
        mv /data/${r_code_file_name} /data/main.R
    fi

    if [ ! -e /data/main.R ] && [ -e /data/main.r ] ; then
        echo "It looks like the main R code is called main.r. Renaming to main.R."
        mv /data/main.r /data/main.R
    fi

    echo "===== Listing /data/ ====="
    ls -R /data/
    echo "===== Listing /data/ ends ====="

    if [ ! -e /data/main.R ] ; then
        echo "******** ERROR: Main R code /data/main.R does not exist!"
        exit -1
    fi

    echo '#!/bin/bash' > /data/runme.sh
    echo 'export MKL_NUM_THREADS=1' >> /data/runme.sh
    echo 'pwd is:' >> /data/runme.sh
    echo "pwd" >> /data/runme.sh
    if [[ "$prologue_shell" != "" ]] ; then
        echo "Running prologue shell..." >> /data/runme.sh
        x="/data/${prologue_shell_file_name} ${PARMS[@]}"
        echo "echo \"$x\"" >> /data/runme.sh
        x="/data/${prologue_shell_file_name} ${PARMS[@]}"
        echo "$x" >> /data/runme.sh
        echo 'echo "Finished running prologue shell code"' >> /data/runme.sh
    fi
    x="Rscript /data/exec.R ${PARMS[@]}"
    echo "echo \"$x\"" >> /data/runme.sh
    echo 'echo "Running code"' >> /data/runme.sh
    x="/usr/bin/Rscript --vanilla /data/main.R ${PARMS[@]}"
    echo "$x" >> /data/runme.sh
    echo 'echo "Finished running main R code"' >> /data/runme.sh
    if [[ "$epilogue_shell" != "" ]] ; then
        echo "Running epilogue shell..." >> /data/runme.sh
        x="/data/${epilogue_shell_file_name} ${PARMS[@]}"
        echo "echo \"$x\"" >> /data/runme.sh
        x="/data/${epilogue_shell_file_name} ${PARMS[@]}"
        echo "$x" >> /data/runme.sh
        echo 'echo "Finished running epilogue shell code"' >> /data/runme.sh
    fi
    chmod 700 /data/runme.sh

    echo "The following script is going to be executed:"
    echo "============================ Script begin ============================ "
    cat /data/runme.sh
    echo "============================= Script end ============================= "

    dx-docker run -v /data/:/data/ robbyjo/r-mkl-bioconductor:3.4.1 /bin/bash /data/runme.sh

    results="/data/results"
    if [ -e /data/results ] ; then
       results=$(dx upload ${results} --brief)
       echo "Uploaded results: '$results'"
       dx-jobutil-add-output results "$results" --class=file
       echo "Moving results to ${output_file}"
       dx mv ${results} ${output_file}
    else
       echo "No result file is detected"
    fi
}
