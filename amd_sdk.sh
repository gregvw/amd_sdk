#!/bin/bash

if [ ! -x /usr/bin/wget ] ; then
    # some extra check if wget is not installed at the usual place                                                                           
    command -v wget >/dev/null 2>&1 || { echo >&2 "Please install wget or set it in your path. Aborting."; exit 1; }
    echo "You can install wget with the command" 
    echo "sudo apt-get install wget"
fi

if [ "$#" -ne 1 ]; then 
    echo "Select 32 or 64"
else 

    # If 64-bit
    if [ $1 -eq "64" ]
    then  

        echo "64-bit selected"

        wget --content-disposition --trust-server-names --post-data='amd_developer_central_nonce=156bbd16d6&_wp_http_referer=/tools-and-sdks/opencl-zone/opencl-tools-sdks/amd-accelerated-parallel-processing-app-sdk/&f=QU1ELUFQUC1TREstdjIuOS1sbng2NC50Z3o=' http://developer.amd.com/tools-and-sdks/opencl-zone/opencl-tools-sdks/amd-accelerated-parallel-processing-app-sdk/

        tar zxvf AMD-APP-SDK-v2.9-lnx64.tgz 

    elif [ $1 -eq "32" ] # 32 bit version
    then  
        echo "32-bit selected"

        wget --content-disposition --trust-server-names --post-data='amd_developer_central_nonce=50c6c41ae1&_wp_http_referer=/tools-and-sdks/opencl-zone/opencl-tools-sdks/amd-accelerated-parallel-processing-app-sdk/&f=QU1ELUFQUC1TREstdjIuOS1sbngzMi50Z3o=' http://developer.amd.com/tools-and-sdks/opencl-zone/opencl-tools-sdks/amd-accelerated-parallel-processing-app-sdk/

        tar zxvf AMD-APP-SDK-v2.9-lnx32.tgz 

    else 
    
        echo "Select 32 or 64"
    fi

        sh ./Install-AMD-APP.sh 
        ln -sf /opt/AMDAPP/include/CL /usr/include
        ln -sf /opt/AMDAPP/lib/x86/* /usr/lib/
        ldconfig
fi

