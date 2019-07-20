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
<package name="TSSOP-20">
<description>20 pins, 4.4x6.5 mm, 0.65 mm pitch</description>
<wire x1="-1.9" y1="-3.25" x2="-1.9" y2="2.25" width="0.2" layer="21"/>
<wire x1="-1.9" y1="2.25" x2="-1.9" y2="3.25" width="0.2" layer="21"/>
<wire x1="1.9" y1="-3.25" x2="1.9" y2="3.25" width="0.2" layer="21"/>
<wire x1="-1.9" y1="3.25" x2="-0.9" y2="3.25" width="0.2" layer="21"/>
<wire x1="-0.9" y1="3.25" x2="1.9" y2="3.25" width="0.2" layer="21"/>
<wire x1="-1.9" y1="-3.25" x2="1.9" y2="-3.25" width="0.2" layer="21"/>
<wire x1="-1.9" y1="2.25" x2="-0.9" y2="3.25" width="0.2" layer="21"/>
<wire x1="-2.2" y1="3.025" x2="-2.2" y2="3.25" width="0.1" layer="51"/>
<wire x1="-2.2" y1="3.25" x2="-1.2" y2="3.25" width="0.1" layer="51"/>
<wire x1="-1.2" y1="3.25" x2="2.2" y2="3.25" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-3.25" x2="2.2" y2="-3.25" width="0.1" layer="51"/>
<wire x1="-2.2" y1="2.25" x2="-1.2" y2="3.25" width="0.1" layer="51"/>
<wire x1="-3.15" y1="2.825" x2="-3.15" y2="3.025" width="0.1" layer="51"/>
<wire x1="-2.2" y1="2.25" x2="-2.2" y2="2.375" width="0.1" layer="51"/>
<wire x1="-2.2" y1="2.375" x2="-2.2" y2="2.825" width="0.1" layer="51"/>
<wire x1="-2.2" y1="2.825" x2="-2.2" y2="3.025" width="0.1" layer="51"/>
<wire x1="-3.15" y1="3.025" x2="-2.2" y2="3.025" width="0.1" layer="51"/>
<wire x1="-3.15" y1="2.825" x2="-2.2" y2="2.825" width="0.1" layer="51"/>
<wire x1="2.2" y1="-3.25" x2="2.2" y2="-3.025" width="0.1" layer="51"/>
<wire x1="2.2" y1="-3.025" x2="2.2" y2="-2.825" width="0.1" layer="51"/>
<wire x1="3.15" y1="-3.025" x2="3.15" y2="-2.825" width="0.1" layer="51"/>
<wire x1="2.2" y1="-2.825" x2="3.15" y2="-2.825" width="0.1" layer="51"/>
<wire x1="2.2" y1="-3.025" x2="3.15" y2="-3.025" width="0.1" layer="51"/>
<wire x1="-3.15" y1="2.175" x2="-3.15" y2="2.375" width="0.1" layer="51"/>
<wire x1="-2.2" y1="1.725" x2="-2.2" y2="2.175" width="0.1" layer="51"/>
<wire x1="-2.2" y1="2.175" x2="-2.2" y2="2.25" width="0.1" layer="51"/>
<wire x1="-3.15" y1="2.375" x2="-2.2" y2="2.375" width="0.1" layer="51"/>
<wire x1="-3.15" y1="2.175" x2="-2.2" y2="2.175" width="0.1" layer="51"/>
<wire x1="2.2" y1="-2.825" x2="2.2" y2="-2.375" width="0.1" layer="51"/>
<wire x1="2.2" y1="-2.375" x2="2.2" y2="-2.175" width="0.1" layer="51"/>
<wire x1="3.15" y1="-2.375" x2="3.15" y2="-2.175" width="0.1" layer="51"/>
<wire x1="2.2" y1="-2.175" x2="3.15" y2="-2.175" width="0.1" layer="51"/>
<wire x1="2.2" y1="-2.375" x2="3.15" y2="-2.375" width="0.1" layer="51"/>
<wire x1="-3.15" y1="1.525" x2="-3.15" y2="1.725" width="0.1" layer="51"/>
<wire x1="-2.2" y1="1.075" x2="-2.2" y2="1.525" width="0.1" layer="51"/>
<wire x1="-2.2" y1="1.525" x2="-2.2" y2="1.725" width="0.1" layer="51"/>
<wire x1="-3.15" y1="1.725" x2="-2.2" y2="1.725" width="0.1" layer="51"/>
<wire x1="-3.15" y1="1.525" x2="-2.2" y2="1.525" width="0.1" layer="51"/>
<wire x1="2.2" y1="-2.175" x2="2.2" y2="-1.725" width="0.1" layer="51"/>
<wire x1="2.2" y1="-1.725" x2="2.2" y2="-1.525" width="0.1" layer="51"/>
<wire x1="3.15" y1="-1.725" x2="3.15" y2="-1.525" width="0.1" layer="51"/>
<wire x1="2.2" y1="-1.525" x2="3.15" y2="-1.525" width="0.1" layer="51"/>
<wire x1="2.2" y1="-1.725" x2="3.15" y2="-1.725" width="0.1" layer="51"/>
<wire x1="-3.15" y1="0.875" x2="-3.15" y2="1.075" width="0.1" layer="51"/>
<wire x1="-2.2" y1="0.425" x2="-2.2" y2="0.875" width="0.1" layer="51"/>
<wire x1="-2.2" y1="0.875" x2="-2.2" y2="1.075" width="0.1" layer="51"/>
<wire x1="-3.15" y1="1.075" x2="-2.2" y2="1.075" width="0.1" layer="51"/>
<wire x1="-3.15" y1="0.875" x2="-2.2" y2="0.875" width="0.1" layer="51"/>
<wire x1="2.2" y1="-1.525" x2="2.2" y2="-1.075" width="0.1" layer="51"/>
<wire x1="2.2" y1="-1.075" x2="2.2" y2="-0.875" width="0.1" layer="51"/>
<wire x1="3.15" y1="-1.075" x2="3.15" y2="-0.875" width="0.1" layer="51"/>
<wire x1="2.2" y1="-0.875" x2="3.15" y2="-0.875" width="0.1" layer="51"/>
<wire x1="2.2" y1="-1.075" x2="3.15" y2="-1.075" width="0.1" layer="51"/>
<wire x1="-3.15" y1="0.225" x2="-3.15" y2="0.425" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-0.225" x2="-2.2" y2="0.225" width="0.1" layer="51"/>
<wire x1="-2.2" y1="0.225" x2="-2.2" y2="0.425" width="0.1" layer="51"/>
<wire x1="-3.15" y1="0.425" x2="-2.2" y2="0.425" width="0.1" layer="51"/>
<wire x1="-3.15" y1="0.225" x2="-2.2" y2="0.225" width="0.1" layer="51"/>
<wire x1="2.2" y1="-0.875" x2="2.2" y2="-0.425" width="0.1" layer="51"/>
<wire x1="2.2" y1="-0.425" x2="2.2" y2="-0.225" width="0.1" layer="51"/>
<wire x1="3.15" y1="-0.425" x2="3.15" y2="-0.225" width="0.1" layer="51"/>
<wire x1="2.2" y1="-0.225" x2="3.15" y2="-0.225" width="0.1" layer="51"/>
<wire x1="2.2" y1="-0.425" x2="3.15" y2="-0.425" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-0.425" x2="-3.15" y2="-0.225" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-0.875" x2="-2.2" y2="-0.425" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-0.425" x2="-2.2" y2="-0.225" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-0.225" x2="-2.2" y2="-0.225" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-0.425" x2="-2.2" y2="-0.425" width="0.1" layer="51"/>
<wire x1="2.2" y1="-0.225" x2="2.2" y2="0.225" width="0.1" layer="51"/>
<wire x1="2.2" y1="0.225" x2="2.2" y2="0.425" width="0.1" layer="51"/>
<wire x1="3.15" y1="0.225" x2="3.15" y2="0.425" width="0.1" layer="51"/>
<wire x1="2.2" y1="0.425" x2="3.15" y2="0.425" width="0.1" layer="51"/>
<wire x1="2.2" y1="0.225" x2="3.15" y2="0.225" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-1.075" x2="-3.15" y2="-0.875" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-1.525" x2="-2.2" y2="-1.075" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-1.075" x2="-2.2" y2="-0.875" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-0.875" x2="-2.2" y2="-0.875" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-1.075" x2="-2.2" y2="-1.075" width="0.1" layer="51"/>
<wire x1="2.2" y1="0.425" x2="2.2" y2="0.875" width="0.1" layer="51"/>
<wire x1="2.2" y1="0.875" x2="2.2" y2="1.075" width="0.1" layer="51"/>
<wire x1="3.15" y1="0.875" x2="3.15" y2="1.075" width="0.1" layer="51"/>
<wire x1="2.2" y1="1.075" x2="3.15" y2="1.075" width="0.1" layer="51"/>
<wire x1="2.2" y1="0.875" x2="3.15" y2="0.875" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-1.725" x2="-3.15" y2="-1.525" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-2.175" x2="-2.2" y2="-1.725" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-1.725" x2="-2.2" y2="-1.525" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-1.525" x2="-2.2" y2="-1.525" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-1.725" x2="-2.2" y2="-1.725" width="0.1" layer="51"/>
<wire x1="2.2" y1="1.075" x2="2.2" y2="1.525" width="0.1" layer="51"/>
<wire x1="2.2" y1="1.525" x2="2.2" y2="1.725" width="0.1" layer="51"/>
<wire x1="3.15" y1="1.525" x2="3.15" y2="1.725" width="0.1" layer="51"/>
<wire x1="2.2" y1="1.725" x2="3.15" y2="1.725" width="0.1" layer="51"/>
<wire x1="2.2" y1="1.525" x2="3.15" y2="1.525" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-2.375" x2="-3.15" y2="-2.175" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-2.825" x2="-2.2" y2="-2.375" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-2.375" x2="-2.2" y2="-2.175" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-2.175" x2="-2.2" y2="-2.175" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-2.375" x2="-2.2" y2="-2.375" width="0.1" layer="51"/>
<wire x1="2.2" y1="1.725" x2="2.2" y2="2.175" width="0.1" layer="51"/>
<wire x1="2.2" y1="2.175" x2="2.2" y2="2.375" width="0.1" layer="51"/>
<wire x1="3.15" y1="2.175" x2="3.15" y2="2.375" width="0.1" layer="51"/>
<wire x1="2.2" y1="2.375" x2="3.15" y2="2.375" width="0.1" layer="51"/>
<wire x1="2.2" y1="2.175" x2="3.15" y2="2.175" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-3.025" x2="-3.15" y2="-2.825" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-3.25" x2="-2.2" y2="-3.025" width="0.1" layer="51"/>
<wire x1="-2.2" y1="-3.025" x2="-2.2" y2="-2.825" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-2.825" x2="-2.2" y2="-2.825" width="0.1" layer="51"/>
<wire x1="-3.15" y1="-3.025" x2="-2.2" y2="-3.025" width="0.1" layer="51"/>
<wire x1="2.2" y1="2.375" x2="2.2" y2="2.825" width="0.1" layer="51"/>
<wire x1="2.2" y1="2.825" x2="2.2" y2="3.025" width="0.1" layer="51"/>
<wire x1="2.2" y1="3.025" x2="2.2" y2="3.25" width="0.1" layer="51"/>
<wire x1="3.15" y1="2.825" x2="3.15" y2="3.025" width="0.1" layer="51"/>
<wire x1="2.2" y1="3.025" x2="3.15" y2="3.025" width="0.1" layer="51"/>
<wire x1="2.2" y1="2.825" x2="3.15" y2="2.825" width="0.1" layer="51"/>
<wire x1="-3.75" y1="3.5" x2="3.75" y2="3.5" width="0" layer="59"/>
<wire x1="3.75" y1="3.5" x2="3.75" y2="-3.5" width="0" layer="59"/>
<wire x1="3.75" y1="-3.5" x2="-3.75" y2="-3.5" width="0" layer="59"/>
<wire x1="-3.75" y1="-3.5" x2="-3.75" y2="3.5" width="0" layer="59"/>
<smd name="1" x="-2.85" y="2.925" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="11" x="2.85" y="-2.925" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="2" x="-2.85" y="2.275" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="12" x="2.85" y="-2.275" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="3" x="-2.85" y="1.625" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="13" x="2.85" y="-1.625" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="4" x="-2.85" y="0.975" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="14" x="2.85" y="-0.975" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="5" x="-2.85" y="0.325" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="15" x="2.85" y="-0.325" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="6" x="-2.85" y="-0.325" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="16" x="2.85" y="0.325" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="7" x="-2.85" y="-0.975" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="17" x="2.85" y="0.975" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="8" x="-2.85" y="-1.625" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="18" x="2.85" y="1.625" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="9" x="-2.85" y="-2.275" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="19" x="2.85" y="2.275" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="10" x="-2.85" y="-2.925" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<smd name="20" x="2.85" y="2.925" dx="0.45" dy="1.3" layer="1" rot="R90"/>
<text x="0" y="0" size="1" layer="51" ratio="10" rot="R90" align="center">&gt;NAME</text>
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
<symbol name="THS7314">
<pin name="CH1_IN" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="CH2_IN" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="CH3_IN" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="VCC" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="CH1_OUT" x="33.02" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="CH2_OUT" x="33.02" y="-5.08" length="middle" direction="pas" rot="R180"/>
<pin name="CH3_OUT" x="33.02" y="-7.62" length="middle" direction="pas" rot="R180"/>
<pin name="GND" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<wire x1="0" y1="0" x2="27.94" y2="0" width="0.254" layer="94"/>
<wire x1="27.94" y1="0" x2="27.94" y2="-20.32" width="0.254" layer="94"/>
<wire x1="27.94" y1="-20.32" x2="0" y2="-20.32" width="0.254" layer="94"/>
<wire x1="0" y1="-20.32" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-22.86" size="1.778" layer="96" font="vector">&gt;VALUE</text>
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
<symbol name="STM32F070F6P6">
<wire x1="0" y1="0" x2="30.48" y2="0" width="0.254" layer="94"/>
<wire x1="30.48" y1="0" x2="30.48" y2="-35.56" width="0.254" layer="94"/>
<wire x1="30.48" y1="-35.56" x2="0" y2="-35.56" width="0.254" layer="94"/>
<wire x1="0" y1="-35.56" x2="0" y2="0" width="0.254" layer="94"/>
<pin name="BOOT0" x="35.56" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="PF0-OSC_IN" x="35.56" y="-7.62" length="middle" direction="pas" rot="R180"/>
<pin name="PF1-OSC_OUT" x="35.56" y="-10.16" length="middle" direction="pas" rot="R180"/>
<pin name="NRST" x="35.56" y="-15.24" length="middle" direction="pas" rot="R180"/>
<pin name="VDDA" x="35.56" y="-27.94" length="middle" direction="pas" rot="R180"/>
<pin name="PA0" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="PA1" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="PA2" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="PA3" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="PA4" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="PA14/SWCLK" x="35.56" y="-17.78" length="middle" direction="pas" rot="R180"/>
<pin name="PA13/SWDIO" x="35.56" y="-20.32" length="middle" direction="pas" rot="R180"/>
<pin name="PA10/PA12" x="-5.08" y="-33.02" length="middle" direction="pas"/>
<pin name="PA9/PA11" x="-5.08" y="-30.48" length="middle" direction="pas"/>
<pin name="VDD" x="35.56" y="-30.48" length="middle" direction="pas" rot="R180"/>
<pin name="VSS" x="35.56" y="-33.02" length="middle" direction="pas" rot="R180"/>
<pin name="PB1" x="-5.08" y="-25.4" length="middle" direction="pas"/>
<pin name="PA7" x="-5.08" y="-20.32" length="middle" direction="pas"/>
<pin name="PA6" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="PA5" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-38.1" size="1.778" layer="96" font="vector">&gt;VALUE</text>
</symbol>
<symbol name="TC1185">
<wire x1="0" y1="0" x2="20.32" y2="0" width="0.254" layer="94"/>
<wire x1="20.32" y1="0" x2="20.32" y2="-12.7" width="0.254" layer="94"/>
<wire x1="20.32" y1="-12.7" x2="0" y2="-12.7" width="0.254" layer="94"/>
<wire x1="0" y1="-12.7" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="0" y="-15.24" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="VIN" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="VOUT" x="25.4" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="SHDN#" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="GND" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="BYP" x="25.4" y="-10.16" length="middle" direction="pas" rot="R180"/>
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
<deviceset name="THS7314D" prefix="U">
<gates>
<gate name="_" symbol="THS7314" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SOIC-8">
<connects>
<connect gate="_" pin="CH1_IN" pad="1"/>
<connect gate="_" pin="CH1_OUT" pad="8"/>
<connect gate="_" pin="CH2_IN" pad="2"/>
<connect gate="_" pin="CH2_OUT" pad="7"/>
<connect gate="_" pin="CH3_IN" pad="3"/>
<connect gate="_" pin="CH3_OUT" pad="6"/>
<connect gate="_" pin="GND" pad="5"/>
<connect gate="_" pin="VCC" pad="4"/>
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
<deviceset name="STM32F070F6P6" prefix="U">
<description>ARM Cortex M0 with USB 32KB Flash, 6KB RAM</description>
<gates>
<gate name="_" symbol="STM32F070F6P6" x="0" y="0"/>
</gates>
<devices>
<device name="" package="TSSOP-20">
<connects>
<connect gate="_" pin="BOOT0" pad="1"/>
<connect gate="_" pin="NRST" pad="4"/>
<connect gate="_" pin="PA0" pad="6"/>
<connect gate="_" pin="PA1" pad="7"/>
<connect gate="_" pin="PA10/PA12" pad="18"/>
<connect gate="_" pin="PA13/SWDIO" pad="19"/>
<connect gate="_" pin="PA14/SWCLK" pad="20"/>
<connect gate="_" pin="PA2" pad="8"/>
<connect gate="_" pin="PA3" pad="9"/>
<connect gate="_" pin="PA4" pad="10"/>
<connect gate="_" pin="PA5" pad="11"/>
<connect gate="_" pin="PA6" pad="12"/>
<connect gate="_" pin="PA7" pad="13"/>
<connect gate="_" pin="PA9/PA11" pad="17"/>
<connect gate="_" pin="PB1" pad="14"/>
<connect gate="_" pin="PF0-OSC_IN" pad="2"/>
<connect gate="_" pin="PF1-OSC_OUT" pad="3"/>
<connect gate="_" pin="VDD" pad="16"/>
<connect gate="_" pin="VDDA" pad="5"/>
<connect gate="_" pin="VSS" pad="15"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="TC1185-3.3VCT713" prefix="U">
<gates>
<gate name="_" symbol="TC1185" x="0" y="0"/>
</gates>
<devices>
<device name="" package="SOT-23-5">
<connects>
<connect gate="_" pin="BYP" pad="4"/>
<connect gate="_" pin="GND" pad="2"/>
<connect gate="_" pin="SHDN#" pad="3"/>
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
<package name="HDR18X1">
<wire x1="-1.27" y1="22.86" x2="1.27" y2="22.86" width="0.2" layer="21"/>
<wire x1="1.27" y1="22.86" x2="1.27" y2="-22.86" width="0.2" layer="21"/>
<wire x1="1.27" y1="-22.86" x2="-1.27" y2="-22.86" width="0.2" layer="21"/>
<wire x1="-1.27" y1="-22.86" x2="-1.27" y2="22.86" width="0.2" layer="21"/>
<pad name="2" x="0" y="19.05" drill="1"/>
<pad name="1" x="0" y="21.59" drill="1" shape="square"/>
<pad name="3" x="0" y="16.51" drill="1"/>
<pad name="4" x="0" y="13.97" drill="1"/>
<pad name="5" x="0" y="11.43" drill="1"/>
<pad name="6" x="0" y="8.89" drill="1"/>
<pad name="7" x="0" y="6.35" drill="1"/>
<pad name="8" x="0" y="3.81" drill="1"/>
<pad name="9" x="0" y="1.27" drill="1"/>
<pad name="10" x="0" y="-1.27" drill="1"/>
<pad name="11" x="0" y="-3.81" drill="1"/>
<pad name="12" x="0" y="-6.35" drill="1"/>
<pad name="13" x="0" y="-8.89" drill="1"/>
<pad name="14" x="0" y="-11.43" drill="1"/>
<pad name="15" x="0" y="-13.97" drill="1"/>
<pad name="16" x="0" y="-16.51" drill="1"/>
<pad name="17" x="0" y="-19.05" drill="1"/>
<pad name="18" x="0" y="-21.59" drill="1"/>
</package>
<package name="10118193-0001LF">
<wire x1="-3.93" y1="2.85" x2="-3.93" y2="2.2" width="0.2" layer="21"/>
<wire x1="3.93" y1="2.85" x2="3.93" y2="2.2" width="0.2" layer="21"/>
<wire x1="-3.93" y1="-0.7" x2="3.93" y2="-0.7" width="0.2" layer="21"/>
<wire x1="-3.93" y1="-1.3" x2="3.93" y2="-1.3" width="0.2" layer="21"/>
<wire x1="-3.93" y1="-1.3" x2="-3.93" y2="0.7" width="0.2" layer="21"/>
<wire x1="3.93" y1="-1.3" x2="3.93" y2="0.7" width="0.2" layer="21"/>
<pad name="MH1" x="-3.3" y="1.45" drill="1" diameter="1.2"/>
<pad name="MH2" x="3.3" y="1.45" drill="1" diameter="1.2"/>
<smd name="1" x="-1.3" y="4.125" dx="0.4" dy="1.35" layer="1"/>
<smd name="2" x="-0.65" y="4.125" dx="0.4" dy="1.35" layer="1"/>
<smd name="3" x="0" y="4.125" dx="0.4" dy="1.35" layer="1"/>
<smd name="4" x="0.65" y="4.125" dx="0.4" dy="1.35" layer="1"/>
<smd name="5" x="1.3" y="4.125" dx="0.4" dy="1.35" layer="1"/>
<smd name="MP1" x="-3.2" y="3.875" dx="1.6" dy="1.4" layer="1"/>
<smd name="MP2" x="3.2" y="3.875" dx="1.6" dy="1.4" layer="1"/>
<wire x1="-3.93" y1="-0.7" x2="3.93" y2="-0.7" width="0.1" layer="51"/>
<wire x1="-3.93" y1="-1.3" x2="3.93" y2="-1.3" width="0.1" layer="51"/>
<wire x1="-3.93" y1="-1.3" x2="-3.93" y2="4.5" width="0.1" layer="51"/>
<wire x1="3.93" y1="-1.3" x2="3.93" y2="4.5" width="0.1" layer="51"/>
<wire x1="3.93" y1="4.5" x2="-3.93" y2="4.5" width="0.1" layer="51"/>
<text x="0" y="2" size="2" layer="51" font="vector" ratio="5" align="center">&gt;NAME</text>
</package>
<package name="HDR2X1">
<wire x1="-1.27" y1="2.54" x2="1.27" y2="2.54" width="0.2" layer="21"/>
<wire x1="1.27" y1="2.54" x2="1.27" y2="-2.54" width="0.2" layer="21"/>
<wire x1="1.27" y1="-2.54" x2="-1.27" y2="-2.54" width="0.2" layer="21"/>
<wire x1="-1.27" y1="-2.54" x2="-1.27" y2="2.54" width="0.2" layer="21"/>
<pad name="2" x="0" y="-1.27" drill="1"/>
<pad name="1" x="0" y="1.27" drill="1" shape="square"/>
</package>
<package name="HDR2X3">
<wire x1="-2.54" y1="3.81" x2="2.54" y2="3.81" width="0.2" layer="21"/>
<wire x1="2.54" y1="3.81" x2="2.54" y2="-3.81" width="0.2" layer="21"/>
<wire x1="2.54" y1="-3.81" x2="-2.54" y2="-3.81" width="0.2" layer="21"/>
<wire x1="-2.54" y1="-3.81" x2="-2.54" y2="3.81" width="0.2" layer="21"/>
<pad name="1" x="-1.27" y="2.54" drill="1"/>
<pad name="2" x="1.27" y="2.54" drill="1"/>
<pad name="3" x="-1.27" y="0" drill="1"/>
<pad name="4" x="1.27" y="0" drill="1"/>
<pad name="5" x="-1.27" y="-2.54" drill="1"/>
<pad name="6" x="1.27" y="-2.54" drill="1"/>
</package>
<package name="HDR4X1">
<wire x1="-1.27" y1="5.08" x2="1.27" y2="5.08" width="0.2" layer="21"/>
<wire x1="1.27" y1="5.08" x2="1.27" y2="-5.08" width="0.2" layer="21"/>
<wire x1="1.27" y1="-5.08" x2="-1.27" y2="-5.08" width="0.2" layer="21"/>
<wire x1="-1.27" y1="-5.08" x2="-1.27" y2="5.08" width="0.2" layer="21"/>
<pad name="2" x="0" y="1.27" drill="1"/>
<pad name="1" x="0" y="3.81" drill="1" shape="square"/>
<pad name="3" x="0" y="-1.27" drill="1"/>
<pad name="4" x="0" y="-3.81" drill="1"/>
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
<symbol name="HDR18X1">
<wire x1="0" y1="0" x2="7.62" y2="0" width="0.254" layer="94"/>
<wire x1="7.62" y1="0" x2="7.62" y2="-48.26" width="0.254" layer="94"/>
<wire x1="7.62" y1="-48.26" x2="0" y2="-48.26" width="0.254" layer="94"/>
<wire x1="0" y1="-48.26" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95">&gt;NAME</text>
<text x="0" y="-50.8" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="2" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="3" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="4" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="5" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="6" x="-5.08" y="-15.24" length="middle" direction="pas"/>
<pin name="7" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="8" x="-5.08" y="-20.32" length="middle" direction="pas"/>
<pin name="9" x="-5.08" y="-22.86" length="middle" direction="pas"/>
<pin name="10" x="-5.08" y="-25.4" length="middle" direction="pas"/>
<pin name="11" x="-5.08" y="-27.94" length="middle" direction="pas"/>
<pin name="12" x="-5.08" y="-30.48" length="middle" direction="pas"/>
<pin name="13" x="-5.08" y="-33.02" length="middle" direction="pas"/>
<pin name="14" x="-5.08" y="-35.56" length="middle" direction="pas"/>
<pin name="15" x="-5.08" y="-38.1" length="middle" direction="pas"/>
<pin name="16" x="-5.08" y="-40.64" length="middle" direction="pas"/>
<pin name="17" x="-5.08" y="-43.18" length="middle" direction="pas"/>
<pin name="18" x="-5.08" y="-45.72" length="middle" direction="pas"/>
</symbol>
<symbol name="MICRO_USB_B">
<wire x1="0" y1="0" x2="0" y2="-27.94" width="0.254" layer="94"/>
<wire x1="0" y1="-27.94" x2="12.7" y2="-27.94" width="0.254" layer="94"/>
<wire x1="12.7" y1="-27.94" x2="12.7" y2="0" width="0.254" layer="94"/>
<wire x1="12.7" y1="0" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95">&gt;NAME</text>
<text x="0" y="-30.48" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VBUS" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="D-" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="D+" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="ID" x="-5.08" y="-10.16" length="middle" direction="pas"/>
<pin name="GND" x="-5.08" y="-12.7" length="middle" direction="pas"/>
<pin name="MP1" x="-5.08" y="-17.78" length="middle" direction="pas"/>
<pin name="MP2" x="-5.08" y="-20.32" length="middle" direction="pas"/>
<pin name="MH1" x="-5.08" y="-22.86" length="middle" direction="pas"/>
<pin name="MH2" x="-5.08" y="-25.4" length="middle" direction="pas"/>
</symbol>
<symbol name="HDR2X1">
<wire x1="0" y1="0" x2="7.62" y2="0" width="0.254" layer="94"/>
<wire x1="7.62" y1="0" x2="7.62" y2="-7.62" width="0.254" layer="94"/>
<wire x1="7.62" y1="-7.62" x2="0" y2="-7.62" width="0.254" layer="94"/>
<wire x1="0" y1="-7.62" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95">&gt;NAME</text>
<text x="0" y="-10.16" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="2" x="-5.08" y="-5.08" length="middle" direction="pas"/>
</symbol>
<symbol name="HDR2X3">
<wire x1="0" y1="0" x2="10.16" y2="0" width="0.254" layer="94"/>
<wire x1="10.16" y1="0" x2="10.16" y2="-10.16" width="0.254" layer="94"/>
<wire x1="10.16" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94"/>
<wire x1="0" y1="-10.16" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95">&gt;NAME</text>
<text x="0" y="-12.7" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="5" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="3" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="2" x="15.24" y="-2.54" length="middle" direction="pas" rot="R180"/>
<pin name="4" x="15.24" y="-5.08" length="middle" direction="pas" rot="R180"/>
<pin name="6" x="15.24" y="-7.62" length="middle" direction="pas" rot="R180"/>
</symbol>
<symbol name="HDR4X1">
<wire x1="0" y1="0" x2="7.62" y2="0" width="0.254" layer="94"/>
<wire x1="7.62" y1="0" x2="7.62" y2="-12.7" width="0.254" layer="94"/>
<wire x1="7.62" y1="-12.7" x2="0" y2="-12.7" width="0.254" layer="94"/>
<wire x1="0" y1="-12.7" x2="0" y2="0" width="0.254" layer="94"/>
<text x="0" y="0.254" size="1.778" layer="95">&gt;NAME</text>
<text x="0" y="-15.24" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-5.08" y="-2.54" length="middle" direction="pas"/>
<pin name="2" x="-5.08" y="-5.08" length="middle" direction="pas"/>
<pin name="3" x="-5.08" y="-7.62" length="middle" direction="pas"/>
<pin name="4" x="-5.08" y="-10.16" length="middle" direction="pas"/>
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
<deviceset name="HDR18X1" prefix="J" uservalue="yes">
<gates>
<gate name="_" symbol="HDR18X1" x="0" y="0"/>
</gates>
<devices>
<device name="" package="HDR18X1">
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
<connect gate="_" pin="2" pad="2"/>
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
<deviceset name="10118193-0001LF" prefix="J">
<gates>
<gate name="_" symbol="MICRO_USB_B" x="0" y="0"/>
</gates>
<devices>
<device name="" package="10118193-0001LF">
<connects>
<connect gate="_" pin="D+" pad="3"/>
<connect gate="_" pin="D-" pad="2"/>
<connect gate="_" pin="GND" pad="5"/>
<connect gate="_" pin="ID" pad="4"/>
<connect gate="_" pin="MH1" pad="MH1"/>
<connect gate="_" pin="MH2" pad="MH2"/>
<connect gate="_" pin="MP1" pad="MP1"/>
<connect gate="_" pin="MP2" pad="MP2"/>
<connect gate="_" pin="VBUS" pad="1"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="HDR2X1" prefix="J" uservalue="yes">
<gates>
<gate name="_" symbol="HDR2X1" x="0" y="0"/>
</gates>
<devices>
<device name="" package="HDR2X1">
<connects>
<connect gate="_" pin="1" pad="1"/>
<connect gate="_" pin="2" pad="2"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="HDR2X3" prefix="J" uservalue="yes">
<gates>
<gate name="_" symbol="HDR2X3" x="0" y="0"/>
</gates>
<devices>
<device name="" package="HDR2X3">
<connects>
<connect gate="_" pin="1" pad="1"/>
<connect gate="_" pin="2" pad="2"/>
<connect gate="_" pin="3" pad="3"/>
<connect gate="_" pin="4" pad="4"/>
<connect gate="_" pin="5" pad="5"/>
<connect gate="_" pin="6" pad="6"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="HDR4X1" prefix="J" uservalue="yes">
<gates>
<gate name="_" symbol="HDR4X1" x="0" y="0"/>
</gates>
<devices>
<device name="" package="HDR4X1">
<connects>
<connect gate="_" pin="1" pad="1"/>
<connect gate="_" pin="2" pad="2"/>
<connect gate="_" pin="3" pad="3"/>
<connect gate="_" pin="4" pad="4"/>
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
<library name="crystals">
<packages>
<package name="XTAL2_5X3.2">
<wire x1="-2.5" y1="1.6" x2="2.5" y2="1.6" width="0.2" layer="21"/>
<wire x1="-2.5" y1="-1.6" x2="2.5" y2="-1.6" width="0.2" layer="21"/>
<wire x1="-3.25" y1="1.85" x2="3.25" y2="1.85" width="0" layer="59"/>
<wire x1="3.25" y1="1.85" x2="3.25" y2="-1.85" width="0" layer="59"/>
<wire x1="3.25" y1="-1.85" x2="-3.25" y2="-1.85" width="0" layer="59"/>
<wire x1="-3.25" y1="-1.85" x2="-3.25" y2="1.85" width="0" layer="59"/>
<smd name="1" x="-2" y="0" dx="2" dy="2.4" layer="1"/>
<smd name="2" x="2" y="0" dx="2" dy="2.4" layer="1"/>
<text x="0" y="0" size="1" layer="51" ratio="10" align="center">&gt;NAME</text>
<wire x1="-3" y1="1.6" x2="3" y2="1.6" width="0.1" layer="51"/>
<wire x1="3" y1="1.6" x2="3" y2="-1.6" width="0.1" layer="51"/>
<wire x1="3" y1="-1.6" x2="-3" y2="-1.6" width="0.1" layer="51"/>
<wire x1="-3" y1="-1.6" x2="-3" y2="1.6" width="0.1" layer="51"/>
</package>
</packages>
<symbols>
<symbol name="XTAL">
<wire x1="-1.778" y1="1.524" x2="-1.778" y2="0" width="0.254" layer="94"/>
<wire x1="-1.778" y1="0" x2="-1.778" y2="-1.524" width="0.254" layer="94"/>
<wire x1="-1.016" y1="2.286" x2="-1.016" y2="-2.286" width="0.254" layer="94"/>
<wire x1="-1.016" y1="-2.286" x2="1.016" y2="-2.286" width="0.254" layer="94"/>
<wire x1="1.016" y1="-2.286" x2="1.016" y2="2.286" width="0.254" layer="94"/>
<wire x1="1.016" y1="2.286" x2="-1.016" y2="2.286" width="0.254" layer="94"/>
<wire x1="1.778" y1="1.524" x2="1.778" y2="0" width="0.254" layer="94"/>
<wire x1="1.778" y1="0" x2="1.778" y2="-1.524" width="0.254" layer="94"/>
<wire x1="-2.54" y1="0" x2="-1.778" y2="0" width="0.1524" layer="94"/>
<wire x1="1.778" y1="0" x2="2.54" y2="0" width="0.1524" layer="94"/>
<text x="-2.54" y="2.794" size="1.778" layer="95" font="vector">&gt;NAME</text>
<text x="-2.54" y="-5.08" size="1.778" layer="96" font="vector">&gt;VALUE</text>
<pin name="1" x="-5.08" y="0" visible="off" length="short" direction="pas"/>
<pin name="2" x="5.08" y="0" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="XTAL2_5X3.2" prefix="X" uservalue="yes">
<gates>
<gate name="_" symbol="XTAL" x="0" y="0"/>
</gates>
<devices>
<device name="" package="XTAL2_5X3.2">
<connects>
<connect gate="_" pin="1" pad="1"/>
<connect gate="_" pin="2" pad="2"/>
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
<part name="U7" library="integrated_circuits" deviceset="AP3417CKTR-G1" device=""/>
<part name="GND41" library="supply" deviceset="GND" device=""/>
<part name="C69" library="rcl" deviceset="CAPACITOR" device="0805" value="10u"/>
<part name="GND42" library="supply" deviceset="GND" device=""/>
<part name="R23" library="rcl" deviceset="RESISTOR" device="0603" value="68k"/>
<part name="R24" library="rcl" deviceset="RESISTOR" device="0603" value="15k"/>
<part name="GND43" library="supply" deviceset="GND" device=""/>
<part name="L14" library="rcl" deviceset="INDUCTOR" device="NRS4018" value="NRS4018T2R2MDGJ"/>
<part name="C70" library="rcl" deviceset="CAPACITOR" device="0805" value="10u"/>
<part name="GND44" library="supply" deviceset="GND" device=""/>
<part name="U5" library="integrated_circuits" deviceset="SG5032CAN_40.000000M-TJGA3" device="" value="SG5032CAN_25.000000M-TJGA3"/>
<part name="GND47" library="supply" deviceset="GND" device=""/>
<part name="C18" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="GND48" library="supply" deviceset="GND" device=""/>
<part name="R5" library="rcl" deviceset="RESISTOR" device="0603" value="100"/>
<part name="R6" library="rcl" deviceset="RESISTOR" device="0603" value="100"/>
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
<part name="R1" library="rcl" deviceset="RESISTOR" device="0603" value="9.31k"/>
<part name="R3" library="rcl" deviceset="RESISTOR" device="0603" value="7.5k"/>
<part name="R7" library="rcl" deviceset="RESISTOR" device="0603" value="15k"/>
<part name="R14" library="rcl" deviceset="RESISTOR" device="0603" value="30k"/>
<part name="R15" library="rcl" deviceset="RESISTOR" device="0603" value="60.4k"/>
<part name="R16" library="rcl" deviceset="RESISTOR" device="0603" value="7.5k"/>
<part name="R25" library="rcl" deviceset="RESISTOR" device="0603" value="15k"/>
<part name="R26" library="rcl" deviceset="RESISTOR" device="0603" value="30k"/>
<part name="R27" library="rcl" deviceset="RESISTOR" device="0603" value="60.4k"/>
<part name="R2" library="rcl" deviceset="RESISTOR" device="0603" value="9.31k"/>
<part name="U$2" library="supply" deviceset="GND" device=""/>
<part name="R28" library="rcl" deviceset="RESISTOR" device="0603" value="1.2k"/>
<part name="R29" library="rcl" deviceset="RESISTOR" device="0603" value="1.2k"/>
<part name="U$3" library="supply" deviceset="GND" device=""/>
<part name="U$4" library="supply" deviceset="GND" device=""/>
<part name="U2" library="integrated_circuits" deviceset="THS7314D" device=""/>
<part name="R30" library="rcl" deviceset="RESISTOR" device="0603" value="75"/>
<part name="R31" library="rcl" deviceset="RESISTOR" device="0603" value="75"/>
<part name="R32" library="rcl" deviceset="RESISTOR" device="0603" value="75"/>
<part name="U$12" library="supply" deviceset="GND" device=""/>
<part name="C1" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="U$24" library="supply" deviceset="GND" device=""/>
<part name="C2" library="rcl" deviceset="CAPACITOR" device="0805" value="10u"/>
<part name="GND1" library="supply" deviceset="GND" device=""/>
<part name="C3" library="rcl" deviceset="CAPACITOR" device="0603" value="1n"/>
<part name="R33" library="rcl" deviceset="RESISTOR" device="0603" value="0"/>
<part name="U$27" library="supply" deviceset="GND" device=""/>
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
<part name="J4" library="connectors" deviceset="HDR18X1" device="" value="BUS"/>
<part name="J1" library="connectors" deviceset="HDR18X1" device="" value="VIDEO"/>
<part name="U$29" library="supply" deviceset="+5V" device=""/>
<part name="C4" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="U$40" library="supply" deviceset="GND" device=""/>
<part name="C5" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="U$42" library="supply" deviceset="GND" device=""/>
<part name="U$41" library="supply" deviceset="+5V" device=""/>
<part name="R36" library="rcl" deviceset="RESISTOR" device="0603" value="0"/>
<part name="U$13" library="supply" deviceset="+3.3V" device=""/>
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
<part name="FRAME2" library="frames" deviceset="FRAME_A3L" device=""/>
<part name="R38" library="rcl" deviceset="RESISTOR" device="0603" value="TBD"/>
<part name="J7" library="connectors" deviceset="10118193-0001LF" device=""/>
<part name="U10" library="integrated_circuits" deviceset="STM32F070F6P6" device=""/>
<part name="C20" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C21" library="rcl" deviceset="CAPACITOR" device="0603" value="100n"/>
<part name="C22" library="rcl" deviceset="CAPACITOR" device="0603" value="4.7u"/>
<part name="R42" library="rcl" deviceset="RESISTOR" device="0603" value="10k"/>
<part name="J2" library="connectors" deviceset="HDR2X1" device="" value="BOOT0"/>
<part name="J8" library="connectors" deviceset="HDR2X3" device="" value="SWD"/>
<part name="J5" library="connectors" deviceset="HDR8X1" device=""/>
<part name="U$50" library="supply" deviceset="+5V" device=""/>
<part name="U$51" library="supply" deviceset="GND" device=""/>
<part name="J6" library="connectors" deviceset="HDR2X1" device="" value="5V_OUT"/>
<part name="U$46" library="supply" deviceset="+5V" device=""/>
<part name="U11" library="integrated_circuits" deviceset="TC1185-3.3VCT713" device=""/>
<part name="C24" library="rcl" deviceset="CAPACITOR" device="0603" value="470p"/>
<part name="C27" library="rcl" deviceset="CAPACITOR" device="0603" value="4.7u"/>
<part name="C28" library="rcl" deviceset="CAPACITOR" device="0805" value="10u"/>
<part name="U$45" library="supply" deviceset="GND" device=""/>
<part name="U$47" library="supply" deviceset="GND" device=""/>
<part name="U$48" library="supply" deviceset="GND" device=""/>
<part name="U$49" library="supply" deviceset="GND" device=""/>
<part name="U$52" library="supply" deviceset="GND" device=""/>
<part name="U$53" library="supply" deviceset="GND" device=""/>
<part name="U$54" library="supply" deviceset="GND" device=""/>
<part name="U$55" library="supply" deviceset="GND" device=""/>
<part name="U$56" library="supply" deviceset="GND" device=""/>
<part name="U$57" library="supply" deviceset="GND" device=""/>
<part name="U$58" library="supply" deviceset="GND" device=""/>
<part name="U$59" library="supply" deviceset="GND" device=""/>
<part name="J9" library="connectors" deviceset="HDR4X1" device="" value="SERIAL"/>
<part name="U$60" library="supply" deviceset="GND" device=""/>
<part name="X2" library="crystals" deviceset="XTAL2_5X3.2" device="" value="7A-8.000MAAE-T"/>
<part name="C29" library="rcl" deviceset="CAPACITOR" device="0603" value="15p"/>
<part name="C30" library="rcl" deviceset="CAPACITOR" device="0603" value="15p"/>
<part name="U$61" library="supply" deviceset="GND" device=""/>
<part name="U$62" library="supply" deviceset="GND" device=""/>
</parts>
<sheets>
<sheet>
<plain>
<wire x1="162.56" y1="134.62" x2="167.64" y2="134.62" width="0.1524" layer="94"/>
<text x="165.1" y="271.78" size="2.54" layer="94" font="vector">VGA interface</text>
<text x="2.54" y="271.78" size="2.54" layer="94" font="vector">FPGA</text>
<text x="2.54" y="45.72" size="2.54" layer="94" font="vector">3.3V power supply</text>
<text x="2.54" y="129.54" size="2.54" layer="94" font="vector">25MHz oscillator</text>
<text x="73.66" y="129.54" size="2.54" layer="94" font="vector">SPI Flash</text>
<wire x1="162.56" y1="134.62" x2="71.12" y2="134.62" width="0.1524" layer="94"/>
<wire x1="71.12" y1="134.62" x2="0" y2="134.62" width="0.1524" layer="94"/>
<text x="93.98" y="45.72" size="2.54" layer="94" font="vector">1.2V power supply</text>
<wire x1="162.56" y1="276.86" x2="162.56" y2="154.94" width="0.1524" layer="94"/>
<wire x1="162.56" y1="154.94" x2="162.56" y2="134.62" width="0.1524" layer="94"/>
<wire x1="0" y1="50.8" x2="91.44" y2="50.8" width="0.1524" layer="94"/>
<wire x1="91.44" y1="50.8" x2="182.88" y2="50.8" width="0.1524" layer="94"/>
<wire x1="182.88" y1="50.8" x2="182.88" y2="0" width="0.1524" layer="94"/>
<wire x1="91.44" y1="50.8" x2="91.44" y2="0" width="0.1524" layer="94"/>
<wire x1="71.12" y1="134.62" x2="71.12" y2="88.9" width="0.1524" layer="94"/>
<wire x1="71.12" y1="88.9" x2="0" y2="88.9" width="0.1524" layer="94"/>
<wire x1="223.52" y1="276.86" x2="223.52" y2="175.26" width="0.1524" layer="94"/>
<wire x1="223.52" y1="175.26" x2="223.52" y2="154.94" width="0.1524" layer="94"/>
<wire x1="223.52" y1="154.94" x2="162.56" y2="154.94" width="0.1524" layer="94"/>
<wire x1="167.64" y1="134.62" x2="167.64" y2="88.9" width="0.1524" layer="94"/>
<wire x1="167.64" y1="88.9" x2="71.12" y2="88.9" width="0.1524" layer="94"/>
<text x="226.06" y="271.78" size="2.54" layer="94" font="vector">Composite video interface</text>
<wire x1="223.52" y1="175.26" x2="269.24" y2="175.26" width="0.1524" layer="94"/>
<wire x1="269.24" y1="175.26" x2="398.78" y2="175.26" width="0.1524" layer="94"/>
<wire x1="269.24" y1="175.26" x2="269.24" y2="0" width="0.1524" layer="94"/>
<text x="271.78" y="170.18" size="2.54" layer="94" font="vector">Board connectors and level shifters</text>
</plain>
<instances>
<instance part="R5" gate="G$1" x="193.04" y="172.72"/>
<instance part="R6" gate="G$1" x="193.04" y="165.1"/>
<instance part="R4" gate="G$1" x="193.04" y="264.16"/>
<instance part="R8" gate="G$1" x="193.04" y="256.54"/>
<instance part="R9" gate="G$1" x="193.04" y="248.92"/>
<instance part="R10" gate="G$1" x="193.04" y="241.3"/>
<instance part="R11" gate="G$1" x="193.04" y="233.68"/>
<instance part="R12" gate="G$1" x="193.04" y="226.06"/>
<instance part="R17" gate="G$1" x="193.04" y="218.44"/>
<instance part="R18" gate="G$1" x="193.04" y="210.82"/>
<instance part="R19" gate="G$1" x="193.04" y="203.2"/>
<instance part="R20" gate="G$1" x="193.04" y="195.58"/>
<instance part="R21" gate="G$1" x="193.04" y="187.96"/>
<instance part="R22" gate="G$1" x="193.04" y="180.34"/>
<instance part="U1" gate="_" x="38.1" y="264.16"/>
<instance part="U$1" gate="G$1" x="88.9" y="185.42"/>
<instance part="C6" gate="G$1" x="101.6" y="208.28" rot="R90"/>
<instance part="C7" gate="G$1" x="111.76" y="208.28" rot="R90"/>
<instance part="C8" gate="G$1" x="121.92" y="208.28" rot="R90"/>
<instance part="C9" gate="G$1" x="132.08" y="208.28" rot="R90"/>
<instance part="C10" gate="G$1" x="142.24" y="208.28" rot="R90"/>
<instance part="C11" gate="G$1" x="152.4" y="208.28" rot="R90"/>
<instance part="U$6" gate="G$1" x="101.6" y="203.2"/>
<instance part="U$7" gate="G$1" x="111.76" y="203.2"/>
<instance part="U$8" gate="G$1" x="121.92" y="203.2"/>
<instance part="U$9" gate="G$1" x="132.08" y="203.2"/>
<instance part="U$10" gate="G$1" x="142.24" y="203.2"/>
<instance part="U$11" gate="G$1" x="152.4" y="203.2"/>
<instance part="U$15" gate="G$1" x="152.4" y="218.44"/>
<instance part="C12" gate="G$1" x="101.6" y="180.34" rot="R90"/>
<instance part="C13" gate="G$1" x="111.76" y="180.34" rot="R90"/>
<instance part="C14" gate="G$1" x="121.92" y="180.34" rot="R90"/>
<instance part="C15" gate="G$1" x="132.08" y="180.34" rot="R90"/>
<instance part="U$16" gate="G$1" x="101.6" y="175.26"/>
<instance part="U$17" gate="G$1" x="111.76" y="175.26"/>
<instance part="U$18" gate="G$1" x="121.92" y="175.26"/>
<instance part="U$19" gate="G$1" x="132.08" y="175.26"/>
<instance part="U$20" gate="G$1" x="152.4" y="190.5"/>
<instance part="C16" gate="G$1" x="111.76" y="157.48" rot="R90"/>
<instance part="C17" gate="G$1" x="121.92" y="157.48" rot="R90"/>
<instance part="U$22" gate="G$1" x="111.76" y="152.4"/>
<instance part="U$23" gate="G$1" x="121.92" y="152.4"/>
<instance part="R40" gate="G$1" x="101.6" y="165.1"/>
<instance part="R41" gate="G$1" x="132.08" y="165.1"/>
<instance part="U7" gate="_" x="27.94" y="38.1"/>
<instance part="GND41" gate="G$1" x="20.32" y="22.86"/>
<instance part="C69" gate="G$1" x="10.16" y="27.94" rot="R90"/>
<instance part="GND42" gate="G$1" x="10.16" y="22.86"/>
<instance part="R23" gate="G$1" x="71.12" y="27.94" rot="R90"/>
<instance part="R24" gate="G$1" x="71.12" y="12.7" rot="R90"/>
<instance part="GND43" gate="G$1" x="71.12" y="7.62"/>
<instance part="L14" gate="G$1" x="60.96" y="35.56" smashed="yes">
<attribute name="NAME" x="53.34" y="40.64" size="1.778" layer="95"/>
<attribute name="VALUE" x="53.34" y="38.1" size="1.778" layer="96"/>
</instance>
<instance part="C70" gate="G$1" x="81.28" y="27.94" rot="R90"/>
<instance part="GND44" gate="G$1" x="81.28" y="22.86"/>
<instance part="U5" gate="_" x="25.4" y="121.92"/>
<instance part="GND47" gate="G$1" x="17.78" y="109.22"/>
<instance part="C18" gate="G$1" x="10.16" y="111.76" rot="R90"/>
<instance part="GND48" gate="G$1" x="10.16" y="106.68"/>
<instance part="U$26" gate="G$1" x="10.16" y="38.1"/>
<instance part="U$5" gate="G$1" x="10.16" y="121.92"/>
<instance part="U4" gate="_" x="119.38" y="119.38"/>
<instance part="GND11" gate="G$1" x="152.4" y="101.6"/>
<instance part="U$31" gate="G$1" x="157.48" y="119.38"/>
<instance part="R43" gate="G$1" x="101.6" y="104.14"/>
<instance part="R44" gate="G$1" x="101.6" y="96.52"/>
<instance part="U$32" gate="G$1" x="88.9" y="99.06"/>
<instance part="C23" gate="G$1" x="157.48" y="109.22" rot="R90"/>
<instance part="GND12" gate="G$1" x="157.48" y="101.6"/>
<instance part="U8" gate="_" x="119.38" y="38.1"/>
<instance part="GND15" gate="G$1" x="111.76" y="22.86"/>
<instance part="C25" gate="G$1" x="101.6" y="27.94" rot="R90"/>
<instance part="GND20" gate="G$1" x="101.6" y="22.86"/>
<instance part="R13" gate="G$1" x="162.56" y="27.94" rot="R90"/>
<instance part="R45" gate="G$1" x="162.56" y="12.7" rot="R90"/>
<instance part="GND21" gate="G$1" x="162.56" y="7.62"/>
<instance part="L1" gate="G$1" x="152.4" y="35.56" smashed="yes">
<attribute name="NAME" x="144.78" y="40.64" size="1.778" layer="95"/>
<attribute name="VALUE" x="144.78" y="38.1" size="1.778" layer="96"/>
</instance>
<instance part="C26" gate="G$1" x="172.72" y="27.94" rot="R90"/>
<instance part="GND23" gate="G$1" x="172.72" y="22.86"/>
<instance part="U$34" gate="G$1" x="101.6" y="38.1"/>
<instance part="U$35" gate="G$1" x="81.28" y="38.1"/>
<instance part="U$14" gate="G$1" x="172.72" y="38.1"/>
<instance part="R46" gate="G$1" x="78.74" y="116.84" rot="MR270"/>
<instance part="U$38" gate="G$1" x="78.74" y="121.92"/>
<instance part="R1" gate="G$1" x="254" y="182.88"/>
<instance part="R3" gate="G$1" x="254" y="264.16"/>
<instance part="R7" gate="G$1" x="254" y="256.54"/>
<instance part="R14" gate="G$1" x="254" y="248.92"/>
<instance part="R15" gate="G$1" x="254" y="241.3"/>
<instance part="R16" gate="G$1" x="254" y="215.9"/>
<instance part="R25" gate="G$1" x="254" y="208.28"/>
<instance part="R26" gate="G$1" x="254" y="200.66"/>
<instance part="R27" gate="G$1" x="254" y="193.04"/>
<instance part="R2" gate="G$1" x="254" y="231.14"/>
<instance part="U$2" gate="G$1" x="246.38" y="228.6"/>
<instance part="R28" gate="G$1" x="269.24" y="256.54" rot="MR270"/>
<instance part="R29" gate="G$1" x="269.24" y="208.28" rot="MR270"/>
<instance part="U$3" gate="G$1" x="269.24" y="251.46"/>
<instance part="U$4" gate="G$1" x="269.24" y="203.2"/>
<instance part="U2" gate="_" x="307.34" y="269.24"/>
<instance part="R30" gate="G$1" x="353.06" y="261.62"/>
<instance part="R31" gate="G$1" x="353.06" y="233.68"/>
<instance part="R32" gate="G$1" x="353.06" y="213.36"/>
<instance part="U$12" gate="G$1" x="299.72" y="248.92"/>
<instance part="C1" gate="G$1" x="284.48" y="228.6" rot="R90"/>
<instance part="U$24" gate="G$1" x="284.48" y="223.52"/>
<instance part="C2" gate="G$1" x="294.64" y="228.6" rot="R90"/>
<instance part="GND1" gate="G$1" x="294.64" y="223.52"/>
<instance part="C3" gate="G$1" x="365.76" y="223.52"/>
<instance part="R33" gate="G$1" x="353.06" y="223.52"/>
<instance part="U$27" gate="G$1" x="375.92" y="22.86"/>
<instance part="U3" gate="_" x="304.8" y="165.1"/>
<instance part="GND2" gate="G$1" x="297.18" y="129.54"/>
<instance part="GND4" gate="G$1" x="330.2" y="129.54"/>
<instance part="U$33" gate="G$1" x="337.82" y="132.08"/>
<instance part="R34" gate="G$1" x="12.7" y="167.64" rot="MR270"/>
<instance part="R35" gate="G$1" x="20.32" y="167.64" rot="MR270"/>
<instance part="U$36" gate="G$1" x="12.7" y="177.8"/>
<instance part="J3" gate="_" x="53.34" y="165.1"/>
<instance part="U$37" gate="G$1" x="45.72" y="165.1"/>
<instance part="U$39" gate="G$1" x="45.72" y="142.24"/>
<instance part="J4" gate="_" x="383.54" y="116.84" rot="MR180"/>
<instance part="J1" gate="_" x="383.54" y="71.12"/>
<instance part="U$29" gate="G$1" x="375.92" y="71.12"/>
<instance part="C4" gate="G$1" x="302.26" y="45.72" rot="R90"/>
<instance part="U$40" gate="G$1" x="302.26" y="40.64"/>
<instance part="C5" gate="G$1" x="312.42" y="45.72" rot="R90"/>
<instance part="U$42" gate="G$1" x="312.42" y="40.64"/>
<instance part="U$41" gate="G$1" x="312.42" y="50.8"/>
<instance part="R36" gate="G$1" x="304.8" y="236.22"/>
<instance part="U$13" gate="G$1" x="312.42" y="238.76"/>
<instance part="U$43" gate="G$1" x="302.26" y="50.8"/>
<instance part="U6" gate="_" x="322.58" y="63.5" rot="R180"/>
<instance part="U$28" gate="G$1" x="335.28" y="66.04"/>
<instance part="U$25" gate="G$1" x="292.1" y="66.04"/>
<instance part="GND3" gate="G$1" x="292.1" y="99.06"/>
<instance part="U9" gate="_" x="304.8" y="121.92"/>
<instance part="GND5" gate="G$1" x="327.66" y="111.76"/>
<instance part="U$21" gate="G$1" x="292.1" y="111.76"/>
<instance part="C19" gate="G$1" x="322.58" y="45.72" rot="R90"/>
<instance part="U$30" gate="G$1" x="322.58" y="40.64"/>
<instance part="U$44" gate="G$1" x="322.58" y="50.8"/>
<instance part="FRAME1" gate="G$1" x="0" y="0"/>
<instance part="FRAME1" gate="G$2" x="297.18" y="0"/>
<instance part="FD1" gate="_" x="185.42" y="12.7"/>
<instance part="FD2" gate="_" x="198.12" y="12.7"/>
<instance part="FD3" gate="_" x="210.82" y="12.7"/>
</instances>
<busses>
</busses>
<nets>
<net name="GND" class="0">
<segment>
<pinref part="U1" gate="_" pin="GND"/>
<pinref part="U$1" gate="G$1" pin="GND"/>
<wire x1="88.9" y1="187.96" x2="86.36" y2="187.96" width="0.1524" layer="91"/>
<wire x1="88.9" y1="185.42" x2="88.9" y2="187.96" width="0.1524" layer="91"/>
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
<wire x1="22.86" y1="25.4" x2="20.32" y2="25.4" width="0.1524" layer="91"/>
<wire x1="20.32" y1="25.4" x2="20.32" y2="22.86" width="0.1524" layer="91"/>
<pinref part="U7" gate="_" pin="GND"/>
<pinref part="GND41" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C69" gate="G$1" pin="1"/>
<pinref part="GND42" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="R24" gate="G$1" pin="1"/>
<pinref part="GND43" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C70" gate="G$1" pin="1"/>
<pinref part="GND44" gate="G$1" pin="GND"/>
</segment>
<segment>
<wire x1="20.32" y1="111.76" x2="17.78" y2="111.76" width="0.1524" layer="91"/>
<wire x1="17.78" y1="111.76" x2="17.78" y2="109.22" width="0.1524" layer="91"/>
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
<wire x1="157.48" y1="104.14" x2="157.48" y2="101.6" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="114.3" y1="25.4" x2="111.76" y2="25.4" width="0.1524" layer="91"/>
<wire x1="111.76" y1="25.4" x2="111.76" y2="22.86" width="0.1524" layer="91"/>
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
<pinref part="U$2" gate="G$1" pin="GND"/>
<wire x1="246.38" y1="228.6" x2="246.38" y2="231.14" width="0.1524" layer="91"/>
<pinref part="R2" gate="G$1" pin="1"/>
<wire x1="246.38" y1="231.14" x2="248.92" y2="231.14" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="R28" gate="G$1" pin="2"/>
<pinref part="U$3" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="R29" gate="G$1" pin="2"/>
<pinref part="U$4" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U2" gate="_" pin="GND"/>
<wire x1="302.26" y1="251.46" x2="299.72" y2="251.46" width="0.1524" layer="91"/>
<wire x1="299.72" y1="251.46" x2="299.72" y2="248.92" width="0.1524" layer="91"/>
<pinref part="U$12" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C1" gate="G$1" pin="1"/>
<pinref part="U$24" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C2" gate="G$1" pin="1"/>
<pinref part="GND1" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U$27" gate="G$1" pin="GND"/>
<wire x1="375.92" y1="38.1" x2="375.92" y2="33.02" width="0.1524" layer="91"/>
<wire x1="375.92" y1="33.02" x2="375.92" y2="25.4" width="0.1524" layer="91"/>
<wire x1="375.92" y1="25.4" x2="375.92" y2="22.86" width="0.1524" layer="91"/>
<wire x1="378.46" y1="25.4" x2="375.92" y2="25.4" width="0.1524" layer="91"/>
<junction x="375.92" y="25.4"/>
<wire x1="378.46" y1="33.02" x2="375.92" y2="33.02" width="0.1524" layer="91"/>
<junction x="375.92" y="33.02"/>
<wire x1="375.92" y1="38.1" x2="375.92" y2="43.18" width="0.1524" layer="91"/>
<wire x1="375.92" y1="43.18" x2="375.92" y2="50.8" width="0.1524" layer="91"/>
<wire x1="375.92" y1="50.8" x2="375.92" y2="55.88" width="0.1524" layer="91"/>
<wire x1="375.92" y1="55.88" x2="375.92" y2="60.96" width="0.1524" layer="91"/>
<wire x1="378.46" y1="38.1" x2="375.92" y2="38.1" width="0.1524" layer="91"/>
<junction x="375.92" y="38.1"/>
<wire x1="378.46" y1="43.18" x2="375.92" y2="43.18" width="0.1524" layer="91"/>
<junction x="375.92" y="43.18"/>
<wire x1="378.46" y1="60.96" x2="375.92" y2="60.96" width="0.1524" layer="91"/>
<wire x1="378.46" y1="55.88" x2="375.92" y2="55.88" width="0.1524" layer="91"/>
<junction x="375.92" y="55.88"/>
<wire x1="378.46" y1="50.8" x2="375.92" y2="50.8" width="0.1524" layer="91"/>
<junction x="375.92" y="50.8"/>
<pinref part="J1" gate="_" pin="4"/>
<pinref part="J1" gate="_" pin="6"/>
<pinref part="J1" gate="_" pin="8"/>
<pinref part="J1" gate="_" pin="11"/>
<pinref part="J1" gate="_" pin="13"/>
<pinref part="J1" gate="_" pin="15"/>
<pinref part="J1" gate="_" pin="18"/>
<pinref part="J1" gate="_" pin="2"/>
<wire x1="378.46" y1="66.04" x2="375.92" y2="66.04" width="0.1524" layer="91"/>
<wire x1="375.92" y1="66.04" x2="375.92" y2="63.5" width="0.1524" layer="91"/>
<junction x="375.92" y="60.96"/>
<pinref part="J1" gate="_" pin="3"/>
<wire x1="375.92" y1="63.5" x2="375.92" y2="60.96" width="0.1524" layer="91"/>
<wire x1="378.46" y1="63.5" x2="375.92" y2="63.5" width="0.1524" layer="91"/>
<junction x="375.92" y="63.5"/>
</segment>
<segment>
<pinref part="U3" gate="_" pin="OE#"/>
<wire x1="299.72" y1="132.08" x2="297.18" y2="132.08" width="0.1524" layer="91"/>
<pinref part="GND2" gate="G$1" pin="GND"/>
<wire x1="297.18" y1="132.08" x2="297.18" y2="129.54" width="0.1524" layer="91"/>
<pinref part="U3" gate="_" pin="A10"/>
<wire x1="299.72" y1="139.7" x2="297.18" y2="139.7" width="0.1524" layer="91"/>
<wire x1="297.18" y1="139.7" x2="297.18" y2="132.08" width="0.1524" layer="91"/>
<junction x="297.18" y="132.08"/>
</segment>
<segment>
<pinref part="U3" gate="_" pin="GND"/>
<wire x1="327.66" y1="132.08" x2="330.2" y2="132.08" width="0.1524" layer="91"/>
<wire x1="330.2" y1="132.08" x2="330.2" y2="129.54" width="0.1524" layer="91"/>
<pinref part="GND4" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U$39" gate="G$1" pin="GND"/>
<wire x1="45.72" y1="142.24" x2="45.72" y2="144.78" width="0.1524" layer="91"/>
<wire x1="45.72" y1="144.78" x2="48.26" y2="144.78" width="0.1524" layer="91"/>
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
<wire x1="378.46" y1="139.7" x2="358.14" y2="139.7" width="0.1524" layer="91"/>
<label x="360.68" y="139.7" size="1.778" layer="95"/>
<pinref part="J4" gate="_" pin="9"/>
</segment>
<segment>
<pinref part="U6" gate="_" pin="GND@3"/>
<wire x1="299.72" y1="101.6" x2="297.18" y2="101.6" width="0.1524" layer="91"/>
<wire x1="297.18" y1="101.6" x2="297.18" y2="99.06" width="0.1524" layer="91"/>
<pinref part="U6" gate="_" pin="GND@1"/>
<wire x1="297.18" y1="99.06" x2="297.18" y2="96.52" width="0.1524" layer="91"/>
<wire x1="297.18" y1="96.52" x2="299.72" y2="96.52" width="0.1524" layer="91"/>
<pinref part="U6" gate="_" pin="GND@2"/>
<wire x1="299.72" y1="99.06" x2="297.18" y2="99.06" width="0.1524" layer="91"/>
<junction x="297.18" y="99.06"/>
<wire x1="297.18" y1="101.6" x2="292.1" y2="101.6" width="0.1524" layer="91"/>
<junction x="297.18" y="101.6"/>
<wire x1="292.1" y1="101.6" x2="292.1" y2="99.06" width="0.1524" layer="91"/>
<pinref part="GND3" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U9" gate="_" pin="GND"/>
<wire x1="325.12" y1="114.3" x2="327.66" y2="114.3" width="0.1524" layer="91"/>
<pinref part="GND5" gate="G$1" pin="GND"/>
<wire x1="327.66" y1="114.3" x2="327.66" y2="111.76" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C19" gate="G$1" pin="1"/>
<pinref part="U$30" gate="G$1" pin="GND"/>
</segment>
</net>
<net name="VGA_HSYNC" class="0">
<segment>
<wire x1="167.64" y1="172.72" x2="187.96" y2="172.72" width="0.1524" layer="91"/>
<label x="170.18" y="172.72" size="1.778" layer="95" font="vector"/>
<pinref part="R5" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="261.62" x2="33.02" y2="261.62" width="0.1524" layer="91"/>
<label x="10.16" y="261.62" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_3B_G6"/>
</segment>
<segment>
<wire x1="228.6" y1="182.88" x2="248.92" y2="182.88" width="0.1524" layer="91"/>
<label x="231.14" y="182.88" size="1.778" layer="95" font="vector"/>
<pinref part="R1" gate="G$1" pin="1"/>
</segment>
</net>
<net name="VGA_VSYNC" class="0">
<segment>
<wire x1="167.64" y1="165.1" x2="187.96" y2="165.1" width="0.1524" layer="91"/>
<label x="170.18" y="165.1" size="1.778" layer="95" font="vector"/>
<pinref part="R6" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="259.08" x2="33.02" y2="259.08" width="0.1524" layer="91"/>
<label x="10.16" y="259.08" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_5B"/>
</segment>
</net>
<net name="VGA_HS" class="0">
<segment>
<wire x1="198.12" y1="172.72" x2="218.44" y2="172.72" width="0.1524" layer="91"/>
<pinref part="R5" gate="G$1" pin="2"/>
<label x="208.28" y="172.72" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="378.46" y1="27.94" x2="353.06" y2="27.94" width="0.1524" layer="91"/>
<label x="355.6" y="27.94" size="1.778" layer="95" font="vector"/>
<pinref part="J1" gate="_" pin="17"/>
</segment>
</net>
<net name="VGA_VS" class="0">
<segment>
<wire x1="218.44" y1="165.1" x2="198.12" y2="165.1" width="0.1524" layer="91"/>
<pinref part="R6" gate="G$1" pin="2"/>
<label x="208.28" y="165.1" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="353.06" y1="30.48" x2="378.46" y2="30.48" width="0.1524" layer="91"/>
<label x="355.6" y="30.48" size="1.778" layer="95" font="vector"/>
<pinref part="J1" gate="_" pin="16"/>
</segment>
</net>
<net name="BUS_A1" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_44B"/>
<wire x1="111.76" y1="243.84" x2="86.36" y2="243.84" width="0.1524" layer="91"/>
<label x="88.9" y="243.84" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="299.72" y1="149.86" x2="276.86" y2="149.86" width="0.1524" layer="91"/>
<label x="279.4" y="149.86" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A6"/>
</segment>
</net>
<net name="BUS_PHY2" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_45A_G1"/>
<wire x1="111.76" y1="236.22" x2="86.36" y2="236.22" width="0.1524" layer="91"/>
<label x="88.9" y="236.22" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="299.72" y1="154.94" x2="276.86" y2="154.94" width="0.1524" layer="91"/>
<label x="279.4" y="154.94" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A4"/>
</segment>
</net>
<net name="BUS_A2" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_48B"/>
<wire x1="111.76" y1="238.76" x2="86.36" y2="238.76" width="0.1524" layer="91"/>
<label x="88.9" y="238.76" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="299.72" y1="152.4" x2="276.86" y2="152.4" width="0.1524" layer="91"/>
<label x="279.4" y="152.4" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A5"/>
</segment>
</net>
<net name="SPI_SCK" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOB_34A_SPI_SCK"/>
<wire x1="7.62" y1="218.44" x2="33.02" y2="218.44" width="0.1524" layer="91"/>
<label x="10.16" y="218.44" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<pinref part="U4" gate="_" pin="CLK"/>
<wire x1="114.3" y1="116.84" x2="88.9" y2="116.84" width="0.1524" layer="91"/>
<label x="91.44" y="116.84" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="22.86" y1="149.86" x2="48.26" y2="149.86" width="0.1524" layer="91"/>
<label x="25.4" y="149.86" size="1.778" layer="95" font="vector"/>
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
<wire x1="7.62" y1="220.98" x2="33.02" y2="220.98" width="0.1524" layer="91"/>
<label x="10.16" y="220.98" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="22.86" y1="152.4" x2="48.26" y2="152.4" width="0.1524" layer="91"/>
<label x="25.4" y="152.4" size="1.778" layer="95" font="vector"/>
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
<wire x1="7.62" y1="213.36" x2="33.02" y2="213.36" width="0.1524" layer="91"/>
<label x="10.16" y="213.36" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="22.86" y1="154.94" x2="48.26" y2="154.94" width="0.1524" layer="91"/>
<label x="25.4" y="154.94" size="1.778" layer="95" font="vector"/>
<pinref part="J3" gate="_" pin="4"/>
</segment>
</net>
<net name="BUS_D3" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOB_23B"/>
<wire x1="7.62" y1="203.2" x2="33.02" y2="203.2" width="0.1524" layer="91"/>
<label x="10.16" y="203.2" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="276.86" y1="81.28" x2="299.72" y2="81.28" width="0.1524" layer="91"/>
<label x="279.4" y="81.28" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B3"/>
</segment>
</net>
<net name="+5V" class="1">
<segment>
<wire x1="22.86" y1="30.48" x2="20.32" y2="30.48" width="0.1524" layer="91"/>
<wire x1="20.32" y1="30.48" x2="20.32" y2="35.56" width="0.1524" layer="91"/>
<wire x1="20.32" y1="35.56" x2="22.86" y2="35.56" width="0.1524" layer="91"/>
<wire x1="20.32" y1="35.56" x2="10.16" y2="35.56" width="0.1524" layer="91"/>
<wire x1="10.16" y1="35.56" x2="10.16" y2="38.1" width="0.1524" layer="91"/>
<wire x1="10.16" y1="33.02" x2="10.16" y2="35.56" width="0.1524" layer="91"/>
<junction x="20.32" y="35.56"/>
<junction x="10.16" y="35.56"/>
<pinref part="U7" gate="_" pin="EN"/>
<pinref part="U7" gate="_" pin="VIN"/>
<pinref part="C69" gate="G$1" pin="2"/>
<pinref part="U$26" gate="G$1" pin="+5V"/>
</segment>
<segment>
<wire x1="114.3" y1="30.48" x2="111.76" y2="30.48" width="0.1524" layer="91"/>
<wire x1="111.76" y1="30.48" x2="111.76" y2="35.56" width="0.1524" layer="91"/>
<wire x1="111.76" y1="35.56" x2="114.3" y2="35.56" width="0.1524" layer="91"/>
<wire x1="111.76" y1="35.56" x2="101.6" y2="35.56" width="0.1524" layer="91"/>
<wire x1="101.6" y1="35.56" x2="101.6" y2="38.1" width="0.1524" layer="91"/>
<wire x1="101.6" y1="33.02" x2="101.6" y2="35.56" width="0.1524" layer="91"/>
<junction x="111.76" y="35.56"/>
<junction x="101.6" y="35.56"/>
<pinref part="U8" gate="_" pin="EN"/>
<pinref part="U8" gate="_" pin="VIN"/>
<pinref part="C25" gate="G$1" pin="2"/>
<pinref part="U$34" gate="G$1" pin="+5V"/>
</segment>
<segment>
<pinref part="U3" gate="_" pin="VCC"/>
<wire x1="327.66" y1="134.62" x2="332.74" y2="134.62" width="0.1524" layer="91"/>
<wire x1="332.74" y1="134.62" x2="332.74" y2="129.54" width="0.1524" layer="91"/>
<wire x1="332.74" y1="129.54" x2="337.82" y2="129.54" width="0.1524" layer="91"/>
<pinref part="U$33" gate="G$1" pin="+5V"/>
<wire x1="337.82" y1="129.54" x2="337.82" y2="132.08" width="0.1524" layer="91"/>
</segment>
<segment>
<wire x1="48.26" y1="162.56" x2="45.72" y2="162.56" width="0.1524" layer="91"/>
<wire x1="45.72" y1="162.56" x2="45.72" y2="165.1" width="0.1524" layer="91"/>
<pinref part="U$37" gate="G$1" pin="+5V"/>
<pinref part="J3" gate="_" pin="1"/>
</segment>
<segment>
<wire x1="378.46" y1="68.58" x2="375.92" y2="68.58" width="0.1524" layer="91"/>
<wire x1="375.92" y1="68.58" x2="375.92" y2="71.12" width="0.1524" layer="91"/>
<pinref part="U$29" gate="G$1" pin="+5V"/>
<pinref part="J1" gate="_" pin="1"/>
</segment>
<segment>
<pinref part="C5" gate="G$1" pin="2"/>
<pinref part="U$41" gate="G$1" pin="+5V"/>
</segment>
<segment>
<wire x1="327.66" y1="66.04" x2="330.2" y2="66.04" width="0.1524" layer="91"/>
<wire x1="330.2" y1="66.04" x2="330.2" y2="63.5" width="0.1524" layer="91"/>
<wire x1="330.2" y1="63.5" x2="335.28" y2="63.5" width="0.1524" layer="91"/>
<pinref part="U$28" gate="G$1" pin="+5V"/>
<wire x1="335.28" y1="63.5" x2="335.28" y2="66.04" width="0.1524" layer="91"/>
<pinref part="U6" gate="_" pin="VCCA"/>
</segment>
<segment>
<pinref part="U9" gate="_" pin="VCC"/>
<wire x1="299.72" y1="114.3" x2="297.18" y2="114.3" width="0.1524" layer="91"/>
<wire x1="297.18" y1="114.3" x2="297.18" y2="109.22" width="0.1524" layer="91"/>
<wire x1="297.18" y1="109.22" x2="292.1" y2="109.22" width="0.1524" layer="91"/>
<wire x1="292.1" y1="109.22" x2="292.1" y2="111.76" width="0.1524" layer="91"/>
<pinref part="U$21" gate="G$1" pin="+5V"/>
</segment>
<segment>
<pinref part="C19" gate="G$1" pin="2"/>
<pinref part="U$44" gate="G$1" pin="+5V"/>
</segment>
</net>
<net name="VGA_R" class="0">
<segment>
<wire x1="218.44" y1="264.16" x2="200.66" y2="264.16" width="0.1524" layer="91"/>
<pinref part="R4" gate="G$1" pin="2"/>
<wire x1="198.12" y1="264.16" x2="200.66" y2="264.16" width="0.1524" layer="91"/>
<pinref part="R8" gate="G$1" pin="2"/>
<wire x1="200.66" y1="256.54" x2="200.66" y2="264.16" width="0.1524" layer="91"/>
<junction x="200.66" y="264.16"/>
<label x="208.28" y="264.16" size="1.778" layer="95"/>
<pinref part="R9" gate="G$1" pin="2"/>
<pinref part="R10" gate="G$1" pin="2"/>
<wire x1="200.66" y1="248.92" x2="198.12" y2="248.92" width="0.1524" layer="91"/>
<wire x1="198.12" y1="241.3" x2="200.66" y2="241.3" width="0.1524" layer="91"/>
<wire x1="200.66" y1="241.3" x2="200.66" y2="248.92" width="0.1524" layer="91"/>
<junction x="200.66" y="248.92"/>
<wire x1="198.12" y1="256.54" x2="200.66" y2="256.54" width="0.1524" layer="91"/>
<wire x1="200.66" y1="256.54" x2="200.66" y2="248.92" width="0.1524" layer="91"/>
<junction x="200.66" y="256.54"/>
</segment>
<segment>
<wire x1="378.46" y1="45.72" x2="353.06" y2="45.72" width="0.1524" layer="91"/>
<label x="355.6" y="45.72" size="1.778" layer="95" font="vector"/>
<pinref part="J1" gate="_" pin="10"/>
</segment>
</net>
<net name="VGA_B" class="0">
<segment>
<pinref part="R19" gate="G$1" pin="2"/>
<wire x1="198.12" y1="203.2" x2="200.66" y2="203.2" width="0.1524" layer="91"/>
<pinref part="R20" gate="G$1" pin="2"/>
<wire x1="198.12" y1="195.58" x2="200.66" y2="195.58" width="0.1524" layer="91"/>
<wire x1="200.66" y1="195.58" x2="200.66" y2="203.2" width="0.1524" layer="91"/>
<junction x="200.66" y="203.2"/>
<pinref part="R21" gate="G$1" pin="2"/>
<wire x1="198.12" y1="187.96" x2="200.66" y2="187.96" width="0.1524" layer="91"/>
<wire x1="200.66" y1="187.96" x2="200.66" y2="195.58" width="0.1524" layer="91"/>
<junction x="200.66" y="195.58"/>
<pinref part="R22" gate="G$1" pin="2"/>
<wire x1="198.12" y1="180.34" x2="200.66" y2="180.34" width="0.1524" layer="91"/>
<wire x1="200.66" y1="180.34" x2="200.66" y2="187.96" width="0.1524" layer="91"/>
<junction x="200.66" y="187.96"/>
<wire x1="218.44" y1="203.2" x2="200.66" y2="203.2" width="0.1524" layer="91"/>
<label x="208.28" y="203.2" size="1.778" layer="95"/>
</segment>
<segment>
<wire x1="378.46" y1="35.56" x2="353.06" y2="35.56" width="0.1524" layer="91"/>
<label x="355.6" y="35.56" size="1.778" layer="95" font="vector"/>
<pinref part="J1" gate="_" pin="14"/>
</segment>
</net>
<net name="VGA_G1" class="0">
<segment>
<wire x1="167.64" y1="218.44" x2="187.96" y2="218.44" width="0.1524" layer="91"/>
<label x="170.18" y="218.44" size="1.778" layer="95" font="vector"/>
<pinref part="R17" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="243.84" x2="33.02" y2="243.84" width="0.1524" layer="91"/>
<label x="10.16" y="243.84" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_8A"/>
</segment>
<segment>
<wire x1="228.6" y1="200.66" x2="248.92" y2="200.66" width="0.1524" layer="91"/>
<label x="231.14" y="200.66" size="1.778" layer="95" font="vector"/>
<pinref part="R26" gate="G$1" pin="1"/>
</segment>
</net>
<net name="VGA_G2" class="0">
<segment>
<wire x1="167.64" y1="226.06" x2="187.96" y2="226.06" width="0.1524" layer="91"/>
<label x="170.18" y="226.06" size="1.778" layer="95" font="vector"/>
<pinref part="R12" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="241.3" x2="33.02" y2="241.3" width="0.1524" layer="91"/>
<label x="10.16" y="241.3" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_13B"/>
</segment>
<segment>
<wire x1="228.6" y1="208.28" x2="248.92" y2="208.28" width="0.1524" layer="91"/>
<label x="231.14" y="208.28" size="1.778" layer="95" font="vector"/>
<pinref part="R25" gate="G$1" pin="1"/>
</segment>
</net>
<net name="VGA_G3" class="0">
<segment>
<wire x1="167.64" y1="233.68" x2="187.96" y2="233.68" width="0.1524" layer="91"/>
<label x="170.18" y="233.68" size="1.778" layer="95" font="vector"/>
<pinref part="R11" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="233.68" x2="33.02" y2="233.68" width="0.1524" layer="91"/>
<label x="10.16" y="233.68" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_16A"/>
</segment>
<segment>
<wire x1="228.6" y1="215.9" x2="248.92" y2="215.9" width="0.1524" layer="91"/>
<label x="231.14" y="215.9" size="1.778" layer="95" font="vector"/>
<pinref part="R16" gate="G$1" pin="1"/>
</segment>
</net>
<net name="VGA_R0" class="0">
<segment>
<wire x1="167.64" y1="241.3" x2="187.96" y2="241.3" width="0.1524" layer="91"/>
<label x="170.18" y="241.3" size="1.778" layer="95" font="vector"/>
<pinref part="R10" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="231.14" x2="33.02" y2="231.14" width="0.1524" layer="91"/>
<label x="10.16" y="231.14" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_18A"/>
</segment>
<segment>
<wire x1="228.6" y1="241.3" x2="248.92" y2="241.3" width="0.1524" layer="91"/>
<label x="231.14" y="241.3" size="1.778" layer="95" font="vector"/>
<pinref part="R15" gate="G$1" pin="1"/>
</segment>
</net>
<net name="VGA_R1" class="0">
<segment>
<wire x1="167.64" y1="248.92" x2="187.96" y2="248.92" width="0.1524" layer="91"/>
<label x="170.18" y="248.92" size="1.778" layer="95" font="vector"/>
<pinref part="R9" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="228.6" x2="33.02" y2="228.6" width="0.1524" layer="91"/>
<label x="10.16" y="228.6" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_20A"/>
</segment>
<segment>
<wire x1="228.6" y1="248.92" x2="248.92" y2="248.92" width="0.1524" layer="91"/>
<label x="231.14" y="248.92" size="1.778" layer="95" font="vector"/>
<pinref part="R14" gate="G$1" pin="1"/>
</segment>
</net>
<net name="VGA_B0" class="0">
<segment>
<wire x1="167.64" y1="180.34" x2="187.96" y2="180.34" width="0.1524" layer="91"/>
<label x="170.18" y="180.34" size="1.778" layer="95" font="vector"/>
<pinref part="R22" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="256.54" x2="33.02" y2="256.54" width="0.1524" layer="91"/>
<label x="10.16" y="256.54" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_0A"/>
</segment>
</net>
<net name="VGA_B1" class="0">
<segment>
<wire x1="167.64" y1="187.96" x2="187.96" y2="187.96" width="0.1524" layer="91"/>
<label x="170.18" y="187.96" size="1.778" layer="95" font="vector"/>
<pinref part="R21" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="254" x2="33.02" y2="254" width="0.1524" layer="91"/>
<label x="10.16" y="254" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_2A"/>
</segment>
</net>
<net name="VGA_B2" class="0">
<segment>
<wire x1="167.64" y1="195.58" x2="187.96" y2="195.58" width="0.1524" layer="91"/>
<label x="170.18" y="195.58" size="1.778" layer="95" font="vector"/>
<pinref part="R20" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="251.46" x2="33.02" y2="251.46" width="0.1524" layer="91"/>
<label x="10.16" y="251.46" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_4A"/>
</segment>
</net>
<net name="VGA_B3" class="0">
<segment>
<wire x1="167.64" y1="203.2" x2="187.96" y2="203.2" width="0.1524" layer="91"/>
<label x="170.18" y="203.2" size="1.778" layer="95" font="vector"/>
<pinref part="R19" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="248.92" x2="33.02" y2="248.92" width="0.1524" layer="91"/>
<label x="10.16" y="248.92" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_6A"/>
</segment>
</net>
<net name="VGA_R2" class="0">
<segment>
<wire x1="167.64" y1="256.54" x2="187.96" y2="256.54" width="0.1524" layer="91"/>
<label x="170.18" y="256.54" size="1.778" layer="95" font="vector"/>
<pinref part="R8" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="226.06" x2="33.02" y2="226.06" width="0.1524" layer="91"/>
<label x="10.16" y="226.06" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_22A"/>
</segment>
<segment>
<wire x1="228.6" y1="256.54" x2="248.92" y2="256.54" width="0.1524" layer="91"/>
<label x="231.14" y="256.54" size="1.778" layer="95" font="vector"/>
<pinref part="R7" gate="G$1" pin="1"/>
</segment>
</net>
<net name="VGA_R3" class="0">
<segment>
<wire x1="167.64" y1="264.16" x2="187.96" y2="264.16" width="0.1524" layer="91"/>
<label x="170.18" y="264.16" size="1.778" layer="95" font="vector"/>
<pinref part="R4" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="223.52" x2="33.02" y2="223.52" width="0.1524" layer="91"/>
<label x="10.16" y="223.52" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_24A"/>
</segment>
<segment>
<wire x1="228.6" y1="264.16" x2="248.92" y2="264.16" width="0.1524" layer="91"/>
<label x="231.14" y="264.16" size="1.778" layer="95" font="vector"/>
<pinref part="R3" gate="G$1" pin="1"/>
</segment>
</net>
<net name="BUS_D0" class="0">
<segment>
<wire x1="7.62" y1="210.82" x2="33.02" y2="210.82" width="0.1524" layer="91"/>
<label x="10.16" y="210.82" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_31B"/>
</segment>
<segment>
<wire x1="276.86" y1="73.66" x2="299.72" y2="73.66" width="0.1524" layer="91"/>
<label x="279.4" y="73.66" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B0"/>
</segment>
</net>
<net name="BUS_D1" class="0">
<segment>
<wire x1="7.62" y1="208.28" x2="33.02" y2="208.28" width="0.1524" layer="91"/>
<label x="10.16" y="208.28" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_29B"/>
</segment>
<segment>
<wire x1="276.86" y1="76.2" x2="299.72" y2="76.2" width="0.1524" layer="91"/>
<label x="279.4" y="76.2" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B1"/>
</segment>
</net>
<net name="BUS_D2" class="0">
<segment>
<wire x1="7.62" y1="205.74" x2="33.02" y2="205.74" width="0.1524" layer="91"/>
<label x="10.16" y="205.74" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_25B_G3"/>
</segment>
<segment>
<wire x1="276.86" y1="78.74" x2="299.72" y2="78.74" width="0.1524" layer="91"/>
<label x="279.4" y="78.74" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B2"/>
</segment>
</net>
<net name="VGA_G0" class="0">
<segment>
<wire x1="167.64" y1="210.82" x2="187.96" y2="210.82" width="0.1524" layer="91"/>
<label x="170.18" y="210.82" size="1.778" layer="95" font="vector"/>
<pinref part="R18" gate="G$1" pin="1"/>
</segment>
<segment>
<wire x1="7.62" y1="246.38" x2="33.02" y2="246.38" width="0.1524" layer="91"/>
<label x="10.16" y="246.38" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOB_9B"/>
</segment>
<segment>
<wire x1="228.6" y1="193.04" x2="248.92" y2="193.04" width="0.1524" layer="91"/>
<label x="231.14" y="193.04" size="1.778" layer="95" font="vector"/>
<pinref part="R27" gate="G$1" pin="1"/>
</segment>
</net>
<net name="BUS_IRQ#" class="0">
<segment>
<wire x1="111.76" y1="220.98" x2="86.36" y2="220.98" width="0.1524" layer="91"/>
<label x="88.9" y="220.98" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_49A"/>
</segment>
<segment>
<wire x1="299.72" y1="162.56" x2="276.86" y2="162.56" width="0.1524" layer="91"/>
<label x="279.4" y="162.56" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A1"/>
</segment>
</net>
<net name="BUS_RES#" class="0">
<segment>
<wire x1="111.76" y1="223.52" x2="86.36" y2="223.52" width="0.1524" layer="91"/>
<label x="88.9" y="223.52" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_51A"/>
</segment>
<segment>
<wire x1="299.72" y1="160.02" x2="276.86" y2="160.02" width="0.1524" layer="91"/>
<label x="279.4" y="160.02" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A2"/>
</segment>
</net>
<net name="SYSCLK" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_46B_G0"/>
<wire x1="111.76" y1="241.3" x2="86.36" y2="241.3" width="0.1524" layer="91"/>
<label x="88.9" y="241.3" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="63.5" y1="119.38" x2="48.26" y2="119.38" width="0.1524" layer="91"/>
<label x="50.8" y="119.38" size="1.778" layer="95" font="vector"/>
<pinref part="U5" gate="_" pin="OUT"/>
</segment>
</net>
<net name="FPGA_CDONE" class="0">
<segment>
<pinref part="U1" gate="_" pin="CDONE"/>
<wire x1="7.62" y1="238.76" x2="33.02" y2="238.76" width="0.1524" layer="91"/>
<label x="10.16" y="238.76" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="20.32" y1="160.02" x2="48.26" y2="160.02" width="0.1524" layer="91"/>
<label x="25.4" y="160.02" size="1.778" layer="95" font="vector"/>
<pinref part="R35" gate="G$1" pin="2"/>
<wire x1="20.32" y1="162.56" x2="20.32" y2="160.02" width="0.1524" layer="91"/>
<pinref part="J3" gate="_" pin="2"/>
</segment>
</net>
<net name="FPGA_CRESET_B" class="0">
<segment>
<pinref part="U1" gate="_" pin="CRESET_B"/>
<wire x1="7.62" y1="236.22" x2="33.02" y2="236.22" width="0.1524" layer="91"/>
<label x="10.16" y="236.22" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="12.7" y1="157.48" x2="48.26" y2="157.48" width="0.1524" layer="91"/>
<label x="25.4" y="157.48" size="1.778" layer="95" font="vector"/>
<pinref part="R34" gate="G$1" pin="2"/>
<wire x1="12.7" y1="157.48" x2="12.7" y2="162.56" width="0.1524" layer="91"/>
<pinref part="J3" gate="_" pin="3"/>
</segment>
</net>
<net name="SPI_SSEL_N" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOB_35B_SPI_SS"/>
<wire x1="7.62" y1="215.9" x2="33.02" y2="215.9" width="0.1524" layer="91"/>
<label x="10.16" y="215.9" size="1.778" layer="95" font="vector"/>
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
<wire x1="22.86" y1="147.32" x2="48.26" y2="147.32" width="0.1524" layer="91"/>
<label x="25.4" y="147.32" size="1.778" layer="95" font="vector"/>
<pinref part="J3" gate="_" pin="7"/>
</segment>
</net>
<net name="N$44" class="0">
<segment>
<pinref part="U1" gate="_" pin="VCCPLL"/>
<wire x1="93.98" y1="193.04" x2="86.36" y2="193.04" width="0.1524" layer="91"/>
<pinref part="R40" gate="G$1" pin="1"/>
<wire x1="96.52" y1="165.1" x2="93.98" y2="165.1" width="0.1524" layer="91"/>
<wire x1="93.98" y1="165.1" x2="93.98" y2="193.04" width="0.1524" layer="91"/>
</segment>
</net>
<net name="BUS_D7" class="0">
<segment>
<wire x1="111.76" y1="254" x2="86.36" y2="254" width="0.1524" layer="91"/>
<label x="88.9" y="254" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_38B"/>
</segment>
<segment>
<wire x1="299.72" y1="91.44" x2="276.86" y2="91.44" width="0.1524" layer="91"/>
<label x="279.4" y="91.44" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B7"/>
</segment>
</net>
<net name="BUS_CS#" class="0">
<segment>
<wire x1="111.76" y1="251.46" x2="86.36" y2="251.46" width="0.1524" layer="91"/>
<label x="88.9" y="251.46" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_41A"/>
</segment>
<segment>
<wire x1="299.72" y1="142.24" x2="276.86" y2="142.24" width="0.1524" layer="91"/>
<label x="279.4" y="142.24" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A9"/>
</segment>
<segment>
<pinref part="U6" gate="_" pin="OE#"/>
<wire x1="327.66" y1="99.06" x2="345.44" y2="99.06" width="0.1524" layer="91"/>
<label x="330.2" y="99.06" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_RW#" class="0">
<segment>
<wire x1="111.76" y1="248.92" x2="86.36" y2="248.92" width="0.1524" layer="91"/>
<label x="88.9" y="248.92" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_42B"/>
</segment>
<segment>
<wire x1="299.72" y1="144.78" x2="276.86" y2="144.78" width="0.1524" layer="91"/>
<label x="279.4" y="144.78" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A8"/>
</segment>
</net>
<net name="BUS_A0" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_43A"/>
<wire x1="86.36" y1="246.38" x2="111.76" y2="246.38" width="0.1524" layer="91"/>
<label x="88.9" y="246.38" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="276.86" y1="147.32" x2="299.72" y2="147.32" width="0.1524" layer="91"/>
<label x="279.4" y="147.32" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A7"/>
</segment>
</net>
<net name="BUS_D5" class="0">
<segment>
<wire x1="111.76" y1="259.08" x2="86.36" y2="259.08" width="0.1524" layer="91"/>
<label x="88.9" y="259.08" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_36B"/>
</segment>
<segment>
<wire x1="299.72" y1="86.36" x2="276.86" y2="86.36" width="0.1524" layer="91"/>
<label x="279.4" y="86.36" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B5"/>
</segment>
</net>
<net name="BUS_D4" class="0">
<segment>
<wire x1="111.76" y1="261.62" x2="86.36" y2="261.62" width="0.1524" layer="91"/>
<label x="88.9" y="261.62" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_37A"/>
</segment>
<segment>
<wire x1="299.72" y1="83.82" x2="276.86" y2="83.82" width="0.1524" layer="91"/>
<label x="279.4" y="83.82" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B4"/>
</segment>
</net>
<net name="+3.3V" class="0">
<segment>
<pinref part="U1" gate="_" pin="VCCIO_2"/>
<pinref part="U1" gate="_" pin="SPI_VCCIO1"/>
<wire x1="88.9" y1="210.82" x2="86.36" y2="210.82" width="0.1524" layer="91"/>
<wire x1="88.9" y1="213.36" x2="86.36" y2="213.36" width="0.1524" layer="91"/>
<wire x1="88.9" y1="210.82" x2="88.9" y2="213.36" width="0.1524" layer="91"/>
<junction x="88.9" y="213.36"/>
<pinref part="U1" gate="_" pin="VCCIO_0"/>
<wire x1="88.9" y1="215.9" x2="86.36" y2="215.9" width="0.1524" layer="91"/>
<wire x1="88.9" y1="213.36" x2="88.9" y2="215.9" width="0.1524" layer="91"/>
<junction x="88.9" y="215.9"/>
<pinref part="U1" gate="_" pin="VPP_2V5"/>
<wire x1="86.36" y1="205.74" x2="88.9" y2="205.74" width="0.1524" layer="91"/>
<wire x1="88.9" y1="205.74" x2="88.9" y2="210.82" width="0.1524" layer="91"/>
<junction x="88.9" y="210.82"/>
<pinref part="C11" gate="G$1" pin="2"/>
<wire x1="88.9" y1="215.9" x2="101.6" y2="215.9" width="0.1524" layer="91"/>
<wire x1="101.6" y1="215.9" x2="111.76" y2="215.9" width="0.1524" layer="91"/>
<wire x1="111.76" y1="215.9" x2="121.92" y2="215.9" width="0.1524" layer="91"/>
<wire x1="121.92" y1="215.9" x2="132.08" y2="215.9" width="0.1524" layer="91"/>
<wire x1="132.08" y1="215.9" x2="142.24" y2="215.9" width="0.1524" layer="91"/>
<wire x1="142.24" y1="215.9" x2="152.4" y2="215.9" width="0.1524" layer="91"/>
<wire x1="152.4" y1="215.9" x2="152.4" y2="213.36" width="0.1524" layer="91"/>
<pinref part="C10" gate="G$1" pin="2"/>
<wire x1="142.24" y1="213.36" x2="142.24" y2="215.9" width="0.1524" layer="91"/>
<junction x="142.24" y="215.9"/>
<pinref part="C9" gate="G$1" pin="2"/>
<wire x1="132.08" y1="213.36" x2="132.08" y2="215.9" width="0.1524" layer="91"/>
<junction x="132.08" y="215.9"/>
<pinref part="C8" gate="G$1" pin="2"/>
<wire x1="121.92" y1="213.36" x2="121.92" y2="215.9" width="0.1524" layer="91"/>
<junction x="121.92" y="215.9"/>
<pinref part="C7" gate="G$1" pin="2"/>
<wire x1="111.76" y1="213.36" x2="111.76" y2="215.9" width="0.1524" layer="91"/>
<junction x="111.76" y="215.9"/>
<pinref part="C6" gate="G$1" pin="2"/>
<wire x1="101.6" y1="213.36" x2="101.6" y2="215.9" width="0.1524" layer="91"/>
<junction x="101.6" y="215.9"/>
<pinref part="U$15" gate="G$1" pin="+3.3V"/>
<wire x1="152.4" y1="218.44" x2="152.4" y2="215.9" width="0.1524" layer="91"/>
<junction x="152.4" y="215.9"/>
</segment>
<segment>
<wire x1="20.32" y1="119.38" x2="10.16" y2="119.38" width="0.1524" layer="91"/>
<wire x1="10.16" y1="119.38" x2="10.16" y2="121.92" width="0.1524" layer="91"/>
<wire x1="10.16" y1="116.84" x2="10.16" y2="119.38" width="0.1524" layer="91"/>
<junction x="10.16" y="119.38"/>
<pinref part="U5" gate="_" pin="VCC"/>
<pinref part="C18" gate="G$1" pin="2"/>
<pinref part="U$5" gate="G$1" pin="+3.3V"/>
</segment>
<segment>
<pinref part="U4" gate="_" pin="VCC"/>
<wire x1="149.86" y1="116.84" x2="157.48" y2="116.84" width="0.1524" layer="91"/>
<wire x1="157.48" y1="116.84" x2="157.48" y2="119.38" width="0.1524" layer="91"/>
<pinref part="U$31" gate="G$1" pin="+3.3V"/>
<pinref part="C23" gate="G$1" pin="2"/>
<wire x1="157.48" y1="114.3" x2="157.48" y2="116.84" width="0.1524" layer="91"/>
<junction x="157.48" y="116.84"/>
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
<wire x1="71.12" y1="33.02" x2="71.12" y2="35.56" width="0.1524" layer="91"/>
<wire x1="71.12" y1="35.56" x2="68.58" y2="35.56" width="0.1524" layer="91"/>
<wire x1="71.12" y1="35.56" x2="81.28" y2="35.56" width="0.1524" layer="91"/>
<wire x1="81.28" y1="33.02" x2="81.28" y2="35.56" width="0.1524" layer="91"/>
<junction x="71.12" y="35.56"/>
<pinref part="R23" gate="G$1" pin="2"/>
<pinref part="L14" gate="G$1" pin="2"/>
<pinref part="C70" gate="G$1" pin="2"/>
<pinref part="U$35" gate="G$1" pin="+3.3V"/>
<wire x1="81.28" y1="35.56" x2="81.28" y2="38.1" width="0.1524" layer="91"/>
<junction x="81.28" y="35.56"/>
</segment>
<segment>
<pinref part="U$36" gate="G$1" pin="+3.3V"/>
<pinref part="R34" gate="G$1" pin="1"/>
<wire x1="12.7" y1="177.8" x2="12.7" y2="175.26" width="0.1524" layer="91"/>
<wire x1="12.7" y1="175.26" x2="12.7" y2="172.72" width="0.1524" layer="91"/>
<wire x1="12.7" y1="175.26" x2="20.32" y2="175.26" width="0.1524" layer="91"/>
<junction x="12.7" y="175.26"/>
<pinref part="R35" gate="G$1" pin="1"/>
<wire x1="20.32" y1="175.26" x2="20.32" y2="172.72" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="U$13" gate="G$1" pin="+3.3V"/>
<wire x1="312.42" y1="238.76" x2="312.42" y2="236.22" width="0.1524" layer="91"/>
<pinref part="R36" gate="G$1" pin="2"/>
<wire x1="312.42" y1="236.22" x2="309.88" y2="236.22" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C4" gate="G$1" pin="2"/>
<pinref part="U$43" gate="G$1" pin="+3.3V"/>
</segment>
<segment>
<pinref part="U$25" gate="G$1" pin="+3.3V"/>
<wire x1="292.1" y1="66.04" x2="292.1" y2="63.5" width="0.1524" layer="91"/>
<wire x1="292.1" y1="63.5" x2="297.18" y2="63.5" width="0.1524" layer="91"/>
<wire x1="299.72" y1="68.58" x2="297.18" y2="68.58" width="0.1524" layer="91"/>
<wire x1="297.18" y1="68.58" x2="297.18" y2="66.04" width="0.1524" layer="91"/>
<wire x1="297.18" y1="66.04" x2="299.72" y2="66.04" width="0.1524" layer="91"/>
<wire x1="297.18" y1="63.5" x2="297.18" y2="66.04" width="0.1524" layer="91"/>
<junction x="297.18" y="66.04"/>
<pinref part="U6" gate="_" pin="VCCB@1"/>
<pinref part="U6" gate="_" pin="VCCB@2"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="R41" gate="G$1" pin="1"/>
<pinref part="R40" gate="G$1" pin="2"/>
<wire x1="127" y1="165.1" x2="121.92" y2="165.1" width="0.1524" layer="91"/>
<pinref part="C16" gate="G$1" pin="2"/>
<wire x1="121.92" y1="165.1" x2="111.76" y2="165.1" width="0.1524" layer="91"/>
<wire x1="111.76" y1="165.1" x2="106.68" y2="165.1" width="0.1524" layer="91"/>
<wire x1="111.76" y1="162.56" x2="111.76" y2="165.1" width="0.1524" layer="91"/>
<junction x="111.76" y="165.1"/>
<pinref part="C17" gate="G$1" pin="2"/>
<wire x1="121.92" y1="162.56" x2="121.92" y2="165.1" width="0.1524" layer="91"/>
<junction x="121.92" y="165.1"/>
</segment>
</net>
<net name="+1.2V" class="0">
<segment>
<pinref part="R41" gate="G$1" pin="2"/>
<wire x1="137.16" y1="165.1" x2="152.4" y2="165.1" width="0.1524" layer="91"/>
<wire x1="152.4" y1="165.1" x2="152.4" y2="187.96" width="0.1524" layer="91"/>
<pinref part="U1" gate="_" pin="VCC@2"/>
<pinref part="U1" gate="_" pin="VCC@1"/>
<wire x1="88.9" y1="198.12" x2="86.36" y2="198.12" width="0.1524" layer="91"/>
<wire x1="96.52" y1="200.66" x2="88.9" y2="200.66" width="0.1524" layer="91"/>
<wire x1="88.9" y1="200.66" x2="86.36" y2="200.66" width="0.1524" layer="91"/>
<wire x1="88.9" y1="198.12" x2="88.9" y2="200.66" width="0.1524" layer="91"/>
<junction x="88.9" y="200.66"/>
<wire x1="96.52" y1="200.66" x2="96.52" y2="187.96" width="0.1524" layer="91"/>
<wire x1="96.52" y1="187.96" x2="101.6" y2="187.96" width="0.1524" layer="91"/>
<pinref part="C15" gate="G$1" pin="2"/>
<wire x1="101.6" y1="187.96" x2="111.76" y2="187.96" width="0.1524" layer="91"/>
<wire x1="111.76" y1="187.96" x2="121.92" y2="187.96" width="0.1524" layer="91"/>
<wire x1="121.92" y1="187.96" x2="132.08" y2="187.96" width="0.1524" layer="91"/>
<wire x1="132.08" y1="187.96" x2="132.08" y2="185.42" width="0.1524" layer="91"/>
<pinref part="C14" gate="G$1" pin="2"/>
<wire x1="121.92" y1="185.42" x2="121.92" y2="187.96" width="0.1524" layer="91"/>
<junction x="121.92" y="187.96"/>
<pinref part="C13" gate="G$1" pin="2"/>
<wire x1="111.76" y1="185.42" x2="111.76" y2="187.96" width="0.1524" layer="91"/>
<junction x="111.76" y="187.96"/>
<pinref part="C12" gate="G$1" pin="2"/>
<wire x1="101.6" y1="185.42" x2="101.6" y2="187.96" width="0.1524" layer="91"/>
<junction x="101.6" y="187.96"/>
<wire x1="152.4" y1="187.96" x2="132.08" y2="187.96" width="0.1524" layer="91"/>
<junction x="132.08" y="187.96"/>
<pinref part="U$20" gate="G$1" pin="+1.2V"/>
<wire x1="152.4" y1="190.5" x2="152.4" y2="187.96" width="0.1524" layer="91"/>
<junction x="152.4" y="187.96"/>
</segment>
<segment>
<wire x1="162.56" y1="33.02" x2="162.56" y2="35.56" width="0.1524" layer="91"/>
<wire x1="162.56" y1="35.56" x2="160.02" y2="35.56" width="0.1524" layer="91"/>
<wire x1="162.56" y1="35.56" x2="172.72" y2="35.56" width="0.1524" layer="91"/>
<wire x1="172.72" y1="33.02" x2="172.72" y2="35.56" width="0.1524" layer="91"/>
<junction x="162.56" y="35.56"/>
<pinref part="R13" gate="G$1" pin="2"/>
<pinref part="L1" gate="G$1" pin="2"/>
<pinref part="C26" gate="G$1" pin="2"/>
<pinref part="U$14" gate="G$1" pin="+1.2V"/>
<wire x1="172.72" y1="35.56" x2="172.72" y2="38.1" width="0.1524" layer="91"/>
<junction x="172.72" y="35.56"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<wire x1="50.8" y1="25.4" x2="53.34" y2="25.4" width="0.1524" layer="91"/>
<wire x1="53.34" y1="25.4" x2="53.34" y2="20.32" width="0.1524" layer="91"/>
<wire x1="53.34" y1="20.32" x2="71.12" y2="20.32" width="0.1524" layer="91"/>
<wire x1="71.12" y1="20.32" x2="71.12" y2="22.86" width="0.1524" layer="91"/>
<wire x1="71.12" y1="20.32" x2="71.12" y2="17.78" width="0.1524" layer="91"/>
<junction x="71.12" y="20.32"/>
<pinref part="U7" gate="_" pin="FB"/>
<pinref part="R23" gate="G$1" pin="1"/>
<pinref part="R24" gate="G$1" pin="2"/>
</segment>
</net>
<net name="N$23" class="0">
<segment>
<wire x1="53.34" y1="35.56" x2="50.8" y2="35.56" width="0.1524" layer="91"/>
<pinref part="U7" gate="_" pin="LX"/>
<pinref part="L14" gate="G$1" pin="1"/>
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
<wire x1="142.24" y1="25.4" x2="144.78" y2="25.4" width="0.1524" layer="91"/>
<wire x1="144.78" y1="25.4" x2="144.78" y2="20.32" width="0.1524" layer="91"/>
<wire x1="144.78" y1="20.32" x2="162.56" y2="20.32" width="0.1524" layer="91"/>
<wire x1="162.56" y1="20.32" x2="162.56" y2="22.86" width="0.1524" layer="91"/>
<wire x1="162.56" y1="20.32" x2="162.56" y2="17.78" width="0.1524" layer="91"/>
<junction x="162.56" y="20.32"/>
<pinref part="U8" gate="_" pin="FB"/>
<pinref part="R13" gate="G$1" pin="1"/>
<pinref part="R45" gate="G$1" pin="2"/>
</segment>
</net>
<net name="N$20" class="0">
<segment>
<wire x1="144.78" y1="35.56" x2="142.24" y2="35.56" width="0.1524" layer="91"/>
<pinref part="U8" gate="_" pin="LX"/>
<pinref part="L1" gate="G$1" pin="1"/>
</segment>
</net>
<net name="BUS_D6" class="0">
<segment>
<wire x1="111.76" y1="256.54" x2="86.36" y2="256.54" width="0.1524" layer="91"/>
<label x="88.9" y="256.54" size="1.778" layer="95" font="vector"/>
<pinref part="U1" gate="_" pin="IOT_39A"/>
</segment>
<segment>
<wire x1="299.72" y1="88.9" x2="276.86" y2="88.9" width="0.1524" layer="91"/>
<label x="279.4" y="88.9" size="1.778" layer="95" font="vector"/>
<pinref part="U6" gate="_" pin="B6"/>
</segment>
</net>
<net name="VGA_G" class="0">
<segment>
<pinref part="R11" gate="G$1" pin="2"/>
<wire x1="198.12" y1="233.68" x2="200.66" y2="233.68" width="0.1524" layer="91"/>
<pinref part="R12" gate="G$1" pin="2"/>
<wire x1="198.12" y1="226.06" x2="200.66" y2="226.06" width="0.1524" layer="91"/>
<wire x1="200.66" y1="226.06" x2="200.66" y2="233.68" width="0.1524" layer="91"/>
<junction x="200.66" y="226.06"/>
<wire x1="200.66" y1="218.44" x2="200.66" y2="226.06" width="0.1524" layer="91"/>
<pinref part="R17" gate="G$1" pin="2"/>
<wire x1="198.12" y1="218.44" x2="200.66" y2="218.44" width="0.1524" layer="91"/>
<wire x1="218.44" y1="233.68" x2="200.66" y2="233.68" width="0.1524" layer="91"/>
<label x="208.28" y="233.68" size="1.778" layer="95"/>
<junction x="200.66" y="233.68"/>
<pinref part="R18" gate="G$1" pin="2"/>
<wire x1="198.12" y1="210.82" x2="200.66" y2="210.82" width="0.1524" layer="91"/>
<wire x1="200.66" y1="210.82" x2="200.66" y2="218.44" width="0.1524" layer="91"/>
<junction x="200.66" y="218.44"/>
</segment>
<segment>
<wire x1="353.06" y1="40.64" x2="378.46" y2="40.64" width="0.1524" layer="91"/>
<label x="355.6" y="40.64" size="1.778" layer="95" font="vector"/>
<pinref part="J1" gate="_" pin="12"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="R31" gate="G$1" pin="1"/>
<wire x1="345.44" y1="233.68" x2="347.98" y2="233.68" width="0.1524" layer="91"/>
<wire x1="347.98" y1="223.52" x2="345.44" y2="223.52" width="0.1524" layer="91"/>
<wire x1="345.44" y1="223.52" x2="345.44" y2="233.68" width="0.1524" layer="91"/>
<junction x="345.44" y="233.68"/>
<pinref part="R33" gate="G$1" pin="1"/>
<pinref part="U2" gate="_" pin="CH2_OUT"/>
<wire x1="340.36" y1="264.16" x2="345.44" y2="264.16" width="0.1524" layer="91"/>
<wire x1="345.44" y1="264.16" x2="345.44" y2="233.68" width="0.1524" layer="91"/>
</segment>
</net>
<net name="VIDEO_Y" class="0">
<segment>
<pinref part="R30" gate="G$1" pin="2"/>
<wire x1="358.14" y1="261.62" x2="393.7" y2="261.62" width="0.1524" layer="91"/>
<label x="375.92" y="261.62" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="353.06" y1="48.26" x2="378.46" y2="48.26" width="0.1524" layer="91"/>
<label x="355.6" y="48.26" size="1.778" layer="95" font="vector"/>
<pinref part="J1" gate="_" pin="9"/>
</segment>
</net>
<net name="VIDEO_C" class="0">
<segment>
<pinref part="R31" gate="G$1" pin="2"/>
<wire x1="358.14" y1="233.68" x2="393.7" y2="233.68" width="0.1524" layer="91"/>
<label x="375.92" y="233.68" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="353.06" y1="53.34" x2="378.46" y2="53.34" width="0.1524" layer="91"/>
<label x="355.6" y="53.34" size="1.778" layer="95" font="vector"/>
<pinref part="J1" gate="_" pin="7"/>
</segment>
</net>
<net name="VIDEO_COMP" class="0">
<segment>
<pinref part="R32" gate="G$1" pin="2"/>
<wire x1="358.14" y1="213.36" x2="373.38" y2="213.36" width="0.1524" layer="91"/>
<label x="375.92" y="213.36" size="1.778" layer="95" font="vector"/>
<pinref part="C3" gate="G$1" pin="2"/>
<wire x1="373.38" y1="213.36" x2="393.7" y2="213.36" width="0.1524" layer="91"/>
<wire x1="370.84" y1="223.52" x2="373.38" y2="223.52" width="0.1524" layer="91"/>
<wire x1="373.38" y1="223.52" x2="373.38" y2="213.36" width="0.1524" layer="91"/>
<junction x="373.38" y="213.36"/>
</segment>
<segment>
<label x="355.6" y="58.42" size="1.778" layer="95" font="vector"/>
<wire x1="353.06" y1="58.42" x2="378.46" y2="58.42" width="0.1524" layer="91"/>
<pinref part="J1" gate="_" pin="5"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="R32" gate="G$1" pin="1"/>
<wire x1="342.9" y1="213.36" x2="347.98" y2="213.36" width="0.1524" layer="91"/>
<pinref part="U2" gate="_" pin="CH1_OUT"/>
<wire x1="340.36" y1="266.7" x2="342.9" y2="266.7" width="0.1524" layer="91"/>
<wire x1="342.9" y1="266.7" x2="342.9" y2="213.36" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="C3" gate="G$1" pin="1"/>
<wire x1="360.68" y1="223.52" x2="358.14" y2="223.52" width="0.1524" layer="91"/>
<pinref part="R33" gate="G$1" pin="2"/>
</segment>
</net>
<net name="BUS_D4_5V" class="0">
<segment>
<wire x1="327.66" y1="83.82" x2="358.14" y2="83.82" width="0.1524" layer="91"/>
<wire x1="358.14" y1="129.54" x2="358.14" y2="83.82" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="5"/>
<wire x1="378.46" y1="129.54" x2="358.14" y2="129.54" width="0.1524" layer="91"/>
<label x="330.2" y="83.82" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A4"/>
</segment>
</net>
<net name="BUS_D3_5V" class="0">
<segment>
<wire x1="327.66" y1="81.28" x2="360.68" y2="81.28" width="0.1524" layer="91"/>
<wire x1="360.68" y1="127" x2="360.68" y2="81.28" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="4"/>
<wire x1="378.46" y1="127" x2="360.68" y2="127" width="0.1524" layer="91"/>
<label x="330.2" y="81.28" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A3"/>
</segment>
</net>
<net name="BUS_D2_5V" class="0">
<segment>
<wire x1="327.66" y1="78.74" x2="363.22" y2="78.74" width="0.1524" layer="91"/>
<wire x1="363.22" y1="124.46" x2="363.22" y2="78.74" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="3"/>
<wire x1="378.46" y1="124.46" x2="363.22" y2="124.46" width="0.1524" layer="91"/>
<label x="330.2" y="78.74" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A2"/>
</segment>
</net>
<net name="BUS_D1_5V" class="0">
<segment>
<wire x1="327.66" y1="76.2" x2="365.76" y2="76.2" width="0.1524" layer="91"/>
<wire x1="365.76" y1="76.2" x2="365.76" y2="121.92" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="2"/>
<wire x1="378.46" y1="121.92" x2="365.76" y2="121.92" width="0.1524" layer="91"/>
<label x="330.2" y="76.2" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A1"/>
</segment>
</net>
<net name="BUS_D0_5V" class="0">
<segment>
<wire x1="327.66" y1="73.66" x2="368.3" y2="73.66" width="0.1524" layer="91"/>
<wire x1="368.3" y1="73.66" x2="368.3" y2="119.38" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="1"/>
<wire x1="368.3" y1="119.38" x2="378.46" y2="119.38" width="0.1524" layer="91"/>
<label x="330.2" y="73.66" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A0"/>
</segment>
</net>
<net name="BUS_IRQ#_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B1"/>
<wire x1="327.66" y1="162.56" x2="378.46" y2="162.56" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="18"/>
<label x="330.2" y="162.56" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_CS#_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B9"/>
<wire x1="327.66" y1="142.24" x2="378.46" y2="142.24" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="10"/>
<label x="330.2" y="142.24" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_RW#_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B8"/>
<wire x1="378.46" y1="144.78" x2="327.66" y2="144.78" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="11"/>
<label x="330.2" y="144.78" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U9" gate="_" pin="A"/>
<wire x1="299.72" y1="119.38" x2="276.86" y2="119.38" width="0.1524" layer="91"/>
<label x="279.4" y="119.38" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_PHY2_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B4"/>
<wire x1="378.46" y1="154.94" x2="327.66" y2="154.94" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="15"/>
<label x="330.2" y="154.94" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_A2_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B5"/>
<wire x1="327.66" y1="152.4" x2="378.46" y2="152.4" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="14"/>
<label x="330.2" y="152.4" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_A1_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B6"/>
<wire x1="378.46" y1="149.86" x2="327.66" y2="149.86" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="13"/>
<label x="330.2" y="149.86" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_A0_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B7"/>
<wire x1="327.66" y1="147.32" x2="378.46" y2="147.32" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="12"/>
<label x="330.2" y="147.32" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_D7_5V" class="0">
<segment>
<wire x1="327.66" y1="91.44" x2="350.52" y2="91.44" width="0.1524" layer="91"/>
<wire x1="350.52" y1="91.44" x2="350.52" y2="137.16" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="8"/>
<wire x1="350.52" y1="137.16" x2="378.46" y2="137.16" width="0.1524" layer="91"/>
<pinref part="U6" gate="_" pin="A7"/>
<label x="330.2" y="91.44" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_D6_5V" class="0">
<segment>
<wire x1="327.66" y1="88.9" x2="353.06" y2="88.9" width="0.1524" layer="91"/>
<wire x1="353.06" y1="88.9" x2="353.06" y2="134.62" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="7"/>
<wire x1="378.46" y1="134.62" x2="353.06" y2="134.62" width="0.1524" layer="91"/>
<label x="330.2" y="88.9" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A6"/>
</segment>
</net>
<net name="VIDEO_CHROMA" class="0">
<segment>
<pinref part="R3" gate="G$1" pin="2"/>
<wire x1="259.08" y1="264.16" x2="261.62" y2="264.16" width="0.1524" layer="91"/>
<pinref part="R7" gate="G$1" pin="2"/>
<wire x1="261.62" y1="256.54" x2="261.62" y2="264.16" width="0.1524" layer="91"/>
<pinref part="R14" gate="G$1" pin="2"/>
<pinref part="R15" gate="G$1" pin="2"/>
<wire x1="261.62" y1="248.92" x2="259.08" y2="248.92" width="0.1524" layer="91"/>
<wire x1="259.08" y1="241.3" x2="261.62" y2="241.3" width="0.1524" layer="91"/>
<wire x1="261.62" y1="241.3" x2="261.62" y2="248.92" width="0.1524" layer="91"/>
<junction x="261.62" y="248.92"/>
<wire x1="259.08" y1="256.54" x2="261.62" y2="256.54" width="0.1524" layer="91"/>
<wire x1="261.62" y1="256.54" x2="261.62" y2="248.92" width="0.1524" layer="91"/>
<junction x="261.62" y="256.54"/>
<wire x1="261.62" y1="264.16" x2="269.24" y2="264.16" width="0.1524" layer="91"/>
<junction x="261.62" y="264.16"/>
<wire x1="269.24" y1="264.16" x2="269.24" y2="261.62" width="0.1524" layer="91"/>
<wire x1="261.62" y1="241.3" x2="261.62" y2="231.14" width="0.1524" layer="91"/>
<junction x="261.62" y="241.3"/>
<pinref part="R2" gate="G$1" pin="2"/>
<wire x1="261.62" y1="231.14" x2="259.08" y2="231.14" width="0.1524" layer="91"/>
<pinref part="R28" gate="G$1" pin="1"/>
<label x="276.86" y="264.16" size="1.778" layer="95"/>
<wire x1="269.24" y1="264.16" x2="302.26" y2="264.16" width="0.1524" layer="91"/>
<junction x="269.24" y="264.16"/>
<pinref part="U2" gate="_" pin="CH2_IN"/>
</segment>
</net>
<net name="VIDEO_LUMA" class="0">
<segment>
<pinref part="R16" gate="G$1" pin="2"/>
<wire x1="259.08" y1="215.9" x2="261.62" y2="215.9" width="0.1524" layer="91"/>
<pinref part="R25" gate="G$1" pin="2"/>
<wire x1="259.08" y1="208.28" x2="261.62" y2="208.28" width="0.1524" layer="91"/>
<wire x1="261.62" y1="208.28" x2="261.62" y2="215.9" width="0.1524" layer="91"/>
<junction x="261.62" y="208.28"/>
<wire x1="261.62" y1="200.66" x2="261.62" y2="208.28" width="0.1524" layer="91"/>
<pinref part="R26" gate="G$1" pin="2"/>
<wire x1="259.08" y1="200.66" x2="261.62" y2="200.66" width="0.1524" layer="91"/>
<junction x="261.62" y="215.9"/>
<pinref part="R27" gate="G$1" pin="2"/>
<wire x1="259.08" y1="193.04" x2="261.62" y2="193.04" width="0.1524" layer="91"/>
<wire x1="261.62" y1="193.04" x2="261.62" y2="200.66" width="0.1524" layer="91"/>
<junction x="261.62" y="200.66"/>
<pinref part="R1" gate="G$1" pin="2"/>
<wire x1="259.08" y1="182.88" x2="261.62" y2="182.88" width="0.1524" layer="91"/>
<wire x1="261.62" y1="182.88" x2="261.62" y2="193.04" width="0.1524" layer="91"/>
<junction x="261.62" y="193.04"/>
<wire x1="261.62" y1="215.9" x2="269.24" y2="215.9" width="0.1524" layer="91"/>
<wire x1="269.24" y1="215.9" x2="269.24" y2="213.36" width="0.1524" layer="91"/>
<pinref part="R29" gate="G$1" pin="1"/>
<wire x1="269.24" y1="215.9" x2="274.32" y2="215.9" width="0.1524" layer="91"/>
<junction x="269.24" y="215.9"/>
<wire x1="274.32" y1="261.62" x2="274.32" y2="215.9" width="0.1524" layer="91"/>
<label x="276.86" y="261.62" size="1.778" layer="95"/>
<wire x1="274.32" y1="261.62" x2="299.72" y2="261.62" width="0.1524" layer="91"/>
<pinref part="U2" gate="_" pin="CH3_IN"/>
<pinref part="U2" gate="_" pin="CH1_IN"/>
<wire x1="299.72" y1="261.62" x2="302.26" y2="261.62" width="0.1524" layer="91"/>
<wire x1="302.26" y1="266.7" x2="299.72" y2="266.7" width="0.1524" layer="91"/>
<wire x1="299.72" y1="266.7" x2="299.72" y2="261.62" width="0.1524" layer="91"/>
<junction x="299.72" y="261.62"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<pinref part="R30" gate="G$1" pin="1"/>
<pinref part="U2" gate="_" pin="CH3_OUT"/>
<wire x1="347.98" y1="261.62" x2="340.36" y2="261.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$29" class="0">
<segment>
<pinref part="U2" gate="_" pin="VCC"/>
<wire x1="302.26" y1="254" x2="284.48" y2="254" width="0.1524" layer="91"/>
<pinref part="C1" gate="G$1" pin="2"/>
<wire x1="284.48" y1="254" x2="284.48" y2="236.22" width="0.1524" layer="91"/>
<wire x1="284.48" y1="236.22" x2="284.48" y2="233.68" width="0.1524" layer="91"/>
<wire x1="284.48" y1="236.22" x2="294.64" y2="236.22" width="0.1524" layer="91"/>
<junction x="284.48" y="236.22"/>
<pinref part="C2" gate="G$1" pin="2"/>
<wire x1="294.64" y1="236.22" x2="294.64" y2="233.68" width="0.1524" layer="91"/>
<wire x1="294.64" y1="236.22" x2="299.72" y2="236.22" width="0.1524" layer="91"/>
<junction x="294.64" y="236.22"/>
<pinref part="R36" gate="G$1" pin="1"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="U6" gate="_" pin="DIR"/>
<wire x1="327.66" y1="101.6" x2="340.36" y2="101.6" width="0.1524" layer="91"/>
<wire x1="340.36" y1="101.6" x2="340.36" y2="119.38" width="0.1524" layer="91"/>
<wire x1="340.36" y1="119.38" x2="325.12" y2="119.38" width="0.1524" layer="91"/>
<pinref part="U9" gate="_" pin="Y"/>
</segment>
</net>
<net name="BUS_D5_5V" class="0">
<segment>
<wire x1="327.66" y1="86.36" x2="355.6" y2="86.36" width="0.1524" layer="91"/>
<wire x1="355.6" y1="132.08" x2="355.6" y2="86.36" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="6"/>
<wire x1="378.46" y1="132.08" x2="355.6" y2="132.08" width="0.1524" layer="91"/>
<label x="330.2" y="86.36" size="1.778" layer="95"/>
<pinref part="U6" gate="_" pin="A5"/>
</segment>
</net>
<net name="BUS_RES#_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B2"/>
<wire x1="327.66" y1="160.02" x2="378.46" y2="160.02" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="17"/>
<label x="330.2" y="160.02" size="1.778" layer="95"/>
</segment>
</net>
<net name="BUS_RDY" class="0">
<segment>
<pinref part="U1" gate="_" pin="IOT_50B"/>
<wire x1="111.76" y1="233.68" x2="86.36" y2="233.68" width="0.1524" layer="91"/>
<label x="88.9" y="233.68" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="299.72" y1="157.48" x2="276.86" y2="157.48" width="0.1524" layer="91"/>
<label x="279.4" y="157.48" size="1.778" layer="95" font="vector"/>
<pinref part="U3" gate="_" pin="A3"/>
</segment>
</net>
<net name="BUS_RDY_5V" class="0">
<segment>
<pinref part="U3" gate="_" pin="B3"/>
<wire x1="327.66" y1="157.48" x2="378.46" y2="157.48" width="0.1524" layer="91"/>
<pinref part="J4" gate="_" pin="16"/>
<label x="330.2" y="157.48" size="1.778" layer="95"/>
</segment>
</net>
</nets>
</sheet>
<sheet>
<plain>
<text x="2.54" y="271.78" size="2.54" layer="94" font="vector">PC interface</text>
<wire x1="195.58" y1="276.86" x2="195.58" y2="154.94" width="0.1524" layer="94"/>
<wire x1="195.58" y1="154.94" x2="0" y2="154.94" width="0.1524" layer="94"/>
</plain>
<instances>
<instance part="FRAME2" gate="G$1" x="0" y="0"/>
<instance part="FRAME2" gate="G$2" x="297.18" y="0"/>
<instance part="R38" gate="G$1" x="27.94" y="228.6" rot="MR90"/>
<instance part="J7" gate="_" x="20.32" y="261.62" smashed="yes" rot="MR0">
<attribute name="NAME" x="20.32" y="261.874" size="1.778" layer="95" rot="MR0"/>
<attribute name="VALUE" x="5.08" y="233.68" size="1.778" layer="96" rot="MR90"/>
</instance>
<instance part="U10" gate="_" x="76.2" y="266.7"/>
<instance part="C20" gate="G$1" x="121.92" y="228.6" rot="R90"/>
<instance part="C21" gate="G$1" x="132.08" y="228.6" rot="R90"/>
<instance part="C22" gate="G$1" x="142.24" y="228.6" rot="R90"/>
<instance part="R42" gate="G$1" x="175.26" y="256.54" rot="R90"/>
<instance part="J2" gate="_" x="182.88" y="269.24"/>
<instance part="J8" gate="_" x="162.56" y="213.36"/>
<instance part="J5" gate="_" x="45.72" y="208.28"/>
<instance part="U$50" gate="G$1" x="38.1" y="208.28"/>
<instance part="U$51" gate="G$1" x="38.1" y="185.42"/>
<instance part="J6" gate="_" x="182.88" y="236.22"/>
<instance part="U$46" gate="G$1" x="175.26" y="236.22"/>
<instance part="U11" gate="_" x="93.98" y="213.36"/>
<instance part="C24" gate="G$1" x="121.92" y="195.58" rot="R90"/>
<instance part="C27" gate="G$1" x="132.08" y="203.2" rot="R90"/>
<instance part="C28" gate="G$1" x="76.2" y="203.2" rot="R90"/>
<instance part="U$45" gate="G$1" x="27.94" y="223.52"/>
<instance part="U$47" gate="G$1" x="114.3" y="231.14"/>
<instance part="U$48" gate="G$1" x="121.92" y="223.52"/>
<instance part="U$49" gate="G$1" x="132.08" y="223.52"/>
<instance part="U$52" gate="G$1" x="142.24" y="223.52"/>
<instance part="U$53" gate="G$1" x="175.26" y="251.46"/>
<instance part="U$54" gate="G$1" x="154.94" y="205.74"/>
<instance part="U$55" gate="G$1" x="132.08" y="198.12"/>
<instance part="U$56" gate="G$1" x="121.92" y="190.5"/>
<instance part="U$57" gate="G$1" x="86.36" y="200.66"/>
<instance part="U$58" gate="G$1" x="76.2" y="198.12"/>
<instance part="U$59" gate="G$1" x="33.02" y="246.38"/>
<instance part="J9" gate="_" x="45.72" y="177.8"/>
<instance part="U$60" gate="G$1" x="38.1" y="165.1"/>
<instance part="X2" gate="_" x="147.32" y="256.54" smashed="yes">
<attribute name="NAME" x="144.78" y="259.334" size="1.778" layer="95" font="vector"/>
<attribute name="VALUE" x="137.16" y="266.7" size="1.778" layer="96" font="vector"/>
</instance>
<instance part="C29" gate="G$1" x="139.7" y="248.92" rot="R90"/>
<instance part="C30" gate="G$1" x="154.94" y="248.92" rot="R90"/>
<instance part="U$61" gate="G$1" x="154.94" y="243.84"/>
<instance part="U$62" gate="G$1" x="139.7" y="243.84"/>
</instances>
<busses>
</busses>
<nets>
<net name="GND" class="0">
<segment>
<pinref part="U$51" gate="G$1" pin="GND"/>
<wire x1="38.1" y1="185.42" x2="38.1" y2="187.96" width="0.1524" layer="91"/>
<wire x1="38.1" y1="187.96" x2="40.64" y2="187.96" width="0.1524" layer="91"/>
<pinref part="J5" gate="_" pin="8"/>
</segment>
<segment>
<pinref part="R38" gate="G$1" pin="1"/>
<pinref part="U$45" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U10" gate="_" pin="VSS"/>
<wire x1="111.76" y1="233.68" x2="114.3" y2="233.68" width="0.1524" layer="91"/>
<wire x1="114.3" y1="233.68" x2="114.3" y2="231.14" width="0.1524" layer="91"/>
<pinref part="U$47" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C20" gate="G$1" pin="1"/>
<pinref part="U$48" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C21" gate="G$1" pin="1"/>
<pinref part="U$49" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C22" gate="G$1" pin="1"/>
<pinref part="U$52" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="R42" gate="G$1" pin="1"/>
<pinref part="U$53" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="J8" gate="_" pin="3"/>
<wire x1="157.48" y1="208.28" x2="154.94" y2="208.28" width="0.1524" layer="91"/>
<wire x1="154.94" y1="208.28" x2="154.94" y2="205.74" width="0.1524" layer="91"/>
<pinref part="U$54" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C27" gate="G$1" pin="1"/>
<pinref part="U$55" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C24" gate="G$1" pin="1"/>
<pinref part="U$56" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="U11" gate="_" pin="GND"/>
<wire x1="88.9" y1="203.2" x2="86.36" y2="203.2" width="0.1524" layer="91"/>
<wire x1="86.36" y1="203.2" x2="86.36" y2="200.66" width="0.1524" layer="91"/>
<pinref part="U$57" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C28" gate="G$1" pin="1"/>
<pinref part="U$58" gate="G$1" pin="GND"/>
</segment>
<segment>
<wire x1="25.4" y1="248.92" x2="33.02" y2="248.92" width="0.1524" layer="91"/>
<wire x1="33.02" y1="248.92" x2="33.02" y2="246.38" width="0.1524" layer="91"/>
<pinref part="J7" gate="_" pin="GND"/>
<pinref part="U$59" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="J9" gate="_" pin="4"/>
<wire x1="40.64" y1="167.64" x2="38.1" y2="167.64" width="0.1524" layer="91"/>
<pinref part="U$60" gate="G$1" pin="GND"/>
<wire x1="38.1" y1="167.64" x2="38.1" y2="165.1" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="C30" gate="G$1" pin="1"/>
<pinref part="U$61" gate="G$1" pin="GND"/>
</segment>
<segment>
<pinref part="C29" gate="G$1" pin="1"/>
<pinref part="U$62" gate="G$1" pin="GND"/>
</segment>
</net>
<net name="N$48" class="0">
<segment>
<wire x1="25.4" y1="243.84" x2="27.94" y2="243.84" width="0.1524" layer="91"/>
<wire x1="27.94" y1="243.84" x2="27.94" y2="241.3" width="0.1524" layer="91"/>
<wire x1="27.94" y1="241.3" x2="27.94" y2="238.76" width="0.1524" layer="91"/>
<wire x1="27.94" y1="238.76" x2="27.94" y2="236.22" width="0.1524" layer="91"/>
<wire x1="27.94" y1="236.22" x2="25.4" y2="236.22" width="0.1524" layer="91"/>
<wire x1="25.4" y1="238.76" x2="27.94" y2="238.76" width="0.1524" layer="91"/>
<wire x1="25.4" y1="241.3" x2="27.94" y2="241.3" width="0.1524" layer="91"/>
<wire x1="27.94" y1="236.22" x2="27.94" y2="233.68" width="0.1524" layer="91"/>
<junction x="27.94" y="238.76"/>
<junction x="27.94" y="241.3"/>
<junction x="27.94" y="236.22"/>
<pinref part="R38" gate="G$1" pin="2"/>
<pinref part="J7" gate="_" pin="MP1"/>
<pinref part="J7" gate="_" pin="MP2"/>
<pinref part="J7" gate="_" pin="MH1"/>
<pinref part="J7" gate="_" pin="MH2"/>
</segment>
</net>
<net name="SPI_SCK" class="0">
<segment>
<pinref part="U10" gate="_" pin="PA5"/>
<wire x1="71.12" y1="251.46" x2="45.72" y2="251.46" width="0.1524" layer="91"/>
<label x="48.26" y="251.46" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="15.24" y1="193.04" x2="40.64" y2="193.04" width="0.1524" layer="91"/>
<label x="17.78" y="193.04" size="1.778" layer="95" font="vector"/>
<pinref part="J5" gate="_" pin="6"/>
</segment>
</net>
<net name="SPI_MOSI" class="0">
<segment>
<pinref part="U10" gate="_" pin="PA7"/>
<wire x1="71.12" y1="246.38" x2="45.72" y2="246.38" width="0.1524" layer="91"/>
<label x="48.26" y="246.38" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="15.24" y1="195.58" x2="40.64" y2="195.58" width="0.1524" layer="91"/>
<label x="17.78" y="195.58" size="1.778" layer="95" font="vector"/>
<pinref part="J5" gate="_" pin="5"/>
</segment>
</net>
<net name="SPI_MISO" class="0">
<segment>
<pinref part="U10" gate="_" pin="PA6"/>
<wire x1="45.72" y1="248.92" x2="71.12" y2="248.92" width="0.1524" layer="91"/>
<label x="48.26" y="248.92" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="15.24" y1="198.12" x2="40.64" y2="198.12" width="0.1524" layer="91"/>
<label x="17.78" y="198.12" size="1.778" layer="95" font="vector"/>
<pinref part="J5" gate="_" pin="4"/>
</segment>
</net>
<net name="+5V" class="1">
<segment>
<wire x1="40.64" y1="205.74" x2="38.1" y2="205.74" width="0.1524" layer="91"/>
<wire x1="38.1" y1="205.74" x2="38.1" y2="208.28" width="0.1524" layer="91"/>
<pinref part="U$50" gate="G$1" pin="+5V"/>
<pinref part="J5" gate="_" pin="1"/>
</segment>
<segment>
<pinref part="J6" gate="_" pin="1"/>
<wire x1="177.8" y1="233.68" x2="175.26" y2="233.68" width="0.1524" layer="91"/>
<wire x1="175.26" y1="233.68" x2="175.26" y2="236.22" width="0.1524" layer="91"/>
<pinref part="U$46" gate="G$1" pin="+5V"/>
</segment>
</net>
<net name="FPGA_CDONE" class="0">
<segment>
<wire x1="71.12" y1="264.16" x2="45.72" y2="264.16" width="0.1524" layer="91"/>
<label x="48.26" y="264.16" size="1.778" layer="95" font="vector"/>
<pinref part="U10" gate="_" pin="PA0"/>
</segment>
<segment>
<wire x1="15.24" y1="203.2" x2="40.64" y2="203.2" width="0.1524" layer="91"/>
<label x="17.78" y="203.2" size="1.778" layer="95" font="vector"/>
<pinref part="J5" gate="_" pin="2"/>
</segment>
</net>
<net name="FPGA_CRESET_B" class="0">
<segment>
<wire x1="45.72" y1="261.62" x2="71.12" y2="261.62" width="0.1524" layer="91"/>
<label x="48.26" y="261.62" size="1.778" layer="95" font="vector"/>
<pinref part="U10" gate="_" pin="PA1"/>
</segment>
<segment>
<wire x1="15.24" y1="200.66" x2="40.64" y2="200.66" width="0.1524" layer="91"/>
<label x="17.78" y="200.66" size="1.778" layer="95" font="vector"/>
<pinref part="J5" gate="_" pin="3"/>
</segment>
</net>
<net name="UART_TXD" class="0">
<segment>
<pinref part="U10" gate="_" pin="PA2"/>
<wire x1="71.12" y1="259.08" x2="45.72" y2="259.08" width="0.1524" layer="91"/>
<label x="48.26" y="259.08" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="40.64" y1="172.72" x2="15.24" y2="172.72" width="0.1524" layer="91"/>
<label x="17.78" y="172.72" size="1.778" layer="95" font="vector"/>
<pinref part="J9" gate="_" pin="2"/>
</segment>
</net>
<net name="UART_RXD" class="0">
<segment>
<pinref part="U10" gate="_" pin="PA3"/>
<wire x1="45.72" y1="256.54" x2="71.12" y2="256.54" width="0.1524" layer="91"/>
<label x="48.26" y="256.54" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<wire x1="15.24" y1="170.18" x2="40.64" y2="170.18" width="0.1524" layer="91"/>
<label x="17.78" y="170.18" size="1.778" layer="95" font="vector"/>
<pinref part="J9" gate="_" pin="3"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="J7" gate="_" pin="D-"/>
<wire x1="25.4" y1="256.54" x2="40.64" y2="256.54" width="0.1524" layer="91"/>
<wire x1="40.64" y1="256.54" x2="40.64" y2="236.22" width="0.1524" layer="91"/>
<wire x1="40.64" y1="236.22" x2="71.12" y2="236.22" width="0.1524" layer="91"/>
<pinref part="U10" gate="_" pin="PA9/PA11"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="J7" gate="_" pin="D+"/>
<wire x1="25.4" y1="254" x2="38.1" y2="254" width="0.1524" layer="91"/>
<wire x1="38.1" y1="254" x2="38.1" y2="233.68" width="0.1524" layer="91"/>
<wire x1="38.1" y1="233.68" x2="71.12" y2="233.68" width="0.1524" layer="91"/>
<pinref part="U10" gate="_" pin="PA10/PA12"/>
</segment>
</net>
<net name="BOOT0" class="0">
<segment>
<pinref part="U10" gate="_" pin="BOOT0"/>
<wire x1="111.76" y1="264.16" x2="175.26" y2="264.16" width="0.1524" layer="91"/>
<pinref part="J2" gate="_" pin="2"/>
<wire x1="177.8" y1="264.16" x2="175.26" y2="264.16" width="0.1524" layer="91"/>
<pinref part="R42" gate="G$1" pin="2"/>
<wire x1="175.26" y1="264.16" x2="175.26" y2="261.62" width="0.1524" layer="91"/>
<junction x="175.26" y="264.16"/>
<label x="114.3" y="264.16" size="1.778" layer="95" font="vector"/>
</segment>
</net>
<net name="SWDIO" class="0">
<segment>
<wire x1="177.8" y1="208.28" x2="190.5" y2="208.28" width="0.1524" layer="91"/>
<label x="180.34" y="208.28" size="1.778" layer="95" font="vector"/>
<pinref part="J8" gate="_" pin="4"/>
</segment>
<segment>
<pinref part="U10" gate="_" pin="PA13/SWDIO"/>
<wire x1="111.76" y1="246.38" x2="132.08" y2="246.38" width="0.1524" layer="91"/>
<label x="114.3" y="246.38" size="1.778" layer="95" font="vector"/>
</segment>
</net>
<net name="SWCLK" class="0">
<segment>
<wire x1="177.8" y1="210.82" x2="190.5" y2="210.82" width="0.1524" layer="91"/>
<label x="180.34" y="210.82" size="1.778" layer="95" font="vector"/>
<pinref part="J8" gate="_" pin="2"/>
</segment>
<segment>
<pinref part="U10" gate="_" pin="PA14/SWCLK"/>
<wire x1="111.76" y1="248.92" x2="132.08" y2="248.92" width="0.1524" layer="91"/>
<label x="114.3" y="248.92" size="1.778" layer="95" font="vector"/>
</segment>
</net>
<net name="NRST" class="0">
<segment>
<wire x1="190.5" y1="205.74" x2="177.8" y2="205.74" width="0.1524" layer="91"/>
<label x="180.34" y="205.74" size="1.778" layer="95" font="vector"/>
<pinref part="J8" gate="_" pin="6"/>
</segment>
<segment>
<pinref part="U10" gate="_" pin="NRST"/>
<wire x1="111.76" y1="251.46" x2="132.08" y2="251.46" width="0.1524" layer="91"/>
<label x="114.3" y="251.46" size="1.778" layer="95" font="vector"/>
</segment>
</net>
<net name="SPI_SSEL_N" class="0">
<segment>
<wire x1="15.24" y1="190.5" x2="40.64" y2="190.5" width="0.1524" layer="91"/>
<label x="17.78" y="190.5" size="1.778" layer="95" font="vector"/>
<pinref part="J5" gate="_" pin="7"/>
</segment>
<segment>
<pinref part="U10" gate="_" pin="PA4"/>
<wire x1="71.12" y1="254" x2="45.72" y2="254" width="0.1524" layer="91"/>
<label x="48.26" y="254" size="1.778" layer="95" font="vector"/>
</segment>
</net>
<net name="VBUS" class="1">
<segment>
<pinref part="J7" gate="_" pin="VBUS"/>
<wire x1="25.4" y1="259.08" x2="38.1" y2="259.08" width="0.1524" layer="91"/>
<label x="27.94" y="259.08" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<pinref part="J6" gate="_" pin="2"/>
<wire x1="177.8" y1="231.14" x2="165.1" y2="231.14" width="0.1524" layer="91"/>
<label x="167.64" y="231.14" size="1.778" layer="95" font="vector"/>
</segment>
<segment>
<pinref part="U11" gate="_" pin="VIN"/>
<wire x1="88.9" y1="210.82" x2="86.36" y2="210.82" width="0.1524" layer="91"/>
<label x="66.04" y="210.82" size="1.778" layer="95" font="vector"/>
<pinref part="U11" gate="_" pin="SHDN#"/>
<wire x1="86.36" y1="210.82" x2="76.2" y2="210.82" width="0.1524" layer="91"/>
<wire x1="76.2" y1="210.82" x2="63.5" y2="210.82" width="0.1524" layer="91"/>
<wire x1="88.9" y1="208.28" x2="86.36" y2="208.28" width="0.1524" layer="91"/>
<wire x1="86.36" y1="208.28" x2="86.36" y2="210.82" width="0.1524" layer="91"/>
<junction x="86.36" y="210.82"/>
<pinref part="C28" gate="G$1" pin="2"/>
<wire x1="76.2" y1="208.28" x2="76.2" y2="210.82" width="0.1524" layer="91"/>
<junction x="76.2" y="210.82"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="U11" gate="_" pin="BYP"/>
<wire x1="119.38" y1="203.2" x2="121.92" y2="203.2" width="0.1524" layer="91"/>
<wire x1="121.92" y1="203.2" x2="121.92" y2="200.66" width="0.1524" layer="91"/>
<pinref part="C24" gate="G$1" pin="2"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="J8" gate="_" pin="1"/>
<wire x1="157.48" y1="210.82" x2="154.94" y2="210.82" width="0.1524" layer="91"/>
<pinref part="C22" gate="G$1" pin="2"/>
<wire x1="121.92" y1="236.22" x2="132.08" y2="236.22" width="0.1524" layer="91"/>
<wire x1="132.08" y1="236.22" x2="142.24" y2="236.22" width="0.1524" layer="91"/>
<wire x1="142.24" y1="236.22" x2="142.24" y2="233.68" width="0.1524" layer="91"/>
<pinref part="C21" gate="G$1" pin="2"/>
<wire x1="132.08" y1="233.68" x2="132.08" y2="236.22" width="0.1524" layer="91"/>
<junction x="132.08" y="236.22"/>
<pinref part="C20" gate="G$1" pin="2"/>
<wire x1="121.92" y1="233.68" x2="121.92" y2="236.22" width="0.1524" layer="91"/>
<junction x="142.24" y="236.22"/>
<pinref part="U10" gate="_" pin="VDDA"/>
<wire x1="114.3" y1="238.76" x2="111.76" y2="238.76" width="0.1524" layer="91"/>
<wire x1="114.3" y1="236.22" x2="114.3" y2="238.76" width="0.1524" layer="91"/>
<pinref part="U10" gate="_" pin="VDD"/>
<wire x1="111.76" y1="236.22" x2="114.3" y2="236.22" width="0.1524" layer="91"/>
<wire x1="114.3" y1="236.22" x2="121.92" y2="236.22" width="0.1524" layer="91"/>
<junction x="114.3" y="236.22"/>
<junction x="121.92" y="236.22"/>
<pinref part="J2" gate="_" pin="1"/>
<wire x1="177.8" y1="266.7" x2="167.64" y2="266.7" width="0.1524" layer="91"/>
<wire x1="167.64" y1="266.7" x2="167.64" y2="236.22" width="0.1524" layer="91"/>
<wire x1="167.64" y1="236.22" x2="154.94" y2="236.22" width="0.1524" layer="91"/>
<wire x1="154.94" y1="236.22" x2="142.24" y2="236.22" width="0.1524" layer="91"/>
<wire x1="154.94" y1="210.82" x2="154.94" y2="236.22" width="0.1524" layer="91"/>
<junction x="154.94" y="236.22"/>
<junction x="154.94" y="210.82"/>
<pinref part="U11" gate="_" pin="VOUT"/>
<wire x1="119.38" y1="210.82" x2="132.08" y2="210.82" width="0.1524" layer="91"/>
<pinref part="C27" gate="G$1" pin="2"/>
<wire x1="132.08" y1="210.82" x2="154.94" y2="210.82" width="0.1524" layer="91"/>
<wire x1="132.08" y1="208.28" x2="132.08" y2="210.82" width="0.1524" layer="91"/>
<junction x="132.08" y="210.82"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="U10" gate="_" pin="PF1-OSC_OUT"/>
<pinref part="X2" gate="_" pin="1"/>
<wire x1="111.76" y1="256.54" x2="139.7" y2="256.54" width="0.1524" layer="91"/>
<wire x1="139.7" y1="256.54" x2="142.24" y2="256.54" width="0.1524" layer="91"/>
<wire x1="139.7" y1="256.54" x2="139.7" y2="254" width="0.1524" layer="91"/>
<junction x="139.7" y="256.54"/>
<pinref part="C29" gate="G$1" pin="2"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="U10" gate="_" pin="PF0-OSC_IN"/>
<wire x1="111.76" y1="259.08" x2="139.7" y2="259.08" width="0.1524" layer="91"/>
<wire x1="139.7" y1="259.08" x2="139.7" y2="261.62" width="0.1524" layer="91"/>
<wire x1="139.7" y1="261.62" x2="154.94" y2="261.62" width="0.1524" layer="91"/>
<wire x1="154.94" y1="261.62" x2="154.94" y2="256.54" width="0.1524" layer="91"/>
<pinref part="X2" gate="_" pin="2"/>
<wire x1="154.94" y1="256.54" x2="152.4" y2="256.54" width="0.1524" layer="91"/>
<wire x1="154.94" y1="256.54" x2="154.94" y2="254" width="0.1524" layer="91"/>
<junction x="154.94" y="256.54"/>
<pinref part="C30" gate="G$1" pin="2"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
