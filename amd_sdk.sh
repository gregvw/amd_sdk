#!/bin/bash

if [ ! -x /usr/bin/wget ] ; then
    command -v wget >/dev/null 2>&1 || { echo >&2 "wget not found. Installing wget now."; exit 1; }
    apt-get install wget
fi

# Location from which to download
url1="http://developer.amd.com/tools-and-sdks/opencl-zone/opencl-tools-sdks/"
url2="amd-accelerated-parallel-processing-app-sdk/"
url=$url1$url2

# Lookup the JavaScript value of the of the download on the AMD SDK page
kernel=`arch`

a="amd_developer_central_nonce="
b='&_wp_http_referer=/tools-and-sdks/opencl-zone/opencl-tools-sdks/'
c='amd-accelerated-parallel-processing-app-sdk/&f='

if [ $kernel == "x86_64" ] # 64-bit version
then  
    echo "64-bit kernel detected"
    value1=`wget -qO - $url | sed -n '/download-2/,/64-bit/p'`
    value2='QU1ELUFQUC1TREstdjIuOS1sbng2NC50Z3o='
 
else # 32-bit version
    echo "32-bit kernel detected"
    value1=`wget -qO - $url | sed -n '/download-1/,/32-bit/p'`
    value2='QU1ELUFQUC1TREstdjIuOS1sbngzMi50Z3o='
fi

value1=`echo $value1 | awk -F 'value="' '{print $2}'`
value1=`echo $value1 | awk -F'"' '{print $1}'`
value1=`echo $value1 | head -2`
value1=`echo $value1 | tail -1`
    
# Concatenate
text=$a$value1$b$c$value2   

wget --content-disposition --trust-server-names --post-data=$text $url


tar zxvf AMD-APP-SDK-v2.9-lnx32.tgz 
sh ./Install-AMD-APP.sh 
ln -sf /opt/AMDAPP/include/CL /usr/include
ln -sf /opt/AMDAPP/lib/x86/* /usr/lib/
ldconfig


