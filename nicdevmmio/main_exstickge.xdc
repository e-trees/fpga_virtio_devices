#UART
set_property PACKAGE_PIN R18 [get_ports uart_rtl_rxd]
set_property PACKAGE_PIN T18 [get_ports uart_rtl_txd]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rtl_rxd]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rtl_txd]
#QSPI
set_property IOSTANDARD LVCMOS33 [get_ports spi_rtl_io0_io]
set_property IOSTANDARD LVCMOS33 [get_ports spi_rtl_io1_io]
set_property IOSTANDARD LVCMOS33 [get_ports spi_rtl_io2_io]
set_property IOSTANDARD LVCMOS33 [get_ports spi_rtl_io3_io]
set_property IOSTANDARD LVCMOS33 [get_ports {spi_rtl_ss_io[0]}]
set_property PACKAGE_PIN P22 [get_ports spi_rtl_io0_io]
set_property PACKAGE_PIN R22 [get_ports spi_rtl_io1_io]
set_property PACKAGE_PIN P21 [get_ports spi_rtl_io2_io]
set_property PACKAGE_PIN R21 [get_ports spi_rtl_io3_io]
set_property PACKAGE_PIN T19 [get_ports {spi_rtl_ss_io[0]}]


set_property PACKAGE_PIN F13 [get_ports dipsw2p_tri_i[0]]
set_property PACKAGE_PIN F14 [get_ports dipsw2p_tri_i[1]]
set_property IOSTANDARD LVCMOS33 [get_ports dipsw2p_tri_i[0]]
set_property IOSTANDARD LVCMOS33 [get_ports dipsw2p_tri_i[1]]
set_property PULLDOWN true [get_ports {dipsw2p_tri_i[0]}]
set_property PULLDOWN true [get_ports {dipsw2p_tri_i[1]}]