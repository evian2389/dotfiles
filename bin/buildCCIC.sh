#source /usr/local/oecore-x86_64/environment-setup-corei7-64-oe-linux
source /usr/local/ccic_SDK/environment-setup-aarch64-gnu-linux
qmake *.pro -spec linux-oe-g++ CONFIG+=debug CONFIG+=qml_debug
make -j9
