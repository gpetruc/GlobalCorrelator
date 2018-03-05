-- Address decode logic for ipbus fabric
-- 
-- This file has been AUTOGENERATED from the address table - do not hand edit
-- 
-- We assume the synthesis tool is clever enough to recognise exclusive conditions
-- in the if statement.
-- 
-- Dave Newbold, February 2011

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

package ipbus_decode_vcu118_infra is

  constant IPBUS_SEL_WIDTH: positive := 5; -- Should be enough for now?
  subtype ipbus_sel_t is std_logic_vector(IPBUS_SEL_WIDTH - 1 downto 0);
  function ipbus_sel_vcu118_infra(addr : in std_logic_vector(31 downto 0)) return ipbus_sel_t;

-- START automatically  generated VHDL the Mon Mar  5 13:53:08 2018 
  constant N_SLV_CTRL_REG: integer := 0;
  constant N_SLV_STAT_REG: integer := 1;
  constant N_SLAVES: integer := 2;
-- END automatically generated VHDL

    
end ipbus_decode_vcu118_infra;

package body ipbus_decode_vcu118_infra is

  function ipbus_sel_vcu118_infra(addr : in std_logic_vector(31 downto 0)) return ipbus_sel_t is
    variable sel: ipbus_sel_t;
  begin

-- START automatically  generated VHDL the Mon Mar  5 13:53:08 2018 
    if    std_match(addr, "-------------------------------0") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_CTRL_REG, IPBUS_SEL_WIDTH)); -- ctrl_reg / base 0x00000000 / mask 0x00000001
    elsif std_match(addr, "-------------------------------1") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_STAT_REG, IPBUS_SEL_WIDTH)); -- stat_reg / base 0x00000001 / mask 0x00000001
-- END automatically generated VHDL

    else
        sel := ipbus_sel_t(to_unsigned(N_SLAVES, IPBUS_SEL_WIDTH));
    end if;

    return sel;

  end function ipbus_sel_vcu118_infra;

end ipbus_decode_vcu118_infra;

