#!/system/bin/sh
tinymix 'Loopback MCLK' 'DISABLE'
tinymix 'LOOPBACK Mode' 'DISABLE'

tinymix 'QUAT_MI2S_RX Audio Mixer MultiMedia1' 0
tinymix 'PRI_MI2S_RX Audio Mixer MultiMedia1' 0
tinymix 'RX3 MIX1 INP1' 'ZERO'
tinymix 'SPK DAC Switch' 0

tinymix 'MultiMedia1 Mixer TERT_MI2S_TX' 0
tinymix 'DEC1 MUX' 'ZERO'
tinymix 'ADC2 MUX' 'ZERO'

tinymix 'RX1 MIX1 INP1' 'ZERO'
tinymix 'RX2 MIX1 INP1' 'ZERO'
tinymix 'RDAC2 MUX' 'ZERO'
tinymix 'HPHL' 0
tinymix 'HPHR' 0
tinymix 'EAR_S' 0