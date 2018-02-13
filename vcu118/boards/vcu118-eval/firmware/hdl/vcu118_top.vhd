library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

use work.ultra_data_types.all;
use work.ultra_constants.all;
use work.board_constants.all;
use work.ipbus.all;

entity top is
 port (
    -- board clocks
    sysclk_in_p : in std_logic; -- 300 MHz
    sysclk_in_n : in std_logic; -- 300 MHz
    sysclk125_in_p : in std_logic; -- 125 MHz
    sysclk125_in_n : in std_logic; -- 125 MHz
    -- ethernet
    clk625_p : in std_logic; --> 625 MHz clock from external device
    clk625_n : in std_logic; 
    txp : out std_logic; 
    txn : out std_logic; 
    rxp : in std_logic; 
    rxn : in std_logic; 
    phy_on   : out std_logic; -- on/off signal
    phy_resetb: out std_logic; -- reset signal
    -- push button & leds
    rst_in : in std_logic; -- external reset button
    leds : out std_logic_vector(2 downto 0)
  );
end top;

architecture Behavioral of top is
    signal clk, clk40 : std_logic;
    signal rst, rst40 : std_logic;

    signal clk_ipb, rst_ipb: std_logic;
    signal ipb_out: ipb_wbus;
    signal ipb_in: ipb_rbus;
begin

  
-- 
data : entity work.data_top
  port map( 
        clk => clk, 
        rst => rst, 
        clk_ipb => clk_ipb, 
        rst_ipb => rst_ipb, 
        ipb_in => ipb_out, 
        ipb_out => ipb_in, 
        leds => leds(1 downto 0));

infra : entity work.vcu118_infra
  port map( 
        -- input clock pins 
        sysclk_in_p => sysclk_in_p,
        sysclk_in_n => sysclk_in_n,
        sysclk125_in_p => sysclk125_in_p,
        sysclk125_in_n => sysclk125_in_n,
        -- data output clocks,
        clk => clk, clk40 => clk40,
        rst => rst, rst40 => rst40,
        -- reset button
        reset_button => rst_in,
        -- ok
        status_ok => leds(2),
        -- ipbus
        clk_ipb => clk_ipb, rst_ipb => rst_ipb, 
        ipb_in => ipb_in, ipb_out => ipb_out,
        -- ethernet
        clk625_p => clk625_p, clk625_n => clk625_n,
        txp => txp, txn => txn,
        rxp => rxp, rxn => rxn,
        phy_on => phy_on, phy_resetb => phy_resetb);

   

end Behavioral;