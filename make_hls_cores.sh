#!/bin/bash

if [[ "$1" == "" ]]; then echo "Usage : $0 core"; exit 1; fi;
test -d ip_cores_firmware || mkdir ip_cores_firmware

while [[ "$1" != "" ]]; do
  core=$1; shift;
  case $core in
    pfHGCal_240MHz_ii4)
        test -d ip_cores_firmware/$core && rm -r ip_cores_firmware/$core 2> /dev/null;
        mkdir -p ip_cores_firmware/$core/firmware/{hdl,cfg} &&
        pushd l1pf_hls &&
            (test -d proj_pfHGCal_VCU118_240MHz_II4 || vivado_hls -f run_hls_pfalgo2hgc_240MHz_II4.tcl) &&
            popd &&
        cp -v l1pf_hls/proj_pfHGCal_VCU118_240MHz_II4/solution/impl/vhdl/* ip_cores_firmware/$core/firmware/hdl/ &&
        (cd ip_cores_firmware/$core/firmware/hdl && ls -1 ) | sed 's/^/src /' | tee ip_cores_firmware/$core/firmware/cfg/top.dep;
        ;;
    puppiHGCal_240MHz_ii4)
        test -d ip_cores_firmware/${core}_charged && rm -r ip_cores_firmware/${core}_{charged,neutral} 2> /dev/null;
        mkdir -p ip_cores_firmware/${core}_{charged,neutral}/firmware/{hdl,cfg} &&
        pushd l1pf_hls/puppi &&
            (test -d proj_linpuppi_HGCal_VCU118_240MHz_II4_charged || vivado_hls -f run_hls_linpuppi_hgcal_240MHz_II4.tcl ) &&
            popd &&
        for X in charged neutral; do
            cp -v l1pf_hls/puppi/proj_linpuppi_HGCal_VCU118_240MHz_II4_${X}/solution/impl/vhdl/* ip_cores_firmware/${core}_${X}/firmware/hdl/ &&
            (cd ip_cores_firmware/${core}_${X}/firmware/hdl && ls -1 ) | sed 's/^/src /' | tee ip_cores_firmware/${core}_${X}/firmware/cfg/top.dep;
        done
        ;;
    puppiHGCal_240MHz_stream)
        test -d ip_cores_firmware/${core}_prep && rm -r ip_cores_firmware/${core}_{prep,one,chs} 2> /dev/null;
        mkdir -p ip_cores_firmware/${core}_{prep,one,chs}/firmware/{hdl,cfg} &&
        pushd l1pf_hls/puppi &&
            (test -d proj_linpuppi_HGCal_VCU118_240MHz_stream_prep || vivado_hls -f run_hls_linpuppi_hgcal_240MHz_stream.tcl ) &&
            popd &&
        for X in prep one chs; do
            cp -v l1pf_hls/puppi/proj_linpuppi_HGCal_VCU118_240MHz_stream_${X}/solution/impl/vhdl/* ip_cores_firmware/${core}_${X}/firmware/hdl/ &&
            (cd ip_cores_firmware/${core}_${X}/firmware/hdl && ls -1 ) | sed 's/^/src /' | tee ip_cores_firmware/${core}_${X}/firmware/cfg/top.dep;
        done
        ;;
    pfHGCal_360MHz_ii6)
        test -d ip_cores_firmware/$core && rm -r ip_cores_firmware/$core 2> /dev/null;
        mkdir -p ip_cores_firmware/$core/firmware/{hdl,cfg} &&
        pushd l1pf_hls &&
            (test -d proj_pfHGCal_VCU118_360MHz_II6 || vivado_hls -f run_hls_pfalgo2hgc_360MHz_II6.tcl) &&
            popd &&
        cp -v l1pf_hls/proj_pfHGCal_VCU118_360MHz_II6/solution/impl/vhdl/* ip_cores_firmware/$core/firmware/hdl/ &&
        (cd ip_cores_firmware/$core/firmware/hdl && ls -1 ) | sed 's/^/src /' | tee ip_cores_firmware/$core/firmware/cfg/top.dep;
        ;;
    puppiHGCal_360MHz_ii6)
        test -d ip_cores_firmware/${core}_charged && rm -r ip_cores_firmware/${core}_{charged,neutral} 2> /dev/null;
        mkdir -p ip_cores_firmware/${core}_{charged,neutral}/firmware/{hdl,cfg} &&
        pushd l1pf_hls/puppi &&
            (test -d l1pf_hls/puppi/proj_linpuppi_HGCal_VCU118_360MHz_II6_charged || vivado_hls -f run_hls_linpuppi_hgcal_360MHz_II6.tcl ) &&
            popd &&
        for X in charged neutral; do
            cp -v l1pf_hls/puppi/proj_linpuppi_HGCal_VCU118_360MHz_II6_${X}/solution/impl/vhdl/* ip_cores_firmware/${core}_${X}/firmware/hdl/ &&
            (cd ip_cores_firmware/${core}_${X}/firmware/hdl && ls -1 ) | sed 's/^/src /' | tee ip_cores_firmware/${core}_${X}/firmware/cfg/top.dep;
        done
        ;;
    tdemux)
        test -d ip_cores_firmware/$core && rm -r ip_cores_firmware/$core 2> /dev/null;
        mkdir -p ip_cores_firmware/$core/firmware/{hdl,cfg} &&
        pushd l1pf_hls/multififo_regionizer/tdemux &&
            (test -d project || vivado_hls -f run_hls.tcl) &&
            popd &&
        cp -v l1pf_hls/multififo_regionizer/tdemux/project/solution/impl/vhdl/* ip_cores_firmware/$core/firmware/hdl/ &&
        (cd ip_cores_firmware/$core/firmware/hdl && ls -1 ) | sed 's/^/src /' | tee ip_cores_firmware/$core/firmware/cfg/top.dep;
        ;;
    unpackers)
        test -d ip_cores_firmware/$core && rm -r ip_cores_firmware/$core 2> /dev/null;
        mkdir -p ip_cores_firmware/$core/firmware/{hdl,cfg} &&
        pushd l1pf_hls/multififo_regionizer &&
            (test -d project_unpack_hgcal_3to1 && test -d project_unpack_mu_3to12 && test -d project_unpack_track_3to2 || vivado_hls -f run_hls_unpackers.tcl) &&
            popd &&
        cp -v l1pf_hls/multififo_regionizer/project_unpack_{hgcal_3to1,track_3to2,mu_3to12}/solution/impl/vhdl/* ip_cores_firmware/$core/firmware/hdl/ &&
        (cd ip_cores_firmware/$core/firmware/hdl && ls -1 ) | sed 's/^/src /' | tee ip_cores_firmware/$core/firmware/cfg/top.dep;
        ;;
    *)
        echo "Unknown or unsupported core $core";
        exit 1;
        ;;
  esac;
done
