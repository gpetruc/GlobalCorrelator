#!/bin/bash
CSIM=project/solution/csim/build
if test -f $CSIM/input.txt; then
    echo " ## Getting C simulation inputs from $CSIM";
    cp -v $CSIM/*.txt .
else
    echo "Couldn't find C simulation inputs in $CSIM.";
    echo "Run vivado_hls in the parent directory before.";
    exit 1;
fi;
IMPL=project/solution/impl/vhdl

# cleanup
rm -r xsim* xelab* webtalk* vivado* xvhdl* test.wdb 2> /dev/null || true;


VHDLS="$IMPL/route_link2fifo.vhd $IMPL/router_monolythic_fifos_data_V_0.vhd $IMPL/router_monolythic.vhd phi_regionizer_tb.vhd"
if [[ "$1" == "hls_nomerge" ]]; then
    VHDLS="$IMPL/route_link2fifo.vhd $IMPL/router_nomerge_fifos_data_V_0.vhd $IMPL/router_nomerge.vhd phi_regionizer_nomerge_tb.vhd"
elif [[ "$1" == "vhdl_nomerge" ]]; then
    VHDLS=" regionizer_data.vhd rolling_fifo.vhd phi_regionizer_nomerge.vhd phi_regionizer_nomerge_vhdl_tb.vhd"
fi

echo " ## Compiling VHDL files: $VHDLS";
for V in $VHDLS; do
    xvhdl $V || exit 2;
    grep -q ERROR xvhdl.log && exit 2;
done;

echo " ## Elaborating: ";
xelab testbench -s test -debug all || exit 3;
grep -q ERROR xelab.log && exit 3;

if [[ "$1" == "--gui" ]]; then
    echo " ## Running simulation in the GUI: ";
    xsim test --gui
else
    echo " ## Running simulation in batch mode: ";
    xsim test -R || exit 4;
    grep -q ERROR xsim.log && exit 4;

    test -f output_vhdl_tb.txt && echo " ## Output produced in output_vhdl_tb.txt ";
fi