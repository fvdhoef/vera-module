<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="7.7.0">
<drawing>
<settings>
<setting alwaysvectorfont="yes"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="1" fill="3" visible="no" active="no"/>
<layer number="3" name="Route3" color="4" fill="3" visible="no" active="no"/>
<layer number="14" name="Route14" color="1" fill="6" visible="no" active="no"/>
<layer number="15" name="Route15" color="4" fill="6" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="4" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="1" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="50" name="dxf" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="53" name="tGND_GNDA" color="7" fill="9" visible="no" active="no"/>
<layer number="54" name="bGND_GNDA" color="1" fill="9" visible="no" active="no"/>
<layer number="59" name="tCourtyard" color="7" fill="1" visible="no" active="no"/>
<layer number="60" name="bCourtyard" color="7" fill="1" visible="no" active="no"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
<layer number="100" name="measures_2" color="12" fill="1" visible="no" active="no"/>
<layer number="101" name="Patch_Top" color="12" fill="4" visible="yes" active="yes"/>
<layer number="116" name="Patch_BOT" color="9" fill="4" visible="yes" active="yes"/>
<layer number="200" name="200bmp" color="1" fill="10" visible="yes" active="yes"/>
<layer number="250" name="Descript" color="3" fill="1" visible="no" active="no"/>
<layer number="251" name="SMDround" color="4" fill="9" visible="no" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="integrated_circuits">
<packages>
<package name="SOT-23-5">
<description>5 pins, 1.8x3.1 mm, 0.95 mm pitch</description>
<wire x1="-0.6" y1="-1.55" x2="-0.6" y2="1.55" width="0.2" layer="21"/>
<wire x1="0.6" y1="-1.55" x2="0.6" y2="1.55" width="0.2" layer="21"/>
<wire x1="-0.6" y1="1.55" x2="0.6" y2="1.55" width="0.2" layer="21"/>
<wire x1="-0.6" y1="-1.55" x2="0.6" y2="-1.55" width="0.2" layer="21"/>
<wire x1="-0.9" y1="1.155" x2="-0.9" y2="1.55" width="0.1" layer="51"/>
<wire x1="-0.9" y1="1.55" x2="0.9" y2="1.55" width="0.1" layer="51"/>
<wire x1="-0.9" y1="-1.55" x2="0.9" y2="-1.55" width="0.1" layer="51"/>
<wire x1="-1.55" y1="0.745" x2="-1.55" y2="1.155" width="0.1" layer="51"/>
<wire x1="-0.9" y1="0.205" x2="-0.9" y2="0.745" width="0.1" layer="51"/>
<wire x1="-0.9" y1="0.745" x2="-0.9" y2="1.155" width="0.1" layer="51"/>
<wire x1="-1.55" y1="1.155" x2="-0.9" y2="1.155" width="0.1" layer="51"/>
<wire x1="-1.55" y1="0.745" x2="-0.9" y2="0.745" width="0.1" layer="51"/>
<wire x1="0.9" y1="-1.55" x2="0.9" y2="-1.155" width="0.1" layer="51"/>
<wire x1="0.9" y1="-1.155" x2="0.9" y2="-0.745" width="0.1" layer="51"/>
<wire x1="1.55" y1="-1.155" x2="1.55" y2="-0.745" width="0.1" layer="51"/>
<wire x1="0.9" y1="-0.745" x2="1.55" y2="-0.745" width="0.1" layer="51"/>
<wire x1="0.9" y1="-1.155" x2="1.55" y2="-1.155" width="0.1" layer="51"/>
<wire x1="-1.55" y1="-0.205" x2="-1.55" y2="0.205" width="0.1" layer="51"/>
<wire x1="-0.9" y1="-0.745" x2="-0.9" y2="-0.205" width="0.1" layer="51"/>
<wire x1="-0.9" y1="-0.205" x2="-0.9" y2="0.205" width="0.1" layer="51"/>
<wire x1="-1.55" y1="0.205" x2="-0.9" y2="0.205" width="0.1" layer="51"/>
<wire x1="-1.55" y1="-0.205" x2="-0.9" y2="-0.205" width="0.1" layer="51"/>
<wire x1="-1.55" y1="-1.155" x2="-1.55" y2="-0.745" width="0.1" layer="51"/>
<wire x1="-0.9" y1="-1.55" x2="-0.9" y2="-1.155" width="0.1" layer="51"/>
<wire x1="-0.9" y1="-1.155" x2="-0.9" y2="-0.745" width="0.1" layer="51"/>
<wire x1="-1.55" y1="-0.745" x2="-0.9" y2="-0.745" width="0.1" layer="51"/>
<wire x1="-1.55" y1="-1.155" x2="-0.9" y2="-1.155" width="0.1" layer="51"/>
<wire x1="0.9" y1="-0.745" x2="0.9" y2="0.745" width="0.1" layer="51"/>
<wire x1="0.9" y1="0.745" x2="0.9" y2="1.155" width="0.1" layer="51"/>
<wire x1="0.9" y1="1.155" x2="0.9" y2="1.55" width="0.1" layer="51"/>
<wire x1="1.55" y1="0.745" x2="1.55" y2="1.155" width="0.1" layer="51"/>
<wire x1="0.9" y1="1.155" x2="1.55" y2="1.155" width="0.1" layer="51"/>
<wire x1="0.9" y1="0.745" x2="1.55" y2="0.745" width="0.1" layer="51"/>
<wire x1="-2.15" y1="1.8" x2="2.15" y2="1.8" width="0" layer="59"/>
<wire x1="2.15" y1="1.8" x2="2.15" y2="-1.8" width="0" layer="59"/>
<wire x1="2.15" y1="-1.8" x2="-2.15" y2="-1.8" width="0" layer="59"/>
<wire x1="-2.15" y1="-1.8" x2="-2.15" y2="1.8" width="0" layer="59"/>
<smd name="1" x="-1.4" y="0.95" dx="0.71" dy="1" layer="1" rot="R90"/>
<smd name="4" x="1.4" y="-0.95" dx="0.71" dy="1" layer="1" rot="R90"/>
<smd name="2" x="-1.4" y="0" dx="0.71" dy="1" layer="1" rot="R90"/>
<smd name="3" x="-1.4" y="-0.95" dx="0.71" dy="1" layer="1" rot="R90"/>
<smd name="5" x="1.4" y="0.95" dx="0.71" dy="1" layer="1" rot="R90"/>
<text x="0" y="0" size="1" layer="51" ratio="10" rot="R90" align="center">&gt;NAME</text>
</package>
<package name="SG5032">
<wire x1="-2.5" y1="1.6" x2="2.5" y2="1.6" width="0.1" layer="51"/>
<wire x1="2.5" y1="1.6" x2="2.5" y2="-1.6" width="0.1" layer="51"/>
<wire x1="2.5" y1="-1.6" x2="-1.5" y2="-1.6" width="0.1" layer="51"/>
<wire x1="-1.5" y1="-1.6" x2="-2.5" y2="-1.6" width="0.1" layer="51"/>
<wire x1="-2.5" y1="-1.6" x2="-2.5" y2="-0.6" width="0.1" layer="51"/>
<wire x1="-2.5" y1="-0.6" x2="-2.5" y2="1.6" width="0.1" layer="51"/>
<wire x1="-2.5" y1="-0.6" x2="-1.5" y2="-1.6" width="0.1" layer="51"/>
<wire x1="-2.5" y1="1.6" x2="-2.5" y2="-1.6" width="0.2" layer="21"/>
<wire x1="2.5" y1="1.6" x2="2.5" y2="-1.6" width="0.2" layer="21"/>
<wire x1="-2.5" y1="1.6" x2="-2.4" y2="1.6" width="0.2" layer="21"/>
<wire x1="-2.5" y1="-1.6" x2="-2.4" y2="-1.6" width="0.2" layer="21"/>
<wire x1="2.5" y1="1.6" x2="2.4" y2="1.6" width="0.2" layer="21"/>
<wire x1="2.5" y1="-1.6" x2="2.4" y2="-1.6" width="0.2" layer="21"/>
<wire x1="-2.75" y1="2.1" x2="-2.75" y2="-2.1" width="0" layer="59"/>
<wire x1="-2.75" y1="-2.1" x2="2.75" y2="-2.1" width="0" layer="59"/>
<wire x1="2.75" y1="-2.1" x2="2.75" y2="2.1" width="0" layer="59"/>
<wire x1="2.75" y1="2.1" x2="-2.75" y2="2.1" width="0" layer="59"/>
<smd name="1" x="-1.27" y="-1.1" dx="1.6" dy="1.5" layer="1"/>
<smd name="2" x="1.27" y="-1.1" dx="1.6" dy="1.5" layer="1"/>
<smd name="3" x="1.27" y="1.1" dx="1.6" dy="1.5" layer="1"/>
<smd name="4" x="-1.27" y="1.1" dx="1.6" dy="1.5" layer="1"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="QFN-48">
<smd name="49" x="0" y="0" dx="5.3" dy="5.3" layer="1" cream="no"/>
<smd name="1" x="-3.45" y="2.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="2" x="-3.45" y="2.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="3" x="-3.45" y="1.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="4" x="-3.45" y="1.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="5" x="-3.45" y="0.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="6" x="-3.45" y="0.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="7" x="-3.45" y="-0.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="8" x="-3.45" y="-0.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="9" x="-3.45" y="-1.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="10" x="-3.45" y="-1.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="11" x="-3.45" y="-2.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="12" x="-3.45" y="-2.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R90"/>
<smd name="13" x="-2.75" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="14" x="-2.25" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="15" x="-1.75" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="16" x="-1.25" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="17" x="-0.75" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="18" x="-0.25" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="19" x="0.25" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="20" x="0.75" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="21" x="1.25" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="22" x="1.75" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="23" x="2.25" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="24" x="2.75" y="-3.45" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R180"/>
<smd name="25" x="3.45" y="-2.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="26" x="3.45" y="-2.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="27" x="3.45" y="-1.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="28" x="3.45" y="-1.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="29" x="3.45" y="-0.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="30" x="3.45" y="-0.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="31" x="3.45" y="0.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="32" x="3.45" y="0.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="33" x="3.45" y="1.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="34" x="3.45" y="1.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="35" x="3.45" y="2.25" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="36" x="3.45" y="2.75" dx="0.3" dy="0.85" layer="1" roundness="100" rot="R270"/>
<smd name="37" x="2.75" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="38" x="2.25" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="39" x="1.75" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="40" x="1.25" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="41" x="0.75" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="42" x="0.25" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="43" x="-0.25" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="44" x="-0.75" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="45" x="-1.25" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="46" x="-1.75" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="47" x="-2.25" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<smd name="48" x="-2.75" y="3.45" dx="0.3" dy="0.85" layer="1" roundness="100"/>
<wire x1="3.2" y1="3.5" x2="3.5" y2="3.5" width="0.2" layer="21"/>
<wire x1="3.5" y1="3.5" x2="3.5" y2="3.2" width="0.2" layer="21"/>
<wire x1="3.5" y1="-3.5" x2="3.5" y2="-3.2" width="0.2" layer="21"/>
<wire x1="3.5" y1="-3.5" x2="3.2" y2="-3.5" width="0.2" layer="21"/>
<wire x1="-3.5" y1="-3.5" x2="-3.2" y2="-3.5" width="0.2" layer="21"/>
<wire x1="-3.5" y1="-3.5" x2="-3.5" y2="-3.2" width="0.2" layer="21"/>
<wire x1="-3.5" y1="3.5" x2="-3.2" y2="3.5" width="0.2" layer="21"/>
<wire x1="-3.5" y1="3.5" x2="-3.5" y2="3.2" width="0.2" layer="21"/>
<wire x1="-3.5" y1="3.2" x2="-3.2" y2="3.5" width="0.2" layer="21"/>
<wire x1="-4.15" y1="4.15" x2="4.15" y2="4.15" width="0" layer="59"/>
<wire x1="4.15" y1="4.15" x2="4.15" y2="-4.15" width="0" layer="59"/>
<wire x1="4.15" y1="-4.15" x2="-4.15" y2="-4.15" width="0" layer="59"/>
<wire x1="-4.15" y1="-4.15" x2="-4.15" y2="4.15" width="0" layer="59"/>
<wire x1="-3.5" y1="3.5" x2="-3" y2="3.5" width="0.1" layer="51"/>
<wire x1="-3" y1="3.5" x2="3.5" y2="3.5" width="0.1" layer="51"/>
<wire x1="3.5" y1="3.5" x2="3.5" y2="-3.5" width="0.1" layer="51"/>
<wire x1="3.5" y1="-3.5" x2="-3.5" y2="-3.5" width="0.1" layer="51"/>
<wire x1="-3.5" y1="-3.5" x2="-3.5" y2="3" width="0.1" layer="51"/>
<wire x1="-3.5" y1="3" x2="-3.5" y2="3.5" width="0.1" layer="51"/>
<wire x1="-3.5" y1="3" x2="-3" y2="3.5" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
<rectangle x1="-2.4" y1="0.2" x2="-0.2" y2="2.4" layer="31"/>
<rectangle x1="-2.4" y1="-2.4" x2="-0.2" y2="-0.2" layer="31"/>
<rectangle x1="0.2" y1="0.2" x2="2.4" y2="2.4" layer="31"/>
<rectangle x1="0.2" y1="-2.4" x2="2.4" y2="-0.2" layer="31"/>
</package>
<package name="SOIC-16-300">
<description>16 pins, 7.6x10.5 mm, 1.27 mm pitch</description>
<wire x1="-3.35" y1="-5.25" x2="-3.35" y2="4.25" width="0.2" layer="21"/>
<wire x1="-3.35" y1="4.25" x2="-3.35" y2="5.25" width="0.2" layer="21"/>
<wire x1="3.35" y1="-5.25" x2="3.35" y2="5.25" width="0.2" layer="21"/>
<wire x1="-3.35" y1="5.25" x2="-2.35" y2="5.25" width="0.2" layer="21"/>
<wire x1="-2.35" y1="5.25" x2="3.35" y2="5.25" width="0.2" layer="21"/>
<wire x1="-3.35" y1="-5.25" x2="3.35" y2="-5.25" width="0.2" layer="21"/>
<wire x1="-3.35" y1="4.25" x2="-2.35" y2="5.25" width="0.2" layer="21"/>
<wire x1="-3.8" y1="4.25" x2="-3.8" y2="4.65" width="0.1" layer="51"/>
<wire x1="-3.8" y1="4.65" x2="-3.8" y2="5.25" width="0.1" layer="51"/>
<wire x1="-3.8" y1="5.25" x2="-2.8" y2="5.25" width="0.1" layer="51"/>
<wire x1="-2.8" y1="5.25" x2="3.8" y2="5.25" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-5.25" x2="3.8" y2="-5.25" width="0.1" layer="51"/>
<wire x1="-3.8" y1="4.25" x2="-2.8" y2="5.25" width="0.1" layer="51"/>
<wire x1="-5.265" y1="4.24" x2="-5.265" y2="4.65" width="0.1" layer="51"/>
<wire x1="-3.8" y1="3.38" x2="-3.8" y2="4.24" width="0.1" layer="51"/>
<wire x1="-3.8" y1="4.24" x2="-3.8" y2="4.25" width="0.1" layer="51"/>
<wire x1="-5.265" y1="4.65" x2="-3.8" y2="4.65" width="0.1" layer="51"/>
<wire x1="-5.265" y1="4.24" x2="-3.8" y2="4.24" width="0.1" layer="51"/>
<wire x1="3.8" y1="-5.25" x2="3.8" y2="-4.65" width="0.1" layer="51"/>
<wire x1="3.8" y1="-4.65" x2="3.8" y2="-4.24" width="0.1" layer="51"/>
<wire x1="5.265" y1="-4.65" x2="5.265" y2="-4.24" width="0.1" layer="51"/>
<wire x1="3.8" y1="-4.24" x2="5.265" y2="-4.24" width="0.1" layer="51"/>
<wire x1="3.8" y1="-4.65" x2="5.265" y2="-4.65" width="0.1" layer="51"/>
<wire x1="-5.265" y1="2.97" x2="-5.265" y2="3.38" width="0.1" layer="51"/>
<wire x1="-3.8" y1="2.11" x2="-3.8" y2="2.97" width="0.1" layer="51"/>
<wire x1="-3.8" y1="2.97" x2="-3.8" y2="3.38" width="0.1" layer="51"/>
<wire x1="-5.265" y1="3.38" x2="-3.8" y2="3.38" width="0.1" layer="51"/>
<wire x1="-5.265" y1="2.97" x2="-3.8" y2="2.97" width="0.1" layer="51"/>
<wire x1="3.8" y1="-4.24" x2="3.8" y2="-3.38" width="0.1" layer="51"/>
<wire x1="3.8" y1="-3.38" x2="3.8" y2="-2.97" width="0.1" layer="51"/>
<wire x1="5.265" y1="-3.38" x2="5.265" y2="-2.97" width="0.1" layer="51"/>
<wire x1="3.8" y1="-2.97" x2="5.265" y2="-2.97" width="0.1" layer="51"/>
<wire x1="3.8" y1="-3.38" x2="5.265" y2="-3.38" width="0.1" layer="51"/>
<wire x1="-5.265" y1="1.7" x2="-5.265" y2="2.11" width="0.1" layer="51"/>
<wire x1="-3.8" y1="0.84" x2="-3.8" y2="1.7" width="0.1" layer="51"/>
<wire x1="-3.8" y1="1.7" x2="-3.8" y2="2.11" width="0.1" layer="51"/>
<wire x1="-5.265" y1="2.11" x2="-3.8" y2="2.11" width="0.1" layer="51"/>
<wire x1="-5.265" y1="1.7" x2="-3.8" y2="1.7" width="0.1" layer="51"/>
<wire x1="3.8" y1="-2.97" x2="3.8" y2="-2.11" width="0.1" layer="51"/>
<wire x1="3.8" y1="-2.11" x2="3.8" y2="-1.7" width="0.1" layer="51"/>
<wire x1="5.265" y1="-2.11" x2="5.265" y2="-1.7" width="0.1" layer="51"/>
<wire x1="3.8" y1="-1.7" x2="5.265" y2="-1.7" width="0.1" layer="51"/>
<wire x1="3.8" y1="-2.11" x2="5.265" y2="-2.11" width="0.1" layer="51"/>
<wire x1="-5.265" y1="0.43" x2="-5.265" y2="0.84" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-0.43" x2="-3.8" y2="0.43" width="0.1" layer="51"/>
<wire x1="-3.8" y1="0.43" x2="-3.8" y2="0.84" width="0.1" layer="51"/>
<wire x1="-5.265" y1="0.84" x2="-3.8" y2="0.84" width="0.1" layer="51"/>
<wire x1="-5.265" y1="0.43" x2="-3.8" y2="0.43" width="0.1" layer="51"/>
<wire x1="3.8" y1="-1.7" x2="3.8" y2="-0.84" width="0.1" layer="51"/>
<wire x1="3.8" y1="-0.84" x2="3.8" y2="-0.43" width="0.1" layer="51"/>
<wire x1="5.265" y1="-0.84" x2="5.265" y2="-0.43" width="0.1" layer="51"/>
<wire x1="3.8" y1="-0.43" x2="5.265" y2="-0.43" width="0.1" layer="51"/>
<wire x1="3.8" y1="-0.84" x2="5.265" y2="-0.84" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-0.84" x2="-5.265" y2="-0.43" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-1.7" x2="-3.8" y2="-0.84" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-0.84" x2="-3.8" y2="-0.43" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-0.43" x2="-3.8" y2="-0.43" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-0.84" x2="-3.8" y2="-0.84" width="0.1" layer="51"/>
<wire x1="3.8" y1="-0.43" x2="3.8" y2="0.43" width="0.1" layer="51"/>
<wire x1="3.8" y1="0.43" x2="3.8" y2="0.84" width="0.1" layer="51"/>
<wire x1="5.265" y1="0.43" x2="5.265" y2="0.84" width="0.1" layer="51"/>
<wire x1="3.8" y1="0.84" x2="5.265" y2="0.84" width="0.1" layer="51"/>
<wire x1="3.8" y1="0.43" x2="5.265" y2="0.43" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-2.11" x2="-5.265" y2="-1.7" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-2.97" x2="-3.8" y2="-2.11" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-2.11" x2="-3.8" y2="-1.7" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-1.7" x2="-3.8" y2="-1.7" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-2.11" x2="-3.8" y2="-2.11" width="0.1" layer="51"/>
<wire x1="3.8" y1="0.84" x2="3.8" y2="1.7" width="0.1" layer="51"/>
<wire x1="3.8" y1="1.7" x2="3.8" y2="2.11" width="0.1" layer="51"/>
<wire x1="5.265" y1="1.7" x2="5.265" y2="2.11" width="0.1" layer="51"/>
<wire x1="3.8" y1="2.11" x2="5.265" y2="2.11" width="0.1" layer="51"/>
<wire x1="3.8" y1="1.7" x2="5.265" y2="1.7" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-3.38" x2="-5.265" y2="-2.97" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-4.24" x2="-3.8" y2="-3.38" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-3.38" x2="-3.8" y2="-2.97" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-2.97" x2="-3.8" y2="-2.97" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-3.38" x2="-3.8" y2="-3.38" width="0.1" layer="51"/>
<wire x1="3.8" y1="2.11" x2="3.8" y2="2.97" width="0.1" layer="51"/>
<wire x1="3.8" y1="2.97" x2="3.8" y2="3.38" width="0.1" layer="51"/>
<wire x1="5.265" y1="2.97" x2="5.265" y2="3.38" width="0.1" layer="51"/>
<wire x1="3.8" y1="3.38" x2="5.265" y2="3.38" width="0.1" layer="51"/>
<wire x1="3.8" y1="2.97" x2="5.265" y2="2.97" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-4.65" x2="-5.265" y2="-4.24" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-5.25" x2="-3.8" y2="-4.65" width="0.1" layer="51"/>
<wire x1="-3.8" y1="-4.65" x2="-3.8" y2="-4.24" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-4.24" x2="-3.8" y2="-4.24" width="0.1" layer="51"/>
<wire x1="-5.265" y1="-4.65" x2="-3.8" y2="-4.65" width="0.1" layer="51"/>
<wire x1="3.8" y1="3.38" x2="3.8" y2="4.24" width="0.1" layer="51"/>
<wire x1="3.8" y1="4.24" x2="3.8" y2="4.65" width="0.1" layer="51"/>
<wire x1="3.8" y1="4.65" x2="3.8" y2="5.25" width="0.1" layer="51"/>
<wire x1="5.265" y1="4.24" x2="5.265" y2="4.65" width="0.1" layer="51"/>
<wire x1="3.8" y1="4.65" x2="5.265" y2="4.65" width="0.1" layer="51"/>
<wire x1="3.8" y1="4.24" x2="5.265" y2="4.24" width="0.1" layer="51"/>
<wire x1="-5.9" y1="-5.5" x2="-5.9" y2="5.5" width="0" layer="59"/>
<wire x1="5.9" y1="-5.5" x2="5.9" y2="5.5" width="0" layer="59"/>
<wire x1="-5.9" y1="5.5" x2="5.9" y2="5.5" width="0" layer="59"/>
<wire x1="-5.9" y1="-5.5" x2="5.9" y2="-5.5" width="0" layer="59"/>
<smd name="1" x="-4.65" y="4.445" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="9" x="4.65" y="-4.445" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="2" x="-4.65" y="3.175" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="10" x="4.65" y="-3.175" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="3" x="-4.65" y="1.905" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="11" x="4.65" y="-1.905" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="4" x="-4.65" y="0.635" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="12" x="4.65" y="-0.635" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="5" x="-4.65" y="-0.635" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="13" x="4.65" y="0.635" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="6" x="-4.65" y="-1.905" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="14" x="4.65" y="1.905" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="7" x="-4.65" y="-3.175" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="15" x="4.65" y="3.175" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="8" x="-4.65" y="-4.445" dx="0.6" dy="2" layer="1" rot="R90"/>
<smd name="16" x="4.65" y="4.445" dx="0.6" dy="2" layer="1" rot="R90"/>
<text x="0" y="0" size="2" layer="51" font="vector" ratio="5" rot="R90" align="center">&gt;NAME</text>
</package>
<package name="SOIC-8">
<description>8 pins, 3.9x4.9 mm, 1.27 mm pitch</description>
<wire x1="-1.65" y1="-2.45" x2="-1.65" y2="1.45" width="0.2" layer="21"/>
<wire x1="-1.65" y1="1.45" x2="-1.65" y2="2.45" width="0.2" layer="21"/>
<wire x1="1.65" y1="-2.45" x2="1.65" y2="2.45" width="0.2" layer="21"/>
<wire x1="-1.65" y1="2.45" x2="-0.65" y2="2.45" width="0.2" layer="21"/>
<wire x1="-0.65" y1="2.45" x2="1.65" y2="2.45" width="0.2" layer="21"/>
<wire x1="-1.65" y1="-2.45" x2="1.65" y2="-2.45" width="0.2" layer="21"/>
<wire x1="-1.65" y1="1.45" x2="-0.65" y2="2.45" width="0.2" layer="21"/>
<wire x1="-1.95" y1="0.84" x2="-1.95" y2="1.45" width="0.1" layer="51"/>
<wire x1="-1.95" y1="2.11" x2="-1.95" y2="2.45" width="0.1" layer="51"/>
<wire x1="-1.95" y1="2.45" x2="-0.95" y2="2.45" width="0.1" layer="51"/>
<wire x1="-0.95" y1="2.45" x2="1.95" y2="2.45" width="0.1" layer="51"/>
<wire x1="-1.95" y1="-2.45" x2="1.95" y2="-2.45" width="0.1" layer="51"/>
<wire x1="-1.95" y1="1.45" x2="-0.95" y2="2.45" width="0.1" layer="51"/>
<wire x1="-2.95" y1="1.7" x2="-2.95" y2="2.11" width="0.1" layer="51"/>
<wire x1="-1.95" y1="1.45" x2="-1.95" y2="1.7" width="0.1" layer="51"/>
<wire x1="-1.95" y1="1.7" x2="-1.95" y2="2.11" width="0.1" layer="51"/>
<wire x1="-2.95" y1="2.11" x2="-1.95" y2="2.11" width="0.1" layer="51"/>
<wire x1="-2.95" y1="1.7" x2="-1.95" y2="1.7" width="0.1" layer="51"/>
<wire x1="1.95" y1="-2.45" x2="1.95" y2="-2.11" width="0.1" layer="51"/>
<wire x1="1.95" y1="-2.11" x2="1.95" y2="-1.7" width="0.1" layer="51"/>
<wire x1="2.95" y1="-2.11" x2="2.95" y2="-1.7" width="0.1" layer="51"/>
<wire x1="1.95" y1="-1.7" x2="2.95" y2="-1.7" width="0.1" layer="51"/>
<wire x1="1.95" y1="-2.11" x2="2.95" y2="-2.11" width="0.1" layer="51"/>
<wire x1="-2.95" y1="0.43" x2="-2.95" y2="0.84" width="0.1" layer="51"/>
<wire x1="-1.95" y1="-0.43" x2="-1.95" y2="0.43" width="0.1" layer="51"/>
<wire x1="-1.95" y1="0.43" x2="-1.95" y2="0.84" width="0.1" layer="51"/>
<wire x1="-2.95" y1="0.84" x2="-1.95" y2="0.84" width="0.1" layer="51"/>
<wire x1="-2.95" y1="0.43" x2="-1.95" y2="0.43" width="0.1" layer="51"/>
<wire x1="1.95" y1="-1.7" x2="1.95" y2="-0.84" width="0.1" layer="51"/>
<wire x1="1.95" y1="-0.84" x2="1.95" y2="-0.43" width="0.1" layer="51"/>
<wire x1="2.95" y1="-0.84" x2="2.95" y2="-0.43" width="0.1" layer="51"/>
<wire x1="1.95" y1="-0.43" x2="2.95" y2="-0.43" width="0.1" layer="51"/>
<wire x1="1.95" y1="-0.84" x2="2.95" y2="-0.84" width="0.1" layer="51"/>
<wire x1="-2.95" y1="-0.84" x2="-2.95" y2="-0.43" width="0.1" layer="51"/>
<wire x1="-1.95" y1="-1.7" x2="-1.95" y2="-0.84" width="0.1" layer="51"/>
<wire x1="-1.95" y1="-0.84" x2="-1.95" y2="-0.43" width="0.1" layer="51"/>
<wire x1="-2.95" y1="-0.43" x2="-1.95" y2="-0.43" width="0.1" layer="51"/>
<wire x1="-2.95" y1="-0.84" x2="-1.95" y2="-0.84" width="0.1" layer="51"/>
<wire x1="1.95" y1="-0.43" x2="1.95" y2="0.43" width="0.1" layer="51"/>
<wire x1="1.95" y1="0.43" x2="1.95" y2="0.84" width="0.1" layer="51"/>
<wire x1="2.95" y1="0.43" x2="2.95" y2="0.84" width="0.1" layer="51"/>
<wire x1="1.95" y1="0.84" x2="2.95" y2="0.84" width="0.1" layer="51"/>
<wire x1="1.95" y1="0.43" x2="2.95" y2="0.43" width="0.1" layer="51"/>
<wire x1="-2.95" y1="-2.11" x2="-2.95" y2="-1.7" width="0.1" layer="51"/>
<wire x1="-1.95" y1="-2.45" x2="-1.95" y2="-2.11" width="0.1" layer="51"/>
<wire x1="-1.95" y1="-2.11" x2="-1.95" y2="-1.7" width="0.1" layer="51"/>
<wire x1="-2.95" y1="-1.7" x2="-1.95" y2="-1.7" width="0.1" layer="51"/>
<wire x1="-2.95" y1="-2.11" x2="-1.95" y2="-2.11" width="0.1" layer="51"/>
<wire x1="1.95" y1="0.84" x2="1.95" y2="1.7" width="0.1" layer="51"/>
<wire x1="1.95" y1="1.7" x2="1.95" y2="2.11" width="0.1" layer="51"/>
<wire x1="1.95" y1="2.11" x2="1.95" y2="2.45" width="0.1" layer="51"/>
<wire x1="2.95" y1="1.7" x2="2.95" y2="2.11" width="0.1" layer="51"/>
<wire x1="1.95" y1="2.11" x2="2.95" y2="2.11" width="0.1" layer="51"/>
<wire x1="1.95" y1="1.7" x2="2.95" y2="1.7" width="0.1" layer="51"/>
<wire x1="-3.55" y1="2.7" x2="3.55" y2="2.7" width="0" layer="59"/>
<wire x1="3.55" y1="2.7" x2="3.55" y2="-2.7" width="0" layer="59"/>
<wire x1="3.55" y1="-2.7" x2="-3.55" y2="-2.7" width="0" layer="59"/>
<wire x1="-3.55" y1="-2.7" x2="-3.55" y2="2.7" width="0" layer="59"/>
<smd name="1" x="-2.625" y="1.905" dx="0.71" dy="1.35" layer="1" rot="R90"/>
<smd name="5" x="2.625" y="-1.905" dx="0.71" dy="1.35" layer="1" rot="R90"/>
<smd name="2" x="-2.625" y="0.635" dx="0.71" dy="1.35" layer="1" rot="R90"/>
<smd name="6" x="2.625" y="-0.635" dx="0.71" dy="1.35" layer="1" rot="R90"/>
<smd name="3" x="-2.625" y="-0.635" dx="0.71" dy="1.35" layer="1" rot="R90"/>
<smd name="7" x="2.625" y="0.635" dx="0.71" dy="1.35" layer="1" rot="R90"/>
<smd name="4" x="-2.625" y="-1.905" dx="0.71" dy="1.35" layer="1" rot="R90"/>
<smd name="8" x="2.625" y="1.905" dx="0.71" dy="1.35" layer="1" rot="R90"/>
<text x="0" y="0" size="1" layer="51" ratio="10" rot="R90" align="center">&gt;NAME</text>
</package>
<package name="TSSOP-24">
<description>24 pins, 4.5x7.9 mm, 0.65 mm pitch</description>
<smd name="1" x="-2.9" y="3.575" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="13" x="2.9" y="-3.575" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="2" x="-2.9" y="2.925" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="14" x="2.9" y="-2.925" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="3" x="-2.9" y="2.275" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="15" x="2.9" y="-2.275" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="4" x="-2.9" y="1.625" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="16" x="2.9" y="-1.625" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="5" x="-2.9" y="0.975" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="17" x="2.9" y="-0.975" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="6" x="-2.9" y="0.325" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="18" x="2.9" y="-0.325" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="7" x="-2.9" y="-0.325" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="19" x="2.9" y="0.325" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="8" x="-2.9" y="-0.975" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="20" x="2.9" y="0.975" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="9" x="-2.9" y="-1.625" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="21" x="2.9" y="1.625" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="10" x="-2.9" y="-2.275" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="22" x="2.9" y="2.275" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="11" x="-2.9" y="-2.925" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="23" x="2.9" y="2.925" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="12" x="-2.9" y="-3.575" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<smd name="24" x="2.9" y="3.575" dx="0.45" dy="1.5" layer="1" rot="R90"/>
<wire x1="-1.85" y1="-3.95" x2="-1.85" y2="2.95" width="0.2" layer="21"/>
<wire x1="-1.85" y1="2.95" x2="-1.85" y2="3.95" width="0.2" layer="21"/>
<wire x1="1.85" y1="-3.95" x2="1.85" y2="3.95" width="0.2" layer="21"/>
<wire x1="-1.85" y1="3.95" x2="-0.85" y2="3.95" width="0.2" layer="21"/>
<wire x1="-0.85" y1="3.95" x2="1.85" y2="3.95" width="0.2" layer="21"/>
<wire x1="-1.85" y1="-3.95" x2="1.85" y2="-3.95" width="0.2" layer="21"/>
<wire x1="-1.85" y1="2.95" x2="-0.85" y2="3.95" width="0.2" layer="21"/>
<text x="-1.95" y="-5.25" size="1" layer="25" font="vector" ratio="20">&gt;NAME</text>
<wire x1="-2.25" y1="-3.95" x2="-2.25" y2="-3.675" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-3.675" x2="-2.25" y2="-3.475" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-3.475" x2="-2.25" y2="-3.025" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-3.025" x2="-2.25" y2="-2.825" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-2.825" x2="-2.25" y2="-2.375" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-2.375" x2="-2.25" y2="-2.175" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-2.175" x2="-2.25" y2="-1.725" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-1.725" x2="-2.25" y2="-1.525" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-1.525" x2="-2.25" y2="-1.075" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-1.075" x2="-2.25" y2="-0.875" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-0.875" x2="-2.25" y2="-0.425" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-0.425" x2="-2.25" y2="-0.225" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-0.225" x2="-2.25" y2="0.225" width="0.1" layer="51"/>
<wire x1="-2.25" y1="0.225" x2="-2.25" y2="0.425" width="0.1" layer="51"/>
<wire x1="-2.25" y1="0.425" x2="-2.25" y2="0.875" width="0.1" layer="51"/>
<wire x1="-2.25" y1="0.875" x2="-2.25" y2="1.075" width="0.1" layer="51"/>
<wire x1="-2.25" y1="1.075" x2="-2.25" y2="1.525" width="0.1" layer="51"/>
<wire x1="-2.25" y1="1.525" x2="-2.25" y2="1.725" width="0.1" layer="51"/>
<wire x1="-2.25" y1="1.725" x2="-2.25" y2="2.175" width="0.1" layer="51"/>
<wire x1="-2.25" y1="2.175" x2="-2.25" y2="2.375" width="0.1" layer="51"/>
<wire x1="-2.25" y1="2.375" x2="-2.25" y2="2.825" width="0.1" layer="51"/>
<wire x1="-2.25" y1="2.825" x2="-2.25" y2="2.95" width="0.1" layer="51"/>
<wire x1="-2.25" y1="2.95" x2="-2.25" y2="3.025" width="0.1" layer="51"/>
<wire x1="-2.25" y1="3.025" x2="-2.25" y2="3.475" width="0.1" layer="51"/>
<wire x1="-2.25" y1="3.475" x2="-2.25" y2="3.675" width="0.1" layer="51"/>
<wire x1="-2.25" y1="3.675" x2="-2.25" y2="3.95" width="0.1" layer="51"/>
<wire x1="2.25" y1="-3.95" x2="2.25" y2="-3.675" width="0.1" layer="51"/>
<wire x1="2.25" y1="-3.675" x2="2.25" y2="-3.475" width="0.1" layer="51"/>
<wire x1="2.25" y1="-3.475" x2="2.25" y2="-3.025" width="0.1" layer="51"/>
<wire x1="2.25" y1="-3.025" x2="2.25" y2="-2.825" width="0.1" layer="51"/>
<wire x1="2.25" y1="-2.825" x2="2.25" y2="-2.375" width="0.1" layer="51"/>
<wire x1="2.25" y1="-2.375" x2="2.25" y2="-2.175" width="0.1" layer="51"/>
<wire x1="2.25" y1="-2.175" x2="2.25" y2="-1.725" width="0.1" layer="51"/>
<wire x1="2.25" y1="-1.725" x2="2.25" y2="-1.525" width="0.1" layer="51"/>
<wire x1="2.25" y1="-1.525" x2="2.25" y2="-1.075" width="0.1" layer="51"/>
<wire x1="2.25" y1="-1.075" x2="2.25" y2="-0.875" width="0.1" layer="51"/>
<wire x1="2.25" y1="-0.875" x2="2.25" y2="-0.425" width="0.1" layer="51"/>
<wire x1="2.25" y1="-0.425" x2="2.25" y2="-0.225" width="0.1" layer="51"/>
<wire x1="2.25" y1="-0.225" x2="2.25" y2="0.225" width="0.1" layer="51"/>
<wire x1="2.25" y1="0.225" x2="2.25" y2="0.425" width="0.1" layer="51"/>
<wire x1="2.25" y1="0.425" x2="2.25" y2="0.875" width="0.1" layer="51"/>
<wire x1="2.25" y1="0.875" x2="2.25" y2="1.075" width="0.1" layer="51"/>
<wire x1="2.25" y1="1.075" x2="2.25" y2="1.525" width="0.1" layer="51"/>
<wire x1="2.25" y1="1.525" x2="2.25" y2="1.725" width="0.1" layer="51"/>
<wire x1="2.25" y1="1.725" x2="2.25" y2="2.175" width="0.1" layer="51"/>
<wire x1="2.25" y1="2.175" x2="2.25" y2="2.375" width="0.1" layer="51"/>
<wire x1="2.25" y1="2.375" x2="2.25" y2="2.825" width="0.1" layer="51"/>
<wire x1="2.25" y1="2.825" x2="2.25" y2="3.025" width="0.1" layer="51"/>
<wire x1="2.25" y1="3.025" x2="2.25" y2="3.475" width="0.1" layer="51"/>
<wire x1="2.25" y1="3.475" x2="2.25" y2="3.675" width="0.1" layer="51"/>
<wire x1="2.25" y1="3.675" x2="2.25" y2="3.95" width="0.1" layer="51"/>
<wire x1="-2.25" y1="3.95" x2="-1.25" y2="3.95" width="0.1" layer="51"/>
<wire x1="-1.25" y1="3.95" x2="2.25" y2="3.95" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-3.95" x2="2.25" y2="-3.95" width="0.1" layer="51"/>
<wire x1="-2.25" y1="2.95" x2="-1.25" y2="3.95" width="0.1" layer="51"/>
<wire x1="-3.25" y1="3.475" x2="-3.25" y2="3.675" width="0.1" layer="51"/>
<wire x1="-3.25" y1="3.675" x2="-2.25" y2="3.675" width="0.1" layer="51"/>
<wire x1="-3.25" y1="3.475" x2="-2.25" y2="3.475" width="0.1" layer="51"/>
<wire x1="3.25" y1="-3.675" x2="3.25" y2="-3.475" width="0.1" layer="51"/>
<wire x1="2.25" y1="-3.475" x2="3.25" y2="-3.475" width="0.1" layer="51"/>
<wire x1="2.25" y1="-3.675" x2="3.25" y2="-3.675" width="0.1" layer="51"/>
<wire x1="-3.25" y1="2.825" x2="-3.25" y2="3.025" width="0.1" layer="51"/>
<wire x1="-3.25" y1="3.025" x2="-2.25" y2="3.025" width="0.1" layer="51"/>
<wire x1="-3.25" y1="2.825" x2="-2.25" y2="2.825" width="0.1" layer="51"/>
<wire x1="3.25" y1="-3.025" x2="3.25" y2="-2.825" width="0.1" layer="51"/>
<wire x1="2.25" y1="-2.825" x2="3.25" y2="-2.825" width="0.1" layer="51"/>
<wire x1="2.25" y1="-3.025" x2="3.25" y2="-3.025" width="0.1" layer="51"/>
<wire x1="-3.25" y1="2.175" x2="-3.25" y2="2.375" width="0.1" layer="51"/>
<wire x1="-3.25" y1="2.375" x2="-2.25" y2="2.375" width="0.1" layer="51"/>
<wire x1="-3.25" y1="2.175" x2="-2.25" y2="2.175" width="0.1" layer="51"/>
<wire x1="3.25" y1="-2.375" x2="3.25" y2="-2.175" width="0.1" layer="51"/>
<wire x1="2.25" y1="-2.175" x2="3.25" y2="-2.175" width="0.1" layer="51"/>
<wire x1="2.25" y1="-2.375" x2="3.25" y2="-2.375" width="0.1" layer="51"/>
<wire x1="-3.25" y1="1.525" x2="-3.25" y2="1.725" width="0.1" layer="51"/>
<wire x1="-3.25" y1="1.725" x2="-2.25" y2="1.725" width="0.1" layer="51"/>
<wire x1="-3.25" y1="1.525" x2="-2.25" y2="1.525" width="0.1" layer="51"/>
<wire x1="3.25" y1="-1.725" x2="3.25" y2="-1.525" width="0.1" layer="51"/>
<wire x1="2.25" y1="-1.525" x2="3.25" y2="-1.525" width="0.1" layer="51"/>
<wire x1="2.25" y1="-1.725" x2="3.25" y2="-1.725" width="0.1" layer="51"/>
<wire x1="-3.25" y1="0.875" x2="-3.25" y2="1.075" width="0.1" layer="51"/>
<wire x1="-3.25" y1="1.075" x2="-2.25" y2="1.075" width="0.1" layer="51"/>
<wire x1="-3.25" y1="0.875" x2="-2.25" y2="0.875" width="0.1" layer="51"/>
<wire x1="3.25" y1="-1.075" x2="3.25" y2="-0.875" width="0.1" layer="51"/>
<wire x1="2.25" y1="-0.875" x2="3.25" y2="-0.875" width="0.1" layer="51"/>
<wire x1="2.25" y1="-1.075" x2="3.25" y2="-1.075" width="0.1" layer="51"/>
<wire x1="-3.25" y1="0.225" x2="-3.25" y2="0.425" width="0.1" layer="51"/>
<wire x1="-3.25" y1="0.425" x2="-2.25" y2="0.425" width="0.1" layer="51"/>
<wire x1="-3.25" y1="0.225" x2="-2.25" y2="0.225" width="0.1" layer="51"/>
<wire x1="3.25" y1="-0.425" x2="3.25" y2="-0.225" width="0.1" layer="51"/>
<wire x1="2.25" y1="-0.225" x2="3.25" y2="-0.225" width="0.1" layer="51"/>
<wire x1="2.25" y1="-0.425" x2="3.25" y2="-0.425" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-0.425" x2="-3.25" y2="-0.225" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-0.225" x2="-2.25" y2="-0.225" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-0.425" x2="-2.25" y2="-0.425" width="0.1" layer="51"/>
<wire x1="3.25" y1="0.225" x2="3.25" y2="0.425" width="0.1" layer="51"/>
<wire x1="2.25" y1="0.425" x2="3.25" y2="0.425" width="0.1" layer="51"/>
<wire x1="2.25" y1="0.225" x2="3.25" y2="0.225" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-1.075" x2="-3.25" y2="-0.875" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-0.875" x2="-2.25" y2="-0.875" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-1.075" x2="-2.25" y2="-1.075" width="0.1" layer="51"/>
<wire x1="3.25" y1="0.875" x2="3.25" y2="1.075" width="0.1" layer="51"/>
<wire x1="2.25" y1="1.075" x2="3.25" y2="1.075" width="0.1" layer="51"/>
<wire x1="2.25" y1="0.875" x2="3.25" y2="0.875" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-1.725" x2="-3.25" y2="-1.525" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-1.525" x2="-2.25" y2="-1.525" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-1.725" x2="-2.25" y2="-1.725" width="0.1" layer="51"/>
<wire x1="3.25" y1="1.525" x2="3.25" y2="1.725" width="0.1" layer="51"/>
<wire x1="2.25" y1="1.725" x2="3.25" y2="1.725" width="0.1" layer="51"/>
<wire x1="2.25" y1="1.525" x2="3.25" y2="1.525" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-2.375" x2="-3.25" y2="-2.175" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-2.175" x2="-2.25" y2="-2.175" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-2.375" x2="-2.25" y2="-2.375" width="0.1" layer="51"/>
<wire x1="3.25" y1="2.175" x2="3.25" y2="2.375" width="0.1" layer="51"/>
<wire x1="2.25" y1="2.375" x2="3.25" y2="2.375" width="0.1" layer="51"/>
<wire x1="2.25" y1="2.175" x2="3.25" y2="2.175" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-3.025" x2="-3.25" y2="-2.825" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-2.825" x2="-2.25" y2="-2.825" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-3.025" x2="-2.25" y2="-3.025" width="0.1" layer="51"/>
<wire x1="3.25" y1="2.825" x2="3.25" y2="3.025" width="0.1" layer="51"/>
<wire x1="2.25" y1="3.025" x2="3.25" y2="3.025" width="0.1" layer="51"/>
<wire x1="2.25" y1="2.825" x2="3.25" y2="2.825" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-3.675" x2="-3.25" y2="-3.475" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-3.475" x2="-2.25" y2="-3.475" width="0.1" layer="51"/>
<wire x1="-3.25" y1="-3.675" x2="-2.25" y2="-3.675" width="0.1" layer="51"/>
<wire x1="3.25" y1="3.475" x2="3.25" y2="3.675" width="0.1" layer="51"/>
<wire x1="2.25" y1="3.675" x2="3.25" y2="3.675" width="0.1" layer="51"/>
<wire x1="2.25" y1="3.475" x2="3.25" y2="3.475" width="0.1" layer="51"/>
<text x="1" y="-3.7" size="2" layer="51" font="vector" ratio="5" rot="R90">&gt;NAME</text>
<wire x1="-3.9" y1="-4.2" x2="-3.9" y2="4.2" width="0" layer="59"/>
<wire x1="3.9" y1="-4.2" x2="3.9" y2="4.2" width="0" layer="59"/>
<wire x1="-3.9" y1="4.2" x2="3.9" y2="4.2" width="0" layer="59"/>
<wire x1="-3.9" y1="-4.2" x2="3.9" y2="-4.2" width="0" layer="59"/>
</package>
<package name="TSSOP-5">
<description>5 pins, 1.4x2.15 mm, 0.65 mm pitch</description>
<wire x1="-0.325" y1="-1.075" x2="-0.325" y2="1.075" width="0.2" layer="21"/>
<wire x1="0.325" y1="-1.075" x2="0.325" y2="1.075" width="0.2" layer="21"/>
<wire x1="-0.325" y1="1.075" x2="0.325" y2="1.075" width="0.2" layer="21"/>
<wire x1="-0.325" y1="-1.075" x2="0.325" y2="-1.075" width="0.2" layer="21"/>
<wire x1="-0.7" y1="0.75" x2="-0.7" y2="1.075" width="0.1" layer="51"/>
<wire x1="-0.7" y1="1.075" x2="0.7" y2="1.075" width="0.1" layer="51"/>
<wire x1="-0.7" y1="-1.075" x2="0.7" y2="-1.075" width="0.1" layer="51"/>
<wire x1="-1.15" y1="0.55" x2="-1.15" y2="0.75" width="0.1" layer="51"/>
<wire x1="-0.7" y1="0.1" x2="-0.7" y2="0.55" width="0.1" layer="51"/>
<wire x1="-0.7" y1="0.55" x2="-0.7" y2="0.75" width="0.1" layer="51"/>
<wire x1="-1.15" y1="0.75" x2="-0.7" y2="0.75" width="0.1" layer="51"/>
<wire x1="-1.15" y1="0.55" x2="-0.7" y2="0.55" width="0.1" layer="51"/>
<wire x1="0.7" y1="-1.075" x2="0.7" y2="-0.75" width="0.1" layer="51"/>
<wire x1="0.7" y1="-0.75" x2="0.7" y2="-0.55" width="0.1" layer="51"/>
<wire x1="1.15" y1="-0.75" x2="1.15" y2="-0.55" width="0.1" layer="51"/>
<wire x1="0.7" y1="-0.55" x2="1.15" y2="-0.55" width="0.1" layer="51"/>
<wire x1="0.7" y1="-0.75" x2="1.15" y2="-0.75" width="0.1" layer="51"/>
<wire x1="-1.15" y1="-0.1" x2="-1.15" y2="0.1" width="0.1" layer="51"/>
<wire x1="-0.7" y1="-0.55" x2="-0.7" y2="-0.1" width="0.1" layer="51"/>
<wire x1="-0.7" y1="-0.1" x2="-0.7" y2="0.1" width="0.1" layer="51"/>
<wire x1="-1.15" y1="0.1" x2="-0.7" y2="0.1" width="0.1" layer="51"/>
<wire x1="-1.15" y1="-0.1" x2="-0.7" y2="-0.1" width="0.1" layer="51"/>
<wire x1="-1.15" y1="-0.75" x2="-1.15" y2="-0.55" width="0.1" layer="51"/>
<wire x1="-0.7" y1="-1.075" x2="-0.7" y2="-0.75" width="0.1" layer="51"/>
<wire x1="-0.7" y1="-0.75" x2="-0.7" y2="-0.55" width="0.1" layer="51"/>
<wire x1="-1.15" y1="-0.55" x2="-0.7" y2="-0.55" width="0.1" layer="51"/>
<wire x1="-1.15" y1="-0.75" x2="-0.7" y2="-0.75" width="0.1" layer="51"/>
<wire x1="0.7" y1="-0.55" x2="0.7" y2="0.55" width="0.1" layer="51"/>
<wire x1="0.7" y1="0.55" x2="0.7" y2="0.75" width="0.1" layer="51"/>
<wire x1="0.7" y1="0.75" x2="0.7" y2="1.075" width="0.1" layer="51"/>
<wire x1="1.15" y1="0.55" x2="1.15" y2="0.75" width="0.1" layer="51"/>
<wire x1="0.7" y1="0.75" x2="1.15" y2="0.75" width="0.1" layer="51"/>
<wire x1="0.7" y1="0.55" x2="1.15" y2="0.55" width="0.1" layer="51"/>
<wire x1="-1.85" y1="-1.35" x2="-1.85" y2="1.35" width="0" layer="59"/>
<wire x1="1.85" y1="-1.35" x2="1.85" y2="1.35" width="0" layer="59"/>
<wire x1="-1.85" y1="1.35" x2="1.85" y2="1.35" width="0" layer="59"/>
<wire x1="-1.85" y1="-1.35" x2="1.85" y2="-1.35" width="0" layer="59"/>
<smd name="1" x="-1.1" y="0.65" dx="0.4" dy="0.95" layer="1" rot="R90"/>
<smd name="4" x="1.1" y="-0.65" dx="0.4" dy="0.95" layer="1" rot="R90"/>
<smd name="2" x="-1.1" y="0" dx="0.4" dy="0.95" layer="1" rot="R90"/>
<smd name="3" x="-1.1" y="-0.65" dx="0.4" dy="0.95" layer="1" rot="R90"/>
<smd name="5" x="1.1" y="0.65" dx="0.4" dy="0.95" layer="1" rot="R90"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" rot="R90" align="center">&gt;NAME</text>
</package>
</packages>
<symbols>
<symbol name="AP3417C">
<wire x1="0" y1="0" x2="17.78" y2="0" width="0.254" layer="94"/>
<wire x1="17.78" y1="0" x2="17.78" y2="-15.24" width="0.254" layer="94"/>
<wire x1="17.78" y1="-15.24" x2="0" y2="-15.24" width="0.254" layer="94"/>
<wire x1="0" y1="-15.24" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-17.78" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="EN" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="GND" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="LX" x="22.86" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VIN" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="FB" x="22.86" y="-12.7" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="OSCILLATOR">
<wire x1="0" y1="0" x2="0" y2="-12.7" width="0.254" layer="94"/>
<wire x1="0" y1="-12.7" x2="17.78" y2="-12.7" width="0.254" layer="94"/>
<wire x1="17.78" y1="-12.7" x2="17.78" y2="0" width="0.254" layer="94"/>
<wire x1="17.78" y1="0" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-15.24" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="OUT" x="22.86" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCC" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="GND" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="OE" x="-5.08" y="-5.08" length="middle" direction="pas"/>
</symbol>
<symbol name="ICE40UP5K-SG48ITR50">
<wire x1="0" y1="0" x2="43.18" y2="0" width="0.254" layer="94"/>
<wire x1="43.18" y1="0" x2="43.18" y2="-78.74" width="0.254" layer="94"/>
<wire x1="43.18" y1="-78.74" x2="0" y2="-78.74" width="0.254" layer="94"/>
<wire x1="0" y1="-78.74" x2="0" y2="0" width="0.254" layer="94"/>
<pin name="VCCIO_2" x="48.26" y="-53.34" length="middle" direction="pas" rot="R180"/>
<pin name="IOB_6A" x="-5.08" y="-15.24" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_9B" x="-5.08" y="-17.78" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_8A" x="-5.08" y="-20.32" length="middle" direction="pas" swaplevel="1"/>
<pin name="VCC@1" x="48.26" y="-63.5" length="middle" direction="pas" rot="R180"/>
<pin name="IOB_13B" x="-5.08" y="-22.86" length="middle" direction="pas" swaplevel="1"/>
<pin name="CDONE" x="-5.08" y="-25.4" length="middle" direction="pas"/>
<pin name="CRESET_B" x="-5.08" y="-27.94" length="middle" direction="pas"/>
<pin name="IOB_16A" x="-5.08" y="-30.48" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_18A" x="-5.08" y="-33.02" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_20A" x="-5.08" y="-35.56" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_22A" x="-5.08" y="-38.1" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_24A" x="-5.08" y="-40.64" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_32A_SPI_SO" x="-5.08" y="-43.18" length="middle" direction="pas"/>
<pin name="IOB_34A_SPI_SCK" x="-5.08" y="-45.72" length="middle" direction="pas"/>
<pin name="IOB_35B_SPI_SS" x="-5.08" y="-48.26" length="middle" direction="pas"/>
<pin name="IOB_33B_SPI_SI" x="-5.08" y="-50.8" length="middle" direction="pas"/>
<pin name="IOB_31B" x="-5.08" y="-53.34" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_29B" x="-5.08" y="-55.88" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_25B_G3" x="-5.08" y="-58.42" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_23B" x="-5.08" y="-60.96" length="middle" direction="pas" swaplevel="1"/>
<pin name="SPI_VCCIO1" x="48.26" y="-50.8" length="middle" direction="pas" rot="R180"/>
<pin name="IOT_37A" x="48.26" y="-2.54" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="VPP_2V5" x="48.26" y="-58.42" length="middle" direction="pas" rot="R180"/>
<pin name="IOT_36B" x="48.26" y="-5.08" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOT_39A" x="48.26" y="-7.62" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOT_38B" x="48.26" y="-10.16" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOT_41A" x="48.26" y="-12.7" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="VCCPLL" x="48.26" y="-71.12" length="middle" direction="pas" rot="R180"/>
<pin name="VCC@2" x="48.26" y="-66.04" length="middle" direction="pas" rot="R180"/>
<pin name="IOT_42B" x="48.26" y="-15.24" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOT_43A" x="48.26" y="-17.78" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="VCCIO_0" x="48.26" y="-48.26" length="middle" direction="pas" rot="R180"/>
<pin name="IOT_44B" x="48.26" y="-20.32" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOT_46B_G0" x="48.26" y="-22.86" length="middle" direction="pas" rot="R180"/>
<pin name="IOT_48B" x="48.26" y="-25.4" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOT_45A_G1" x="48.26" y="-27.94" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOT_50B" x="48.26" y="-30.48" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="RGB0" x="48.26" y="-33.02" length="middle" direction="pas" swaplevel="3" rot="R180"/>
<pin name="RGB1" x="48.26" y="-35.56" length="middle" direction="pas" swaplevel="3" rot="R180"/>
<pin name="RGB2" x="48.26" y="-38.1" length="middle" direction="pas" swaplevel="3" rot="R180"/>
<pin name="IOT_51A" x="48.26" y="-40.64" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOT_49A" x="48.26" y="-43.18" length="middle" direction="pas" swaplevel="2" rot="R180"/>
<pin name="IOB_3B_G6" x="-5.08" y="-2.54" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_5B" x="-5.08" y="-5.08" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_0A" x="-5.08" y="-7.62" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_2A" x="-5.08" y="-10.16" length="middle" direction="pas" swaplevel="1"/>
<pin name="IOB_4A" x="-5.08" y="-12.7" length="middle" direction="pas" swaplevel="1"/>
<pin name="GND" x="48.26" y="-76.2" length="middle" direction="pas" rot="R180"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-81.28" size="1.778" layer="96" font="vector">&gt;VALUE</text>
</symbol>
<symbol name="QSPI_FLASH">
<wire x1="0" y1="0" x2="25.4" y2="0" width="0.254" layer="94"/>
<wire x1="25.4" y1="0" x2="25.4" y2="-17.78" width="0.254" layer="94"/>
<wire x1="25.4" y1="-17.78" x2="0" y2="-17.78" width="0.254" layer="94"/>
<wire x1="0" y1="-17.78" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-20.32" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="DQ3/HOLD#" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="CS#" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="DQ1" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="DQ2/WP#" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="VSS" x="30.48" y="-15.24" length="middle" direction="pas" rot="R180"/>
<pin name="DQ0" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="VCC" x="30.48" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="CLK" x="-5.08" y="-2.54" length="middle" direction="pas"/>
</symbol>
<symbol name="SN74CBTD3861PWR">
<pin name="A1" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="B1" x="22.86" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="A2" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="B2" x="22.86" y="-5.08" length="middle" direction="pas" rot="R180"/>
<pin name="A3" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="B3" x="22.86" y="-7.62" length="middle" direction="pas" rot="R180"/>
<pin name="A4" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="B4" x="22.86" y="-10.16" length="middle" direction="pas" rot="R180"/>
<pin name="A5" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="B5" x="22.86" y="-12.7" length="middle" direction="pas" rot="R180"/>
<pin name="A6" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="B6" x="22.86" y="-15.24" length="middle" direction="pas" rot="R180"/>
<pin name="A7" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="B7" x="22.86" y="-17.78" length="middle" direction="pas" rot="R180"/>
<pin name="A8" x="-5.08" y="-20.32" length="middle" direction="pas"/>
<pin name="B8" x="22.86" y="-20.32" length="middle" direction="pas" rot="R180"/>
<pin name="A9" x="-5.08" y="-22.86" length="middle" direction="pas"/>
<pin name="B9" x="22.86" y="-22.86" length="middle" direction="pas" rot="R180"/>
<pin name="OE#" x="-5.08" y="-33.02" length="middle" direction="pas"/>
<pin name="VCC" x="22.86" y="-30.48" length="middle" direction="pas" rot="R180"/>
<pin name="GND" x="22.86" y="-33.02" length="middle" direction="pas" rot="R180"/>
<wire x1="0" y1="0" x2="17.78" y2="0" width="0.254" layer="94"/>
<wire x1="17.78" y1="0" x2="17.78" y2="-35.56" width="0.254" layer="94"/>
<wire x1="17.78" y1="-35.56" x2="0" y2="-35.56" width="0.254" layer="94"/>
<wire x1="0" y1="-35.56" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-38.1" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="A10" x="-5.08" y="-25.4" length="middle" direction="pas"/>
<pin name="B10" x="22.86" y="-25.4" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="74LVC4245APW">
<pin name="A1" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="B1" x="22.86" y="-12.7" length="middle" direction="pas" rot="R180"/>
<pin name="A2" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="B2" x="22.86" y="-15.24" length="middle" direction="pas" rot="R180"/>
<pin name="A3" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="B3" x="22.86" y="-17.78" length="middle" direction="pas" rot="R180"/>
<pin name="A4" x="-5.08" y="-20.32" length="middle" direction="pas"/>
<pin name="B4" x="22.86" y="-20.32" length="middle" direction="pas" rot="R180"/>
<pin name="A5" x="-5.08" y="-22.86" length="middle" direction="pas"/>
<pin name="B5" x="22.86" y="-22.86" length="middle" direction="pas" rot="R180"/>
<pin name="A6" x="-5.08" y="-25.4" length="middle" direction="pas"/>
<pin name="B6" x="22.86" y="-25.4" length="middle" direction="pas" rot="R180"/>
<pin name="A7" x="-5.08" y="-27.94" length="middle" direction="pas"/>
<pin name="B7" x="22.86" y="-27.94" length="middle" direction="pas" rot="R180"/>
<pin name="OE#" x="-5.08" y="-35.56" length="middle" direction="pas"/>
<pin name="VCCA" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="GND@1" x="22.86" y="-33.02" length="middle" direction="pas" rot="R180"/>
<wire x1="0" y1="0" x2="17.78" y2="0" width="0.254" layer="94"/>
<wire x1="17.78" y1="0" x2="17.78" y2="-40.64" width="0.254" layer="94"/>
<wire x1="17.78" y1="-40.64" x2="0" y2="-40.64" width="0.254" layer="94"/>
<wire x1="0" y1="-40.64" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-43.18" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="A0" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="B0" x="22.86" y="-10.16" length="middle" direction="pas" rot="R180"/>
<pin name="DIR" x="-5.08" y="-38.1" length="middle" direction="pas"/>
<pin name="VCCB@1" x="22.86" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCCB@2" x="22.86" y="-5.08" length="middle" direction="pas" rot="R180"/>
<pin name="GND@2" x="22.86" y="-35.56" length="middle" direction="pas" rot="R180"/>
<pin name="GND@3" x="22.86" y="-38.1" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="74AHCT1G14">
<wire x1="0" y1="0" x2="15.24" y2="0" width="0.254" layer="94"/>
<wire x1="15.24" y1="0" x2="15.24" y2="-10.16" width="0.254" layer="94"/>
<wire x1="15.24" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94"/>
<wire x1="0" y1="-10.16" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-12.7" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="A" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="Y" x="20.32" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="VCC" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="GND" x="20.32" y="-7.62" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="MIC5504-3.3YM5-TR">
<wire x1="0" y1="0" x2="20.32" y2="0" width="0.254" layer="94"/>
<wire x1="20.32" y1="0" x2="20.32" y2="-12.7" width="0.254" layer="94"/>
<wire x1="20.32" y1="-12.7" x2="0" y2="-12.7" width="0.254" layer="94"/>
<wire x1="0" y1="-12.7" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-15.24" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="VIN" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="VOUT" x="25.4" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="EN" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="GND" x="-5.08" y="-10.16" length="middle" direction="pas"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="AP3417CKTR-G1" prefix="U">
<gates>
<gate name="_" symbol="AP3417C" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SOT-23-5">
<connects>
<connect gate="_" pin="EN" pad="1"/>
<connect gate="_" pin="FB" pad="5"/>
<connect gate="_" pin="GND" pad="2"/>
<connect gate="_" pin="LX" pad="3"/>
<connect gate="_" pin="VIN" pad="4"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="SG5032CAN_40.000000M-TJGA3" prefix="U">
<description>Epson 40 MHz 3.3V Oscillator +/- 50ppm</description>
<gates>
<gate name="_" symbol="OSCILLATOR" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SG5032">
<connects>
<connect gate="_" pin="GND" pad="2"/>
<connect gate="_" pin="OE" pad="1"/>
<connect gate="_" pin="OUT" pad="3"/>
<connect gate="_" pin="VCC" pad="4"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="ICE40UP5K-SG48ITR50" prefix="U">
<description>Lattice ICE40 5K LE FPGA</description>
<gates>
<gate name="_" symbol="ICE40UP5K-SG48ITR50" x="0" y="0"/>
</gates>
<devices>
<device name="" package="QFN-48">
<connects>
<connect gate="_" pin="CDONE" pad="7"/>
<connect gate="_" pin="CRESET_B" pad="8"/>
<connect gate="_" pin="GND" pad="49"/>
<connect gate="_" pin="IOB_0A" pad="46"/>
<connect gate="_" pin="IOB_13B" pad="6"/>
<connect gate="_" pin="IOB_16A" pad="9"/>
<connect gate="_" pin="IOB_18A" pad="10"/>
<connect gate="_" pin="IOB_20A" pad="11"/>
<connect gate="_" pin="IOB_22A" pad="12"/>
<connect gate="_" pin="IOB_23B" pad="21"/>
<connect gate="_" pin="IOB_24A" pad="13"/>
<connect gate="_" pin="IOB_25B_G3" pad="20"/>
<connect gate="_" pin="IOB_29B" pad="19"/>
<connect gate="_" pin="IOB_2A" pad="47"/>
<connect gate="_" pin="IOB_31B" pad="18"/>
<connect gate="_" pin="IOB_32A_SPI_SO" pad="14"/>
<connect gate="_" pin="IOB_33B_SPI_SI" pad="17"/>
<connect gate="_" pin="IOB_34A_SPI_SCK" pad="15"/>
<connect gate="_" pin="IOB_35B_SPI_SS" pad="16"/>
<connect gate="_" pin="IOB_3B_G6" pad="44"/>
<connect gate="_" pin="IOB_4A" pad="48"/>
<connect gate="_" pin="IOB_5B" pad="45"/>
<connect gate="_" pin="IOB_6A" pad="2"/>
<connect gate="_" pin="IOB_8A" pad="4"/>
<connect gate="_" pin="IOB_9B" pad="3"/>
<connect gate="_" pin="IOT_36B" pad="25"/>
<connect gate="_" pin="IOT_37A" pad="23"/>
<connect gate="_" pin="IOT_38B" pad="27"/>
<connect gate="_" pin="IOT_39A" pad="26"/>
<connect gate="_" pin="IOT_41A" pad="28"/>
<connect gate="_" pin="IOT_42B" pad="31"/>
<connect gate="_" pin="IOT_43A" pad="32"/>
<connect gate="_" pin="IOT_44B" pad="34"/>
<connect gate="_" pin="IOT_45A_G1" pad="37"/>
<connect gate="_" pin="IOT_46B_G0" pad="35"/>
<connect gate="_" pin="IOT_48B" pad="36"/>
<connect gate="_" pin="IOT_49A" pad="43"/>
<connect gate="_" pin="IOT_50B" pad="38"/>
<connect gate="_" pin="IOT_51A" pad="42"/>
<connect gate="_" pin="RGB0" pad="39"/>
<connect gate="_" pin="RGB1" pad="40"/>
<connect gate="_" pin="RGB2" pad="41"/>
<connect gate="_" pin="SPI_VCCIO1" pad="22"/>
<connect gate="_" pin="VCC@1" pad="5"/>
<connect gate="_" pin="VCC@2" pad="30"/>
<connect gate="_" pin="VCCIO_0" pad="33"/>
<connect gate="_" pin="VCCIO_2" pad="1"/>
<connect gate="_" pin="VCCPLL" pad="29"/>
<connect gate="_" pin="VPP_2V5" pad="24"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="QSPI_FLASH" prefix="U">
<gates>
<gate name="_" symbol="QSPI_FLASH" x="0" y="0"/>
</gates>
<devices>
<device name="SOIC16W" package="SOIC-16-300">
<connects>
<connect gate="_" pin="CLK" pad="16"/>
<connect gate="_" pin="CS#" pad="7"/>
<connect gate="_" pin="DQ0" pad="15"/>
<connect gate="_" pin="DQ1" pad="8"/>
<connect gate="_" pin="DQ2/WP#" pad="9"/>
<connect gate="_" pin="DQ3/HOLD#" pad="1"/>
<connect gate="_" pin="VCC" pad="2"/>
<connect gate="_" pin="VSS" pad="10"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="SOIC8" package="SOIC-8">
<connects>
<connect gate="_" pin="CLK" pad="6"/>
<connect gate="_" pin="CS#" pad="1"/>
<connect gate="_" pin="DQ0" pad="5"/>
<connect gate="_" pin="DQ1" pad="2"/>
<connect gate="_" pin="DQ2/WP#" pad="3"/>
<connect gate="_" pin="DQ3/HOLD#" pad="7"/>
<connect gate="_" pin="VCC" pad="8"/>
<connect gate="_" pin="VSS" pad="4"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="SN74CBTD3861PWR" prefix="U">
<gates>
<gate name="_" symbol="SN74CBTD3861PWR" x="0" y="0"/>
</gates>
<devices>
<device name="" package="TSSOP-24">
<connects>
<connect gate="_" pin="A1" pad="2"/>
<connect gate="_" pin="A10" pad="11"/>
<connect gate="_" pin="A2" pad="3"/>
<connect gate="_" pin="A3" pad="4"/>
<connect gate="_" pin="A4" pad="5"/>
<connect gate="_" pin="A5" pad="6"/>
<connect gate="_" pin="A6" pad="7"/>
<connect gate="_" pin="A7" pad="8"/>
<connect gate="_" pin="A8" pad="9"/>
<connect gate="_" pin="A9" pad="10"/>
<connect gate="_" pin="B1" pad="22"/>
<connect gate="_" pin="B10" pad="13"/>
<connect gate="_" pin="B2" pad="21"/>
<connect gate="_" pin="B3" pad="20"/>
<connect gate="_" pin="B4" pad="19"/>
<connect gate="_" pin="B5" pad="18"/>
<connect gate="_" pin="B6" pad="17"/>
<connect gate="_" pin="B7" pad="16"/>
<connect gate="_" pin="B8" pad="15"/>
<connect gate="_" pin="B9" pad="14"/>
<connect gate="_" pin="GND" pad="12"/>
<connect gate="_" pin="OE#" pad="23"/>
<connect gate="_" pin="VCC" pad="24"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="74LVC4245APW" prefix="U">
<gates>
<gate name="_" symbol="74LVC4245APW" x="0" y="0"/>
</gates>
<devices>
<device name="" package="TSSOP-24">
<connects>
<connect gate="_" pin="A0" pad="3"/>
<connect gate="_" pin="A1" pad="4"/>
<connect gate="_" pin="A2" pad="5"/>
<connect gate="_" pin="A3" pad="6"/>
<connect gate="_" pin="A4" pad="7"/>
<connect gate="_" pin="A5" pad="8"/>
<connect gate="_" pin="A6" pad="9"/>
<connect gate="_" pin="A7" pad="10"/>
<connect gate="_" pin="B0" pad="21"/>
<connect gate="_" pin="B1" pad="20"/>
<connect gate="_" pin="B2" pad="19"/>
<connect gate="_" pin="B3" pad="18"/>
<connect gate="_" pin="B4" pad="17"/>
<connect gate="_" pin="B5" pad="16"/>
<connect gate="_" pin="B6" pad="15"/>
<connect gate="_" pin="B7" pad="14"/>
<connect gate="_" pin="DIR" pad="2"/>
<connect gate="_" pin="GND@1" pad="11"/>
<connect gate="_" pin="GND@2" pad="12"/>
<connect gate="_" pin="GND@3" pad="13"/>
<connect gate="_" pin="OE#" pad="22"/>
<connect gate="_" pin="VCCA" pad="1"/>
<connect gate="_" pin="VCCB@1" pad="23"/>
<connect gate="_" pin="VCCB@2" pad="24"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="74AHCT1G14SE-7" prefix="U">
<gates>
<gate name="_" symbol="74AHCT1G14" x="0" y="0"/>
</gates>
<devices>
<device name="" package="TSSOP-5">
<connects>
<connect gate="_" pin="A" pad="2"/>
<connect gate="_" pin="GND" pad="3"/>
<connect gate="_" pin="VCC" pad="5"/>
<connect gate="_" pin="Y" pad="4"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="MIC5504-3.3YM5-TR" prefix="U">
<gates>
<gate name="_" symbol="MIC5504-3.3YM5-TR" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SOT-23-5">
<connects>
<connect gate="_" pin="EN" pad="3"/>
<connect gate="_" pin="GND" pad="2"/>
<connect gate="_" pin="VIN" pad="1"/>
<connect gate="_" pin="VOUT" pad="5"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="rcl">
<packages>
<package name="C0603">
<description>1.6x0.8 mm</description>
<smd name="1" x="-0.8" y="0" dx="1" dy="0.95" layer="1" rot="R90"/>
<smd name="2" x="0.8" y="0" dx="1" dy="0.95" layer="1" rot="R90"/>
<wire x1="-1.55" y1="-0.75" x2="-1.55" y2="0.75" width="0" layer="59"/>
<wire x1="1.55" y1="-0.75" x2="1.55" y2="0.75" width="0" layer="59"/>
<wire x1="-1.55" y1="0.75" x2="1.55" y2="0.75" width="0" layer="59"/>
<wire x1="-1.55" y1="-0.75" x2="1.55" y2="-0.75" width="0" layer="59"/>
<wire x1="-1.3" y1="-0.5" x2="-1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="1.3" y1="-0.5" x2="1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="-1.3" y1="0.5" x2="1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="-1.3" y1="-0.5" x2="1.3" y2="-0.5" width="0.1" layer="51"/>
<text x="0" y="0" size="0.5" layer="51" font="vector" ratio="20" align="center">&gt;NAME</text>
</package>
<package name="C0805">
<description>2x1.25 mm</description>
<smd name="1" x="-0.9" y="0" dx="1.45" dy="1.15" layer="1" rot="R90"/>
<smd name="2" x="0.9" y="0" dx="1.45" dy="1.15" layer="1" rot="R90"/>
<wire x1="-1.75" y1="-1" x2="-1.75" y2="1" width="0" layer="59"/>
<wire x1="1.75" y1="-1" x2="1.75" y2="1" width="0" layer="59"/>
<wire x1="-1.75" y1="1" x2="1.75" y2="1" width="0" layer="59"/>
<wire x1="-1.75" y1="-1" x2="1.75" y2="-1" width="0" layer="59"/>
<wire x1="-1.5" y1="-0.725" x2="-1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="1.5" y1="-0.725" x2="1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="-1.5" y1="0.725" x2="1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="-1.5" y1="-0.725" x2="1.5" y2="-0.725" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="NRS4018">
<wire x1="0.5" y1="2" x2="-0.5" y2="2" width="0.2" layer="21"/>
<wire x1="-0.5" y1="-2" x2="0.5" y2="-2" width="0.2" layer="21"/>
<wire x1="-2" y1="2" x2="2" y2="2" width="0.1" layer="51"/>
<wire x1="2" y1="2" x2="2" y2="-2" width="0.1" layer="51"/>
<wire x1="2" y1="-2" x2="-2" y2="-2" width="0.1" layer="51"/>
<wire x1="-2" y1="-2" x2="-2" y2="2" width="0.1" layer="51"/>
<wire x1="-2.7" y1="2.3" x2="2.7" y2="2.3" width="0" layer="59"/>
<wire x1="2.7" y1="2.3" x2="2.7" y2="-2.3" width="0" layer="59"/>
<wire x1="2.7" y1="-2.3" x2="-2.7" y2="-2.3" width="0" layer="59"/>
<wire x1="-2.7" y1="-2.3" x2="-2.7" y2="2.3" width="0" layer="59"/>
<smd name="1" x="-1.6" y="0" dx="1.6" dy="3.7" layer="1" rot="R180"/>
<smd name="2" x="1.6" y="0" dx="1.6" dy="3.7" layer="1" rot="R180"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="R0603">
<description>1.6x0.8 mm</description>
<smd name="1" x="-0.8" y="0" dx="1" dy="0.95" layer="1" rot="R90"/>
<smd name="2" x="0.8" y="0" dx="1" dy="0.95" layer="1" rot="R90"/>
<wire x1="-1.55" y1="-0.75" x2="-1.55" y2="0.75" width="0" layer="59"/>
<wire x1="1.55" y1="-0.75" x2="1.55" y2="0.75" width="0" layer="59"/>
<wire x1="-1.55" y1="0.75" x2="1.55" y2="0.75" width="0" layer="59"/>
<wire x1="-1.55" y1="-0.75" x2="1.55" y2="-0.75" width="0" layer="59"/>
<wire x1="-1.3" y1="-0.5" x2="-1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="1.3" y1="-0.5" x2="1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="-1.3" y1="0.5" x2="1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="-1.3" y1="-0.5" x2="1.3" y2="-0.5" width="0.1" layer="51"/>
<text x="0" y="0" size="0.5" layer="51" font="vector" ratio="20" align="center">&gt;NAME</text>
</package>
<package name="C0402">
<description>1x0.5 mm</description>
<smd name="1" x="-0.45" y="0" dx="0.62" dy="0.62" layer="1" rot="R90"/>
<smd name="2" x="0.45" y="0" dx="0.62" dy="0.62" layer="1" rot="R90"/>
<wire x1="-0.95" y1="-0.5" x2="-0.95" y2="0.5" width="0" layer="59"/>
<wire x1="0.95" y1="-0.5" x2="0.95" y2="0.5" width="0" layer="59"/>
<wire x1="-0.95" y1="0.5" x2="0.95" y2="0.5" width="0" layer="59"/>
<wire x1="-0.95" y1="-0.5" x2="0.95" y2="-0.5" width="0" layer="59"/>
<wire x1="-0.5" y1="-0.25" x2="-0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="0.5" y1="-0.25" x2="0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="-0.5" y1="0.25" x2="0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="-0.5" y1="-0.25" x2="0.5" y2="-0.25" width="0.1" layer="51"/>
<text x="0" y="0" size="0.2" layer="51" font="vector" ratio="30" align="center">&gt;NAME</text>
</package>
<package name="C1206">
<description>3.2x1.6 mm</description>
<smd name="1" x="-1.5" y="0" dx="1.8" dy="1.15" layer="1" rot="R90"/>
<smd name="2" x="1.5" y="0" dx="1.8" dy="1.15" layer="1" rot="R90"/>
<wire x1="-0.625" y1="0.8" x2="0.625" y2="0.8" width="0.2" layer="21"/>
<wire x1="-0.625" y1="-0.8" x2="0.625" y2="-0.8" width="0.2" layer="21"/>
<wire x1="-2.35" y1="-1.15" x2="-2.35" y2="1.15" width="0" layer="59"/>
<wire x1="2.35" y1="-1.15" x2="2.35" y2="1.15" width="0" layer="59"/>
<wire x1="-2.35" y1="1.15" x2="2.35" y2="1.15" width="0" layer="59"/>
<wire x1="-2.35" y1="-1.15" x2="2.35" y2="-1.15" width="0" layer="59"/>
<wire x1="-1.6" y1="-0.8" x2="-1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="1.6" y1="-0.8" x2="1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="-1.6" y1="0.8" x2="1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="-1.6" y1="-0.8" x2="1.6" y2="-0.8" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="C1210">
<description>3.2x2.5 mm</description>
<smd name="1" x="-1.5" y="0" dx="2.7" dy="1.15" layer="1" rot="R90"/>
<smd name="2" x="1.5" y="0" dx="2.7" dy="1.15" layer="1" rot="R90"/>
<wire x1="-0.625" y1="1.25" x2="0.625" y2="1.25" width="0.2" layer="21"/>
<wire x1="-0.625" y1="-1.25" x2="0.625" y2="-1.25" width="0.2" layer="21"/>
<wire x1="-2.35" y1="-1.6" x2="-2.35" y2="1.6" width="0" layer="59"/>
<wire x1="2.35" y1="-1.6" x2="2.35" y2="1.6" width="0" layer="59"/>
<wire x1="-2.35" y1="1.6" x2="2.35" y2="1.6" width="0" layer="59"/>
<wire x1="-2.35" y1="-1.6" x2="2.35" y2="-1.6" width="0" layer="59"/>
<wire x1="-1.6" y1="-1.25" x2="-1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="1.6" y1="-1.25" x2="1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="-1.6" y1="1.25" x2="1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="-1.6" y1="-1.25" x2="1.6" y2="-1.25" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="AVX_D3">
<description>AVX Film capacitor D3 case</description>
<pad name="1" x="-11.25" y="0" drill="1"/>
<pad name="2" x="11.25" y="0" drill="1"/>
<wire x1="-13.25" y1="5.75" x2="13.25" y2="5.75" width="0.2" layer="21"/>
<wire x1="13.25" y1="5.75" x2="13.25" y2="-5.75" width="0.2" layer="21"/>
<wire x1="13.25" y1="-5.75" x2="-13.25" y2="-5.75" width="0.2" layer="21"/>
<wire x1="-13.25" y1="-5.75" x2="-13.25" y2="5.75" width="0.2" layer="21"/>
<wire x1="-13.5" y1="-6" x2="-13.5" y2="6" width="0" layer="59"/>
<wire x1="13.5" y1="-6" x2="13.5" y2="6" width="0" layer="59"/>
<wire x1="-13.5" y1="6" x2="13.5" y2="6" width="0" layer="59"/>
<wire x1="-13.5" y1="-6" x2="13.5" y2="-6" width="0" layer="59"/>
<wire x1="-13.25" y1="-5.75" x2="-13.25" y2="5.75" width="0.1" layer="51"/>
<wire x1="13.25" y1="-5.75" x2="13.25" y2="5.75" width="0.1" layer="51"/>
<wire x1="-13.25" y1="5.75" x2="13.25" y2="5.75" width="0.1" layer="51"/>
<wire x1="-13.25" y1="-5.75" x2="13.25" y2="-5.75" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="CTH18X5_15LS">
<description>Body 18x5mm  15mm lead spacing</description>
<pad name="1" x="-7.5" y="0" drill="1"/>
<pad name="2" x="7.5" y="0" drill="1"/>
<wire x1="-9" y1="2.5" x2="9" y2="2.5" width="0.1" layer="51"/>
<wire x1="9" y1="2.5" x2="9" y2="-2.5" width="0.1" layer="51"/>
<wire x1="9" y1="-2.5" x2="-9" y2="-2.5" width="0.1" layer="51"/>
<wire x1="-9" y1="-2.5" x2="-9" y2="2.5" width="0.1" layer="51"/>
<wire x1="-9.25" y1="-2.75" x2="-9.25" y2="2.75" width="0" layer="59"/>
<wire x1="9.25" y1="-2.75" x2="9.25" y2="2.75" width="0" layer="59"/>
<wire x1="-9.25" y1="2.75" x2="9.25" y2="2.75" width="0" layer="59"/>
<wire x1="-9.25" y1="-2.75" x2="9.25" y2="-2.75" width="0" layer="59"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
<wire x1="-9" y1="2.5" x2="9" y2="2.5" width="0.2" layer="21"/>
<wire x1="9" y1="2.5" x2="9" y2="-2.5" width="0.2" layer="21"/>
<wire x1="9" y1="-2.5" x2="-9" y2="-2.5" width="0.2" layer="21"/>
<wire x1="-9" y1="-2.5" x2="-9" y2="2.5" width="0.2" layer="21"/>
</package>
<package name="CTH13X4_10LS">
<description>Body 13x4mm  10mm lead spacing</description>
<pad name="1" x="-5" y="0" drill="1"/>
<pad name="2" x="5" y="0" drill="1"/>
<wire x1="-6.5" y1="2" x2="6.5" y2="2" width="0.1" layer="51"/>
<wire x1="6.5" y1="2" x2="6.5" y2="-2" width="0.1" layer="51"/>
<wire x1="6.5" y1="-2" x2="-6.5" y2="-2" width="0.1" layer="51"/>
<wire x1="-6.5" y1="-2" x2="-6.5" y2="2" width="0.1" layer="51"/>
<wire x1="-6.75" y1="-2.25" x2="-6.75" y2="2.25" width="0" layer="59"/>
<wire x1="6.75" y1="-2.25" x2="6.75" y2="2.25" width="0" layer="59"/>
<wire x1="-6.75" y1="2.25" x2="6.75" y2="2.25" width="0" layer="59"/>
<wire x1="-6.75" y1="-2.25" x2="6.75" y2="-2.25" width="0" layer="59"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
<wire x1="-6.5" y1="2" x2="6.5" y2="2" width="0.2" layer="21"/>
<wire x1="6.5" y1="2" x2="6.5" y2="-2" width="0.2" layer="21"/>
<wire x1="6.5" y1="-2" x2="-6.5" y2="-2" width="0.2" layer="21"/>
<wire x1="-6.5" y1="-2" x2="-6.5" y2="2" width="0.2" layer="21"/>
</package>
<package name="R0402">
<description>1x0.5 mm</description>
<smd name="1" x="-0.48" y="0" dx="0.57" dy="0.62" layer="1" rot="R90"/>
<smd name="2" x="0.48" y="0" dx="0.57" dy="0.62" layer="1" rot="R90"/>
<wire x1="-0.95" y1="-0.5" x2="-0.95" y2="0.5" width="0" layer="59"/>
<wire x1="0.95" y1="-0.5" x2="0.95" y2="0.5" width="0" layer="59"/>
<wire x1="-0.95" y1="0.5" x2="0.95" y2="0.5" width="0" layer="59"/>
<wire x1="-0.95" y1="-0.5" x2="0.95" y2="-0.5" width="0" layer="59"/>
<wire x1="-0.5" y1="-0.25" x2="-0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="0.5" y1="-0.25" x2="0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="-0.5" y1="0.25" x2="0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="-0.5" y1="-0.25" x2="0.5" y2="-0.25" width="0.1" layer="51"/>
<text x="0" y="0" size="0.2" layer="51" font="vector" ratio="30" align="center">&gt;NAME</text>
</package>
<package name="R0805">
<description>2x1.25 mm</description>
<smd name="1" x="-0.95" y="0" dx="1.4" dy="1.05" layer="1" rot="R90"/>
<smd name="2" x="0.95" y="0" dx="1.4" dy="1.05" layer="1" rot="R90"/>
<wire x1="-0.125" y1="0.625" x2="0.125" y2="0.625" width="0.2" layer="21"/>
<wire x1="-0.125" y1="-0.625" x2="0.125" y2="-0.625" width="0.2" layer="21"/>
<wire x1="-1.75" y1="-0.95" x2="-1.75" y2="0.95" width="0" layer="59"/>
<wire x1="1.75" y1="-0.95" x2="1.75" y2="0.95" width="0" layer="59"/>
<wire x1="-1.75" y1="0.95" x2="1.75" y2="0.95" width="0" layer="59"/>
<wire x1="-1.75" y1="-0.95" x2="1.75" y2="-0.95" width="0" layer="59"/>
<wire x1="-1.5" y1="-0.725" x2="-1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="1.5" y1="-0.725" x2="1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="-1.5" y1="0.725" x2="1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="-1.5" y1="-0.725" x2="1.5" y2="-0.725" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="R1206">
<description>3.2x1.6 mm</description>
<smd name="1" x="-1.45" y="0" dx="1.8" dy="1.15" layer="1" rot="R90"/>
<smd name="2" x="1.45" y="0" dx="1.8" dy="1.15" layer="1" rot="R90"/>
<wire x1="-0.575" y1="0.8" x2="0.575" y2="0.8" width="0.2" layer="21"/>
<wire x1="-0.575" y1="-0.8" x2="0.575" y2="-0.8" width="0.2" layer="21"/>
<wire x1="-2.3" y1="-1.15" x2="-2.3" y2="1.15" width="0" layer="59"/>
<wire x1="2.3" y1="-1.15" x2="2.3" y2="1.15" width="0" layer="59"/>
<wire x1="-2.3" y1="1.15" x2="2.3" y2="1.15" width="0" layer="59"/>
<wire x1="-2.3" y1="-1.15" x2="2.3" y2="-1.15" width="0" layer="59"/>
<wire x1="-1.6" y1="-0.8" x2="-1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="1.6" y1="-0.8" x2="1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="-1.6" y1="0.8" x2="1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="-1.6" y1="-0.8" x2="1.6" y2="-0.8" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="R1210">
<description>3.2x2.5 mm</description>
<smd name="1" x="-1.45" y="0" dx="2.7" dy="1.15" layer="1" rot="R90"/>
<smd name="2" x="1.45" y="0" dx="2.7" dy="1.15" layer="1" rot="R90"/>
<wire x1="-0.575" y1="1.25" x2="0.575" y2="1.25" width="0.2" layer="21"/>
<wire x1="-0.575" y1="-1.25" x2="0.575" y2="-1.25" width="0.2" layer="21"/>
<wire x1="-2.3" y1="-1.6" x2="-2.3" y2="1.6" width="0" layer="59"/>
<wire x1="2.3" y1="-1.6" x2="2.3" y2="1.6" width="0" layer="59"/>
<wire x1="-2.3" y1="1.6" x2="2.3" y2="1.6" width="0" layer="59"/>
<wire x1="-2.3" y1="-1.6" x2="2.3" y2="-1.6" width="0" layer="59"/>
<wire x1="-1.6" y1="-1.25" x2="-1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="1.6" y1="-1.25" x2="1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="-1.6" y1="1.25" x2="1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="-1.6" y1="-1.25" x2="1.6" y2="-1.25" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="RTH8.5X2.7">
<description>Body 8.5x2.7  (0.5W resistor)</description>
<pad name="1" x="-5.5" y="0" drill="0.8"/>
<pad name="2" x="5.5" y="0" drill="0.8"/>
<wire x1="-4.25" y1="1.35" x2="4.25" y2="1.35" width="0.1" layer="51"/>
<wire x1="4.25" y1="1.35" x2="4.25" y2="0.275" width="0.1" layer="51"/>
<wire x1="4.25" y1="0.275" x2="4.25" y2="-0.275" width="0.1" layer="51"/>
<wire x1="4.25" y1="-0.275" x2="4.25" y2="-1.35" width="0.1" layer="51"/>
<wire x1="4.25" y1="-1.35" x2="-4.25" y2="-1.35" width="0.1" layer="51"/>
<wire x1="-4.25" y1="-1.35" x2="-4.25" y2="-0.275" width="0.1" layer="51"/>
<wire x1="-4.25" y1="-0.275" x2="-4.25" y2="0.275" width="0.1" layer="51"/>
<wire x1="-4.25" y1="0.275" x2="-4.25" y2="1.35" width="0.1" layer="51"/>
<wire x1="-4.25" y1="0.275" x2="-5.5" y2="0.275" width="0.1" layer="51"/>
<wire x1="-5.5" y1="0.275" x2="-5.5" y2="-0.275" width="0.1" layer="51" curve="180"/>
<wire x1="-5.5" y1="-0.275" x2="-4.25" y2="-0.275" width="0.1" layer="51"/>
<wire x1="4.25" y1="0.275" x2="5.5" y2="0.275" width="0.1" layer="51"/>
<wire x1="5.5" y1="0.275" x2="5.5" y2="-0.275" width="0.1" layer="51" curve="-180"/>
<wire x1="5.5" y1="-0.275" x2="4.25" y2="-0.275" width="0.1" layer="51"/>
<wire x1="-6.45" y1="-1.6" x2="-6.45" y2="1.6" width="0" layer="59"/>
<wire x1="6.45" y1="-1.6" x2="6.45" y2="1.6" width="0" layer="59"/>
<wire x1="-6.45" y1="1.6" x2="6.45" y2="1.6" width="0" layer="59"/>
<wire x1="-6.45" y1="-1.6" x2="6.45" y2="-1.6" width="0" layer="59"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
<wire x1="-4.25" y1="1.35" x2="4.25" y2="1.35" width="0.2" layer="21"/>
<wire x1="4.25" y1="1.35" x2="4.25" y2="-1.35" width="0.2" layer="21"/>
<wire x1="4.25" y1="-1.35" x2="-4.25" y2="-1.35" width="0.2" layer="21"/>
<wire x1="-4.25" y1="-1.35" x2="-4.25" y2="1.35" width="0.2" layer="21"/>
</package>
<package name="L0402">
<description>1x0.5 mm</description>
<smd name="1" x="-0.48" y="0" dx="0.72" dy="0.59" layer="1" rot="R90"/>
<smd name="2" x="0.48" y="0" dx="0.72" dy="0.59" layer="1" rot="R90"/>
<wire x1="-0.95" y1="-0.55" x2="-0.95" y2="0.55" width="0" layer="59"/>
<wire x1="0.95" y1="-0.55" x2="0.95" y2="0.55" width="0" layer="59"/>
<wire x1="-0.95" y1="0.55" x2="0.95" y2="0.55" width="0" layer="59"/>
<wire x1="-0.95" y1="-0.55" x2="0.95" y2="-0.55" width="0" layer="59"/>
<wire x1="-0.5" y1="-0.25" x2="-0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="0.5" y1="-0.25" x2="0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="-0.5" y1="0.25" x2="0.5" y2="0.25" width="0.1" layer="51"/>
<wire x1="-0.5" y1="-0.25" x2="0.5" y2="-0.25" width="0.1" layer="51"/>
<text x="0" y="0" size="0.2" layer="51" font="vector" ratio="30" align="center">&gt;NAME</text>
</package>
<package name="L0603">
<description>1.6x0.8 mm</description>
<smd name="1" x="-0.8" y="0" dx="1" dy="0.95" layer="1" rot="R90"/>
<smd name="2" x="0.8" y="0" dx="1" dy="0.95" layer="1" rot="R90"/>
<wire x1="-1.55" y1="-0.75" x2="-1.55" y2="0.75" width="0" layer="59"/>
<wire x1="1.55" y1="-0.75" x2="1.55" y2="0.75" width="0" layer="59"/>
<wire x1="-1.55" y1="0.75" x2="1.55" y2="0.75" width="0" layer="59"/>
<wire x1="-1.55" y1="-0.75" x2="1.55" y2="-0.75" width="0" layer="59"/>
<wire x1="-1.3" y1="-0.5" x2="-1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="1.3" y1="-0.5" x2="1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="-1.3" y1="0.5" x2="1.3" y2="0.5" width="0.1" layer="51"/>
<wire x1="-1.3" y1="-0.5" x2="1.3" y2="-0.5" width="0.1" layer="51"/>
<text x="0" y="0" size="0.5" layer="51" font="vector" ratio="20" align="center">&gt;NAME</text>
</package>
<package name="L0805">
<description>2x1.25 mm</description>
<smd name="1" x="-0.85" y="0" dx="1.45" dy="1.2" layer="1" rot="R90"/>
<smd name="2" x="0.85" y="0" dx="1.45" dy="1.2" layer="1" rot="R90"/>
<wire x1="-1.7" y1="-1" x2="-1.7" y2="1" width="0" layer="59"/>
<wire x1="1.7" y1="-1" x2="1.7" y2="1" width="0" layer="59"/>
<wire x1="-1.7" y1="1" x2="1.7" y2="1" width="0" layer="59"/>
<wire x1="-1.7" y1="-1" x2="1.7" y2="-1" width="0" layer="59"/>
<wire x1="-1.5" y1="-0.725" x2="-1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="1.5" y1="-0.725" x2="1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="-1.5" y1="0.725" x2="1.5" y2="0.725" width="0.1" layer="51"/>
<wire x1="-1.5" y1="-0.725" x2="1.5" y2="-0.725" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="L1008">
<description>2.5x2 mm</description>
<smd name="1" x="-1.25" y="0" dx="2.3" dy="0.95" layer="1" rot="R90"/>
<smd name="2" x="1.25" y="0" dx="2.3" dy="0.95" layer="1" rot="R90"/>
<wire x1="-0.475" y1="1" x2="0.475" y2="1" width="0.2" layer="21"/>
<wire x1="-0.475" y1="-1" x2="0.475" y2="-1" width="0.2" layer="21"/>
<wire x1="-2" y1="-1.4" x2="-2" y2="1.4" width="0" layer="59"/>
<wire x1="2" y1="-1.4" x2="2" y2="1.4" width="0" layer="59"/>
<wire x1="-2" y1="1.4" x2="2" y2="1.4" width="0" layer="59"/>
<wire x1="-2" y1="-1.4" x2="2" y2="-1.4" width="0" layer="59"/>
<wire x1="-1.25" y1="-1" x2="-1.25" y2="1" width="0.1" layer="51"/>
<wire x1="1.25" y1="-1" x2="1.25" y2="1" width="0.1" layer="51"/>
<wire x1="-1.25" y1="1" x2="1.25" y2="1" width="0.1" layer="51"/>
<wire x1="-1.25" y1="-1" x2="1.25" y2="-1" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="L1210">
<description>3.2x2.5 mm</description>
<smd name="1" x="-1.5" y="0" dx="2.7" dy="1.15" layer="1" rot="R90"/>
<smd name="2" x="1.5" y="0" dx="2.7" dy="1.15" layer="1" rot="R90"/>
<wire x1="-0.625" y1="1.25" x2="0.625" y2="1.25" width="0.2" layer="21"/>
<wire x1="-0.625" y1="-1.25" x2="0.625" y2="-1.25" width="0.2" layer="21"/>
<wire x1="-2.35" y1="-1.6" x2="-2.35" y2="1.6" width="0" layer="59"/>
<wire x1="2.35" y1="-1.6" x2="2.35" y2="1.6" width="0" layer="59"/>
<wire x1="-2.35" y1="1.6" x2="2.35" y2="1.6" width="0" layer="59"/>
<wire x1="-2.35" y1="-1.6" x2="2.35" y2="-1.6" width="0" layer="59"/>
<wire x1="-1.6" y1="-1.25" x2="-1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="1.6" y1="-1.25" x2="1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="-1.6" y1="1.25" x2="1.6" y2="1.25" width="0.1" layer="51"/>
<wire x1="-1.6" y1="-1.25" x2="1.6" y2="-1.25" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="L1806">
<description>4.5x0.9 mm</description>
<smd name="1" x="-2.1" y="0" dx="1.2" dy="1.3" layer="1" rot="R90"/>
<smd name="2" x="2.1" y="0" dx="1.2" dy="1.3" layer="1" rot="R90"/>
<wire x1="-1.15" y1="0.45" x2="1.15" y2="0.45" width="0.2" layer="21"/>
<wire x1="-1.15" y1="-0.45" x2="1.15" y2="-0.45" width="0.2" layer="21"/>
<wire x1="-3" y1="-0.85" x2="-3" y2="0.85" width="0" layer="59"/>
<wire x1="3" y1="-0.85" x2="3" y2="0.85" width="0" layer="59"/>
<wire x1="-3" y1="0.85" x2="3" y2="0.85" width="0" layer="59"/>
<wire x1="-3" y1="-0.85" x2="3" y2="-0.85" width="0" layer="59"/>
<wire x1="-2.25" y1="-0.45" x2="-2.25" y2="0.45" width="0.1" layer="51"/>
<wire x1="2.25" y1="-0.45" x2="2.25" y2="0.45" width="0.1" layer="51"/>
<wire x1="-2.25" y1="0.45" x2="2.25" y2="0.45" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-0.45" x2="2.25" y2="-0.45" width="0.1" layer="51"/>
<text x="0" y="0" size="0.6" layer="51" font="vector" ratio="16" align="center">&gt;NAME</text>
</package>
<package name="L1812">
<description>4.5x3.2 mm</description>
<smd name="1" x="-2.05" y="0" dx="3.4" dy="1.4" layer="1" rot="R90"/>
<smd name="2" x="2.05" y="0" dx="3.4" dy="1.4" layer="1" rot="R90"/>
<wire x1="-1.05" y1="1.6" x2="1.05" y2="1.6" width="0.2" layer="21"/>
<wire x1="-1.05" y1="-1.6" x2="1.05" y2="-1.6" width="0.2" layer="21"/>
<wire x1="-3" y1="-1.95" x2="-3" y2="1.95" width="0" layer="59"/>
<wire x1="3" y1="-1.95" x2="3" y2="1.95" width="0" layer="59"/>
<wire x1="-3" y1="1.95" x2="3" y2="1.95" width="0" layer="59"/>
<wire x1="-3" y1="-1.95" x2="3" y2="-1.95" width="0" layer="59"/>
<wire x1="-2.25" y1="-1.6" x2="-2.25" y2="1.6" width="0.1" layer="51"/>
<wire x1="2.25" y1="-1.6" x2="2.25" y2="1.6" width="0.1" layer="51"/>
<wire x1="-2.25" y1="1.6" x2="2.25" y2="1.6" width="0.1" layer="51"/>
<wire x1="-2.25" y1="-1.6" x2="2.25" y2="-1.6" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="L2220">
<description>5.7x5 mm</description>
<smd name="1" x="-2.7" y="0" dx="5.3" dy="1.2" layer="1" rot="R90"/>
<smd name="2" x="2.7" y="0" dx="5.3" dy="1.2" layer="1" rot="R90"/>
<wire x1="-1.8" y1="2.5" x2="1.8" y2="2.5" width="0.2" layer="21"/>
<wire x1="-1.8" y1="-2.5" x2="1.8" y2="-2.5" width="0.2" layer="21"/>
<wire x1="-3.55" y1="-2.9" x2="-3.55" y2="2.9" width="0" layer="59"/>
<wire x1="3.55" y1="-2.9" x2="3.55" y2="2.9" width="0" layer="59"/>
<wire x1="-3.55" y1="2.9" x2="3.55" y2="2.9" width="0" layer="59"/>
<wire x1="-3.55" y1="-2.9" x2="3.55" y2="-2.9" width="0" layer="59"/>
<wire x1="-2.85" y1="-2.5" x2="-2.85" y2="2.5" width="0.1" layer="51"/>
<wire x1="2.85" y1="-2.5" x2="2.85" y2="2.5" width="0.1" layer="51"/>
<wire x1="-2.85" y1="2.5" x2="2.85" y2="2.5" width="0.1" layer="51"/>
<wire x1="-2.85" y1="-2.5" x2="2.85" y2="-2.5" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="L2520">
<description>6.3x5 mm</description>
<smd name="1" x="-3" y="0" dx="5.3" dy="1.2" layer="1" rot="R90"/>
<smd name="2" x="3" y="0" dx="5.3" dy="1.2" layer="1" rot="R90"/>
<wire x1="-2.1" y1="2.5" x2="2.1" y2="2.5" width="0.2" layer="21"/>
<wire x1="-2.1" y1="-2.5" x2="2.1" y2="-2.5" width="0.2" layer="21"/>
<wire x1="-3.85" y1="-2.9" x2="-3.85" y2="2.9" width="0" layer="59"/>
<wire x1="3.85" y1="-2.9" x2="3.85" y2="2.9" width="0" layer="59"/>
<wire x1="-3.85" y1="2.9" x2="3.85" y2="2.9" width="0" layer="59"/>
<wire x1="-3.85" y1="-2.9" x2="3.85" y2="-2.9" width="0" layer="59"/>
<wire x1="-3.15" y1="-2.5" x2="-3.15" y2="2.5" width="0.1" layer="51"/>
<wire x1="3.15" y1="-2.5" x2="3.15" y2="2.5" width="0.1" layer="51"/>
<wire x1="-3.15" y1="2.5" x2="3.15" y2="2.5" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-2.5" x2="3.15" y2="-2.5" width="0.1" layer="51"/>
<text x="0" y="0" size="1" layer="51" font="vector" ratio="10" align="center">&gt;NAME</text>
</package>
<package name="RA4_1206">
<description>1.6x0.8 mm</description>
<smd name="1A" x="-1.2" y="0.8" dx="0.4" dy="0.8" layer="1"/>
<smd name="1B" x="-1.2" y="-0.8" dx="0.4" dy="0.8" layer="1"/>
<wire x1="-1.85" y1="-1.45" x2="-1.85" y2="1.45" width="0" layer="59"/>
<wire x1="1.85" y1="-1.45" x2="1.85" y2="1.45" width="0" layer="59"/>
<wire x1="-1.85" y1="1.45" x2="1.85" y2="1.45" width="0" layer="59"/>
<wire x1="-1.85" y1="-1.45" x2="1.85" y2="-1.45" width="0" layer="59"/>
<wire x1="-1.6" y1="-0.8" x2="-1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="1.6" y1="-0.8" x2="1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="-1.6" y1="0.8" x2="1.6" y2="0.8" width="0.1" layer="51"/>
<wire x1="-1.6" y1="-0.8" x2="1.6" y2="-0.8" width="0.1" layer="51"/>
<text x="0" y="0" size="0.5" layer="51" font="vector" ratio="20" align="center">&gt;NAME</text>
<smd name="2A" x="-0.4" y="0.8" dx="0.4" dy="0.8" layer="1"/>
<smd name="2B" x="-0.4" y="-0.8" dx="0.4" dy="0.8" layer="1"/>
<smd name="3A" x="0.4" y="0.8" dx="0.4" dy="0.8" layer="1"/>
<smd name="3B" x="0.4" y="-0.8" dx="0.4" dy="0.8" layer="1"/>
<smd name="4A" x="1.2" y="0.8" dx="0.4" dy="0.8" layer="1"/>
<smd name="4B" x="1.2" y="-0.8" dx="0.4" dy="0.8" layer="1"/>
<wire x1="-1.6" y1="0.8" x2="-1.6" y2="-0.8" width="0.2" layer="21"/>
<wire x1="1.6" y1="0.8" x2="1.6" y2="-0.8" width="0.2" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="CAPACITOR">
<wire x1="-2.54" y1="0" x2="-0.762" y2="0" width="0.1524" layer="94"/>
<wire x1="2.54" y1="0" x2="0.762" y2="0" width="0.1524" layer="94"/>
<text x="0" y="2.54" size="1.778" layer="95" align="bottom-center">&gt;NAME</text>
<text x="0" y="-2.54" size="1.778" layer="96" align="top-center">&gt;VALUE</text>
<rectangle x1="-1.524" y1="-0.254" x2="2.54" y2="0.254" layer="94" rot="R90"/>
<rectangle x1="-2.54" y1="-0.254" x2="1.524" y2="0.254" layer="94" rot="R90"/>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
</symbol>
<symbol name="INDUCTOR">
<wire x1="-5.08" y1="0" x2="-2.54" y2="0" width="0.254" layer="94" curve="-180"/>
<wire x1="-2.54" y1="0" x2="0" y2="0" width="0.254" layer="94" curve="-180"/>
<wire x1="0" y1="0" x2="2.54" y2="0" width="0.254" layer="94" curve="-180"/>
<wire x1="2.54" y1="0" x2="5.08" y2="0" width="0.254" layer="94" curve="-180"/>
<text x="0" y="2.286" size="1.778" layer="95" align="bottom-center">&gt;NAME</text>
<text x="0" y="-1.016" size="1.778" layer="96" align="top-center">&gt;VALUE</text>
<pin name="1" x="-7.62" y="0" visible="off" length="short" direction="pas"/>
<pin name="2" x="7.62" y="0" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
<symbol name="RESISTOR">
<wire x1="-2.54" y1="-0.889" x2="2.54" y2="-0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="-0.889" x2="2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<text x="0" y="-1.778" size="1.778" layer="96" align="top-center">&gt;VALUE</text>
<text x="0" y="1.778" size="1.778" layer="95" align="bottom-center">&gt;NAME</text>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
</symbol>
<symbol name="RESARRAY4">
<wire x1="-2.54" y1="-0.889" x2="2.54" y2="-0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="2.54" y1="-0.889" x2="2.54" y2="0.889" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-0.889" x2="-2.54" y2="0.889" width="0.254" layer="94"/>
<text x="0" y="-9.398" size="1.778" layer="96" align="top-center">&gt;VALUE</text>
<text x="0" y="1.778" size="1.778" layer="95" align="bottom-center">&gt;NAME</text>
<pin name="1B" x="5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="1A" x="-5.08" y="0" visible="off" length="short" direction="pas" swaplevel="1"/>
<wire x1="-2.54" y1="-3.429" x2="2.54" y2="-3.429" width="0.254" layer="94"/>
<wire x1="2.54" y1="-1.651" x2="-2.54" y2="-1.651" width="0.254" layer="94"/>
<wire x1="2.54" y1="-3.429" x2="2.54" y2="-1.651" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-3.429" x2="-2.54" y2="-1.651" width="0.254" layer="94"/>
<pin name="2B" x="5.08" y="-2.54" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="2A" x="-5.08" y="-2.54" visible="off" length="short" direction="pas" swaplevel="1"/>
<wire x1="-2.54" y1="-5.969" x2="2.54" y2="-5.969" width="0.254" layer="94"/>
<wire x1="2.54" y1="-4.191" x2="-2.54" y2="-4.191" width="0.254" layer="94"/>
<wire x1="2.54" y1="-5.969" x2="2.54" y2="-4.191" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-5.969" x2="-2.54" y2="-4.191" width="0.254" layer="94"/>
<pin name="3B" x="5.08" y="-5.08" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="3A" x="-5.08" y="-5.08" visible="off" length="short" direction="pas" swaplevel="1"/>
<wire x1="-2.54" y1="-8.509" x2="2.54" y2="-8.509" width="0.254" layer="94"/>
<wire x1="2.54" y1="-6.731" x2="-2.54" y2="-6.731" width="0.254" layer="94"/>
<wire x1="2.54" y1="-8.509" x2="2.54" y2="-6.731" width="0.254" layer="94"/>
<wire x1="-2.54" y1="-8.509" x2="-2.54" y2="-6.731" width="0.254" layer="94"/>
<pin name="4B" x="5.08" y="-7.62" visible="off" length="short" direction="pas" swaplevel="1" rot="R180"/>
<pin name="4A" x="-5.08" y="-7.62" visible="off" length="short" direction="pas" swaplevel="1"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="CAPACITOR" prefix="C" uservalue="yes">
<gates>
<gate name="G$1" symbol="CAPACITOR" x="0" y="0"/>
</gates>
<devices>
<device name="0402" package="C0402">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0603" package="C0603">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0805" package="C0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1206" package="C1206">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1210" package="C1210">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="AVX_D3" package="AVX_D3">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="18X5_15LS" package="CTH18X5_15LS">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="13X4_10LS" package="CTH13X4_10LS">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="INDUCTOR" prefix="L" uservalue="yes">
<gates>
<gate name="G$1" symbol="INDUCTOR" x="0" y="0"/>
</gates>
<devices>
<device name="0402" package="L0402">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0603" package="L0603">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0805" package="L0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1008" package="L1008">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1210" package="L1210">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1806" package="L1806">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1812" package="L1812">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="2220" package="L2220">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="2520" package="L2520">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="NRS4018" package="NRS4018">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="RESISTOR" prefix="R" uservalue="yes">
<gates>
<gate name="G$1" symbol="RESISTOR" x="0" y="0"/>
</gates>
<devices>
<device name="0402" package="R0402">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0603" package="R0603">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="0805" package="R0805">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1206" package="R1206">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1210" package="R1210">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="TH8.5X2.7" package="RTH8.5X2.7">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="RES_ARRAY4" prefix="R" uservalue="yes">
<gates>
<gate name="G$1" symbol="RESARRAY4" x="0" y="0"/>
</gates>
<devices>
<device name="1206" package="RA4_1206">
<connects>
<connect gate="G$1" pin="1A" pad="1A"/>
<connect gate="G$1" pin="1B" pad="1B"/>
<connect gate="G$1" pin="2A" pad="2A"/>
<connect gate="G$1" pin="2B" pad="2B"/>
<connect gate="G$1" pin="3A" pad="3A"/>
<connect gate="G$1" pin="3B" pad="3B"/>
<connect gate="G$1" pin="4A" pad="4A"/>
<connect gate="G$1" pin="4B" pad="4B"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="supply">
<packages>
</packages>
<symbols>
<symbol name="GND">
<pin name="GND" x="0" y="0" visible="off" length="short" direction="sup" rot="R270"/>
<wire x1="2.032" y1="-2.54" x2="-2.032" y2="-2.54" width="0.254" layer="94"/>
<text x="0" y="-3.048" size="1.778" layer="96" font="vector" rot="R180" align="bottom-center">&gt;VALUE</text>
</symbol>
<symbol name="+3.3V">
<pin name="+3.3V" x="0" y="0" visible="off" length="short" direction="sup" rot="R90"/>
<wire x1="-2.032" y1="2.54" x2="2.032" y2="2.54" width="0.254" layer="94"/>
<text x="0" y="3.048" size="1.778" layer="96" font="vector" align="bottom-center">&gt;VALUE</text>
</symbol>
<symbol name="+1.2V">
<pin name="+1.2V" x="0" y="0" visible="off" length="short" direction="sup" rot="R90"/>
<wire x1="-2.032" y1="2.54" x2="2.032" y2="2.54" width="0.254" layer="94"/>
<text x="0" y="3.048" size="1.778" layer="96" font="vector" align="bottom-center">&gt;VALUE</text>
</symbol>
<symbol name="+5V">
<pin name="+5V" x="0" y="0" visible="off" length="short" direction="sup" rot="R90"/>
<wire x1="-2.032" y1="2.54" x2="2.032" y2="2.54" width="0.254" layer="94"/>
<text x="0" y="3.048" size="1.778" layer="96" font="vector" align="bottom-center">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="GND">
<description>Supply symbol</description>
<gates>
<gate name="G$1" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="+3.3V">
<description>Supply symbol</description>
<gates>
<gate name="G$1" symbol="+3.3V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="+1.2V">
<description>Supply symbol</description>
<gates>
<gate name="G$1" symbol="+1.2V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="+5V">
<description>Supply symbol</description>
<gates>
<gate name="G$1" symbol="+5V" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="connectors">
<packages>
<package name="HDR8X1">
<wire x1="-1.27" y1="10.16" x2="1.27" y2="10.16" width="0.2" layer="21"/>
<wire x1="1.27" y1="10.16" x2="1.27" y2="-10.16" width="0.2" layer="21"/>
<wire x1="1.27" y1="-10.16" x2="-1.27" y2="-10.16" width="0.2" layer="21"/>
<wire x1="-1.27" y1="-10.16" x2="-1.27" y2="10.16" width="0.2" layer="21"/>
<pad name="2" x="0" y="6.35" drill="1"/>
<pad name="1" x="0" y="8.89" drill="1" shape="square"/>
<pad name="3" x="0" y="3.81" drill="1"/>
<pad name="4" x="0" y="1.27" drill="1"/>
<pad name="5" x="0" y="-1.27" drill="1"/>
<pad name="6" x="0" y="-3.81" drill="1"/>
<pad name="7" x="0" y="-6.35" drill="1"/>
<pad name="8" x="0" y="-8.89" drill="1"/>
</package>
<package name="1-1734344-2">
<wire x1="15.4" y1="16" x2="-15.4" y2="16" width="0.2" layer="21"/>
<wire x1="-15.4" y1="0" x2="-14.5" y2="0" width="0.2" layer="21"/>
<wire x1="-14.5" y1="0" x2="-10.5" y2="0" width="0.2" layer="21"/>
<wire x1="-10.5" y1="0" x2="-8.15" y2="0" width="0.2" layer="21"/>
<wire x1="-8.15" y1="0" x2="8.15" y2="0" width="0.2" layer="21"/>
<wire x1="8.15" y1="0" x2="10.5" y2="0" width="0.2" layer="21"/>
<wire x1="10.5" y1="0" x2="14.5" y2="0" width="0.2" layer="21"/>
<wire x1="14.5" y1="0" x2="15.4" y2="0" width="0.2" layer="21"/>
<wire x1="-15.4" y1="16" x2="-15.4" y2="0" width="0.2" layer="21"/>
<wire x1="15.4" y1="16" x2="15.4" y2="0" width="0.2" layer="21"/>
<wire x1="-8.15" y1="-6" x2="8.15" y2="-6" width="0.2" layer="21"/>
<wire x1="-8.15" y1="-6" x2="-8.15" y2="0" width="0.2" layer="21"/>
<wire x1="8.15" y1="-6" x2="8.15" y2="0" width="0.2" layer="21"/>
<wire x1="10.5" y1="-6" x2="10.5" y2="0" width="0.2" layer="21"/>
<wire x1="10.5" y1="-6" x2="14.5" y2="-6" width="0.2" layer="21"/>
<wire x1="14.5" y1="-6" x2="14.5" y2="0" width="0.2" layer="21"/>
<wire x1="-14.5" y1="-6" x2="-14.5" y2="0" width="0.2" layer="21"/>
<wire x1="-14.5" y1="-6" x2="-10.5" y2="-6" width="0.2" layer="21"/>
<wire x1="-10.5" y1="-6" x2="-10.5" y2="0" width="0.2" layer="21"/>
<pad name="1" x="4.315" y="13.97" drill="1"/>
<pad name="2" x="2.025" y="13.97" drill="1"/>
<pad name="3" x="-0.265" y="13.97" drill="1"/>
<pad name="4" x="-2.555" y="13.97" drill="1"/>
<pad name="5" x="-4.845" y="13.97" drill="1"/>
<pad name="6" x="5.455" y="11.43" drill="1"/>
<pad name="7" x="3.165" y="11.43" drill="1"/>
<pad name="8" x="0.875" y="11.43" drill="1"/>
<pad name="9" x="-1.415" y="11.43" drill="1"/>
<pad name="10" x="-3.705" y="11.43" drill="1"/>
<pad name="11" x="4.315" y="8.89" drill="1"/>
<pad name="12" x="2.025" y="8.89" drill="1"/>
<pad name="13" x="-0.265" y="8.89" drill="1"/>
<pad name="14" x="-2.555" y="8.89" drill="1"/>
<pad name="15" x="-4.845" y="8.89" drill="1"/>
<pad name="MH2" x="12.495" y="11.43" drill="3.18"/>
<pad name="MH1" x="-12.495" y="11.43" drill="3.18"/>
<wire x1="-15.4" y1="16" x2="15.4" y2="16" width="0.1" layer="51"/>
<wire x1="15.4" y1="16" x2="15.4" y2="0" width="0.1" layer="51"/>
<wire x1="15.4" y1="0" x2="14.5" y2="0" width="0.1" layer="51"/>
<wire x1="14.5" y1="0" x2="10.5" y2="0" width="0.1" layer="51"/>
<wire x1="10.5" y1="0" x2="8.15" y2="0" width="0.1" layer="51"/>
<wire x1="8.15" y1="0" x2="-8.15" y2="0" width="0.1" layer="51"/>
<wire x1="-8.15" y1="0" x2="-10.5" y2="0" width="0.1" layer="51"/>
<wire x1="-10.5" y1="0" x2="-14.5" y2="0" width="0.1" layer="51"/>
<wire x1="-14.5" y1="0" x2="-15.4" y2="0" width="0.1" layer="51"/>
<wire x1="-15.4" y1="0" x2="-15.4" y2="16" width="0.1" layer="51"/>
<wire x1="-14.5" y1="0" x2="-14.5" y2="-6" width="0.1" layer="51"/>
<wire x1="-14.5" y1="-6" x2="-10.5" y2="-6" width="0.1" layer="51"/>
<wire x1="-10.5" y1="-6" x2="-10.5" y2="0" width="0.1" layer="51"/>
<wire x1="-8.15" y1="0" x2="-8.15" y2="-6" width="0.1" layer="51"/>
<wire x1="-8.15" y1="-6" x2="8.15" y2="-6" width="0.1" layer="51"/>
<wire x1="8.15" y1="-6" x2="8.15" y2="0" width="0.1" layer="51"/>
<wire x1="10.5" y1="0" x2="10.5" y2="-6" width="0.1" layer="51"/>
<wire x1="10.5" y1="-6" x2="14.5" y2="-6" width="0.1" layer="51"/>
<wire x1="14.5" y1="-6" x2="14.5" y2="0" width="0.1" layer="51"/>
<text x="0" y="8" size="2" layer="51" font="vector" ratio="5" align="center">&gt;NAME</text>
</package>
<package name="RCJ-01X">
<pad name="G1" x="0" y="0" drill="2.6"/>
<pad name="G2" x="-5" y="-4.5" drill="2.6"/>
<pad name="G3" x="5" y="-4.5" drill="2.6"/>
<pad name="S" x="0" y="-4.5" drill="1.7"/>
<wire x1="-5.3" y1="0.7" x2="-5.15" y2="0.7" width="0.2" layer="21"/>
<wire x1="-5.15" y1="0.7" x2="-4.15" y2="1.7" width="0.2" layer="21" curve="90"/>
<wire x1="-4.15" y1="1.7" x2="-4.15" y2="7.75" width="0.2" layer="21"/>
<wire x1="-4.15" y1="7.75" x2="-3.15" y2="8.75" width="0.2" layer="21" curve="-90"/>
<wire x1="-3.15" y1="8.75" x2="3.15" y2="8.75" width="0.2" layer="21"/>
<wire x1="3.15" y1="8.75" x2="4.15" y2="7.75" width="0.2" layer="21" curve="-90"/>
<wire x1="4.15" y1="7.75" x2="4.15" y2="1.7" width="0.2" layer="21"/>
<wire x1="4.15" y1="1.7" x2="5.15" y2="0.7" width="0.2" layer="21" curve="90"/>
<wire x1="5.15" y1="0.7" x2="5.3" y2="0.7" width="0.2" layer="21"/>
<wire x1="5.3" y1="0.7" x2="5.3" y2="-5.75" width="0.2" layer="21"/>
<wire x1="5.3" y1="-5.75" x2="-5.3" y2="-5.75" width="0.2" layer="21"/>
<wire x1="-5.3" y1="-5.75" x2="-5.3" y2="0.7" width="0.2" layer="21"/>
</package>
<package name="HDR2X10">
<wire x1="-2.54" y1="12.7" x2="2.54" y2="12.7" width="0.2" layer="21"/>
<wire x1="2.54" y1="12.7" x2="2.54" y2="-12.7" width="0.2" layer="21"/>
<wire x1="2.54" y1="-12.7" x2="-2.54" y2="-12.7" width="0.2" layer="21"/>
<wire x1="-2.54" y1="-12.7" x2="-2.54" y2="12.7" width="0.2" layer="21"/>
<wire x1="-2.54" y1="12.7" x2="-1.27" y2="12.7" width="0.1" layer="51"/>
<wire x1="-1.27" y1="12.7" x2="2.54" y2="12.7" width="0.1" layer="51"/>
<wire x1="2.54" y1="12.7" x2="2.54" y2="-12.7" width="0.1" layer="51"/>
<wire x1="2.54" y1="-12.7" x2="-2.54" y2="-12.7" width="0.1" layer="51"/>
<wire x1="-2.54" y1="-12.7" x2="-2.54" y2="11.43" width="0.1" layer="51"/>
<wire x1="-2.54" y1="11.43" x2="-2.54" y2="12.7" width="0.1" layer="51"/>
<wire x1="-2.54" y1="11.43" x2="-1.27" y2="12.7" width="0.1" layer="51"/>
<pad name="1" x="-1.27" y="11.43" drill="1" shape="square"/>
<pad name="2" x="1.27" y="11.43" drill="1"/>
<pad name="3" x="-1.27" y="8.89" drill="1"/>
<pad name="4" x="1.27" y="8.89" drill="1"/>
<pad name="5" x="-1.27" y="6.35" drill="1"/>
<pad name="6" x="1.27" y="6.35" drill="1"/>
<pad name="7" x="-1.27" y="3.81" drill="1"/>
<pad name="8" x="1.27" y="3.81" drill="1"/>
<pad name="9" x="-1.27" y="1.27" drill="1"/>
<pad name="10" x="1.27" y="1.27" drill="1"/>
<pad name="11" x="-1.27" y="-1.27" drill="1"/>
<pad name="12" x="1.27" y="-1.27" drill="1"/>
<pad name="13" x="-1.27" y="-3.81" drill="1"/>
<pad name="14" x="1.27" y="-3.81" drill="1"/>
<pad name="15" x="-1.27" y="-6.35" drill="1"/>
<pad name="16" x="1.27" y="-6.35" drill="1"/>
<pad name="17" x="-1.27" y="-8.89" drill="1"/>
<pad name="18" x="1.27" y="-8.89" drill="1"/>
<pad name="19" x="-1.27" y="-11.43" drill="1"/>
<pad name="20" x="1.27" y="-11.43" drill="1"/>
<text x="0.73" y="-11.23" size="1" layer="51" ratio="10" rot="R90">&gt;NAME</text>
</package>
<package name="C64CART">
<wire x1="-28.5" y1="9" x2="-28.5" y2="1" width="0.1" layer="21"/>
<wire x1="-28.5" y1="1" x2="-28.5" y2="0.5" width="0.1" layer="21"/>
<wire x1="-28.5" y1="0.5" x2="-28" y2="0" width="0.1" layer="21"/>
<wire x1="-28" y1="0" x2="28" y2="0" width="0.1" layer="21"/>
<wire x1="28" y1="0" x2="28.5" y2="0.5" width="0.1" layer="21"/>
<wire x1="28.5" y1="0.5" x2="28.5" y2="1" width="0.1" layer="21"/>
<wire x1="28.5" y1="1" x2="28.5" y2="9" width="0.1" layer="21"/>
<smd name="1" x="-26.67" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="2" x="-24.13" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="3" x="-21.59" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="4" x="-19.05" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="5" x="-16.51" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="6" x="-13.97" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="7" x="-11.43" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="8" x="-8.89" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="9" x="-6.35" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="10" x="-3.81" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="11" x="-1.27" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="12" x="1.27" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="13" x="3.81" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="14" x="6.35" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="15" x="8.89" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="16" x="11.43" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="17" x="13.97" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="18" x="16.51" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="19" x="19.05" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="20" x="21.59" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="21" x="24.13" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="22" x="26.67" y="5" dx="1.6" dy="8" layer="1" cream="no"/>
<smd name="A" x="-26.67" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="B" x="-24.13" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="C" x="-21.59" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="D" x="-19.05" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="E" x="-16.51" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="F" x="-13.97" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="H" x="-11.43" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="J" x="-8.89" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="K" x="-6.35" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="L" x="-3.81" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="M" x="-1.27" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="N" x="1.27" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="P" x="3.81" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="R" x="6.35" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="S" x="8.89" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="T" x="11.43" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="U" x="13.97" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="V" x="16.51" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="W" x="19.05" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="X" x="21.59" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="Y" x="24.13" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
<smd name="Z" x="26.67" y="5" dx="1.6" dy="8" layer="16" cream="no"/>
</package>
</packages>
<symbols>
<symbol name="HDR8X1">
<wire x1="0" y1="0" x2="7.62" y2="0" width="0.254" layer="94"/>
<wire x1="7.62" y1="0" x2="7.62" y2="-22.86" width="0.254" layer="94"/>
<wire x1="7.62" y1="-22.86" x2="0" y2="-22.86" width="0.254" layer="94"/>
<wire x1="0" y1="-22.86" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95">&gt;NAME</text>
<text x="0" y="-25.4" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="2" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="3" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="4" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="5" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="6" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="7" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="8" x="-5.08" y="-20.32" length="middle" direction="pas"/>
</symbol>
<symbol name="VGA">
<wire x1="0" y1="0" x2="0" y2="-48.26" width="0.254" layer="94"/>
<wire x1="0" y1="-48.26" x2="12.7" y2="-48.26" width="0.254" layer="94"/>
<wire x1="12.7" y1="-48.26" x2="12.7" y2="0" width="0.254" layer="94"/>
<wire x1="12.7" y1="0" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-50.8" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="RED" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="GREEN" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="BLUE" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="RES" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="GND" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="RGND" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="GGND" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="BGND" x="-5.08" y="-20.32" length="middle" direction="pas"/>
<pin name="+5V" x="-5.08" y="-22.86" length="middle" direction="pas"/>
<pin name="SGND" x="-5.08" y="-25.4" length="middle" direction="pas"/>
<pin name="ID0" x="-5.08" y="-27.94" length="middle" direction="pas"/>
<pin name="SDA" x="-5.08" y="-30.48" length="middle" direction="pas"/>
<pin name="HSYNC" x="-5.08" y="-33.02" length="middle" direction="pas"/>
<pin name="VSYNC" x="-5.08" y="-35.56" length="middle" direction="pas"/>
<pin name="SCL" x="-5.08" y="-38.1" length="middle" direction="pas"/>
<pin name="MH1" x="-5.08" y="-43.18" length="middle" direction="pas"/>
<pin name="MH2" x="-5.08" y="-45.72" length="middle" direction="pas"/>
</symbol>
<symbol name="RCA">
<wire x1="13.97" y1="-1.27" x2="11.43" y2="-1.27" width="0.254" layer="94"/>
<wire x1="11.43" y1="-1.27" x2="11.43" y2="-6.35" width="0.254" layer="94"/>
<wire x1="11.43" y1="-6.35" x2="12.7" y2="-6.35" width="0.254" layer="94"/>
<wire x1="12.7" y1="-6.35" x2="13.97" y2="-6.35" width="0.254" layer="94"/>
<wire x1="13.97" y1="-6.35" x2="13.97" y2="-1.27" width="0.254" layer="94"/>
<wire x1="3.81" y1="-2.54" x2="2.54" y2="-3.81" width="0.254" layer="94"/>
<wire x1="2.54" y1="-3.81" x2="1.27" y2="-2.54" width="0.254" layer="94"/>
<wire x1="1.27" y1="-2.54" x2="0" y2="-2.54" width="0.254" layer="94"/>
<wire x1="15.24" y1="0" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="0" y2="-7.62" width="0.254" layer="94"/>
<wire x1="0" y1="-7.62" x2="0" y2="-10.16" width="0.254" layer="94"/>
<wire x1="0" y1="-10.16" x2="15.24" y2="-10.16" width="0.254" layer="94"/>
<wire x1="15.24" y1="-10.16" x2="15.24" y2="0" width="0.254" layer="94"/>
<wire x1="12.7" y1="-6.35" x2="12.7" y2="-7.62" width="0.254" layer="94"/>
<wire x1="12.7" y1="-7.62" x2="0" y2="-7.62" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-12.7" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="S" x="-5.08" y="-2.54" visible="pad" length="middle" direction="pas"/>
<pin name="G" x="-5.08" y="-7.62" visible="pad" length="middle" direction="pas"/>
</symbol>
<symbol name="HDR2X10">
<wire x1="0" y1="0" x2="15.24" y2="0" width="0.254" layer="94"/>
<wire x1="15.24" y1="0" x2="15.24" y2="-27.94" width="0.254" layer="94"/>
<wire x1="15.24" y1="-27.94" x2="0" y2="-27.94" width="0.254" layer="94"/>
<wire x1="0" y1="-27.94" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95">&gt;NAME</text>
<text x="0" y="-30.48" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="5" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="3" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="7" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="9" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="11" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="2" x="20.32" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="4" x="20.32" y="-5.08" length="middle" direction="pas" rot="R180"/>
<pin name="6" x="20.32" y="-7.62" length="middle" direction="pas" rot="R180"/>
<pin name="8" x="20.32" y="-10.16" length="middle" direction="pas" rot="R180"/>
<pin name="12" x="20.32" y="-15.24" length="middle" direction="pas" rot="R180"/>
<pin name="10" x="20.32" y="-12.7" length="middle" direction="pas" rot="R180"/>
<pin name="13" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="14" x="20.32" y="-17.78" length="middle" direction="pas" rot="R180"/>
<pin name="15" x="-5.08" y="-20.32" length="middle" direction="pas"/>
<pin name="16" x="20.32" y="-20.32" length="middle" direction="pas" rot="R180"/>
<pin name="17" x="-5.08" y="-22.86" length="middle" direction="pas"/>
<pin name="18" x="20.32" y="-22.86" length="middle" direction="pas" rot="R180"/>
<pin name="19" x="-5.08" y="-25.4" length="middle" direction="pas"/>
<pin name="20" x="20.32" y="-25.4" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="C64CART">
<wire x1="0" y1="0" x2="25.4" y2="0" width="0.254" layer="94"/>
<wire x1="25.4" y1="0" x2="25.4" y2="-58.42" width="0.254" layer="94"/>
<wire x1="25.4" y1="-58.42" x2="0" y2="-58.42" width="0.254" layer="94"/>
<wire x1="0" y1="-58.42" x2="0" y2="0" width="0.254" layer="94"/>
<pin name="A0" x="30.48" y="-53.34" length="middle" direction="pas" rot="R180"/>
<pin name="A1" x="30.48" y="-50.8" length="middle" direction="pas" rot="R180"/>
<pin name="A2" x="30.48" y="-48.26" length="middle" direction="pas" rot="R180"/>
<pin name="A3" x="30.48" y="-45.72" length="middle" direction="pas" rot="R180"/>
<pin name="A4" x="30.48" y="-43.18" length="middle" direction="pas" rot="R180"/>
<pin name="A5" x="30.48" y="-40.64" length="middle" direction="pas" rot="R180"/>
<pin name="A6" x="30.48" y="-38.1" length="middle" direction="pas" rot="R180"/>
<pin name="A7" x="30.48" y="-35.56" length="middle" direction="pas" rot="R180"/>
<pin name="A8" x="30.48" y="-33.02" length="middle" direction="pas" rot="R180"/>
<pin name="A9" x="30.48" y="-30.48" length="middle" direction="pas" rot="R180"/>
<pin name="A10" x="30.48" y="-27.94" length="middle" direction="pas" rot="R180"/>
<pin name="A11" x="30.48" y="-25.4" length="middle" direction="pas" rot="R180"/>
<pin name="A12" x="30.48" y="-22.86" length="middle" direction="pas" rot="R180"/>
<pin name="A13" x="30.48" y="-20.32" length="middle" direction="pas" rot="R180"/>
<pin name="A14" x="30.48" y="-17.78" length="middle" direction="pas" rot="R180"/>
<pin name="A15" x="30.48" y="-15.24" length="middle" direction="pas" rot="R180"/>
<pin name="D0" x="-5.08" y="-53.34" length="middle" direction="pas"/>
<pin name="D1" x="-5.08" y="-50.8" length="middle" direction="pas"/>
<pin name="D2" x="-5.08" y="-48.26" length="middle" direction="pas"/>
<pin name="D3" x="-5.08" y="-45.72" length="middle" direction="pas"/>
<pin name="D4" x="-5.08" y="-43.18" length="middle" direction="pas"/>
<pin name="D5" x="-5.08" y="-40.64" length="middle" direction="pas"/>
<pin name="D6" x="-5.08" y="-38.1" length="middle" direction="pas"/>
<pin name="D7" x="-5.08" y="-35.56" length="middle" direction="pas"/>
<pin name="BA" x="-5.08" y="-30.48" length="middle" direction="pas"/>
<pin name="!DMA" x="-5.08" y="-33.02" length="middle" direction="pas"/>
<pin name="GND@1" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="GND@2" x="-5.08" y="-55.88" length="middle" direction="pas"/>
<pin name="GND@4" x="30.48" y="-55.88" length="middle" direction="pas" rot="R180"/>
<pin name="GND@3" x="30.48" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="+5V@1" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="+5V@2" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="!IRQ" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="R/!W" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="DOTCLK" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="I/O1" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="!GAME" x="-5.08" y="-20.32" length="middle" direction="pas"/>
<pin name="!EXROM" x="-5.08" y="-22.86" length="middle" direction="pas"/>
<pin name="I/O2" x="-5.08" y="-25.4" length="middle" direction="pas"/>
<pin name="!ROML" x="-5.08" y="-27.94" length="middle" direction="pas"/>
<pin name="!ROMH" x="30.48" y="-5.08" length="middle" direction="pas" rot="R180"/>
<pin name="!RESET" x="30.48" y="-7.62" length="middle" direction="pas" rot="R180"/>
<pin name="!NMI" x="30.48" y="-10.16" length="middle" direction="pas" rot="R180"/>
<pin name="S02" x="30.48" y="-12.7" length="middle" direction="pas" rot="R180"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-60.96" size="1.778" layer="96" font="vector">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="HDR8X1" prefix="J">
<gates>
<gate name="_" symbol="HDR8X1" x="0" y="0"/>
</gates>
<devices>
<device name="" package="HDR8X1">
<connects>
<connect gate="_" pin="1" pad="1"/>
<connect gate="_" pin="2" pad="2"/>
<connect gate="_" pin="3" pad="3"/>
<connect gate="_" pin="4" pad="4"/>
<connect gate="_" pin="5" pad="5"/>
<connect gate="_" pin="6" pad="6"/>
<connect gate="_" pin="7" pad="7"/>
<connect gate="_" pin="8" pad="8"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="ICD15S13E4GX00LF" prefix="J">
<gates>
<gate name="_" symbol="VGA" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1-1734344-2">
<connects>
<connect gate="_" pin="+5V" pad="9"/>
<connect gate="_" pin="BGND" pad="8"/>
<connect gate="_" pin="BLUE" pad="3"/>
<connect gate="_" pin="GGND" pad="7"/>
<connect gate="_" pin="GND" pad="5"/>
<connect gate="_" pin="GREEN" pad="2"/>
<connect gate="_" pin="HSYNC" pad="13"/>
<connect gate="_" pin="ID0" pad="11"/>
<connect gate="_" pin="MH1" pad="MH1"/>
<connect gate="_" pin="MH2" pad="MH2"/>
<connect gate="_" pin="RED" pad="1"/>
<connect gate="_" pin="RES" pad="4"/>
<connect gate="_" pin="RGND" pad="6"/>
<connect gate="_" pin="SCL" pad="15"/>
<connect gate="_" pin="SDA" pad="12"/>
<connect gate="_" pin="SGND" pad="10"/>
<connect gate="_" pin="VSYNC" pad="14"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="RCJ-014" prefix="J">
<gates>
<gate name="_" symbol="RCA" x="0" y="0"/>
</gates>
<devices>
<device name="" package="RCJ-01X">
<connects>
<connect gate="_" pin="G" pad="G1 G2 G3"/>
<connect gate="_" pin="S" pad="S"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="HDR2X10" prefix="J" uservalue="yes">
<gates>
<gate name="_" symbol="HDR2X10" x="0" y="0"/>
</gates>
<devices>
<device name="" package="HDR2X10">
<connects>
<connect gate="_" pin="1" pad="1"/>
<connect gate="_" pin="10" pad="10"/>
<connect gate="_" pin="11" pad="11"/>
<connect gate="_" pin="12" pad="12"/>
<connect gate="_" pin="13" pad="13"/>
<connect gate="_" pin="14" pad="14"/>
<connect gate="_" pin="15" pad="15"/>
<connect gate="_" pin="16" pad="16"/>
<connect gate="_" pin="17" pad="17"/>
<connect gate="_" pin="18" pad="18"/>
<connect gate="_" pin="19" pad="19"/>
<connect gate="_" pin="2" pad="2"/>
<connect gate="_" pin="20" pad="20"/>
<connect gate="_" pin="3" pad="3"/>
<connect gate="_" pin="4" pad="4"/>
<connect gate="_" pin="5" pad="5"/>
<connect gate="_" pin="6" pad="6"/>
<connect gate="_" pin="7" pad="7"/>
<connect gate="_" pin="8" pad="8"/>
<connect gate="_" pin="9" pad="9"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="C64CART" prefix="J">
<gates>
<gate name="_" symbol="C64CART" x="0" y="0"/>
</gates>
<devices>
<device name="" package="C64CART">
<connects>
<connect gate="_" pin="!DMA" pad="13"/>
<connect gate="_" pin="!EXROM" pad="9"/>
<connect gate="_" pin="!GAME" pad="8"/>
<connect gate="_" pin="!IRQ" pad="4"/>
<connect gate="_" pin="!NMI" pad="D"/>
<connect gate="_" pin="!RESET" pad="C"/>
<connect gate="_" pin="!ROMH" pad="B"/>
<connect gate="_" pin="!ROML" pad="11"/>
<connect gate="_" pin="+5V@1" pad="2"/>
<connect gate="_" pin="+5V@2" pad="3"/>
<connect gate="_" pin="A0" pad="Y"/>
<connect gate="_" pin="A1" pad="X"/>
<connect gate="_" pin="A10" pad="M"/>
<connect gate="_" pin="A11" pad="L"/>
<connect gate="_" pin="A12" pad="K"/>
<connect gate="_" pin="A13" pad="J"/>
<connect gate="_" pin="A14" pad="H"/>
<connect gate="_" pin="A15" pad="F"/>
<connect gate="_" pin="A2" pad="W"/>
<connect gate="_" pin="A3" pad="V"/>
<connect gate="_" pin="A4" pad="U"/>
<connect gate="_" pin="A5" pad="T"/>
<connect gate="_" pin="A6" pad="S"/>
<connect gate="_" pin="A7" pad="R"/>
<connect gate="_" pin="A8" pad="P"/>
<connect gate="_" pin="A9" pad="N"/>
<connect gate="_" pin="BA" pad="12"/>
<connect gate="_" pin="D0" pad="21"/>
<connect gate="_" pin="D1" pad="20"/>
<connect gate="_" pin="D2" pad="19"/>
<connect gate="_" pin="D3" pad="18"/>
<connect gate="_" pin="D4" pad="17"/>
<connect gate="_" pin="D5" pad="16"/>
<connect gate="_" pin="D6" pad="15"/>
<connect gate="_" pin="D7" pad="14"/>
<connect gate="_" pin="DOTCLK" pad="6"/>
<connect gate="_" pin="GND@1" pad="1"/>
<connect gate="_" pin="GND@2" pad="22"/>
<connect gate="_" pin="GND@3" pad="A"/>
<connect gate="_" pin="GND@4" pad="Z"/>
<connect gate="_" pin="I/O1" pad="7"/>
<connect gate="_" pin="I/O2" pad="10"/>
<connect gate="_" pin="R/!W" pad="5"/>
<connect gate="_" pin="S02" pad="E"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="frames">
<packages>
</packages>
<symbols>
<symbol name="DINA3L">
<wire x1="0" y1="0" x2="398.78" y2="0" width="0.4064" layer="94"/>
<wire x1="0" y1="276.86" x2="0" y2="0" width="0.4064" layer="94"/>
<wire x1="398.78" y1="276.86" x2="0" y2="276.86" width="0.4064" layer="94"/>
<wire x1="398.78" y1="276.86" x2="398.78" y2="0" width="0.4064" layer="94"/>
</symbol>
<symbol name="DOCFIELD">
<wire x1="0" y1="0" x2="71.12" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="0" x2="0" y2="5.08" width="0.254" layer="94"/>
<wire x1="0" y1="5.08" x2="71.12" y2="5.08" width="0.254" layer="94"/>
<wire x1="71.12" y1="5.08" x2="71.12" y2="0" width="0.254" layer="94"/>
<wire x1="71.12" y1="0" x2="101.6" y2="0" width="0.254" layer="94"/>
<wire x1="71.12" y1="5.08" x2="101.6" y2="5.08" width="0.254" layer="94"/>
<wire x1="101.6" y1="5.08" x2="101.6" y2="0" width="0.254" layer="94"/>
<wire x1="0" y1="5.08" x2="0" y2="12.7" width="0.254" layer="94"/>
<wire x1="0" y1="12.7" x2="101.6" y2="12.7" width="0.254" layer="94"/>
<wire x1="101.6" y1="12.7" x2="101.6" y2="5.08" width="0.254" layer="94"/>
<text x="1.27" y="1.27" size="2.54" layer="94" font="vector">Date:</text>
<text x="12.7" y="1.27" size="2.54" layer="94" font="vector">&gt;LAST_DATE_TIME</text>
<text x="72.39" y="1.27" size="2.54" layer="94" font="vector">Sheet:</text>
<text x="86.36" y="1.27" size="2.54" layer="94" font="vector">&gt;SHEET</text>
<text x="1.27" y="8.89" size="2.54" layer="94" font="vector">TITLE:</text>
<text x="17.78" y="8.89" size="2.54" layer="94" font="vector">&gt;DRAWING_NAME</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="FRAME_A3L" prefix="FRAME">
<description>Frame A3 landscape</description>
<gates>
<gate name="G$1" symbol="DINA3L" x="0" y="0"/>
<gate name="G$2" symbol="DOCFIELD" x="297.18" y="0" addlevel="must"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="misc">
<packages>
<package name="FIDUCIAL">
<smd name="FD" x="0" y="0" dx="1" dy="1" layer="1" roundness="100" stop="no" thermals="no" cream="no"/>
<circle x="0" y="0" radius="0.5" width="1" layer="29"/>
<circle x="0" y="0" radius="0.5" width="1" layer="41"/>
</package>
</packages>
<symbols>
<symbol name="FIDUCIAL">
<wire x1="0" y1="0" x2="10.16" y2="0" width="0.254" layer="94"/>
<wire x1="10.16" y1="0" x2="10.16" y2="-7.62" width="0.254" layer="94"/>
<wire x1="10.16" y1="-7.62" x2="0" y2="-7.62" width="0.254" layer="94"/>
<wire x1="0" y1="-7.62" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-10.16" size="1.778" layer="96" font="vector">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="FIDUCIAL" prefix="FD">
<gates>
<gate name="_" symbol="FIDUCIAL" x="0" y="0"/>
</gates>
<devices>
<device name="" package="FIDUCIAL">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="transistor">
<packages>
<package name="SOT-23-3">
<description>3 pins, 1.3x2.9 mm, 0.95 mm pitch</description>
<wire x1="-0.35" y1="-1.45" x2="-0.35" y2="1.45" width="0.2" layer="21"/>
<wire x1="0.35" y1="-1.45" x2="0.35" y2="1.45" width="0.2" layer="21"/>
<wire x1="-0.35" y1="1.45" x2="0.35" y2="1.45" width="0.2" layer="21"/>
<wire x1="-0.35" y1="-1.45" x2="0.35" y2="-1.45" width="0.2" layer="21"/>
<wire x1="-0.65" y1="1.17" x2="-0.65" y2="1.45" width="0.1" layer="51"/>
<wire x1="-0.65" y1="1.45" x2="0.65" y2="1.45" width="0.1" layer="51"/>
<wire x1="-0.65" y1="-1.45" x2="0.65" y2="-1.45" width="0.1" layer="51"/>
<wire x1="-1.27" y1="0.73" x2="-1.27" y2="1.17" width="0.1" layer="51"/>
<wire x1="-0.65" y1="0.73" x2="-0.65" y2="1.17" width="0.1" layer="51"/>
<wire x1="-1.27" y1="1.17" x2="-0.65" y2="1.17" width="0.1" layer="51"/>
<wire x1="-1.27" y1="0.73" x2="-0.65" y2="0.73" width="0.1" layer="51"/>
<wire x1="-0.65" y1="-0.73" x2="-0.65" y2="0.73" width="0.1" layer="51"/>
<wire x1="0.65" y1="-1.45" x2="0.65" y2="-0.22" width="0.1" layer="51"/>
<wire x1="0.65" y1="-0.22" x2="0.65" y2="0.22" width="0.1" layer="51"/>
<wire x1="1.27" y1="-0.22" x2="1.27" y2="0.22" width="0.1" layer="51"/>
<wire x1="0.65" y1="0.22" x2="1.27" y2="0.22" width="0.1" layer="51"/>
<wire x1="0.65" y1="-0.22" x2="1.27" y2="-0.22" width="0.1" layer="51"/>
<wire x1="-1.27" y1="-1.17" x2="-1.27" y2="-0.73" width="0.1" layer="51"/>
<wire x1="-0.65" y1="-1.45" x2="-0.65" y2="-1.17" width="0.1" layer="51"/>
<wire x1="-0.65" y1="-1.17" x2="-0.65" y2="-0.73" width="0.1" layer="51"/>
<wire x1="-1.27" y1="-0.73" x2="-0.65" y2="-0.73" width="0.1" layer="51"/>
<wire x1="-1.27" y1="-1.17" x2="-0.65" y2="-1.17" width="0.1" layer="51"/>
<wire x1="0.65" y1="0.22" x2="0.65" y2="1.45" width="0.1" layer="51"/>
<wire x1="-1.95" y1="1.75" x2="1.95" y2="1.75" width="0" layer="59"/>
<wire x1="1.95" y1="1.75" x2="1.95" y2="-1.75" width="0" layer="59"/>
<wire x1="1.95" y1="-1.75" x2="-1.95" y2="-1.75" width="0" layer="59"/>
<wire x1="-1.95" y1="-1.75" x2="-1.95" y2="1.75" width="0" layer="59"/>
<smd name="1" x="-1.15" y="0.95" dx="0.65" dy="1.05" layer="1" rot="R90"/>
<smd name="3" x="1.15" y="0" dx="0.65" dy="1.05" layer="1" rot="R90"/>
<smd name="2" x="-1.15" y="-0.95" dx="0.65" dy="1.05" layer="1" rot="R90"/>
<text x="0" y="0" size="1" layer="51" ratio="10" rot="R90" align="center">&gt;NAME</text>
</package>
<package name="SC-70-3">
<description>3 pins, 1.25x2 mm, 0.65 mm pitch</description>
<wire x1="-0.325" y1="-1" x2="-0.325" y2="1" width="0.2" layer="21"/>
<wire x1="0.325" y1="-1" x2="0.325" y2="1" width="0.2" layer="21"/>
<wire x1="-0.325" y1="1" x2="0.325" y2="1" width="0.2" layer="21"/>
<wire x1="-0.325" y1="-1" x2="0.325" y2="-1" width="0.2" layer="21"/>
<wire x1="-0.625" y1="0.8" x2="-0.625" y2="1" width="0.1" layer="51"/>
<wire x1="-0.625" y1="1" x2="0.625" y2="1" width="0.1" layer="51"/>
<wire x1="-0.625" y1="-1" x2="0.625" y2="-1" width="0.1" layer="51"/>
<wire x1="-1" y1="0.5" x2="-1" y2="0.8" width="0.1" layer="51"/>
<wire x1="-0.625" y1="0.5" x2="-0.625" y2="0.8" width="0.1" layer="51"/>
<wire x1="-1" y1="0.8" x2="-0.625" y2="0.8" width="0.1" layer="51"/>
<wire x1="-1" y1="0.5" x2="-0.625" y2="0.5" width="0.1" layer="51"/>
<wire x1="-0.625" y1="-0.5" x2="-0.625" y2="0.5" width="0.1" layer="51"/>
<wire x1="0.625" y1="-1" x2="0.625" y2="-0.15" width="0.1" layer="51"/>
<wire x1="0.625" y1="-0.15" x2="0.625" y2="0.15" width="0.1" layer="51"/>
<wire x1="1" y1="-0.15" x2="1" y2="0.15" width="0.1" layer="51"/>
<wire x1="0.625" y1="0.15" x2="1" y2="0.15" width="0.1" layer="51"/>
<wire x1="0.625" y1="-0.15" x2="1" y2="-0.15" width="0.1" layer="51"/>
<wire x1="-1" y1="-0.8" x2="-1" y2="-0.5" width="0.1" layer="51"/>
<wire x1="-0.625" y1="-1" x2="-0.625" y2="-0.8" width="0.1" layer="51"/>
<wire x1="-0.625" y1="-0.8" x2="-0.625" y2="-0.5" width="0.1" layer="51"/>
<wire x1="-1" y1="-0.5" x2="-0.625" y2="-0.5" width="0.1" layer="51"/>
<wire x1="-1" y1="-0.8" x2="-0.625" y2="-0.8" width="0.1" layer="51"/>
<wire x1="0.625" y1="0.15" x2="0.625" y2="1" width="0.1" layer="51"/>
<wire x1="-1.75" y1="1.3" x2="1.75" y2="1.3" width="0" layer="59"/>
<wire x1="1.75" y1="1.3" x2="1.75" y2="-1.3" width="0" layer="59"/>
<wire x1="1.75" y1="-1.3" x2="-1.75" y2="-1.3" width="0" layer="59"/>
<wire x1="-1.75" y1="-1.3" x2="-1.75" y2="1.3" width="0" layer="59"/>
<smd name="1" x="-1.05" y="0.65" dx="0.5" dy="0.9" layer="1" rot="R90"/>
<smd name="3" x="1.05" y="0" dx="0.5" dy="0.9" layer="1" rot="R90"/>
<smd name="2" x="-1.05" y="-0.65" dx="0.5" dy="0.9" layer="1" rot="R90"/>
<text x="0" y="0" size="1" layer="51" ratio="10" rot="R90" align="center">&gt;NAME</text>
</package>
</packages>
<symbols>
<symbol name="NPN">
<wire x1="0" y1="2.54" x2="0" y2="1.27" width="0.4064" layer="94"/>
<wire x1="0" y1="1.27" x2="0" y2="0" width="0.4064" layer="94"/>
<wire x1="0" y1="0" x2="0" y2="-2.54" width="0.4064" layer="94"/>
<wire x1="2.54" y1="2.54" x2="2.54" y2="5.08" width="0.254" layer="94"/>
<wire x1="-2.54" y1="0" x2="0" y2="0" width="0.254" layer="94"/>
<wire x1="2.54" y1="-2.54" x2="2.54" y2="-5.08" width="0.254" layer="94"/>
<text x="5.08" y="-2.54" size="1.778" layer="96">&gt;VALUE</text>
<text x="5.08" y="0" size="1.778" layer="95">&gt;NAME</text>
<pin name="B" x="-2.54" y="0" visible="pad" length="point" direction="pas"/>
<pin name="E" x="2.54" y="-5.08" visible="pad" length="point" direction="pas" rot="R90"/>
<pin name="C" x="2.54" y="5.08" visible="pad" length="point" direction="pas" rot="R270"/>
<wire x1="0" y1="-1.27" x2="2.032" y2="-2.286" width="0.254" layer="94"/>
<wire x1="2.032" y1="-2.286" x2="2.54" y2="-2.54" width="0.254" layer="94"/>
<wire x1="2.032" y1="-2.286" x2="1.397" y2="-1.524" width="0.254" layer="94"/>
<wire x1="1.397" y1="-1.524" x2="1.016" y2="-2.2098" width="0.254" layer="94"/>
<wire x1="1.016" y1="-2.2098" x2="2.032" y2="-2.286" width="0.254" layer="94"/>
<wire x1="2.54" y1="2.54" x2="0" y2="1.27" width="0.254" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="BC847" prefix="Q">
<description>&lt;b&gt;BC847 NPN transistor&lt;/b&gt;
&lt;br&gt;
Vcb = max 50V&lt;br&gt;
Vce = max 45V&lt;br&gt;
Veb = max 6V&lt;br&gt;
Ic = max 100mA&lt;br&gt;
hFE = A:110-220 B:200-450 C:420-800</description>
<gates>
<gate name="_" symbol="NPN" x="0" y="0"/>
</gates>
<devices>
<device name="SOT-23" package="SOT-23-3">
<connects>
<connect gate="_" pin="B" pad="1"/>
<connect gate="_" pin="C" pad="3"/>
<connect gate="_" pin="E" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="SC-70" package="SC-70-3">
<connects>
<connect gate="_" pin="B" pad="1"/>
<connect gate="_" pin="C" pad="3"/>
<connect gate="_" pin="E" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
<class number="1" name="5V" width="0" drill="0">
<clearance class="1" value="0.2"/>
</class>
</classes>
<parts>
<part name="C69" library="rcl" deviceset="CAPACITOR" device="0805" value="10u"/>
<part name="GND42" library="supply" deviceset="GND" device=""/>
<part name="C70" library="rcl" deviceset="CAPACITOR" device="0805" value="10u"/>
<part name="GND44" library="supply" deviceset="GND" device=""/>
<part name="U5" library="integrated_circuits" deviceset="SG5032CAN_40.000000M-TJGA3" device="" value="SG5032CAN_25.000000M-TJGA3"/>
<part name="GND47" library="supply" deviceset="GND" device=""/>
<part name="C18" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="GND48" library="supply" deviceset="GND" device=""/>
<part name="R5" library="rcl" deviceset="RESISTOR" device="0603" value="820"/>
<part name="R6" library="rcl" deviceset="RESISTOR" device="0603" value="820"/>
<part name="U1" library="integrated_circuits" deviceset="ICE40UP5K-SG48ITR50" device=""/>
<part name="U$1" library="supply" deviceset="GND" device=""/>
<part name="R4" library="rcl" deviceset="RESISTOR" device="0603" value="536"/>
<part name="R8" library="rcl" deviceset="RESISTOR" device="0603" value="1070"/>
<part name="R9" library="rcl" deviceset="RESISTOR" device="0603" value="2150"/>
<part name="R10" library="rcl" deviceset="RESISTOR" device="0603" value="4300"/>
<part name="R11" library="rcl" deviceset="RESISTOR" device="0603" value="536"/>
<part name="R12" library="rcl" deviceset="RESISTOR" device="0603" value="1070"/>
<part name="R17" library="rcl" deviceset="RESISTOR" device="0603" value="2150"/>
<part name="R18" library="rcl" deviceset="RESISTOR" device="0603" value="4300"/>
<part name="R19" library="rcl" deviceset="RESISTOR" device="0603" value="536"/>
<part name="R20" library="rcl" deviceset="RESISTOR" device="0603" value="1070"/>
<part name="R21" library="rcl" deviceset="RESISTOR" device="0603" value="2150"/>
<part name="R22" library="rcl" deviceset="RESISTOR" device="0603" value="4300"/>
<part name="C6" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C7" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C8" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C9" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C10" library="rcl" deviceset="CAPACITOR" device="0603" value="4.7u"/>
<part name="C11" library="rcl" deviceset="CAPACITOR" device="0603" value="4.7u"/>
<part name="U$6" library="supply" deviceset="GND" device=""/>
<part name="U$7" library="supply" deviceset="GND" device=""/>
<part name="U$8" library="supply" deviceset="GND" device=""/>
<part name="U$9" library="supply" deviceset="GND" device=""/>
<part name="U$10" library="supply" deviceset="GND" device=""/>
<part name="U$11" library="supply" deviceset="GND" device=""/>
<part name="U$15" library="supply" deviceset="+3.3V" device=""/>
<part name="C12" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C13" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C14" library="rcl" deviceset="CAPACITOR" device="0603" value="4.7u"/>
<part name="C15" library="rcl" deviceset="CAPACITOR" device="0603" value="4.7u"/>
<part name="U$16" library="supply" deviceset="GND" device=""/>
<part name="U$17" library="supply" deviceset="GND" device=""/>
<part name="U$18" library="supply" deviceset="GND" device=""/>
<part name="U$19" library="supply" deviceset="GND" device=""/>
<part name="U$20" library="supply" deviceset="+1.2V" device=""/>
<part name="C16" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C17" library="rcl" deviceset="CAPACITOR" device="0603" value="4.7u"/>
<part name="U$22" library="supply" deviceset="GND" device=""/>
<part name="U$23" library="supply" deviceset="GND" device=""/>
<part name="R40" library="rcl" deviceset="RESISTOR" device="0603" value="100"/>
<part name="R41" library="rcl" deviceset="RESISTOR" device="0603" value="1"/>
<part name="U$26" library="supply" deviceset="+5V" device=""/>
<part name="U$5" library="supply" deviceset="+3.3V" device=""/>
<part name="U4" library="integrated_circuits" deviceset="QSPI_FLASH" device="SOIC8" value="W25Q16JVSNIQ"/>
<part name="GND11" library="supply" deviceset="GND" device=""/>
<part name="U$31" library="supply" deviceset="+3.3V" device=""/>
<part name="R43" library="rcl" deviceset="RESISTOR" device="0603" value="47k"/>
<part name="R44" library="rcl" deviceset="RESISTOR" device="0603" value="47k"/>
<part name="U$32" library="supply" deviceset="+3.3V" device=""/>
<part name="C23" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="GND12" library="supply" deviceset="GND" device=""/>
<part name="U8" library="integrated_circuits" deviceset="AP3417CKTR-G1" device=""/>
<part name="GND15" library="supply" deviceset="GND" device=""/>
<part name="C25" library="rcl" deviceset="CAPACITOR" device="0805" value="10u"/>
<part name="GND20" library="supply" deviceset="GND" device=""/>
<part name="R13" library="rcl" deviceset="RESISTOR" device="0603" value="47k"/>
<part name="R45" library="rcl" deviceset="RESISTOR" device="0603" value="47k"/>
<part name="GND21" library="supply" deviceset="GND" device=""/>
<part name="L1" library="rcl" deviceset="INDUCTOR" device="NRS4018" value="NRS4018T2R2MDGJ"/>
<part name="C26" library="rcl" deviceset="CAPACITOR" device="0805" value="10u"/>
<part name="GND23" library="supply" deviceset="GND" device=""/>
<part name="U$34" library="supply" deviceset="+5V" device=""/>
<part name="U$35" library="supply" deviceset="+3.3V" device=""/>
<part name="U$14" library="supply" deviceset="+1.2V" device=""/>
<part name="R46" library="rcl" deviceset="RESISTOR" device="0603" value="10k"/>
<part name="U$38" library="supply" deviceset="+3.3V" device=""/>
<part name="U3" library="integrated_circuits" deviceset="SN74CBTD3861PWR" device=""/>
<part name="GND2" library="supply" deviceset="GND" device=""/>
<part name="GND4" library="supply" deviceset="GND" device=""/>
<part name="U$33" library="supply" deviceset="+5V" device=""/>
<part name="R34" library="rcl" deviceset="RESISTOR" device="0603" value="10k"/>
<part name="R35" library="rcl" deviceset="RESISTOR" device="0603" value="10k"/>
<part name="U$36" library="supply" deviceset="+3.3V" device=""/>
<part name="J3" library="connectors" deviceset="HDR8X1" device=""/>
<part name="U$37" library="supply" deviceset="+5V" device=""/>
<part name="U$39" library="supply" deviceset="GND" device=""/>
<part name="C4" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="U$40" library="supply" deviceset="GND" device=""/>
<part name="C5" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="U$42" library="supply" deviceset="GND" device=""/>
<part name="U$41" library="supply" deviceset="+5V" device=""/>
<part name="U$43" library="supply" deviceset="+3.3V" device=""/>
<part name="U6" library="integrated_circuits" deviceset="74LVC4245APW" device=""/>
<part name="U$28" library="supply" deviceset="+5V" device=""/>
<part name="U$25" library="supply" deviceset="+3.3V" device=""/>
<part name="GND3" library="supply" deviceset="GND" device=""/>
<part name="U9" library="integrated_circuits" deviceset="74AHCT1G14SE-7" device=""/>
<part name="GND5" library="supply" deviceset="GND" device=""/>
<part name="U$21" library="supply" deviceset="+5V" device=""/>
<part name="C19" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="U$30" library="supply" deviceset="GND" device=""/>
<part name="U$44" library="supply" deviceset="+5V" device=""/>
<part name="FRAME1" library="frames" deviceset="FRAME_A3L" device=""/>
<part name="FD1" library="misc" deviceset="FIDUCIAL" device=""/>
<part name="FD2" library="misc" deviceset="FIDUCIAL" device=""/>
<part name="FD3" library="misc" deviceset="FIDUCIAL" device=""/>
<part name="R16" library="rcl" deviceset="RESISTOR" device="0603" value="1k"/>
<part name="U$2" library="supply" deviceset="GND" device=""/>
<part name="Q1" library="transistor" deviceset="BC847" device="SOT-23"/>
<part name="R25" library="rcl" deviceset="RESISTOR" device="0603" value="1k"/>
<part name="R26" library="rcl" deviceset="RESISTOR" device="0603" value="1k"/>
<part name="R27" library="rcl" deviceset="RESISTOR" device="0603" value="1k"/>
<part name="U$3" library="supply" deviceset="GND" device=""/>
<part name="U$4" library="supply" deviceset="+3.3V" device=""/>
<part name="C1" library="rcl" deviceset="CAPACITOR" device="0603" value="22p"/>
<part name="U$12" library="supply" deviceset="GND" device=""/>
<part name="C2" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="U$13" library="supply" deviceset="GND" device=""/>
<part name="R1" library="rcl" deviceset="RES_ARRAY4" device="1206" value="CAY16-1001F4LF"/>
<part name="R2" library="rcl" deviceset="RES_ARRAY4" device="1206" value="CAY16-1001F4LF"/>
<part name="R3" library="rcl" deviceset="RES_ARRAY4" device="1206" value="CAY16-1001F4LF"/>
<part name="R7" library="rcl" deviceset="RES_ARRAY4" device="1206" value="CAY16-1001F4LF"/>
<part name="R14" library="rcl" deviceset="RES_ARRAY4" device="1206" value="CAY16-1001F4LF"/>
<part name="R15" library="rcl" deviceset="RES_ARRAY4" device="1206" value="CAY16-1001F4LF"/>
<part name="U$24" library="supply" deviceset="GND" device=""/>
<part name="J1" library="connectors" deviceset="ICD15S13E4GX00LF" device=""/>
<part name="J2" library="connectors" deviceset="RCJ-014" device=""/>
<part name="U$27" library="supply" deviceset="GND" device=""/>
<part name="R28" library="rcl" deviceset="RESISTOR" device="0603" value="1"/>
<part name="U2" library="integrated_circuits" deviceset="MIC5504-3.3YM5-TR" device=""/>
<part name="GND1" library="supply" deviceset="GND" device=""/>
<part name="J5" library="connectors" deviceset="HDR2X10" device="" value="BUS"/>
<part name="U$29" library="supply" deviceset="+5V" device=""/>
<part name="GND6" library="supply" deviceset="GND" device=""/>
<part name="GND7" library="supply" deviceset="GND" device=""/>
<part name="J4" library="connectors" deviceset="C64CART" device=""/>
<part name="GND8" library="supply" deviceset="GND" device=""/>
<part name="GND9" library="supply" deviceset="GND" device=""/>
<part name="U$45" library="supply" deviceset="+5V" device=""/>
<part name="GND10" library="supply" deviceset="GND" device=""/>
<part name="GND13" library="supply" deviceset="GND" device=""/>
</parts>
<sheets>
<sheet>
<plain>
<text x="177.8" y="271.78" size="2.54" layer="94" font="vector">VGA interface</text>
<text x="2.54" y="271.78" size="2.54" layer="94" font="vector">FPGA</text>
<text x="2.54" y="83.82" size="2.54" layer="94" font="vector">3.3V power supply</text>
<text x="2.54" y="129.54" size="2.54" layer="94" font="vector">25MHz oscillator</text>
<text x="73.66" y="129.54" size="2.54" layer="94" font="vector">SPI Flash</text>
<wire x1="175.26" y1="134.62" x2="71.12" y2="134.62" width="0.1524" layer="94"/>
<wire x1="71.12" y1="134.62" x2="0" y2="134.62" width="0.1524" layer="94"/>
<text x="86.36" y="83.82" size="2.54" layer="94" font="vector">1.2V power supply</text>
<wire x1="175.26" y1="276.86" x2="175.26" y2="157.48" width="0.1524" layer="94"/>
<wire x1="83.82" y1="88.9" x2="83.82" y2="33.02" width="0.1524" layer="94"/>
<wire x1="71.12" y1="134.62" x2="71.12" y2="88.9" width="0.1524" layer="94"/>
<wire x1="71.12" y1="88.9" x2="0" y2="88.9" width="0.1524" layer="94"/>
<wire x1="269.24" y1="276.86" x2="269.24" y2="203.2" width="0.1524" layer="94"/>
<wire x1="269.24" y1="157.48" x2="175.26" y2="157.48" width="0.1524" layer="94"/>
<wire x1="175.26" y1="88.9" x2="71.12" y2="88.9" width="0.1524" layer="94"/>
<text x="271.78" y="271.78" size="2.54" layer="94" font="vector">Composite video interface</text>
<wire x1="269.24" y1="203.2" x2="360.68" y2="203.2" width="0.1524" layer="94"/>
<wire x1="360.68" y1="203.2" x2="398.78" y2="203.2" width="0.1524" layer="94"/>
<wire x1="269.24" y1="203.2" x2="269.24" y2="157.48" width="0.1524" layer="94"/>
<text x="177.8" y="152.4" size="2.54" layer="94" font="vector">Level shifters</text>
<text x="271.78" y="198.12" size="2.54" layer="94" font="vector">Bus connectors</text>
<wire x1="175.26" y1="33.02" x2="175.26" y2="88.9" width="0.1524" layer="94"/>
<wire x1="175.26" y1="88.9" x2="175.26" y2="134.62" width="0.1524" layer="94"/>
<wire x1="175.26" y1="134.62" x2="175.26" y2="157.48" width="0.1524" layer="94"/>
<wire x1="269.24" y1="157.48" x2="269.24" y2="76.2" width="0.1524" layer="94"/>
<wire x1="269.24" y1="76.2" x2="269.24" y2="12.7" width="0.1524" layer="94"/>
<wire x1="269.24" y1="12.7" x2="175.26" y2="12.7" width="0.1524" layer="94"/>
<wire x1="175.26" y1="12.7" x2="175.26" y2="33.02" width="0.1524" layer="94"/>
<wire x1="83.82" y1="33.02" x2="175.26" y2="33.02" width="0.1524" layer="94"/>
<wire x1="83.82" y1="33.02" x2="0" y2="33.02" width="0.1524" layer="94"/>
<wire x1="360.68" y1="203.2" x2="360.68" y2="76.2" width="0.1524" layer="94"/>
<wire x1="360.68" y1="76.2" x2="269.24" y2="76.2" width="0.1524" layer="94"/>
</plain>
<instances>
<instance part="R5" gate="G$1" x="205.74" y="172.72"/>
<instance part="R6" gate="G$1" x="205.74" y="165.1"/>
<instance part="R4" gate="G$1" x="205.74" y="264.16"/>
<instance part="R8" gate="G$1" x="205.74" y="256.54"/>
<instance part="R9" gate="G$1" x="205.74" y="248.92"/>
<instance part="R10" gate="G$1" x="205.74" y="241.3"/>
<instance part="R11" gate="G$1" x="205.74" y="233.68"/>
<instance part="R12" gate="G$1" x="205.74" y="226.06"/>
<instance part="R17" gate="G$1" x="205.74" y="218.44"/>
<instance part="R18" gate="G$1" x="205.74" y="210.82"/>
<instance part="R19" gate="G$1" x="205.74" y="203.2"/>
<instance part="R20" gate="G$1" x="205.74" y="195.58"/>
<instance part="R21" gate="G$1" x="205.74" y="187.96"/>
<instance part="R22" gate="G$1" x="205.74" y="180.34"/>
<instance part="U1" gate="_" x="38.1" y="266.7"/>
<instance part="U$1" gate="G$1" x="88.9" y="187.96"/>
<instance part="C6" gate="G$1" x="101.6" y="210.82" rot="R90"/>
<instance part="C7" gate="G$1" x="111.76" y="210.82" rot="R90"/>
<instance part="C8" gate="G$1" x="121.92" y="210.82" rot="R90"/>
<instance part="C9" gate="G$1" x="132.08" y="210.82" rot="R90"/>
<instance part="C10" gate="G$1" x="142.24" y="210.82" rot="R90"/>
<instance part="C11" gate="G$1" x="152.4" y="210.82" rot="R90"/>
<instance part="U$6" gate="G$1" x="101.6" y="205.74"/>
<instance part="U$7" gate="G$1" x="111.76" y="205.74"/>
<instance part="U$8" gate="G$1" x="121.92" y="205.74"/>
<instance part="U$9" gate="G$1" x="132.08" y="205.74"/>
<instance part="U$10" gate="G$1" x="142.24" y="205.74"/>
<instance part="U$11" gate="G$1" x="152.4" y="205.74"/>
<instance part="U$15" gate="G$1" x="152.4" y="220.98"/>
<instance part="C12" gate="G$1" x="101.6" y="182.88" rot="R90"/>
<instance part="C13" gate="G$1" x="111.76" y="182.88" rot="R90"/>
<instance part="C14" gate="G$1" x="121.92" y="182.88" rot="R90"/>
<instance part="C15" gate="G$1" x="132.08" y="182.88" rot="R90"/>
<instance part="U$16" gate="G$1" x="101.6" y="177.8"/>
<instance part="U$17" gate="G$1" x="111.76" y="177.8"/>
<instance part="U$18" gate="G$1" x="121.92" y="177.8"/>
<instance part="U$19" gate="G$1" x="132.08" y="177.8"/>
<instance part="U$20" gate="G$1" x="152.4" y="193.04"/>
<instance part="C16" gate="G$1" x="111.76" y="160.02" rot="R90"/>
<instance part="C17" gate="G$1" x="121.92" y="160.02" rot="R90"/>
<instance part="U$22" gate="G$1" x="111.76" y="154.94"/>
<instance part="U$23" gate="G$1" x="121.92" y="154.94"/>
<instance part="R40" gate="G$1" x="101.6" y="167.64"/>
<instance part="R41" gate="G$1" x="132.08" y="167.64"/>
<instance part="C69" gate="G$1" x="22.86" y="63.5" rot="R90"/>
<instance part="GND42" gate="G$1" x="22.86" y="58.42"/>
<instance part="C70" gate="G$1" x="73.66" y="63.5" rot="R90"/>
<instance part="GND44" gate="G$1" x="73.66" y="58.42"/>
<instance part="U5" gate="_" x="25.4" y="119.38"/>
<instance part="GND47" gate="G$1" x="17.78" y="106.68"/>
<instance part="C18" gate="G$1" x="10.16" y="109.22" rot="R90"/>
<instance part="GND48" gate="G$1" x="10.16" y="104.14"/>
<instance part="U$26" gate="G$1" x="7.62" y="73.66"/>
<instance part="U$5" gate="G$1" x="10.16" y="119.38"/>
<instance part="U4" gate="_" x="119.38" y="119.38"/>
<instance part="GND11" gate="G$1" x="152.4" y="101.6"/>
<instance part="U$31" gate="G$1" x="160.02" y="119.38"/>
<instance part="R43" gate="G$1" x="101.6" y="104.14"/>
<instance part="R44" gate="G$1" x="101.6" y="96.52"/>
<instance part="U$32" gate="G$1" x="88.9" y="99.06"/>
<instance part="C23" gate="G$1" x="160.02" y="109.22" rot="R90"/>
<instance part="GND12" gate="G$1" x="160.02" y="101.6"/>
<instance part="U8" gate="_" x="111.76" y="73.66"/>
<instance part="GND15" gate="G$1" x="104.14" y="58.42"/>
<instance part="C25" gate="G$1" x="93.98" y="63.5" rot="R90"/>
<instance part="GND20" gate="G$1" x="93.98" y="58.42"/>
<instance part="R13" gate="G$1" x="154.94" y="63.5" rot="R90"/>
<instance part="R45" gate="G$1" x="154.94" y="48.26" rot="R90"/>
<instance part="GND21" gate="G$1" x="154.94" y="43.18"/>
<instance part="L1" gate="G$1" x="144.78" y="71.12" smashed="yes">
<attribute name="NAME" x="137.16" y="76.2" size="1.778" layer="95"/>
<attribute name="VALUE" x="137.16" y="73.66" size="1.778" layer="96"/>
</instance>
<instance part="C26" gate="G$1" x="165.1" y="63.5" rot="R90"/>
<instance part="GND23" gate="G$1" x="165.1" y="58.42"/>
<instance part="U$34" gate="G$1" x="93.98" y="73.66"/>
<instance part="U$35" gate="G$1" x="73.66" y="73.66"/>
<instance part="U$14" gate="G$1" x="165.1" y="73.66"/>
<instance part="R46" gate="G$1" x="78.74" y="116.84" rot="MR270"/>
<instance part="U$38" gate="G$1" x="78.74" y="121.92"/>
<instance part="U3" gate="_" x="210.82" y="147.32"/>
<instance part="GND2" gate="G$1" x="203.2" y="111.76"/>
<instance part="GND4" gate="G$1" x="236.22" y="111.76"/>
<instance part="U$33" gate="G$1" x="243.84" y="114.3"/>
<instance part="R34" gate="G$1" x="12.7" y="170.18" rot="MR270"/>
<instance part="R35" gate="G$1" x="20.32" y="170.18" rot="MR270"/>
<instance part="U$36" gate="G$1" x="12.7" y="180.34"/>
<instance part="J3" gate="_" x="53.34" y="167.64"/>
<instance part="U$37" gate="G$1" x="45.72" y="167.64"/>
<instance part="U$39" gate="G$1" x="45.72" y="144.78"/>
<instance part="C4" gate="G$1" x="208.28" y="27.94" rot="R90"/>
<instance part="U$40" gate="G$1" x="208.28" y="22.86"/>
<instance part="C5" gate="G$1" x="218.44" y="27.94" rot="R90"/>
<instance part="U$42" gate="G$1" x="218.44" y="22.86"/>
<instance part="U$41" gate="G$1" x="218.44" y="33.02"/>
<instance part="U$43" gate="G$1" x="208.28" y="33.02"/>
<instance part="U6" gate="_" x="228.6" y="45.72" rot="R180"/>
<instance part="U$28" gate="G$1" x="241.3" y="48.26"/>
<instance part="U$25" gate="G$1" x="198.12" y="48.26"/>
<instance part="GND3" gate="G$1" x="198.12" y="81.28"/>
<instance part="U9" gate="_" x="210.82" y="104.14"/>
<instance part="GND5" gate="G$1" x="233.68" y="93.98"/>
<instance part="U$21" gate="G$1" x="198.12" y="93.98"/>
<instance part="C19" gate="G$1" x="228.6" y="27.94" rot="R90"/>
<instance part="U$30" gate="G$1" x="228.6" y="22.86"/>
<instance part="U$44" gate="G$1" x="228.6" y="33.02"/>
<instance part="FRAME1" gate="G$1" x="0" y="0"/>
<instance part="FRAME1" gate="G$2" x="297.18" y="0"/>
<instance part="FD1" gate="_" x="358.14" y="27.94"/>
<instance part="FD2" gate="_" x="370.84" y="27.94"/>
<instance part="FD3" gate="_" x="383.54" y="27.94"/>
<instance part="R16" gate="G$1" x="340.36" y="215.9"/>
<instance part="U$2" gate="G$1" x="347.98" y="213.36"/>
<instance part="Q1" gate="_" x="353.06" y="246.38"/>
<instance part="R25" gate="G$1" x="345.44" y="254" rot="R90"/>
<instance part="R26" gate="G$1" x="355.6" y="236.22" rot="R90"/>
<instance part="R27" gate="G$1" x="355.6" y="220.98" rot="R90"/>
<instance part="U$3" gate="G$1" x="355.6" y="213.36"/>
<instance part="U$4" gate="G$1" x="355.6" y="264.16"/>
<instance part="C1" gate="G$1" x="345.44" y="238.76" rot="R90"/>
<instance part="U$12" gate="G$1" x="345.44" y="233.68"/>
<instance part="C2" gate="G$1" x="363.22" y="261.62"/>
<instance part="U$13" gate="G$1" x="370.84" y="259.08"/>
<instance part="R1" gate="G$1" x="299.72" y="241.3" smashed="yes" rot="MR0">
<attribute name="VALUE" x="299.72" y="231.902" size="0.8128" layer="96" rot="MR0" align="top-center"/>
<attribute name="NAME" x="299.72" y="243.078" size="1.778" layer="95" rot="MR0" align="bottom-center"/>
</instance>
<instance part="R2" gate="G$1" x="299.72" y="223.52" smashed="yes" rot="MR0">
<attribute name="VALUE" x="299.72" y="214.122" size="0.8128" layer="96" rot="MR0" align="top-center"/>
<attribute name="NAME" x="299.72" y="225.298" size="1.778" layer="95" rot="MR0" align="bottom-center"/>
</instance>
<instance part="R3" gate="G$1" x="312.42" y="241.3" smashed="yes" rot="MR0">
<attribute name="VALUE" x="312.42" y="231.902" size="0.8128" layer="96" rot="MR0" align="top-center"/>
<attribute name="NAME" x="312.42" y="243.078" size="1.778" layer="95" rot="MR0" align="bottom-center"/>
</instance>
<instance part="R7" gate="G$1" x="312.42" y="223.52" smashed="yes" rot="MR0">
<attribute name="VALUE" x="312.42" y="214.122" size="0.8128" layer="96" rot="MR0" align="top-center"/>
<attribute name="NAME" x="312.42" y="225.298" size="1.778" layer="95" rot="MR0" align="bottom-center"/>
</instance>
<instance part="R14" gate="G$1" x="327.66" y="241.3" smashed="yes" rot="MR0">
<attribute name="VALUE" x="327.66" y="231.902" size="0.8128" layer="96" rot="MR0" align="top-center"/>
<attribute name="NAME" x="327.66" y="243.078" size="1.778" layer="95" rot="MR0" align="bottom-center"/>
</instance>
<instance part="R15" gate="G$1" x="327.66" y="223.52" smashed="yes" rot="MR0">
<attribute name="VALUE" x="327.66" y="214.122" size="0.8128" layer="96" rot="MR0" align="top-center"/>
<attribute name="NAME" x="327.66" y="225.298" size="1.778" layer="95" rot="MR0" align="bottom-center"/>
</instance>
<instance part="U$24" gate="G$1" x="238.76" y="218.44"/>
<instance part="J1" gate="_" x="246.38" y="266.7" smashed="yes">
<attribute name="NAME" x="246.38" y="266.954" size="1.778" layer="95" font="vector"/>
<attribute name="VALUE" x="261.62" y="218.44" size="1.778" layer="96" font="vector" rot="R90"/>
</instance>
<instance part="J2" gate="_" x="378.46" y="231.14"/>
<instance part="U$27" gate="G$1" x="370.84" y="220.98"/>
<instance part="R28" gate="G$1" x="15.24" y="71.12"/>
<instance part="U2" gate="_" x="40.64" y="73.66"/>
<instance part="GND1" gate="G$1" x="33.02" y="60.96"/>
<instance part="J5" gate="_" x="307.34" y="187.96"/>
<instance part="U$29" gate="G$1" x="299.72" y="187.96"/>
<instance part="GND6" gate="G$1" x="330.2" y="160.02"/>
<instance part="GND7" gate="G$1" x="335.28" y="190.5"/>
<instance part="J4" gate="_" x="302.26" y="147.32"/>
<instance part="GND8" gate="G$1" x="294.64" y="88.9"/>
<instance part="GND9" gate="G$1" x="335.28" y="88.9"/>
<instance part="U$45" gate="G$1" x="294.64" y="147.32"/>
<instance part="GND10" gate="G$1" x="287.02" y="144.78"/>
<instance part="GND13" gate="G$1" x="340.36" y="147.32"/>
</instances>
<busses>
</busses>
<nets>
<net name="GND" class="0">
<segment>
<pinref part="U1" gate="_" pin="GND"/>
<pinref part="U$1" gate="G$1" pin="GND"/>
<wire x1="88.9" y1="190.5" x2="86.36" y2="190.5" width="0.1524" layer="91"/>
<wire x1="88.9" y1="187.96" x2="88.9" y2="190.5" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C6" gate="G$1" pin="1"/>
<pinref part="U$6" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C7" gate="G$1" pin="1"/>
<pinref part="U$7" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C8" gate="G$1" pin="1"/>
<pinref part="U$8" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C9" gate="G$1" pin="1"/>
<pinref part="U$9" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C10" gate="G$1" pin="1"/>
<pinref part="U$10" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C11" gate="G$1" pin="1"/>
<pinref part="U$11" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C12" gate="G$1" pin="1"/>
<pinref part="U$16" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C13" gate="G$1" pin="1"/>
<pinref part="U$17" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C14" gate="G$1" pin="1"/>
<pinref part="U$18" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C15" gate="G$1" pin="1"/>
<pinref part="U$19" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C16" gate="G$1" pin="1"/>
<pinref part="U$22" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C17" gate="G$1" pin="1"/>
<pinref part="U$23" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C69" gate="G$1" pin="1"/>
<pinref part="GND42" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C70" gate="G$1" pin="1"/>
<pinref part="GND44" gate="G$1" pin="GND"/>
</segment>
<segment>
<wire x1="20.32" y1="109.22" x2="17.78" y2="109.22" width="0.1524" layer="91"/>
<wire x1="17.78" y1="109.22" x2="17.78" y2="106.68" width="0.1524" layer="91"/>
<pinref part="U5" gate="_" pin="GND"/>
<pinref part="GND47" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C18" gate="G$1" pin="1"/>
<pinref part="GND48" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U4" gate="_" pin="VSS"/>
<wire x1="149.86" y1="104.14" x2="152.4" y2="104.14" width="0.1524" layer="91"/>
<wire x1="152.4" y1="104.14" x2="152.4" y2="101.6" width="0.1524" layer="91"/>
<pinref part="GND11" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C23" gate="G$1" pin="1"/>
<pinref part="GND12" gate="G$1" pin="GND"/>
<wire x1="160.02" y1="104.14" x2="160.02" y2="101.6" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="106.68" y1="60.96" x2="104.14" y2="60.96" width="0.1524" layer="91"/>
<wire x1="104.14" y1="60.96" x2="104.14" y2="58.42" width="0.1524" layer="91"/>
<pinref part="U8" gate="_" pin="GND"/>
<pinref part="GND15" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C25" gate="G$1" pin="1"/>
<pinref part="GND20" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="R45" gate="G$1" pin="1"/>
<pinref part="GND21" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C26" gate="G$1" pin="1"/>
<pinref part="GND23" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U3" gate="_" pin="OE#"/>
<wire x1="205.74" y1="114.3" x2="203.2" y2="114.3" width="0.1524" layer="91"/>
<pinref part="GND2" gate="G$1" pin="GND"/>
<wire x1="203.2" y1="114.3" x2="203.2" y2="111.76" width="0.1524" layer="91"/>
<pinref part="U3" gate="_" pin="A10"/>
<wire x1="205.74" y1="121.92" x2="203.2" y2="121.92" width="0.1524" layer="91"/>
<wire x1="203.2" y1="121.92" x2="203.2" y2="114.3" width="0.1524" layer="91"/>
<junction x="203.2" y="114.3"/>
</segment>
<segment>
<pinref part="U3" gate="_" pin="GND"/>
<wire x1="233.68" y1="114.3" x2="236.22" y2="114.3" width="0.1524" layer="91"/>
<wire x1="236.22" y1="114.3" x2="236.22" y2="111.76" width="0.1524" layer="91"/>
<pinref part="GND4" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U$39" gate="G$1" pin="GND"/>
<wire x1="45.72" y1="144.78" x2="45.72" y2="147.32" width="0.1524" layer="91"/>
<wire x1="45.72" y1="147.32" x2="48.26" y2="147.32" width="0.1524" layer="91"/>
<pinref part="J3" gate="_" pin="8"/>
</segment>
<segment>
<pinref part="C4" gate="G$1" pin="1"/>
<pinref part="U$40" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C5" gate="G$1" pin="1"/>
<pinref part="U$42" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U6" gate="_" pin="GND@3"/>
<wire x1="205.74" y1="83.82" x2="203.2" y2="83.82" width="0.1524" layer="91"/>
<wire x1="203.2" y1="83.82" x2="203.2" y2="81.28" width="0.1524" layer="91"/>
<pinref part="U6" gate="_" pin="GND@1"/>
<wire x1="203.2" y1="81.28" x2="203.2" y2="78.74" width="0.1524" layer="91"/>
<wire x1="203.2" y1="78.74" x2="205.74" y2="78.74" width="0.1524" layer="91"/>
<pinref part="U6" gate="_" pin="GND@2"/>
<wire x1="205.74" y1="81.28" x2="203.2" y2="81.28" width="0.1524" layer="91"/>
<junction x="203.2" y="81.28"/>
<wire x1="203.2" y1="83.82" x2="198.12" y2="83.82" width="0.1524" layer="91"/>
<junction x="203.2" y="83.82"/>
<wire x1="198.12" y1="83.82" x2="198.12" y2="81.28" width="0.1524" layer="91"/>
<pinref part="GND3" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U9" gate="_" pin="GND"/>
<wire x1="231.14" y1="96.52" x2="233.68" y2="96.52" width="0.1524" layer="91"/>
<pinref part="GND5" gate="G$1" pin="GND"/>
<wire x1="233.68" y1="96.52" x2="233.68" y2="93.98" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C19" gate="G$1" pin="1"/>
<pinref part="U$30" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="R16" gate="G$1" pin="2"/>
<wire x1="345.44" y1="215.9" x2="347.98" y2="215.9" width="0.1524" layer="91"/>
<wire x1="347.98" y1="215.9" x2="347.98" y2="213.36" width="0.1524" layer="91"/>
<pinref part="U$2" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="R27" gate="G$1" pin="1"/>
<pinref part="U$3" gate="G$1" pin="GND"/>
<wire x1="355.6" y1="215.9" x2="355.6" y2="213.36" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C1" gate="G$1" pin="1"/>
<pinref part="U$12" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C2" gate="G$1" pin="2"/>
<wire x1="368.3" y1="261.62" x2="370.84" y2="261.62" width="0.1524" layer="91"/>
<pinref part="U$13" gate="G$1" pin="GND"/>
<wire x1="370.84" y1="261.62" x2="370.84" y2="259.08" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="241.3" y1="254" x2="238.76" y2="254" width="0.1524" layer="91"/>
<wire x1="238.76" y1="254" x2="238.76" y2="251.46" width="0.1524" layer="91"/>
<wire x1="238.76" y1="251.46" x2="238.76" y2="248.92" width="0.1524" layer="91"/>
<wire x1="238.76" y1="248.92" x2="238.76" y2="246.38" width="0.1524" layer="91"/>
<wire x1="238.76" y1="246.38" x2="241.3" y2="246.38" width="0.1524" layer="91"/>
<wire x1="241.3" y1="248.92" x2="238.76" y2="248.92" width="0.1524" layer="91"/>
<junction x="238.76" y="248.92"/>
<wire x1="241.3" y1="251.46" x2="238.76" y2="251.46" width="0.1524" layer="91"/>
<junction x="238.76" y="251.46"/>
<wire x1="238.76" y1="246.38" x2="238.76" y2="241.3" width="0.1524" layer="91"/>
<junction x="238.76" y="246.38"/>
<wire x1="238.76" y1="241.3" x2="241.3" y2="241.3" width="0.1524" layer="91"/>
<wire x1="238.76" y1="241.3" x2="238.76" y2="218.44" width="0.1524" layer="91"/>
<junction x="238.76" y="241.3"/>
<pinref part="U$24" gate="G$1" pin="GND"/>
<pinref part="J1" gate="_" pin="GND"/>
<pinref part="J1" gate="_" pin="RGND"/>
<pinref part="J1" gate="_" pin="GGND"/>
<pinref part="J1" gate="_" pin="BGND"/>
<pinref part="J1" gate="_" pin="SGND"/>
</segment>
<segment>
<pinref part="J2" gate="_" pin="G"/>
<wire x1="373.38" y1="223.52" x2="370.84" y2="223.52" width="0.1524" layer="91"/>
<pinref part="U$27" gate="G$1" pin="GND"/>
<wire x1="370.84" y1="223.52" x2="370.84" y2="220.98" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U2" gate="_" pin="GND"/>
<wire x1="35.56" y1="63.5" x2="33.02" y2="63.5" width="0.1524" layer="91"/>
<wire x1="33.02" y1="63.5" x2="33.02" y2="60.96" width="0.1524" layer="91"/>
<pinref part="GND1" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="J5" gate="_" pin="20"/>
<pinref part="GND6" gate="G$1" pin="GND"/>
<wire x1="327.66" y1="162.56" x2="330.2" y2="162.56" width="0.1524" layer="91"/>
<wire x1="330.2" y1="162.56" x2="330.2" y2="160.02" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J5" gate="_" pin="2"/>
<wire x1="327.66" y1="185.42" x2="330.2" y2="185.42" width="0.1524" layer="91"/>
<wire x1="330.2" y1="185.42" x2="330.2" y2="193.04" width="0.1524" layer="91"/>
<wire x1="330.2" y1="193.04" x2="335.28" y2="193.04" width="0.1524" layer="91"/>
<pinref part="GND7" gate="G$1" pin="GND"/>
<wire x1="335.28" y1="193.04" x2="335.28" y2="190.5" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J4" gate="_" pin="GND@2"/>
<wire x1="297.18" y1="91.44" x2="294.64" y2="91.44" width="0.1524" layer="91"/>
<wire x1="294.64" y1="91.44" x2="294.64" y2="88.9" width="0.1524" layer="91"/>
<pinref part="GND8" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="J4" gate="_" pin="GND@4"/>
<wire x1="332.74" y1="91.44" x2="335.28" y2="91.44" width="0.1524" layer="91"/>
<wire x1="335.28" y1="91.44" x2="335.28" y2="88.9" width="0.1524" layer="91"/>
<pinref part="GND9" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="J4" gate="_" pin="GND@1"/>
<wire x1="297.18" y1="144.78" x2="292.1" y2="144.78" width="0.1524" layer="91"/>
<wire x1="292.1" y1="144.78" x2="292.1" y2="147.32" width="0.1524" layer="91"/>
<wire x1="292.1" y1="147.32" x2="287.02" y2="147.32" width="0.1524" layer="91"/>
<wire x1="287.02" y1="147.32" x2="287.02" y2="144.78" width="0.1524" layer="91"/>
<pinref part="GND10" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="J4" gate="_" pin="GND@3"/>
<wire x1="332.74" y1="144.78" x2="335.28" y2="144.78" width="0.1524" layer="91"/>
<wire x1="335.28" y1="144.78" x2="335.28" y2="149.86" width="0.1524" layer="91"/>
<wire x1="335.28" y1="149.86" x2="340.36" y2="149.86" width="0.1524" layer="91"/>
<pinref part="GND13" gate="G$1" pin="GND"/>
<wire x1="340.36" y1="149.86" x2="340.36" y2="147.32" width="0.1524" layer="91"/>
</segment>
</net>
<net name="VGA_HSYNC" class="0">
<segment>
<wire x1="180.34" y1="172.72" x2="200.66" y2="172.72" width="0.1524" layer="91"/>
<label x="182.88" y="172.72" size="1.778" layer="95" font="vector"/>
<pinref part="R5" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="264.16" x2="33.02" y2="264.16" width="0.1524" layer="91"/>
<label x="10.16" y="264.16" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_3B_G6"/>
</segment>
</net>
<net name="VGA_VSYNC" class="0">
<segment>
<wire x1="180.34" y1="165.1" x2="200.66" y2="165.1" width="0.1524" layer="91"/>
<label x="182.88" y="165.1" size="1.778" layer="95" font="vector"/>
<pinref part="R6" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="261.62" x2="33.02" y2="261.62" width="0.1524" layer="91"/>
<label x="10.16" y="261.62" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_5B"/>
</segment>
</net>
<net name="VGA_HS" class="0">
<segment>
<wire x1="210.82" y1="172.72" x2="220.98" y2="172.72" width="0.1524" layer="91"/>
<pinref part="R5" gate="G$1" pin="2"/>
<wire x1="241.3" y1="233.68" x2="220.98" y2="233.68" width="0.1524" layer="91"/>
<wire x1="220.98" y1="233.68" x2="220.98" y2="172.72" width="0.1524" layer="91"/>
<label x="226.06" y="233.68" size="1.778" layer="95"/>
<pinref part="J1" gate="_" pin="HSYNC"/>
</segment>
</net>
<net name="VGA_VS" class="0">
<segment>
<pinref part="R6" gate="G$1" pin="2"/>
<wire x1="223.52" y1="165.1" x2="210.82" y2="165.1" width="0.1524" layer="91"/>
<wire x1="241.3" y1="231.14" x2="223.52" y2="231.14" width="0.1524" layer="91"/>
<wire x1="223.52" y1="231.14" x2="223.52" y2="165.1" width="0.1524" layer="91"/>
<label x="226.06" y="231.14" size="1.778" layer="95"/>
<pinref part="J1" gate="_" pin="VSYNC"/>
</segment>
</net>
<net name="BUS_A1" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_44B"/>
<wire x1="111.76" y1="246.38" x2="86.36" y2="246.38" width="0.1524" layer="91"/>
<label x="88.9" y="246.38" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="205.74" y1="132.08" x2="182.88" y2="132.08" width="0.1524" layer="91"/>
<label x="185.42" y="132.08" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A6"/>
</segment>
</net>
<net name="BUS_PHY2" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_45A_G1"/>
<wire x1="111.76" y1="238.76" x2="86.36" y2="238.76" width="0.1524" layer="91"/>
<label x="88.9" y="238.76" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="205.74" y1="137.16" x2="182.88" y2="137.16" width="0.1524" layer="91"/>
<label x="185.42" y="137.16" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A4"/>
</segment>
</net>
<net name="BUS_A0" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_48B"/>
<wire x1="111.76" y1="241.3" x2="86.36" y2="241.3" width="0.1524" layer="91"/>
<label x="88.9" y="241.3" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="205.74" y1="134.62" x2="182.88" y2="134.62" width="0.1524" layer="91"/>
<label x="185.42" y="134.62" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A5"/>
</segment>
</net>
<net name="SPI_SCK" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOB_34A_SPI_SCK"/>
<wire x1="7.62" y1="220.98" x2="33.02" y2="220.98" width="0.1524" layer="91"/>
<label x="10.16" y="220.98" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<pinref part="U4" gate="_" pin="CLK"/>
<wire x1="114.3" y1="116.84" x2="88.9" y2="116.84" width="0.1524" layer="91"/>
<label x="91.44" y="116.84" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="22.86" y1="152.4" x2="48.26" y2="152.4" width="0.1524" layer="91"/>
<label x="25.4" y="152.4" size="1.778" layer="95" font="vector"/>
<pinref part="J3" gate="_" pin="6"/>
</segment>
</net>
<net name="SPI_MOSI" class="0">
<segment>
<pinref part="U4" gate="_" pin="DQ0"/>
<wire x1="114.3" y1="111.76" x2="88.9" y2="111.76" width="0.1524" layer="91"/>
<label x="91.44" y="111.76" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<pinref part="U1" gate="_" pin="IOB_32A_SPI_SO"/>
<wire x1="7.62" y1="223.52" x2="33.02" y2="223.52" width="0.1524" layer="91"/>
<label x="10.16" y="223.52" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="22.86" y1="154.94" x2="48.26" y2="154.94" width="0.1524" layer="91"/>
<label x="25.4" y="154.94" size="1.778" layer="95" font="vector"/>
<pinref part="J3" gate="_" pin="5"/>
</segment>
</net>
<net name="SPI_MISO" class="0">
<segment>
<pinref part="U4" gate="_" pin="DQ1"/>
<wire x1="114.3" y1="109.22" x2="88.9" y2="109.22" width="0.1524" layer="91"/>
<label x="91.44" y="109.22" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<pinref part="U1" gate="_" pin="IOB_33B_SPI_SI"/>
<wire x1="7.62" y1="215.9" x2="33.02" y2="215.9" width="0.1524" layer="91"/>
<label x="10.16" y="215.9" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="22.86" y1="157.48" x2="48.26" y2="157.48" width="0.1524" layer="91"/>
<label x="25.4" y="157.48" size="1.778" layer="95" font="vector"/>
<pinref part="J3" gate="_" pin="4"/>
</segment>
</net>
<net name="BUS_D4" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOB_23B"/>
<wire x1="7.62" y1="205.74" x2="33.02" y2="205.74" width="0.1524" layer="91"/>
<label x="10.16" y="205.74" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="182.88" y1="63.5" x2="205.74" y2="63.5" width="0.1524" layer="91"/>
<label x="185.42" y="63.5" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B3"/>
</segment>
</net>
<net name="+5V" class="1">
<segment>
<pinref part="U$26" gate="G$1" pin="+5V"/>
<pinref part="R28" gate="G$1" pin="1"/>
<wire x1="10.16" y1="71.12" x2="7.62" y2="71.12" width="0.1524" layer="91"/>
<wire x1="7.62" y1="71.12" x2="7.62" y2="73.66" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="106.68" y1="66.04" x2="104.14" y2="66.04" width="0.1524" layer="91"/>
<wire x1="104.14" y1="66.04" x2="104.14" y2="71.12" width="0.1524" layer="91"/>
<wire x1="104.14" y1="71.12" x2="106.68" y2="71.12" width="0.1524" layer="91"/>
<wire x1="104.14" y1="71.12" x2="93.98" y2="71.12" width="0.1524" layer="91"/>
<wire x1="93.98" y1="71.12" x2="93.98" y2="73.66" width="0.1524" layer="91"/>
<wire x1="93.98" y1="68.58" x2="93.98" y2="71.12" width="0.1524" layer="91"/>
<junction x="104.14" y="71.12"/>
<junction x="93.98" y="71.12"/>
<pinref part="U8" gate="_" pin="EN"/>
<pinref part="U8" gate="_" pin="VIN"/>
<pinref part="C25" gate="G$1" pin="2"/>
<pinref part="U$34" gate="G$1" pin="+5V"/>
</segment>
<segment>
<pinref part="U3" gate="_" pin="VCC"/>
<wire x1="233.68" y1="116.84" x2="238.76" y2="116.84" width="0.1524" layer="91"/>
<wire x1="238.76" y1="116.84" x2="238.76" y2="111.76" width="0.1524" layer="91"/>
<wire x1="238.76" y1="111.76" x2="243.84" y2="111.76" width="0.1524" layer="91"/>
<pinref part="U$33" gate="G$1" pin="+5V"/>
<wire x1="243.84" y1="111.76" x2="243.84" y2="114.3" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="48.26" y1="165.1" x2="45.72" y2="165.1" width="0.1524" layer="91"/>
<wire x1="45.72" y1="165.1" x2="45.72" y2="167.64" width="0.1524" layer="91"/>
<pinref part="U$37" gate="G$1" pin="+5V"/>
<pinref part="J3" gate="_" pin="1"/>
</segment>
<segment>
<pinref part="C5" gate="G$1" pin="2"/>
<pinref part="U$41" gate="G$1" pin="+5V"/>
</segment>
<segment>
<wire x1="233.68" y1="48.26" x2="236.22" y2="48.26" width="0.1524" layer="91"/>
<wire x1="236.22" y1="48.26" x2="236.22" y2="45.72" width="0.1524" layer="91"/>
<wire x1="236.22" y1="45.72" x2="241.3" y2="45.72" width="0.1524" layer="91"/>
<pinref part="U$28" gate="G$1" pin="+5V"/>
<wire x1="241.3" y1="45.72" x2="241.3" y2="48.26" width="0.1524" layer="91"/>
<pinref part="U6" gate="_" pin="VCCA"/>
</segment>
<segment>
<pinref part="U9" gate="_" pin="VCC"/>
<wire x1="205.74" y1="96.52" x2="203.2" y2="96.52" width="0.1524" layer="91"/>
<wire x1="203.2" y1="96.52" x2="203.2" y2="91.44" width="0.1524" layer="91"/>
<wire x1="203.2" y1="91.44" x2="198.12" y2="91.44" width="0.1524" layer="91"/>
<wire x1="198.12" y1="91.44" x2="198.12" y2="93.98" width="0.1524" layer="91"/>
<pinref part="U$21" gate="G$1" pin="+5V"/>
</segment>
<segment>
<pinref part="C19" gate="G$1" pin="2"/>
<pinref part="U$44" gate="G$1" pin="+5V"/>
</segment>
<segment>
<pinref part="U$29" gate="G$1" pin="+5V"/>
<wire x1="299.72" y1="187.96" x2="299.72" y2="185.42" width="0.1524" layer="91"/>
<pinref part="J5" gate="_" pin="1"/>
<wire x1="299.72" y1="185.42" x2="302.26" y2="185.42" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="J4" gate="_" pin="+5V@2"/>
<wire x1="297.18" y1="139.7" x2="294.64" y2="139.7" width="0.1524" layer="91"/>
<wire x1="294.64" y1="139.7" x2="294.64" y2="142.24" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="+5V@1"/>
<wire x1="294.64" y1="142.24" x2="297.18" y2="142.24" width="0.1524" layer="91"/>
<wire x1="294.64" y1="142.24" x2="294.64" y2="147.32" width="0.1524" layer="91"/>
<junction x="294.64" y="142.24"/>
<pinref part="U$45" gate="G$1" pin="+5V"/>
</segment>
</net>
<net name="VGA_R" class="0">
<segment>
<wire x1="241.3" y1="264.16" x2="213.36" y2="264.16" width="0.1524" layer="91"/>
<pinref part="R4" gate="G$1" pin="2"/>
<wire x1="210.82" y1="264.16" x2="213.36" y2="264.16" width="0.1524" layer="91"/>
<pinref part="R8" gate="G$1" pin="2"/>
<wire x1="213.36" y1="256.54" x2="213.36" y2="264.16" width="0.1524" layer="91"/>
<junction x="213.36" y="264.16"/>
<label x="226.06" y="264.16" size="1.778" layer="95"/>
<pinref part="R9" gate="G$1" pin="2"/>
<pinref part="R10" gate="G$1" pin="2"/>
<wire x1="213.36" y1="248.92" x2="210.82" y2="248.92" width="0.1524" layer="91"/>
<wire x1="210.82" y1="241.3" x2="213.36" y2="241.3" width="0.1524" layer="91"/>
<wire x1="213.36" y1="241.3" x2="213.36" y2="248.92" width="0.1524" layer="91"/>
<junction x="213.36" y="248.92"/>
<wire x1="210.82" y1="256.54" x2="213.36" y2="256.54" width="0.1524" layer="91"/>
<wire x1="213.36" y1="256.54" x2="213.36" y2="248.92" width="0.1524" layer="91"/>
<junction x="213.36" y="256.54"/>
<pinref part="J1" gate="_" pin="RED"/>
</segment>
</net>
<net name="VGA_B" class="0">
<segment>
<pinref part="R19" gate="G$1" pin="2"/>
<wire x1="210.82" y1="203.2" x2="213.36" y2="203.2" width="0.1524" layer="91"/>
<pinref part="R20" gate="G$1" pin="2"/>
<wire x1="210.82" y1="195.58" x2="213.36" y2="195.58" width="0.1524" layer="91"/>
<wire x1="213.36" y1="195.58" x2="213.36" y2="203.2" width="0.1524" layer="91"/>
<junction x="213.36" y="203.2"/>
<pinref part="R21" gate="G$1" pin="2"/>
<wire x1="210.82" y1="187.96" x2="213.36" y2="187.96" width="0.1524" layer="91"/>
<wire x1="213.36" y1="187.96" x2="213.36" y2="195.58" width="0.1524" layer="91"/>
<junction x="213.36" y="195.58"/>
<pinref part="R22" gate="G$1" pin="2"/>
<wire x1="210.82" y1="180.34" x2="213.36" y2="180.34" width="0.1524" layer="91"/>
<wire x1="213.36" y1="180.34" x2="213.36" y2="187.96" width="0.1524" layer="91"/>
<junction x="213.36" y="187.96"/>
<wire x1="218.44" y1="203.2" x2="213.36" y2="203.2" width="0.1524" layer="91"/>
<wire x1="218.44" y1="203.2" x2="218.44" y2="259.08" width="0.1524" layer="91"/>
<wire x1="218.44" y1="259.08" x2="241.3" y2="259.08" width="0.1524" layer="91"/>
<label x="226.06" y="259.08" size="1.778" layer="95"/>
<pinref part="J1" gate="_" pin="BLUE"/>
</segment>
</net>
<net name="VGA_G1" class="0">
<segment>
<wire x1="180.34" y1="218.44" x2="200.66" y2="218.44" width="0.1524" layer="91"/>
<label x="182.88" y="218.44" size="1.778" layer="95" font="vector"/>
<pinref part="R17" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="246.38" x2="33.02" y2="246.38" width="0.1524" layer="91"/>
<label x="10.16" y="246.38" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_8A"/>
</segment>
<segment>
<wire x1="274.32" y1="218.44" x2="294.64" y2="218.44" width="0.1524" layer="91"/>
<label x="276.86" y="218.44" size="1.778" layer="95" font="vector"/>
<pinref part="R2" gate="G$1" pin="3B"/>
</segment>
</net>
<net name="VGA_G2" class="0">
<segment>
<wire x1="180.34" y1="226.06" x2="200.66" y2="226.06" width="0.1524" layer="91"/>
<label x="182.88" y="226.06" size="1.778" layer="95" font="vector"/>
<pinref part="R12" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="243.84" x2="33.02" y2="243.84" width="0.1524" layer="91"/>
<label x="10.16" y="243.84" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_13B"/>
</segment>
<segment>
<wire x1="274.32" y1="220.98" x2="294.64" y2="220.98" width="0.1524" layer="91"/>
<label x="276.86" y="220.98" size="1.778" layer="95" font="vector"/>
<pinref part="R2" gate="G$1" pin="2B"/>
</segment>
</net>
<net name="VGA_G3" class="0">
<segment>
<wire x1="180.34" y1="233.68" x2="200.66" y2="233.68" width="0.1524" layer="91"/>
<label x="182.88" y="233.68" size="1.778" layer="95" font="vector"/>
<pinref part="R11" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="236.22" x2="33.02" y2="236.22" width="0.1524" layer="91"/>
<label x="10.16" y="236.22" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_16A"/>
</segment>
<segment>
<wire x1="274.32" y1="223.52" x2="294.64" y2="223.52" width="0.1524" layer="91"/>
<label x="276.86" y="223.52" size="1.778" layer="95" font="vector"/>
<pinref part="R2" gate="G$1" pin="1B"/>
</segment>
</net>
<net name="VGA_R0" class="0">
<segment>
<wire x1="180.34" y1="241.3" x2="200.66" y2="241.3" width="0.1524" layer="91"/>
<label x="182.88" y="241.3" size="1.778" layer="95" font="vector"/>
<pinref part="R10" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="233.68" x2="33.02" y2="233.68" width="0.1524" layer="91"/>
<label x="10.16" y="233.68" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_18A"/>
</segment>
<segment>
<wire x1="274.32" y1="233.68" x2="294.64" y2="233.68" width="0.1524" layer="91"/>
<label x="276.86" y="233.68" size="1.778" layer="95" font="vector"/>
<pinref part="R1" gate="G$1" pin="4B"/>
</segment>
</net>
<net name="VGA_R1" class="0">
<segment>
<wire x1="180.34" y1="248.92" x2="200.66" y2="248.92" width="0.1524" layer="91"/>
<label x="182.88" y="248.92" size="1.778" layer="95" font="vector"/>
<pinref part="R9" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="231.14" x2="33.02" y2="231.14" width="0.1524" layer="91"/>
<label x="10.16" y="231.14" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_20A"/>
</segment>
<segment>
<wire x1="274.32" y1="236.22" x2="294.64" y2="236.22" width="0.1524" layer="91"/>
<label x="276.86" y="236.22" size="1.778" layer="95" font="vector"/>
<pinref part="R1" gate="G$1" pin="3B"/>
</segment>
</net>
<net name="VGA_B0" class="0">
<segment>
<wire x1="180.34" y1="180.34" x2="200.66" y2="180.34" width="0.1524" layer="91"/>
<label x="182.88" y="180.34" size="1.778" layer="95" font="vector"/>
<pinref part="R22" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="259.08" x2="33.02" y2="259.08" width="0.1524" layer="91"/>
<label x="10.16" y="259.08" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_0A"/>
</segment>
</net>
<net name="VGA_B1" class="0">
<segment>
<wire x1="180.34" y1="187.96" x2="200.66" y2="187.96" width="0.1524" layer="91"/>
<label x="182.88" y="187.96" size="1.778" layer="95" font="vector"/>
<pinref part="R21" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="256.54" x2="33.02" y2="256.54" width="0.1524" layer="91"/>
<label x="10.16" y="256.54" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_2A"/>
</segment>
</net>
<net name="VGA_B2" class="0">
<segment>
<wire x1="180.34" y1="195.58" x2="200.66" y2="195.58" width="0.1524" layer="91"/>
<label x="182.88" y="195.58" size="1.778" layer="95" font="vector"/>
<pinref part="R20" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="254" x2="33.02" y2="254" width="0.1524" layer="91"/>
<label x="10.16" y="254" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_4A"/>
</segment>
</net>
<net name="VGA_B3" class="0">
<segment>
<wire x1="180.34" y1="203.2" x2="200.66" y2="203.2" width="0.1524" layer="91"/>
<label x="182.88" y="203.2" size="1.778" layer="95" font="vector"/>
<pinref part="R19" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="251.46" x2="33.02" y2="251.46" width="0.1524" layer="91"/>
<label x="10.16" y="251.46" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_6A"/>
</segment>
</net>
<net name="VGA_R2" class="0">
<segment>
<wire x1="180.34" y1="256.54" x2="200.66" y2="256.54" width="0.1524" layer="91"/>
<label x="182.88" y="256.54" size="1.778" layer="95" font="vector"/>
<pinref part="R8" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="228.6" x2="33.02" y2="228.6" width="0.1524" layer="91"/>
<label x="10.16" y="228.6" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_22A"/>
</segment>
<segment>
<wire x1="274.32" y1="238.76" x2="294.64" y2="238.76" width="0.1524" layer="91"/>
<label x="276.86" y="238.76" size="1.778" layer="95" font="vector"/>
<pinref part="R1" gate="G$1" pin="2B"/>
</segment>
</net>
<net name="VGA_R3" class="0">
<segment>
<wire x1="180.34" y1="264.16" x2="200.66" y2="264.16" width="0.1524" layer="91"/>
<label x="182.88" y="264.16" size="1.778" layer="95" font="vector"/>
<pinref part="R4" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="226.06" x2="33.02" y2="226.06" width="0.1524" layer="91"/>
<label x="10.16" y="226.06" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_24A"/>
</segment>
<segment>
<wire x1="274.32" y1="241.3" x2="294.64" y2="241.3" width="0.1524" layer="91"/>
<label x="276.86" y="241.3" size="1.778" layer="95" font="vector"/>
<pinref part="R1" gate="G$1" pin="1B"/>
</segment>
</net>
<net name="BUS_D7" class="0">
<segment>
<wire x1="7.62" y1="213.36" x2="33.02" y2="213.36" width="0.1524" layer="91"/>
<label x="10.16" y="213.36" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_31B"/>
</segment>
<segment>
<wire x1="182.88" y1="55.88" x2="205.74" y2="55.88" width="0.1524" layer="91"/>
<label x="185.42" y="55.88" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B0"/>
</segment>
</net>
<net name="BUS_D6" class="0">
<segment>
<wire x1="7.62" y1="210.82" x2="33.02" y2="210.82" width="0.1524" layer="91"/>
<label x="10.16" y="210.82" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_29B"/>
</segment>
<segment>
<wire x1="182.88" y1="58.42" x2="205.74" y2="58.42" width="0.1524" layer="91"/>
<label x="185.42" y="58.42" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B1"/>
</segment>
</net>
<net name="BUS_D5" class="0">
<segment>
<wire x1="7.62" y1="208.28" x2="33.02" y2="208.28" width="0.1524" layer="91"/>
<label x="10.16" y="208.28" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_25B_G3"/>
</segment>
<segment>
<wire x1="182.88" y1="60.96" x2="205.74" y2="60.96" width="0.1524" layer="91"/>
<label x="185.42" y="60.96" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B2"/>
</segment>
</net>
<net name="VGA_G0" class="0">
<segment>
<wire x1="180.34" y1="210.82" x2="200.66" y2="210.82" width="0.1524" layer="91"/>
<label x="182.88" y="210.82" size="1.778" layer="95" font="vector"/>
<pinref part="R18" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="248.92" x2="33.02" y2="248.92" width="0.1524" layer="91"/>
<label x="10.16" y="248.92" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_9B"/>
</segment>
<segment>
<wire x1="274.32" y1="215.9" x2="294.64" y2="215.9" width="0.1524" layer="91"/>
<label x="276.86" y="215.9" size="1.778" layer="95" font="vector"/>
<pinref part="R2" gate="G$1" pin="4B"/>
</segment>
</net>
<net name="BUS_IRQ#" class="0">
<segment>
<wire x1="111.76" y1="223.52" x2="86.36" y2="223.52" width="0.1524" layer="91"/>
<label x="88.9" y="223.52" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_49A"/>
</segment>
<segment>
<wire x1="205.74" y1="144.78" x2="182.88" y2="144.78" width="0.1524" layer="91"/>
<label x="185.42" y="144.78" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A1"/>
</segment>
</net>
<net name="BUS_RES#" class="0">
<segment>
<wire x1="111.76" y1="226.06" x2="86.36" y2="226.06" width="0.1524" layer="91"/>
<label x="88.9" y="226.06" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_51A"/>
</segment>
<segment>
<wire x1="205.74" y1="142.24" x2="182.88" y2="142.24" width="0.1524" layer="91"/>
<label x="185.42" y="142.24" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A2"/>
</segment>
</net>
<net name="SYSCLK" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_46B_G0"/>
<wire x1="111.76" y1="243.84" x2="86.36" y2="243.84" width="0.1524" layer="91"/>
<label x="88.9" y="243.84" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="63.5" y1="116.84" x2="48.26" y2="116.84" width="0.1524" layer="91"/>
<label x="50.8" y="116.84" size="1.778" layer="95" font="vector"/>
<pinref part="U5" gate="_" pin="OUT"/>
</segment>
</net>
<net name="FPGA_CDONE" class="0">
<segment>
<pinref part="U1" gate="_" pin="CDONE"/>
<wire x1="7.62" y1="241.3" x2="33.02" y2="241.3" width="0.1524" layer="91"/>
<label x="10.16" y="241.3" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="20.32" y1="162.56" x2="48.26" y2="162.56" width="0.1524" layer="91"/>
<label x="25.4" y="162.56" size="1.778" layer="95" font="vector"/>
<pinref part="R35" gate="G$1" pin="2"/>
<wire x1="20.32" y1="165.1" x2="20.32" y2="162.56" width="0.1524" layer="91"/>
<pinref part="J3" gate="_" pin="2"/>
</segment>
</net>
<net name="FPGA_CRESET_B" class="0">
<segment>
<pinref part="U1" gate="_" pin="CRESET_B"/>
<wire x1="7.62" y1="238.76" x2="33.02" y2="238.76" width="0.1524" layer="91"/>
<label x="10.16" y="238.76" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="12.7" y1="160.02" x2="48.26" y2="160.02" width="0.1524" layer="91"/>
<label x="25.4" y="160.02" size="1.778" layer="95" font="vector"/>
<pinref part="R34" gate="G$1" pin="2"/>
<wire x1="12.7" y1="160.02" x2="12.7" y2="165.1" width="0.1524" layer="91"/>
<pinref part="J3" gate="_" pin="3"/>
</segment>
</net>
<net name="SPI_SSEL_N" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOB_35B_SPI_SS"/>
<wire x1="7.62" y1="218.44" x2="33.02" y2="218.44" width="0.1524" layer="91"/>
<label x="10.16" y="218.44" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<pinref part="U4" gate="_" pin="CS#"/>
<wire x1="114.3" y1="114.3" x2="86.36" y2="114.3" width="0.1524" layer="91"/>
<label x="91.44" y="114.3" size="1.778" layer="95" font="vector"/>
<wire x1="86.36" y1="114.3" x2="86.36" y2="109.22" width="0.1524" layer="91"/>
<pinref part="R46" gate="G$1" pin="2"/>
<wire x1="78.74" y1="111.76" x2="78.74" y2="109.22" width="0.1524" layer="91"/>
<wire x1="86.36" y1="109.22" x2="78.74" y2="109.22" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="22.86" y1="149.86" x2="48.26" y2="149.86" width="0.1524" layer="91"/>
<label x="25.4" y="149.86" size="1.778" layer="95" font="vector"/>
<pinref part="J3" gate="_" pin="7"/>
</segment>
</net>
<net name="N$44" class="0">
<segment>
<pinref part="U1" gate="_" pin="VCCPLL"/>
<wire x1="93.98" y1="195.58" x2="86.36" y2="195.58" width="0.1524" layer="91"/>
<pinref part="R40" gate="G$1" pin="1"/>
<wire x1="96.52" y1="167.64" x2="93.98" y2="167.64" width="0.1524" layer="91"/>
<wire x1="93.98" y1="167.64" x2="93.98" y2="195.58" width="0.1524" layer="91"/>
</segment>
</net>
<net name="BUS_D0" class="0">
<segment>
<wire x1="111.76" y1="256.54" x2="86.36" y2="256.54" width="0.1524" layer="91"/>
<label x="88.9" y="256.54" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_38B"/>
</segment>
<segment>
<wire x1="205.74" y1="73.66" x2="182.88" y2="73.66" width="0.1524" layer="91"/>
<label x="185.42" y="73.66" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B7"/>
</segment>
</net>
<net name="BUS_CS#" class="0">
<segment>
<wire x1="111.76" y1="254" x2="86.36" y2="254" width="0.1524" layer="91"/>
<label x="88.9" y="254" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_41A"/>
</segment>
<segment>
<wire x1="205.74" y1="124.46" x2="182.88" y2="124.46" width="0.1524" layer="91"/>
<label x="185.42" y="124.46" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A9"/>
</segment>
<segment>
<pinref part="U6" gate="_" pin="OE#"/>
<wire x1="233.68" y1="81.28" x2="251.46" y2="81.28" width="0.1524" layer="91"/>
<label x="236.22" y="81.28" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_RW#" class="0">
<segment>
<wire x1="111.76" y1="251.46" x2="86.36" y2="251.46" width="0.1524" layer="91"/>
<label x="88.9" y="251.46" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_42B"/>
</segment>
<segment>
<wire x1="205.74" y1="127" x2="182.88" y2="127" width="0.1524" layer="91"/>
<label x="185.42" y="127" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A8"/>
</segment>
</net>
<net name="BUS_A2" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_43A"/>
<wire x1="86.36" y1="248.92" x2="111.76" y2="248.92" width="0.1524" layer="91"/>
<label x="88.9" y="248.92" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="182.88" y1="129.54" x2="205.74" y2="129.54" width="0.1524" layer="91"/>
<label x="185.42" y="129.54" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A7"/>
</segment>
</net>
<net name="BUS_D2" class="0">
<segment>
<wire x1="111.76" y1="261.62" x2="86.36" y2="261.62" width="0.1524" layer="91"/>
<label x="88.9" y="261.62" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_36B"/>
</segment>
<segment>
<wire x1="205.74" y1="68.58" x2="182.88" y2="68.58" width="0.1524" layer="91"/>
<label x="185.42" y="68.58" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B5"/>
</segment>
</net>
<net name="BUS_D3" class="0">
<segment>
<wire x1="111.76" y1="264.16" x2="86.36" y2="264.16" width="0.1524" layer="91"/>
<label x="88.9" y="264.16" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_37A"/>
</segment>
<segment>
<wire x1="205.74" y1="66.04" x2="182.88" y2="66.04" width="0.1524" layer="91"/>
<label x="185.42" y="66.04" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B4"/>
</segment>
</net>
<net name="+3.3V" class="0">
<segment>
<pinref part="U1" gate="_" pin="VCCIO_2"/>
<pinref part="U1" gate="_" pin="SPI_VCCIO1"/>
<wire x1="88.9" y1="213.36" x2="86.36" y2="213.36" width="0.1524" layer="91"/>
<wire x1="88.9" y1="215.9" x2="86.36" y2="215.9" width="0.1524" layer="91"/>
<wire x1="88.9" y1="213.36" x2="88.9" y2="215.9" width="0.1524" layer="91"/>
<junction x="88.9" y="215.9"/>
<pinref part="U1" gate="_" pin="VCCIO_0"/>
<wire x1="88.9" y1="218.44" x2="86.36" y2="218.44" width="0.1524" layer="91"/>
<wire x1="88.9" y1="215.9" x2="88.9" y2="218.44" width="0.1524" layer="91"/>
<junction x="88.9" y="218.44"/>
<pinref part="U1" gate="_" pin="VPP_2V5"/>
<wire x1="86.36" y1="208.28" x2="88.9" y2="208.28" width="0.1524" layer="91"/>
<wire x1="88.9" y1="208.28" x2="88.9" y2="213.36" width="0.1524" layer="91"/>
<junction x="88.9" y="213.36"/>
<pinref part="C11" gate="G$1" pin="2"/>
<wire x1="88.9" y1="218.44" x2="101.6" y2="218.44" width="0.1524" layer="91"/>
<wire x1="101.6" y1="218.44" x2="111.76" y2="218.44" width="0.1524" layer="91"/>
<wire x1="111.76" y1="218.44" x2="121.92" y2="218.44" width="0.1524" layer="91"/>
<wire x1="121.92" y1="218.44" x2="132.08" y2="218.44" width="0.1524" layer="91"/>
<wire x1="132.08" y1="218.44" x2="142.24" y2="218.44" width="0.1524" layer="91"/>
<wire x1="142.24" y1="218.44" x2="152.4" y2="218.44" width="0.1524" layer="91"/>
<wire x1="152.4" y1="218.44" x2="152.4" y2="215.9" width="0.1524" layer="91"/>
<pinref part="C10" gate="G$1" pin="2"/>
<wire x1="142.24" y1="215.9" x2="142.24" y2="218.44" width="0.1524" layer="91"/>
<junction x="142.24" y="218.44"/>
<pinref part="C9" gate="G$1" pin="2"/>
<wire x1="132.08" y1="215.9" x2="132.08" y2="218.44" width="0.1524" layer="91"/>
<junction x="132.08" y="218.44"/>
<pinref part="C8" gate="G$1" pin="2"/>
<wire x1="121.92" y1="215.9" x2="121.92" y2="218.44" width="0.1524" layer="91"/>
<junction x="121.92" y="218.44"/>
<pinref part="C7" gate="G$1" pin="2"/>
<wire x1="111.76" y1="215.9" x2="111.76" y2="218.44" width="0.1524" layer="91"/>
<junction x="111.76" y="218.44"/>
<pinref part="C6" gate="G$1" pin="2"/>
<wire x1="101.6" y1="215.9" x2="101.6" y2="218.44" width="0.1524" layer="91"/>
<junction x="101.6" y="218.44"/>
<pinref part="U$15" gate="G$1" pin="+3.3V"/>
<wire x1="152.4" y1="220.98" x2="152.4" y2="218.44" width="0.1524" layer="91"/>
<junction x="152.4" y="218.44"/>
</segment>
<segment>
<wire x1="20.32" y1="116.84" x2="10.16" y2="116.84" width="0.1524" layer="91"/>
<wire x1="10.16" y1="116.84" x2="10.16" y2="119.38" width="0.1524" layer="91"/>
<wire x1="10.16" y1="114.3" x2="10.16" y2="116.84" width="0.1524" layer="91"/>
<junction x="10.16" y="116.84"/>
<pinref part="U5" gate="_" pin="VCC"/>
<pinref part="C18" gate="G$1" pin="2"/>
<pinref part="U$5" gate="G$1" pin="+3.3V"/>
</segment>
<segment>
<pinref part="U4" gate="_" pin="VCC"/>
<wire x1="149.86" y1="116.84" x2="160.02" y2="116.84" width="0.1524" layer="91"/>
<wire x1="160.02" y1="116.84" x2="160.02" y2="119.38" width="0.1524" layer="91"/>
<pinref part="U$31" gate="G$1" pin="+3.3V"/>
<pinref part="C23" gate="G$1" pin="2"/>
<wire x1="160.02" y1="114.3" x2="160.02" y2="116.84" width="0.1524" layer="91"/>
<junction x="160.02" y="116.84"/>
</segment>
<segment>
<pinref part="R43" gate="G$1" pin="1"/>
<wire x1="96.52" y1="104.14" x2="93.98" y2="104.14" width="0.1524" layer="91"/>
<wire x1="93.98" y1="104.14" x2="93.98" y2="96.52" width="0.1524" layer="91"/>
<pinref part="R44" gate="G$1" pin="1"/>
<wire x1="93.98" y1="96.52" x2="96.52" y2="96.52" width="0.1524" layer="91"/>
<wire x1="93.98" y1="96.52" x2="88.9" y2="96.52" width="0.1524" layer="91"/>
<junction x="93.98" y="96.52"/>
<wire x1="88.9" y1="96.52" x2="88.9" y2="99.06" width="0.1524" layer="91"/>
<pinref part="U$32" gate="G$1" pin="+3.3V"/>
</segment>
<segment>
<pinref part="R46" gate="G$1" pin="1"/>
<pinref part="U$38" gate="G$1" pin="+3.3V"/>
</segment>
<segment>
<pinref part="C70" gate="G$1" pin="2"/>
<pinref part="U$35" gate="G$1" pin="+3.3V"/>
<wire x1="73.66" y1="68.58" x2="73.66" y2="71.12" width="0.1524" layer="91"/>
<pinref part="U2" gate="_" pin="VOUT"/>
<wire x1="73.66" y1="71.12" x2="73.66" y2="73.66" width="0.1524" layer="91"/>
<wire x1="66.04" y1="71.12" x2="73.66" y2="71.12" width="0.1524" layer="91"/>
<junction x="73.66" y="71.12"/>
</segment>
<segment>
<pinref part="U$36" gate="G$1" pin="+3.3V"/>
<pinref part="R34" gate="G$1" pin="1"/>
<wire x1="12.7" y1="180.34" x2="12.7" y2="177.8" width="0.1524" layer="91"/>
<wire x1="12.7" y1="177.8" x2="12.7" y2="175.26" width="0.1524" layer="91"/>
<wire x1="12.7" y1="177.8" x2="20.32" y2="177.8" width="0.1524" layer="91"/>
<junction x="12.7" y="177.8"/>
<pinref part="R35" gate="G$1" pin="1"/>
<wire x1="20.32" y1="177.8" x2="20.32" y2="175.26" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C4" gate="G$1" pin="2"/>
<pinref part="U$43" gate="G$1" pin="+3.3V"/>
</segment>
<segment>
<pinref part="U$25" gate="G$1" pin="+3.3V"/>
<wire x1="198.12" y1="48.26" x2="198.12" y2="45.72" width="0.1524" layer="91"/>
<wire x1="198.12" y1="45.72" x2="203.2" y2="45.72" width="0.1524" layer="91"/>
<wire x1="205.74" y1="50.8" x2="203.2" y2="50.8" width="0.1524" layer="91"/>
<wire x1="203.2" y1="50.8" x2="203.2" y2="48.26" width="0.1524" layer="91"/>
<wire x1="203.2" y1="48.26" x2="205.74" y2="48.26" width="0.1524" layer="91"/>
<wire x1="203.2" y1="45.72" x2="203.2" y2="48.26" width="0.1524" layer="91"/>
<junction x="203.2" y="48.26"/>
<pinref part="U6" gate="_" pin="VCCB@1"/>
<pinref part="U6" gate="_" pin="VCCB@2"/>
</segment>
<segment>
<pinref part="R25" gate="G$1" pin="2"/>
<wire x1="345.44" y1="259.08" x2="345.44" y2="261.62" width="0.1524" layer="91"/>
<wire x1="345.44" y1="261.62" x2="355.6" y2="261.62" width="0.1524" layer="91"/>
<pinref part="Q1" gate="_" pin="C"/>
<wire x1="355.6" y1="261.62" x2="355.6" y2="251.46" width="0.1524" layer="91"/>
<wire x1="355.6" y1="261.62" x2="355.6" y2="264.16" width="0.1524" layer="91"/>
<junction x="355.6" y="261.62"/>
<pinref part="U$4" gate="G$1" pin="+3.3V"/>
<pinref part="C2" gate="G$1" pin="1"/>
<wire x1="358.14" y1="261.62" x2="355.6" y2="261.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="R41" gate="G$1" pin="1"/>
<pinref part="R40" gate="G$1" pin="2"/>
<wire x1="127" y1="167.64" x2="121.92" y2="167.64" width="0.1524" layer="91"/>
<pinref part="C16" gate="G$1" pin="2"/>
<wire x1="121.92" y1="167.64" x2="111.76" y2="167.64" width="0.1524" layer="91"/>
<wire x1="111.76" y1="167.64" x2="106.68" y2="167.64" width="0.1524" layer="91"/>
<wire x1="111.76" y1="165.1" x2="111.76" y2="167.64" width="0.1524" layer="91"/>
<junction x="111.76" y="167.64"/>
<pinref part="C17" gate="G$1" pin="2"/>
<wire x1="121.92" y1="165.1" x2="121.92" y2="167.64" width="0.1524" layer="91"/>
<junction x="121.92" y="167.64"/>
</segment>
</net>
<net name="+1.2V" class="0">
<segment>
<pinref part="R41" gate="G$1" pin="2"/>
<wire x1="137.16" y1="167.64" x2="152.4" y2="167.64" width="0.1524" layer="91"/>
<wire x1="152.4" y1="167.64" x2="152.4" y2="190.5" width="0.1524" layer="91"/>
<pinref part="U1" gate="_" pin="VCC@2"/>
<pinref part="U1" gate="_" pin="VCC@1"/>
<wire x1="88.9" y1="200.66" x2="86.36" y2="200.66" width="0.1524" layer="91"/>
<wire x1="96.52" y1="203.2" x2="88.9" y2="203.2" width="0.1524" layer="91"/>
<wire x1="88.9" y1="203.2" x2="86.36" y2="203.2" width="0.1524" layer="91"/>
<wire x1="88.9" y1="200.66" x2="88.9" y2="203.2" width="0.1524" layer="91"/>
<junction x="88.9" y="203.2"/>
<wire x1="96.52" y1="203.2" x2="96.52" y2="190.5" width="0.1524" layer="91"/>
<wire x1="96.52" y1="190.5" x2="101.6" y2="190.5" width="0.1524" layer="91"/>
<pinref part="C15" gate="G$1" pin="2"/>
<wire x1="101.6" y1="190.5" x2="111.76" y2="190.5" width="0.1524" layer="91"/>
<wire x1="111.76" y1="190.5" x2="121.92" y2="190.5" width="0.1524" layer="91"/>
<wire x1="121.92" y1="190.5" x2="132.08" y2="190.5" width="0.1524" layer="91"/>
<wire x1="132.08" y1="190.5" x2="132.08" y2="187.96" width="0.1524" layer="91"/>
<pinref part="C14" gate="G$1" pin="2"/>
<wire x1="121.92" y1="187.96" x2="121.92" y2="190.5" width="0.1524" layer="91"/>
<junction x="121.92" y="190.5"/>
<pinref part="C13" gate="G$1" pin="2"/>
<wire x1="111.76" y1="187.96" x2="111.76" y2="190.5" width="0.1524" layer="91"/>
<junction x="111.76" y="190.5"/>
<pinref part="C12" gate="G$1" pin="2"/>
<wire x1="101.6" y1="187.96" x2="101.6" y2="190.5" width="0.1524" layer="91"/>
<junction x="101.6" y="190.5"/>
<wire x1="152.4" y1="190.5" x2="132.08" y2="190.5" width="0.1524" layer="91"/>
<junction x="132.08" y="190.5"/>
<pinref part="U$20" gate="G$1" pin="+1.2V"/>
<wire x1="152.4" y1="193.04" x2="152.4" y2="190.5" width="0.1524" layer="91"/>
<junction x="152.4" y="190.5"/>
</segment>
<segment>
<wire x1="154.94" y1="68.58" x2="154.94" y2="71.12" width="0.1524" layer="91"/>
<wire x1="154.94" y1="71.12" x2="152.4" y2="71.12" width="0.1524" layer="91"/>
<wire x1="154.94" y1="71.12" x2="165.1" y2="71.12" width="0.1524" layer="91"/>
<wire x1="165.1" y1="68.58" x2="165.1" y2="71.12" width="0.1524" layer="91"/>
<junction x="154.94" y="71.12"/>
<pinref part="R13" gate="G$1" pin="2"/>
<pinref part="L1" gate="G$1" pin="2"/>
<pinref part="C26" gate="G$1" pin="2"/>
<pinref part="U$14" gate="G$1" pin="+1.2V"/>
<wire x1="165.1" y1="71.12" x2="165.1" y2="73.66" width="0.1524" layer="91"/>
<junction x="165.1" y="71.12"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="R43" gate="G$1" pin="2"/>
<wire x1="106.68" y1="104.14" x2="109.22" y2="104.14" width="0.1524" layer="91"/>
<wire x1="109.22" y1="104.14" x2="109.22" y2="106.68" width="0.1524" layer="91"/>
<pinref part="U4" gate="_" pin="DQ2/WP#"/>
<wire x1="109.22" y1="106.68" x2="114.3" y2="106.68" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$19" class="0">
<segment>
<pinref part="R44" gate="G$1" pin="2"/>
<wire x1="106.68" y1="96.52" x2="111.76" y2="96.52" width="0.1524" layer="91"/>
<wire x1="111.76" y1="96.52" x2="111.76" y2="104.14" width="0.1524" layer="91"/>
<pinref part="U4" gate="_" pin="DQ3/HOLD#"/>
<wire x1="111.76" y1="104.14" x2="114.3" y2="104.14" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<wire x1="134.62" y1="60.96" x2="137.16" y2="60.96" width="0.1524" layer="91"/>
<wire x1="137.16" y1="60.96" x2="137.16" y2="55.88" width="0.1524" layer="91"/>
<wire x1="137.16" y1="55.88" x2="154.94" y2="55.88" width="0.1524" layer="91"/>
<wire x1="154.94" y1="55.88" x2="154.94" y2="58.42" width="0.1524" layer="91"/>
<wire x1="154.94" y1="55.88" x2="154.94" y2="53.34" width="0.1524" layer="91"/>
<junction x="154.94" y="55.88"/>
<pinref part="U8" gate="_" pin="FB"/>
<pinref part="R13" gate="G$1" pin="1"/>
<pinref part="R45" gate="G$1" pin="2"/>
</segment>
</net>
<net name="N$20" class="0">
<segment>
<wire x1="137.16" y1="71.12" x2="134.62" y2="71.12" width="0.1524" layer="91"/>
<pinref part="U8" gate="_" pin="LX"/>
<pinref part="L1" gate="G$1" pin="1"/>
</segment>
</net>
<net name="BUS_D1" class="0">
<segment>
<wire x1="111.76" y1="259.08" x2="86.36" y2="259.08" width="0.1524" layer="91"/>
<label x="88.9" y="259.08" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_39A"/>
</segment>
<segment>
<wire x1="205.74" y1="71.12" x2="182.88" y2="71.12" width="0.1524" layer="91"/>
<label x="185.42" y="71.12" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B6"/>
</segment>
</net>
<net name="VGA_G" class="0">
<segment>
<pinref part="R11" gate="G$1" pin="2"/>
<wire x1="210.82" y1="233.68" x2="213.36" y2="233.68" width="0.1524" layer="91"/>
<pinref part="R12" gate="G$1" pin="2"/>
<wire x1="210.82" y1="226.06" x2="213.36" y2="226.06" width="0.1524" layer="91"/>
<wire x1="213.36" y1="226.06" x2="213.36" y2="233.68" width="0.1524" layer="91"/>
<junction x="213.36" y="226.06"/>
<wire x1="213.36" y1="218.44" x2="213.36" y2="226.06" width="0.1524" layer="91"/>
<pinref part="R17" gate="G$1" pin="2"/>
<wire x1="210.82" y1="218.44" x2="213.36" y2="218.44" width="0.1524" layer="91"/>
<junction x="213.36" y="233.68"/>
<pinref part="R18" gate="G$1" pin="2"/>
<wire x1="215.9" y1="233.68" x2="213.36" y2="233.68" width="0.1524" layer="91"/>
<wire x1="210.82" y1="210.82" x2="213.36" y2="210.82" width="0.1524" layer="91"/>
<wire x1="213.36" y1="210.82" x2="213.36" y2="218.44" width="0.1524" layer="91"/>
<junction x="213.36" y="218.44"/>
<wire x1="241.3" y1="261.62" x2="215.9" y2="261.62" width="0.1524" layer="91"/>
<wire x1="215.9" y1="261.62" x2="215.9" y2="233.68" width="0.1524" layer="91"/>
<label x="226.06" y="261.62" size="1.778" layer="95"/>
<pinref part="J1" gate="_" pin="GREEN"/>
</segment>
</net>
<net name="BUS_D3_5V" class="0">
<segment>
<wire x1="233.68" y1="66.04" x2="256.54" y2="66.04" width="0.1524" layer="91"/>
<label x="236.22" y="66.04" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A4"/>
</segment>
<segment>
<wire x1="302.26" y1="177.8" x2="279.4" y2="177.8" width="0.1524" layer="91"/>
<label x="281.94" y="177.8" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="7"/>
</segment>
<segment>
<wire x1="274.32" y1="101.6" x2="297.18" y2="101.6" width="0.1524" layer="91"/>
<label x="276.86" y="101.6" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="D3"/>
</segment>
</net>
<net name="BUS_D4_5V" class="0">
<segment>
<wire x1="233.68" y1="63.5" x2="256.54" y2="63.5" width="0.1524" layer="91"/>
<label x="236.22" y="63.5" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A3"/>
</segment>
<segment>
<wire x1="327.66" y1="180.34" x2="350.52" y2="180.34" width="0.1524" layer="91"/>
<label x="330.2" y="180.34" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="6"/>
</segment>
<segment>
<wire x1="274.32" y1="104.14" x2="297.18" y2="104.14" width="0.1524" layer="91"/>
<label x="276.86" y="104.14" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="D4"/>
</segment>
</net>
<net name="BUS_D5_5V" class="0">
<segment>
<wire x1="233.68" y1="60.96" x2="256.54" y2="60.96" width="0.1524" layer="91"/>
<label x="236.22" y="60.96" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A2"/>
</segment>
<segment>
<wire x1="302.26" y1="180.34" x2="279.4" y2="180.34" width="0.1524" layer="91"/>
<label x="281.94" y="180.34" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="5"/>
</segment>
<segment>
<wire x1="274.32" y1="106.68" x2="297.18" y2="106.68" width="0.1524" layer="91"/>
<label x="276.86" y="106.68" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="D5"/>
</segment>
</net>
<net name="BUS_D6_5V" class="0">
<segment>
<wire x1="233.68" y1="58.42" x2="256.54" y2="58.42" width="0.1524" layer="91"/>
<label x="236.22" y="58.42" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A1"/>
</segment>
<segment>
<wire x1="327.66" y1="182.88" x2="350.52" y2="182.88" width="0.1524" layer="91"/>
<label x="330.2" y="182.88" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="4"/>
</segment>
<segment>
<wire x1="274.32" y1="109.22" x2="297.18" y2="109.22" width="0.1524" layer="91"/>
<label x="276.86" y="109.22" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="D6"/>
</segment>
</net>
<net name="BUS_D7_5V" class="0">
<segment>
<wire x1="233.68" y1="55.88" x2="256.54" y2="55.88" width="0.1524" layer="91"/>
<label x="236.22" y="55.88" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A0"/>
</segment>
<segment>
<wire x1="302.26" y1="182.88" x2="279.4" y2="182.88" width="0.1524" layer="91"/>
<label x="281.94" y="182.88" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="3"/>
</segment>
<segment>
<wire x1="274.32" y1="111.76" x2="297.18" y2="111.76" width="0.1524" layer="91"/>
<label x="276.86" y="111.76" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="D7"/>
</segment>
</net>
<net name="BUS_IRQ#_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B1"/>
<wire x1="233.68" y1="144.78" x2="256.54" y2="144.78" width="0.1524" layer="91"/>
<label x="236.22" y="144.78" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="302.26" y1="162.56" x2="279.4" y2="162.56" width="0.1524" layer="91"/>
<label x="281.94" y="162.56" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="19"/>
</segment>
<segment>
<wire x1="274.32" y1="137.16" x2="297.18" y2="137.16" width="0.1524" layer="91"/>
<label x="276.86" y="137.16" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="!IRQ"/>
</segment>
</net>
<net name="BUS_CS#_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B9"/>
<wire x1="233.68" y1="124.46" x2="256.54" y2="124.46" width="0.1524" layer="91"/>
<label x="236.22" y="124.46" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="302.26" y1="172.72" x2="279.4" y2="172.72" width="0.1524" layer="91"/>
<label x="281.94" y="172.72" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="11"/>
</segment>
<segment>
<wire x1="274.32" y1="129.54" x2="297.18" y2="129.54" width="0.1524" layer="91"/>
<label x="276.86" y="129.54" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="I/O1"/>
</segment>
</net>
<net name="BUS_RW#_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B8"/>
<wire x1="256.54" y1="127" x2="233.68" y2="127" width="0.1524" layer="91"/>
<label x="236.22" y="127" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U9" gate="_" pin="A"/>
<wire x1="205.74" y1="101.6" x2="182.88" y2="101.6" width="0.1524" layer="91"/>
<label x="185.42" y="101.6" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="327.66" y1="172.72" x2="350.52" y2="172.72" width="0.1524" layer="91"/>
<label x="330.2" y="172.72" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="12"/>
</segment>
<segment>
<wire x1="297.18" y1="134.62" x2="274.32" y2="134.62" width="0.1524" layer="91"/>
<label x="276.86" y="134.62" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="R/!W"/>
</segment>
</net>
<net name="BUS_PHY2_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B4"/>
<wire x1="256.54" y1="137.16" x2="233.68" y2="137.16" width="0.1524" layer="91"/>
<label x="236.22" y="137.16" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="327.66" y1="167.64" x2="350.52" y2="167.64" width="0.1524" layer="91"/>
<label x="330.2" y="167.64" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="16"/>
</segment>
<segment>
<wire x1="355.6" y1="134.62" x2="332.74" y2="134.62" width="0.1524" layer="91"/>
<label x="335.28" y="134.62" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="S02"/>
</segment>
</net>
<net name="BUS_A0_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B5"/>
<wire x1="233.68" y1="134.62" x2="256.54" y2="134.62" width="0.1524" layer="91"/>
<label x="236.22" y="134.62" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="302.26" y1="167.64" x2="279.4" y2="167.64" width="0.1524" layer="91"/>
<label x="281.94" y="167.64" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="15"/>
</segment>
<segment>
<wire x1="332.74" y1="93.98" x2="355.6" y2="93.98" width="0.1524" layer="91"/>
<label x="335.28" y="93.98" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="A0"/>
</segment>
</net>
<net name="BUS_A1_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B6"/>
<wire x1="256.54" y1="132.08" x2="233.68" y2="132.08" width="0.1524" layer="91"/>
<label x="236.22" y="132.08" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="327.66" y1="170.18" x2="350.52" y2="170.18" width="0.1524" layer="91"/>
<label x="330.2" y="170.18" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="14"/>
</segment>
<segment>
<wire x1="355.6" y1="96.52" x2="332.74" y2="96.52" width="0.1524" layer="91"/>
<label x="335.28" y="96.52" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="A1"/>
</segment>
</net>
<net name="BUS_A2_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B7"/>
<wire x1="233.68" y1="129.54" x2="256.54" y2="129.54" width="0.1524" layer="91"/>
<label x="236.22" y="129.54" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="302.26" y1="170.18" x2="279.4" y2="170.18" width="0.1524" layer="91"/>
<label x="281.94" y="170.18" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="13"/>
</segment>
<segment>
<wire x1="332.74" y1="99.06" x2="355.6" y2="99.06" width="0.1524" layer="91"/>
<label x="335.28" y="99.06" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="A2"/>
</segment>
</net>
<net name="BUS_D0_5V" class="0">
<segment>
<wire x1="233.68" y1="73.66" x2="256.54" y2="73.66" width="0.1524" layer="91"/>
<pinref part="U6" gate="_" pin="A7"/>
<label x="236.22" y="73.66" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="327.66" y1="175.26" x2="350.52" y2="175.26" width="0.1524" layer="91"/>
<label x="330.2" y="175.26" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="10"/>
</segment>
<segment>
<wire x1="274.32" y1="93.98" x2="297.18" y2="93.98" width="0.1524" layer="91"/>
<label x="276.86" y="93.98" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="D0"/>
</segment>
</net>
<net name="BUS_D1_5V" class="0">
<segment>
<wire x1="233.68" y1="71.12" x2="256.54" y2="71.12" width="0.1524" layer="91"/>
<label x="236.22" y="71.12" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A6"/>
</segment>
<segment>
<wire x1="302.26" y1="175.26" x2="279.4" y2="175.26" width="0.1524" layer="91"/>
<label x="281.94" y="175.26" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="9"/>
</segment>
<segment>
<wire x1="274.32" y1="96.52" x2="297.18" y2="96.52" width="0.1524" layer="91"/>
<label x="276.86" y="96.52" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="D1"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="U6" gate="_" pin="DIR"/>
<wire x1="233.68" y1="83.82" x2="246.38" y2="83.82" width="0.1524" layer="91"/>
<wire x1="246.38" y1="83.82" x2="246.38" y2="101.6" width="0.1524" layer="91"/>
<wire x1="246.38" y1="101.6" x2="231.14" y2="101.6" width="0.1524" layer="91"/>
<pinref part="U9" gate="_" pin="Y"/>
</segment>
</net>
<net name="BUS_D2_5V" class="0">
<segment>
<wire x1="233.68" y1="68.58" x2="256.54" y2="68.58" width="0.1524" layer="91"/>
<label x="236.22" y="68.58" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A5"/>
</segment>
<segment>
<wire x1="327.66" y1="177.8" x2="350.52" y2="177.8" width="0.1524" layer="91"/>
<label x="330.2" y="177.8" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="8"/>
</segment>
<segment>
<wire x1="274.32" y1="99.06" x2="297.18" y2="99.06" width="0.1524" layer="91"/>
<label x="276.86" y="99.06" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="D2"/>
</segment>
</net>
<net name="BUS_RES#_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B2"/>
<wire x1="233.68" y1="142.24" x2="256.54" y2="142.24" width="0.1524" layer="91"/>
<label x="236.22" y="142.24" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="327.66" y1="165.1" x2="350.52" y2="165.1" width="0.1524" layer="91"/>
<label x="330.2" y="165.1" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="18"/>
</segment>
<segment>
<wire x1="332.74" y1="139.7" x2="355.6" y2="139.7" width="0.1524" layer="91"/>
<label x="335.28" y="139.7" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="!RESET"/>
</segment>
</net>
<net name="BUS_RDY" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_50B"/>
<wire x1="111.76" y1="236.22" x2="86.36" y2="236.22" width="0.1524" layer="91"/>
<label x="88.9" y="236.22" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="205.74" y1="139.7" x2="182.88" y2="139.7" width="0.1524" layer="91"/>
<label x="185.42" y="139.7" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A3"/>
</segment>
</net>
<net name="BUS_RDY_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B3"/>
<wire x1="233.68" y1="139.7" x2="256.54" y2="139.7" width="0.1524" layer="91"/>
<label x="236.22" y="139.7" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="302.26" y1="165.1" x2="279.4" y2="165.1" width="0.1524" layer="91"/>
<label x="281.94" y="165.1" size="1.778" layer="95"/>
<pinref part="J5" gate="_" pin="17"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<wire x1="307.34" y1="241.3" x2="304.8" y2="241.3" width="0.1524" layer="91"/>
<pinref part="R1" gate="G$1" pin="1A"/>
<pinref part="R3" gate="G$1" pin="1B"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<wire x1="307.34" y1="238.76" x2="304.8" y2="238.76" width="0.1524" layer="91"/>
<pinref part="R1" gate="G$1" pin="2A"/>
<pinref part="R3" gate="G$1" pin="2B"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<wire x1="307.34" y1="236.22" x2="304.8" y2="236.22" width="0.1524" layer="91"/>
<pinref part="R1" gate="G$1" pin="3A"/>
<pinref part="R3" gate="G$1" pin="3B"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<wire x1="307.34" y1="233.68" x2="304.8" y2="233.68" width="0.1524" layer="91"/>
<pinref part="R1" gate="G$1" pin="4A"/>
<pinref part="R3" gate="G$1" pin="4B"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<wire x1="307.34" y1="223.52" x2="304.8" y2="223.52" width="0.1524" layer="91"/>
<pinref part="R2" gate="G$1" pin="1A"/>
<pinref part="R7" gate="G$1" pin="1B"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<wire x1="307.34" y1="220.98" x2="304.8" y2="220.98" width="0.1524" layer="91"/>
<pinref part="R2" gate="G$1" pin="2A"/>
<pinref part="R7" gate="G$1" pin="2B"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<wire x1="307.34" y1="218.44" x2="304.8" y2="218.44" width="0.1524" layer="91"/>
<pinref part="R2" gate="G$1" pin="3A"/>
<pinref part="R7" gate="G$1" pin="3B"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<wire x1="307.34" y1="215.9" x2="304.8" y2="215.9" width="0.1524" layer="91"/>
<pinref part="R2" gate="G$1" pin="4A"/>
<pinref part="R7" gate="G$1" pin="4B"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<wire x1="322.58" y1="241.3" x2="320.04" y2="241.3" width="0.1524" layer="91"/>
<wire x1="320.04" y1="241.3" x2="317.5" y2="241.3" width="0.1524" layer="91"/>
<wire x1="320.04" y1="241.3" x2="320.04" y2="246.38" width="0.1524" layer="91"/>
<junction x="320.04" y="241.3"/>
<wire x1="320.04" y1="246.38" x2="345.44" y2="246.38" width="0.1524" layer="91"/>
<pinref part="Q1" gate="_" pin="B"/>
<pinref part="R25" gate="G$1" pin="1"/>
<wire x1="345.44" y1="246.38" x2="350.52" y2="246.38" width="0.1524" layer="91"/>
<wire x1="345.44" y1="248.92" x2="345.44" y2="246.38" width="0.1524" layer="91"/>
<junction x="345.44" y="246.38"/>
<pinref part="C1" gate="G$1" pin="2"/>
<wire x1="345.44" y1="243.84" x2="345.44" y2="246.38" width="0.1524" layer="91"/>
<pinref part="R3" gate="G$1" pin="1A"/>
<pinref part="R14" gate="G$1" pin="1B"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<wire x1="322.58" y1="238.76" x2="320.04" y2="238.76" width="0.1524" layer="91"/>
<wire x1="320.04" y1="238.76" x2="317.5" y2="238.76" width="0.1524" layer="91"/>
<wire x1="332.74" y1="241.3" x2="335.28" y2="241.3" width="0.1524" layer="91"/>
<wire x1="335.28" y1="241.3" x2="335.28" y2="240.03" width="0.1524" layer="91"/>
<wire x1="335.28" y1="240.03" x2="320.04" y2="240.03" width="0.1524" layer="91"/>
<wire x1="320.04" y1="240.03" x2="320.04" y2="238.76" width="0.1524" layer="91"/>
<junction x="320.04" y="238.76"/>
<pinref part="R3" gate="G$1" pin="2A"/>
<pinref part="R14" gate="G$1" pin="1A"/>
<pinref part="R14" gate="G$1" pin="2B"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<wire x1="322.58" y1="236.22" x2="320.04" y2="236.22" width="0.1524" layer="91"/>
<wire x1="320.04" y1="236.22" x2="317.5" y2="236.22" width="0.1524" layer="91"/>
<wire x1="332.74" y1="238.76" x2="335.28" y2="238.76" width="0.1524" layer="91"/>
<wire x1="335.28" y1="238.76" x2="335.28" y2="237.49" width="0.1524" layer="91"/>
<wire x1="335.28" y1="237.49" x2="320.04" y2="237.49" width="0.1524" layer="91"/>
<wire x1="320.04" y1="237.49" x2="320.04" y2="236.22" width="0.1524" layer="91"/>
<junction x="320.04" y="236.22"/>
<pinref part="R3" gate="G$1" pin="3A"/>
<pinref part="R14" gate="G$1" pin="2A"/>
<pinref part="R14" gate="G$1" pin="3B"/>
</segment>
</net>
<net name="N$17" class="0">
<segment>
<wire x1="322.58" y1="233.68" x2="320.04" y2="233.68" width="0.1524" layer="91"/>
<wire x1="320.04" y1="233.68" x2="317.5" y2="233.68" width="0.1524" layer="91"/>
<wire x1="332.74" y1="236.22" x2="335.28" y2="236.22" width="0.1524" layer="91"/>
<wire x1="335.28" y1="236.22" x2="335.28" y2="234.95" width="0.1524" layer="91"/>
<wire x1="335.28" y1="234.95" x2="320.04" y2="234.95" width="0.1524" layer="91"/>
<wire x1="320.04" y1="234.95" x2="320.04" y2="233.68" width="0.1524" layer="91"/>
<junction x="320.04" y="233.68"/>
<pinref part="R3" gate="G$1" pin="4A"/>
<pinref part="R14" gate="G$1" pin="3A"/>
<pinref part="R14" gate="G$1" pin="4B"/>
</segment>
</net>
<net name="N$18" class="0">
<segment>
<wire x1="322.58" y1="223.52" x2="320.04" y2="223.52" width="0.1524" layer="91"/>
<wire x1="320.04" y1="223.52" x2="317.5" y2="223.52" width="0.1524" layer="91"/>
<wire x1="332.74" y1="233.68" x2="335.28" y2="233.68" width="0.1524" layer="91"/>
<wire x1="335.28" y1="233.68" x2="335.28" y2="228.6" width="0.1524" layer="91"/>
<wire x1="335.28" y1="228.6" x2="320.04" y2="228.6" width="0.1524" layer="91"/>
<wire x1="320.04" y1="228.6" x2="320.04" y2="223.52" width="0.1524" layer="91"/>
<junction x="320.04" y="223.52"/>
<pinref part="R7" gate="G$1" pin="1A"/>
<pinref part="R14" gate="G$1" pin="4A"/>
<pinref part="R15" gate="G$1" pin="1B"/>
</segment>
</net>
<net name="N$21" class="0">
<segment>
<wire x1="322.58" y1="220.98" x2="320.04" y2="220.98" width="0.1524" layer="91"/>
<wire x1="320.04" y1="220.98" x2="317.5" y2="220.98" width="0.1524" layer="91"/>
<wire x1="332.74" y1="223.52" x2="335.28" y2="223.52" width="0.1524" layer="91"/>
<wire x1="335.28" y1="223.52" x2="335.28" y2="222.25" width="0.1524" layer="91"/>
<wire x1="335.28" y1="222.25" x2="320.04" y2="222.25" width="0.1524" layer="91"/>
<wire x1="320.04" y1="222.25" x2="320.04" y2="220.98" width="0.1524" layer="91"/>
<junction x="320.04" y="220.98"/>
<pinref part="R7" gate="G$1" pin="2A"/>
<pinref part="R15" gate="G$1" pin="1A"/>
<pinref part="R15" gate="G$1" pin="2B"/>
</segment>
</net>
<net name="N$22" class="0">
<segment>
<wire x1="322.58" y1="218.44" x2="320.04" y2="218.44" width="0.1524" layer="91"/>
<wire x1="320.04" y1="218.44" x2="317.5" y2="218.44" width="0.1524" layer="91"/>
<wire x1="332.74" y1="220.98" x2="335.28" y2="220.98" width="0.1524" layer="91"/>
<wire x1="335.28" y1="220.98" x2="335.28" y2="219.71" width="0.1524" layer="91"/>
<wire x1="335.28" y1="219.71" x2="320.04" y2="219.71" width="0.1524" layer="91"/>
<wire x1="320.04" y1="219.71" x2="320.04" y2="218.44" width="0.1524" layer="91"/>
<junction x="320.04" y="218.44"/>
<pinref part="R7" gate="G$1" pin="3A"/>
<pinref part="R15" gate="G$1" pin="2A"/>
<pinref part="R15" gate="G$1" pin="3B"/>
</segment>
</net>
<net name="N$29" class="0">
<segment>
<pinref part="R16" gate="G$1" pin="1"/>
<wire x1="332.74" y1="215.9" x2="335.28" y2="215.9" width="0.1524" layer="91"/>
<pinref part="R15" gate="G$1" pin="4A"/>
</segment>
</net>
<net name="N$25" class="0">
<segment>
<wire x1="332.74" y1="218.44" x2="335.28" y2="218.44" width="0.1524" layer="91"/>
<wire x1="335.28" y1="218.44" x2="335.28" y2="217.17" width="0.1524" layer="91"/>
<wire x1="335.28" y1="217.17" x2="320.04" y2="217.17" width="0.1524" layer="91"/>
<wire x1="322.58" y1="215.9" x2="320.04" y2="215.9" width="0.1524" layer="91"/>
<wire x1="320.04" y1="215.9" x2="317.5" y2="215.9" width="0.1524" layer="91"/>
<wire x1="320.04" y1="217.17" x2="320.04" y2="215.9" width="0.1524" layer="91"/>
<junction x="320.04" y="215.9"/>
<pinref part="R7" gate="G$1" pin="4A"/>
<pinref part="R15" gate="G$1" pin="3A"/>
<pinref part="R15" gate="G$1" pin="4B"/>
</segment>
</net>
<net name="N$26" class="0">
<segment>
<pinref part="Q1" gate="_" pin="E"/>
<pinref part="R26" gate="G$1" pin="2"/>
</segment>
</net>
<net name="COMPOSITE" class="0">
<segment>
<pinref part="R26" gate="G$1" pin="1"/>
<pinref part="R27" gate="G$1" pin="2"/>
<wire x1="355.6" y1="231.14" x2="355.6" y2="228.6" width="0.1524" layer="91"/>
<wire x1="355.6" y1="228.6" x2="355.6" y2="226.06" width="0.1524" layer="91"/>
<wire x1="355.6" y1="228.6" x2="373.38" y2="228.6" width="0.1524" layer="91"/>
<junction x="355.6" y="228.6"/>
<label x="358.14" y="228.6" size="1.778" layer="95"/>
<pinref part="J2" gate="_" pin="S"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="U2" gate="_" pin="EN"/>
<wire x1="35.56" y1="68.58" x2="33.02" y2="68.58" width="0.1524" layer="91"/>
<wire x1="33.02" y1="68.58" x2="33.02" y2="71.12" width="0.1524" layer="91"/>
<pinref part="U2" gate="_" pin="VIN"/>
<wire x1="33.02" y1="71.12" x2="35.56" y2="71.12" width="0.1524" layer="91"/>
<wire x1="22.86" y1="71.12" x2="20.32" y2="71.12" width="0.1524" layer="91"/>
<wire x1="22.86" y1="68.58" x2="22.86" y2="71.12" width="0.1524" layer="91"/>
<pinref part="C69" gate="G$1" pin="2"/>
<pinref part="R28" gate="G$1" pin="2"/>
<wire x1="33.02" y1="71.12" x2="22.86" y2="71.12" width="0.1524" layer="91"/>
<junction x="33.02" y="71.12"/>
<junction x="22.86" y="71.12"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
