set origin_dir "."
set _xil_proj_name_ "nicdevmmio"

create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xc7z020clg400-1
set proj_dir [get_property directory [current_project]]

set obj [current_project]
set_property -name "board_part" -value "digilentinc.com:zybo-z7-20:part0:1.0" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "platform.board_id" -value "zybo-z7-20" -objects $obj
set_property -name "revised_directory_structure" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_FIFO XPM_MEMORY" -objects $obj

set source_files { \
  ../nicdevmmio/mmiotop.v \
  ../nicdevmmio/nicporcessor_send.v \
  ../nicdevmmio/nicprocessor_recv.v \
  ../nicdevmmio/packetgen_conv.v \
  ../nicdevmmio/packetgensimple.v \
}

set ipcore_files { \
  ./ipcores_nicdevmmio/fifo_generator_0.xci \
  ./ipcores_nicdevmmio/packet_send_ila.xci \
}

set constraint_files { \
  ../nicdevmmio/main.xdc \
}

add_files -norecurse $source_files
import_ip -files $ipcore_files
update_ip_catalog

add_files -fileset constrs_1 -norecurse $constraint_files

source nicdevmmio_design_1.tcl
validate_bd_design
save_bd_design
close_bd_design [get_bd_designs design_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

make_wrapper -files [get_files ./nicdevmmio/nicdevmmio.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse ./nicdevmmio/nicdevmmio.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

set_property top design_1_wrapper [current_fileset]

# build process
launch_runs synth_1 -jobs 20
wait_on_run synth_1

launch_runs impl_1 -jobs 20
wait_on_run impl_1

launch_runs impl_1 -to_step write_bitstream -jobs 20
wait_on_run impl_1

write_hw_platform -fixed -include_bit -force -file ./nicdevmmio/design_1_wrapper.xsa

close_project
quit

