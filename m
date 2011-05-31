Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43421 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891Ab1EaSbb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 May 2011 14:31:31 -0400
Received: by eyx24 with SMTP id 24so1756473eyx.19
        for <util-linux@vger.kernel.org>; Tue, 31 May 2011 11:31:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Sami Kerola <sami.kerola@tomtom.com>
Subject: [PATCH] tests: add lscpu dumps from three Dell's & a Xen
Date: Tue, 31 May 2011 20:31:25 +0200
Message-Id: <1306866685-2507-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Sami Kerola <sami.kerola@tomtom.com>

x86_64-dell_poweredgeR610
	Ubuntu 11.04 kernel 2.6.38-8

x86_64-dell_poweredge1950
	Red Hat EL 4.5 kernel 2.6.9-55.ELsmp

x86_64-dell_e4310
	Red Hat EL 5.3 kernel 2.6.18-194.17.4.el5

x86_64-el5xen
	Red Hat EL 5.6 kernel 2.6.18-238.el5xen

Signed-off-by: Sami Kerola <sami.kerola@tomtom.com>
---
 tests/expected/lscpu/lscpu-x86_64-dell_e4310       |   28 ++++++++++++++
 .../expected/lscpu/lscpu-x86_64-dell_poweredge1950 |   23 +++++++++++
 .../expected/lscpu/lscpu-x86_64-dell_poweredgeR610 |   40 ++++++++++++++++++++
 tests/expected/lscpu/lscpu-x86_64-el5xen           |   30 +++++++++++++++
 tests/ts/lscpu/dumps/x86_64-dell_e4310.tar.gz      |  Bin 0 -> 12933 bytes
 .../lscpu/dumps/x86_64-dell_poweredge1950.tar.gz   |  Bin 0 -> 1492 bytes
 .../lscpu/dumps/x86_64-dell_poweredgeR610.tar.gz   |  Bin 0 -> 14095 bytes
 tests/ts/lscpu/dumps/x86_64-el5xen.tar.gz          |  Bin 0 -> 7296 bytes
 8 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 tests/expected/lscpu/lscpu-x86_64-dell_e4310
 create mode 100644 tests/expected/lscpu/lscpu-x86_64-dell_poweredge1950
 create mode 100644 tests/expected/lscpu/lscpu-x86_64-dell_poweredgeR610
 create mode 100644 tests/expected/lscpu/lscpu-x86_64-el5xen
 create mode 100644 tests/ts/lscpu/dumps/x86_64-dell_e4310.tar.gz
 create mode 100644 tests/ts/lscpu/dumps/x86_64-dell_poweredge1950.tar.gz
 create mode 100644 tests/ts/lscpu/dumps/x86_64-dell_poweredgeR610.tar.gz
 create mode 100644 tests/ts/lscpu/dumps/x86_64-el5xen.tar.gz

diff --git a/tests/expected/lscpu/lscpu-x86_64-dell_e4310 b/tests/expected/lscpu/lscpu-x86_64-dell_e4310
new file mode 100644
index 0000000..7131e3e
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-x86_64-dell_e4310
@@ -0,0 +1,28 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                4
+On-line CPU(s) list:   0-3
+Thread(s) per core:    2
+Core(s) per socket:    2
+CPU socket(s):         1
+NUMA node(s):          1
+Vendor ID:             GenuineIntel
+CPU family:            6
+Model:                 37
+Stepping:              5
+CPU MHz:               1199.000
+BogoMIPS:              5319.97
+Virtualization:        VT-x
+L1d cache:             32K
+L1i cache:             32K
+L2 cache:              256K
+L3 cache:              3072K
+NUMA node0 CPU(s):     0-3
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i,L2,L3
+0,0,0,0,,0,0,0,0
+1,1,0,0,,1,1,1,0
+2,0,0,0,,0,0,0,0
+3,1,0,0,,1,1,1,0
diff --git a/tests/expected/lscpu/lscpu-x86_64-dell_poweredge1950 b/tests/expected/lscpu/lscpu-x86_64-dell_poweredge1950
new file mode 100644
index 0000000..64c5a9c
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-x86_64-dell_poweredge1950
@@ -0,0 +1,23 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                8
+NUMA node(s):          1
+Vendor ID:             GenuineIntel
+CPU family:            6
+Model:                 15
+Stepping:              7
+CPU MHz:               2327.526
+BogoMIPS:              4655.08
+NUMA node0 CPU(s):     0-7
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+0,,,0
+1,,,0
+2,,,0
+3,,,0
+4,,,0
+5,,,0
+6,,,0
+7,,,0
diff --git a/tests/expected/lscpu/lscpu-x86_64-dell_poweredgeR610 b/tests/expected/lscpu/lscpu-x86_64-dell_poweredgeR610
new file mode 100644
index 0000000..55791ce
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-x86_64-dell_poweredgeR610
@@ -0,0 +1,40 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                16
+Thread(s) per core:    2
+Core(s) per socket:    4
+CPU socket(s):         2
+NUMA node(s):          2
+Vendor ID:             GenuineIntel
+CPU family:            6
+Model:                 26
+Stepping:              5
+CPU MHz:               2261.056
+BogoMIPS:              4522.04
+Virtualization:        VT-x
+L1d cache:             32K
+L1i cache:             32K
+L2 cache:              256K
+L3 cache:              8192K
+NUMA node0 CPU(s):     0,2,4,6,8,10,12,14
+NUMA node1 CPU(s):     1,3,5,7,9,11,13,15
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i,L2,L3
+0,0,0,0,,0,0,0,0
+1,1,1,1,,1,1,1,1
+2,2,0,0,,2,2,2,0
+3,3,1,1,,3,3,3,1
+4,4,0,0,,4,4,4,0
+5,5,1,1,,5,5,5,1
+6,6,0,0,,6,6,6,0
+7,7,1,1,,7,7,7,1
+8,0,0,0,,0,0,0,0
+9,1,1,1,,1,1,1,1
+10,2,0,0,,2,2,2,0
+11,3,1,1,,3,3,3,1
+12,4,0,0,,4,4,4,0
+13,5,1,1,,5,5,5,1
+14,6,0,0,,6,6,6,0
+15,7,1,1,,7,7,7,1
diff --git a/tests/expected/lscpu/lscpu-x86_64-el5xen b/tests/expected/lscpu/lscpu-x86_64-el5xen
new file mode 100644
index 0000000..c801b23
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-x86_64-el5xen
@@ -0,0 +1,30 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                8
+Thread(s) per core:    1
+Core(s) per socket:    1
+CPU socket(s):         8
+Vendor ID:             GenuineIntel
+CPU family:            6
+Model:                 26
+Stepping:              5
+CPU MHz:               2393.998
+BogoMIPS:              5986.29
+Hypervisor vendor:     Xen
+Virtualization type:   para
+L1d cache:             32K
+L1i cache:             32K
+L2 cache:              256K
+L3 cache:              8192K
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node,,L1d,L1i,L2,L3
+0,0,0,,,0,0,0,0
+1,1,1,,,0,0,0,0
+2,2,2,,,1,1,1,0
+3,3,3,,,1,1,1,0
+4,4,4,,,2,2,2,0
+5,5,5,,,2,2,2,0
+6,6,6,,,3,3,3,0
+7,7,7,,,3,3,3,0
diff --git a/tests/ts/lscpu/dumps/x86_64-dell_e4310.tar.gz b/tests/ts/lscpu/dumps/x86_64-dell_e4310.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..2988cbc52d5c1580634140b3f044224386c22bb6
GIT binary patch
literal 12933
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%0DyM$%h<S7f)oCDrZ%
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

literal 0
HcmV?d00001

diff --git a/tests/ts/lscpu/dumps/x86_64-dell_poweredge1950.tar.gz b/tests/ts/lscpu/dumps/x86_64-dell_poweredge1950.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..ef3f73ea23667abdb7583d0e86ade215bc8a64b1
GIT binary patch
literal 1492
zcmV;_1uOa=iwFScp5#pc1MOT}kE1pio!9Uy{MbtE)Hb#u`&6}E?T)HSt4fvjEpm*>
zAaN^@+06d>+9YHqnPC!`jMI#Lq$I?E;XCK>`2xu*WHUy7j%1q7%Ho@>WVDcIO5rb8
zCj(RnC~ZF#_CMQYglK>e3Vae=K|~-5t^hsVDfDAmH@pJisw#@+rR@%_zfi1t^)IVJ
zoW=wr^bZ(z`kTN3{YAM<^0;{2F|@#hkRJUJ!faoE<`Z@W;Auj98J6p>RhD&KRFe+?
zdUrC9ifWcb>f0xoEA8b?-pJHbJ^(S#lJs7!VO~}!!%Wm7qU&Xl^GvGm?bbj1{Ui7)
zi(G&H{^cL=fREHC6o6j=zV`i3pTB!`Bg-<$7i!m_J;-05zw3IjkArK9nJ2iom7q?(
z>)HvNGVtebUU_?8CxWM-JyGb@$vjn+)Or(76qVE~+BLdLU9esimrGrIFKfLxlPe+1
zCMohwnKpX_QhBFhQ=vicTe;ml<*Iu1MePUfG6^CH%36Y^79guDP;v<}A%R$hfR~8?
zwJbr_RBFvaui-#s#hu!$(YyH!h%`=@^(}~+8gNl2Aj?)DUa6{TRjqnq^#*Pm&}5*#
zuT`*$;}u9VQ08jmB2Sv40#Q8^WeQ}ix5Mh_h=Em8R^Gf=6j@TXVKW*kw!Q9%8!j1H
zb35Z{vdA-;H|s(kMT)Mv-AwPU&UK!slk7PE36OAIa+g%ilBZsqHbBO6zL2_}51#kf
zRp>HZg?e2@oU2+_(Q7z8o2&3;x~e}{A?K>jRrGAG@-Nd>{ke)dS9Pum&*my}nXc;3
zRoJ<zb5(FQSJBIKRe!Ex&Q%*%sbJ3KDt4K!>d#fabJh8CRdAWE>d#eybJcnJRp*;2
zd!INk|2tpSufGQ{eEy$O>bv=W6F5TuQY5eQz;OMUkD1fo1dh}{l6Q$}&Bq<%<@-O_
zN0994AFu$q`#&b26_|uDWS9y#;nNA&1$^HH9)zfiUt&As54-q%E91wV{&8q${9FC$
z<o|PGW(rjJ{#O2}mGb*r`2!o}54Z9|E5k>2hmY+Jzq|HhWMlZ#ZTP;8;qz_yRyO?e
zZRTe-hA%hav#FiKKDlu}Q%P`+PJWoVkf*Qom;!vvF3Vey%x*=bd6;%QOegcx`(Q4_
zh48>T9{Ah%fnNv@amRyr%tI`AJ6m^-7>KdM$_F0eO@1Uq+SokAU3v_x>>0;hR-DSW
zXdPn#&yx+%F}r-Zx%oP~`QxJp(PnZO`c~QiLEMFpEeszk(G>+DgosWaHRDmJvZES3
z_E!>%P`<Xch{g0ti-QhUicir<g}RPRE_lV0Xjb#ugSrhuh%w~}8wZP2hfgFyjEKpj
zo^2eq8WGcHhM~#c$UI+R53)@%^feh44w+OM?BW*|UIM{Zeq^Qm0SvqNiH-4xcDDf2
zofhCh{+QU)0tn3k3<6C2C(jDV$6fkZP}RjhF)6WN&xDNj3dkFf(n>t}H|1C@X&TT2
z4PuXmaF2%Y-O?a84FZC6XOI{Rf4B3i3dEB$j^1E`@JZ+Qx!&+m6GDdzr0$Dr63_z)
zVuu92PeS+%38$YOG*1G8EL0Z+#1ttKqDKRzb&lE{D2d%ff#TDrvGBRvxOasd9!ec9
zSTpOM$-ZFpKmS?ZpWxB&7Q>(aC90R{p8qw0m-XK~_WMd74A-Aw>i+-92#(WVEjKb7
zYlGqX2MoI3e;C0a{YAMP<AK5YV?E*S^f!UQ`m5K_{{|ecKf(k#{Y_wu{>X&>?)o=^
zG5TW@`n&eu2*&8|o6w&){Y_wu{=|g-Zv1ZqWAvvc^mo7iHi9wwGZXr|`5z+~qkmvP
ze+r%cCNN0<yolt8383NnL+U&IjbOO``fb<@(1`1wy8Az7Fjjxn3}n1K?igC&{{Mf`
u@b~n`>hsF||BC^{vAccm;Nalk;Nalk;Nalk;Nal!p79?w?Ssw$cmM!n2L&Mj

literal 0
HcmV?d00001

diff --git a/tests/ts/lscpu/dumps/x86_64-dell_poweredgeR610.tar.gz b/tests/ts/lscpu/dumps/x86_64-dell_poweredgeR610.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..2f9fccdb9e33534cac231162373cbd1a1a0ac4bc
GIT binary patch
literal 14095
zcmcJ0d0b8T|9@JP!QA3Q8OF^%Xq07S>C?&14EkV*AvaqXa+9H=I!dImWDljAZ5k7@
z7pW6bwp^rzmK$kNT5os1=e&NebM9@i&CKWXo!>v7$LD%<&pG$JU$5uuxx9wI!_44q
z<eO;*Mpef=!t%b~cUlum4{TU#dHC(JzV{FO?D*}5q{D+-w{6$j?n27q8E#V!eD68$
zU%j)d=F^qoKf0<8O*z<mNUz=VcT27OU0nl?#|HHi^qjtwacryTp(&f7YWRgZ$IPjI
zaQ6?bxM&~9EeG%0wlazzu%?{xQ|4axtB7p7ayb3N>r1_znIZQ}m^L-in{hh|mez;6
z&dw?eken7!GXh9^CeQV|aNjoD(h27U50t$U%t0mhO`11nt$2k|<gyo|>lD6+woTWL
zE6o@54Sf{u)4jM(cyd9tBC9%;nz}EHIv6qGYNEjQC@A7eehc+i`OXS==0_;pF4-iX
z6D>R{Xv3#wXS9_bS3QBcx}~%H21Wp>EPxUMD&N3?tlwxA$)tzh7ir@h6!(|bOZqW!
z0qQuAE5bB4^4H`<%$81)rjBD26iwGE)J4qEH?N9s9wrX$r`0u8632Dk0rfRdTr96!
zMnzdV?@uM3`{&2;qmEKbCCs5P>CZ0LC{Jb3OX?CmUh~6?^u>u$6!U9aet2G){A9S7
zB)~_&INHX`ZoJgiU6*GFrba!G9JRfoqN|G~*CeE7)>DUA6_Fu|(8|w6+B~?wK`_07
z_N(`xB3AG4s`pqpy_6F7t?JcJ<270}r{<_&-c@Sm)KbYGlB1G2@uW@r{i@9Rx4tl9
z-gC{A!IJa+B+0bnJf=`PTT>e6!IVY7)b5p2Xpc+e3wwdDv_1G=S``3(qkYxcexVVi
z-xWSrR1u4kzUdnw@0ca8h4_e4+q1(fZ@iq=S))<O&!{GWV}C`JB!|h!ppL8JZ`i4l
z3cGhdQjnM<(k`9vQ5LbW{zr#FHKJsHzu)I%#mnTiRgaQjmDGPEQw-Z@+*`P0gTUdO
zON6lGw*Y$S#ks>4<?;jaUWN7BAF^I5>%K(gynnS^eMFL-sJ`x__OaUCSMuw$iv#kg
zGC^PPmV;w}pC;`_p5K!F7Q)rHEr&B(*ON&R%yY|ZNoiXRV_sRvU%cFJNuO=Gz3DT;
z)f*#(?=<7yX@qCX+77J0trn?oyT_|;Clhzn3c=h#Uo4$-@l{OnMU_YL#Twql8tP&f
z!Q8z)hQk@#)d?Ava=OQGe{y@t38&IsNt!dlcMZcOxr&fng=DV#wWSMl-^C<fxSZ#=
zXi~}I7{4VG3UlA!wY=k1X}j;=9hH26N*Rz%d&$lZy`MWe`4Z(c1V5R?DFiPL2;bRW
z*u9=waJO>ms6&-Og5#Tu0<Q1N(ZsEOY%h25SwdbvnsX%BCdY)jQ(755aAOiY7(%U&
z9XRhM-!j7l6sc0jWK*|bAbNM9!R-8Y*pR$?lPUJpDb<0xNuJBJmL<YU_v-G7ol=@V
zsQqK_*TgY(B+WN_Y36sh&*jptqEq}s{Jz9K?Msm|*H3o2IGoVfd4nAcdDQQ#mEn0m
zyMT0YJaaDpJIR*{I&X&GVF{h89XD81PL6(7BiUV_8YG;wLAxR04f}uAb{plddc`l3
zgsR4CN)n61Yo-OL7-dOJXG(jw@?lNQv$r8v%*m-E#Q~3fD&thW#9>kyUF`QXfS+Hd
zvD57F-C8p)VQ)=pgVO&n`3*#N?fh`*^~gR%$+Qf&ux~-@cwmz2(u|nvOTSs3p3_sa
z=jVG%Hgv6D(Yr2P(F69ZY!`lammmL7dd;{xx&MfE9oLOZy;C2ysOQ6}=f4h5Uv&J1
zCsV9VwG$~1CzS45H}A;xJ%#@FB)?mCo4L4)T2LyOwKh84adm*AN|BPJ>aHExbCCOn
zWK*VUlX>Ay)2*j#Zbc}pZ~F2|@gG-ex_9dyA$D}oj@WB|`L#$i*T#P&p_#TaAl<7d
z-s9pg{gRjFsK#%28}Yg|naB9Ni}y&fmGk#Md1NxEjyI*yrd{DpGu5K;hiO%)*ULej
z3jJD@*o<=DQ7;?zhdot%NAObB_YSeaOPfre`bnyhiRc|pZxt!EYC-3*ZZz+fN(nRM
zJN$TQ&&jXFWU!~JHX^LDJ})=N?LXReIoafv<uw0xv{D=|UQ!r%t4=ZH@>ff>7VUPE
zQtJ3}BVKn%lFkw<ds$h+jhAzrvnon%ST6F>X1bf)Q})`vlU(JUOpH1q*)*|hk%AUX
zdA-1%Q4M>gqRe*>R>suv-?VQX`HbqjR~^UqUUo6T&ahn$S?hS5u`nyAGTzJr`(N*9
zsfCebS|7UKlys=NY;)>45fuF3yJ@GGu&>uE@)k2!=N{|cc3UNR)W@0bRrJUsVy&9^
zrC{MPlhvIZZJ;=F*mA~n%v5bo#01r*jjHdgy2G&LwCNTnts-oKG^RR2kN|U5J3ACV
z(~^rpH1aW+pD%nvK`SX~zcZN0A#KHu#r0~UK@J{txH>21-zBAzGYc=9m6K9!)$#lS
zmxmhvd7=TW7G#r!5wI=_431|JB|^(qG@SE!5no{|*ZiD3s6r;JRF_l@9aKrsGhpTA
zo^A|3sO^u`GUEnFYF&G!@Bsc6m$<yk?ZGc?8Lc_bWICK=EbKtowG}OnO)m}eD7B3<
zaw5LA^I;U3Hc!B`$I@;FHoc-D_4?hisKNNJ^9r@&X`{*g$xM8E0WT(&!X_DIa}q35
z!!tHsA7t6hWM_wSWZWBY154vTWu=lxfGwUoTWN^ZJ&%JAOp0eBmhDyv%p7@FNUMoX
zV911>tpPXMa%}YqxUh3GW1{6JsfD-Iylq{wgkQCy@e(6oT+!o#;fCs*I`RTz6v*)M
z%*qAnaEq}u%ct}3DgzkaB)p-TSl#g)8S@5;RJP{Euj7iLh~eEH+`56x9X}T8n6Ndp
zeX)wLo*Bg~(p~y@((LhN!_{55`y?<SDfM9<#trNjwY<R5-t2wu!rsd*Zz?5vcrx+3
zxF@BxL=D`k^}QVDEtYObP1~Dd{Zvi89#T8!^%k1n1;GoS;x$axy#$&+eD4$LSJ*;R
z=H+lfcZmY6@SayT*~1Q2;W5N2iMepgNfEAp3N_!*yZV~N6KXep3(OO^8?V>$9l+AC
zjKs$y3SsSQtxzl@f}JP0dYWB$IGL{bl`f`#`{Us(6*I_`R;-6K$Z~}k-?7lo*k1Z@
zPxv&S5ns$*x|4|;QD0{IQz%bLjwGhNg|T*nnDtlBMg5WWaJ}vAT4l`nB-me<({BhP
z{W-^7+dV2fA}jHSz#l3h8Ei#;8_01Z(yVWT%P`M6&y(XTsDS)~cVFK&vs(bS)<M`9
zCkS=+`L*_3&%qF9SteRL1^U&)JS<AXc=}rCbMUSaUpq{GJ0~VR=#^S{2yTL@p-hOq
zMV<p!&CWTmQtJuFX}&Nz_^^^+L7kZn!lQN!`$pF>qsvG$7h$~wHmj(v6Y*?mDo_F1
z-tN`AzfReP@5>2<Ibc~1rcWzG_3=CKwA5rKqpEoX<2(Z^;<3=ytI4;pHHG1`hkP3B
zvD^b`ihbALgRK~D@0rQ`h96Q?H3e$EhMeK|;%s=O*R2^T-#k?-zAvLLL)#!HEuKX_
zj2V%(nLAwaCY&Uh9ZML?AhA&upM8+caB>rj<Bs^v?sf6ljB#Gf=t{!Mhe>QMwWg9*
z^Vllx6-^$KN?w3TU?O|SSnFdN%NquMxn)fs$6UB26<C|yVcUS_2QO)d1r-|16w~|y
zwJ=ReI-PQ$Q-^Ua^B*veTyBy(g!|x0^8!n_pNwBr@eOIdzPe<5Gi(#=rBMto3fcrp
zDSSHHA}B8dU*K&MNBAdgii+<#e7AAy&}{O=8@TrtoUF~sufbG7BGe*C^zEQ_!4AdJ
z)Lj*SdIYqe_gHOfTuOT2Z^FOL0rPU^5|%!`xCJoIjZVkD#&5lO2O%jk_MU9>A$X4f
zwz08iJC>1~&O;Bs0Tn^xHoH!&AYI<^YwTycMm<n?k1VI+H1<qfwVKH2s3v+O91(20
z8QG`Jq*gn2W|CJ|#;bE2PagCc5d(#4iIj0MUjTXT2bj28zvR=im067Vrs}5m%8Ae~
zcyC=?tcUE!a|_RJv}k=7*3)Iaz~7du6vw(o)RQZ+jbasY!*DtHgV3==8}`a-ix~(D
zQ)b`U)gcztYh60;koHRPq(g=s2VT%-X1~oMi@G@$M<8d%WpTnO*e}CIH44;_d3P!x
zQ6-%Ji0T}>f5|OR+S&CsBQ$$Xc}%Q;ECbJyp+9ZqJp|P_u$2<(@pr+^V2W*W>(pY=
zHuvw{w5=xJfoH7@!b@Qm4YS@GB-<I=ZU&ydG=C#Q^+&A0R_JG7g}o8}r9r}3I1l!3
z`qQNOPxLHi!`>%w+Q<M0MU@;zmBQczC)xa_zg!69p-aFsl)^RL-?h$w5N*vc=aG0`
zKza0TAm18n9wWt?oaY9%+YZ#*?+RvYzc%ok0q5sK##}I}TXuQj`G+QxTAjR8DM1A9
zhDg}^wQU8AxI-)r)DULrRu`~ddaA?Z<eMa!AR3Hx4YT(NwotFi$8bFcjC3P`E9zrf
z;n5M<q+Kmznm4&z@Eq#?fSppJHQOu4$xdKeNpO%F%*<xNv5lcO`|vE*;*7w$?z<4C
zW5Hv~OumDN-rO?VnUh@095Ru^n908Ckd?g~5V50~9wWqGTv*0^C_)r=sn%alN^lMO
z(M{XP!Zu^i^lsqSussul#jU*gA}6uTH&IYL*=>&xEl6&6^PtiRCOMYSV)NeYU}zps
z<KZiYCx@}vM#DR(!xZE%QmTjIER1zya_}FpL)gx(wq<`kKEI4G&L;IgT?0KlX<^qk
z^eTMOVuUo6guR5Ej2r=*9yAYzxlMzi;|GHw8af6=sFs<XZ^L6d=Q-CoE}!ZgTfRzW
zbnbSDif}z@q9!bM?j&73Vq<=md1dXeb70O0YhamH7P<>=zP#E6Lfl7Q*eD$6xe_D_
zD6Oizt>UK)Zf(IxP6Wno@7iY$$coR~bS|5;`IVX%r6SrHs-4~2xQ>ti^&ZQ}{E?A~
zeut9&m85wB#7{fRP@CY|UG1uiqegaamjlC&)Z^h!)#SOKVg!|d&pTUrK^rEHT!L)u
zM=g&D`>~7(L2Y4eK^|nt51Qqq28?PzJ>^mU*UkoZNW+RXkjO}I9+;nF`jd&1%ZX$l
zsuVC3c(+XckPPXd&M61yw+K^e5gv2gGjImJu^eG)EDTT(wOYcge~Iv`HgviKo}7b=
zz`xtfiQ-6vHI@^FDsjX&bD|Tl0@6dJqQkJYNa~~sS){9<Lg?TnR@(;WKV=qmX+y{6
zLkgbw`Fsy7_JbNe5+YrluyCv6Cc3iF6C!*dhNq^ipTMFBtUJecHx4S@z*I~I;;X=B
zX##An0e`8ax`?6G-ueb!CU==J^f=Eb992!l|B(2L;&*_KEFHmjRtQhUAZ7UNME07E
z3J0NLRkt?nI>f>FbU-i(bn40Aqg8`-w<S&xGHrZA+$(%7wz`&L`Jp{@Wq&z0Ft{GW
zfsx=9j{t*>tsfZrF~c{^X>9T`7+a)eTVRrgn0^d0{;KGYL8gNz6Jn=$X#UK1pQpLq
z{mHaT#D-WB;Wsp7ox0{6{JVxUxrGC1;#;UcC?uW?@H-5dr(YakoQ-=G3taLl&is_L
zK-RNe7+I00A-j<Ni;Ic44IXK5eBPI53-i8M@Dda>r5d&zOmRB*)Kb1iE*AFRpJgi3
zUFX?64l_uV@g1b3m2pGOQT}t-)pH24q~#n-svv#Sw0z?z5Jt?UNd@DvLzT05y_b#E
zd0085gcg_|hRYd~X(}7y{3gcME>iJDBgI-?(C<pVmX9=vOjGvSvmI#+fh;L!O}*GJ
zMJs9F>jacDkfNaiIt=wr?`Y7j*KtrX>|D42rsHGD2a-XE8a3d&iH1k8gkwp;%y(*-
z6$R}ARqW{^O%gGL**oCQLk+$RKUjzU#WiGkHsnIs>xb@13&Pv(Hk=rm110V$91(s8
zK`jc;jXQXL6^vNRbd*x&e%)69*MJDb8o}78OHA7y-dD)Ey1rszPeJ6e9~d6?FiV`d
zVmJ#<%}oGp|7*l=B1zcTwWLo4KS+AkfSrPPALJVsv`ci5Is%q7-=}4>>4g9{pWYV&
z6e|Sk)Xu+X`MVjOafdn<zQOdBl@ZRXo+rrmV5%W|V0Ypj(lx{lm1NH*y#&B!M|@yH
zSP9V7f0d2>r<VZwDaT0w?75e)wn8gx=16JH9O>Ts9Lb0lndd*U9p`yDxR2ldKLh&A
z9f!pH6`dR(!P}Rjaxk_V(kKmPbJ8F=3Bpkt4A)5m{?U?@illQXr)g3G5zg!6q!T9%
z<`47iwD#m3y)@8r(qJfrpfpHUjiDvq^pwKJwel|E4de+XeEC@zQ>21xp;;&mB%Czp
z$4UdyjbH^ihLzoWS!p0p>7~KC{!+s1#A~vaTrj;gFO2+ZUnGb1yBO&I&lJ8I@Q_yF
zA;mU8CMyp(yurQ_!xmN^AY0MWJXRh+3wcndRv?F#lVh+4AJDued0_FByaL5{RL+lJ
zY^`rJooc5W^fhD~-v=LoeIdB9H|Esur|a*NU_Tl;_J4)*o!lNaQHn#2lmcHLD+ah;
z$R^o2qI(t}rl0X+_9d`FCmh5rl!4|uRvF}wCyJrAfwacoj^vADdid>*7W6<R;luEB
zgza-c&ng3i94$Ypk~BLD`UjAs{8zJ-2D_+MD=>=$9E0rKJR_y9Ga<ESesB9_s|{UZ
z!Sy0}Q}W|_-<}dlNi-x^OO(`&N*Km#Ajf(RrP|%f=y<4h+K`!$^;<y&TSc#5MKYTz
zNwG#S1_@Ne47GUBPmW~tY^5E<{IG5k^b2aK3ec&PRngQ=%JE{I$R%-jF+8y`om1ms
zGN=kPjKuG&Txj(<Szs#G@>{o}muK)QU}Cc>=qRHcme9Ph-<KTiI|n35q|R&V#(GT^
z9STwYsffIt&tVk}50+o~f`16=jyyaJW6V3j7U-4r7I-@e!%*d_24J~)!iN21sZlAc
zv9h2iDZsQ4Wcv?aA01`jW`!`L0B_XDG-0h50Hhy~FDqd=!{5SsM2IzBV1)Q`m;-l&
z{h?~Gz5v{Ne+y+Q5|Q^Jp3Wzcp2}f$U)!MZTAb4VZNaZXcBAIC{zSoFhd{k7<th<d
zs;F9D2v6|kplC*U@s=&Dwn(g2DG9^B!)$aFp9;6|rvFgIPiD37htvwEie3xr`USP{
z_2smsp_J0IDJ=3|$QR8MhhZlUc6=`I0xP+Bi%efia&}WNt5awxB@M=JiGICNWbPJz
zQ7!4DN!Lu99p0~=cKuRaQ_1Xt*hI!z>ZEge%>6nV?>6k*<qZ6sxkiR$VPKu-bV!m>
zWptc1dPy1I&}Ek2iW<ocYOapA?kRJ!u5J8dj;%|Q8LCdToDrl6L^>f{N3J-8Lik#v
z5N`htHhb<I6AbYyiUz!%7@9@W2?KZBRav+tFykI@B`^LIxlto+K!5c^LjSzaO`PM)
z*L+m+M_QD;Xb6K+GVUo5C0gFAm(!Rdyu*;VXnX^|0Qf$T<Gi@E+Q)D+OQa<rkwI%Y
zY+fOAR^?4#T_RW+2O<^OZqR?|L#PiC%CY3j;VKI||5(YN^k!xaU)JaW=?;Gr{BUm;
z&iFUG<vbQ}iy6~qIg7`vvto3T_0u(9OD>(&#OeQGnE#3iJJ9m3dILx&MoM5^A#8ai
zbr;k`l~o1o>J>QVwM<m5B!;L7bClDmVA14nT0Et;HTjzyGh+Qs_J_0nCMQw#{^s8&
zH%|!|?TnP@&w*Y_9yLXJSQ^k}?5H2+-irS`qfaY``dvce8OP{VDH@6O&K->^wt!Qy
z4;_lbtU1@Sua<u_E2W~~n4a2%^w&_RUCduWM%RR26K3?335e<ki`OnPMsi;CwF1nI
z8$?Un?ARXPoGPG(T{aS(7gocbVyO9g4f}6S!>(;W8q0VLoeps&uuAlFfZtpuJ?0#Q
ztN8wlUy~QeQ{jRwuj-uFv2}0!nmj|3KLUwD`gT@?RzbKiHQP{EZI#2oY&aed-spYY
zepFCrY>;YJ4l^}?F4a9RHEDfC9iy%484W*FL8=CxxsP{i3J2J0P6blaQO4VhG++0<
z!wlHOpb4bGVat7MiI(s^G!x8bK9HcTNIhrByDaq)9C`{nUNw{cZ0MA+`P>~-4WgLI
z7;6TZ5U2K17+!=<9*&0o>zWvlq1v*R`~?}%ytGCJ)QWDaBsR(<!7_fkn{Z2K4|+1`
zs26qapc`%4Y+IrlO3<)w{CX|FfgHm!rKf7|?^zGiu*L0Jv8k)(Y;tH681*c9%V*tP
zwAIxiMGgZ~4(UE1xGuQP8jtwgda=P>S}!&@3$<43%yE!tvK34sK&&C{{0iSy7D#Uv
zTv*%NZt@kTV;`6_7TxR?0m$dP{}tqD_O%OiE-&lr+@M(dS7(*Z#gWV1|FiDstTJ*P
z&3iR#hGjRycgSrL7lRLVrlS7GWa{A<@Gqe1$n`mpfmU~Lk$XUwdatP7-ArtTOxKYh
zblE>3L4(!Kw(~g>Bx9U&$|b7)C>hf3Qs=K_&APhrdi4Yhx1L{RcsLX8aptIQCV0oQ
zGl5W(dCIay52Vn8>ydB2`nX44z*eOH_ic{vD4(<UF#4lX)*t07pn4DR9-#tYB*XWr
zp_<O?ERDNc(J<F;0c75}%<uwNl6gBbSuXTa&xKYV9Rgdd`!c4G-syf3*Ca#PCb7*2
zG8dNbmJ-3S_Np3^Q@@<peUb;G(PY!JBCNCqC`(d_Xv&IXMOXt)K&nqNneG!(w1lzc
z?*R|Z$}zozXgGj>G#4)8actE<!73aaq<JnEowZd!Vh%&f!AX~k35uAIHFTJQh*n;j
zXPZ+JbaL~I6SA6vT0X0T&C!6Fbeps6bCDS91fWdfPN!>ajYXy}iFSDUSXkK#w087D
z*a>bch?{CQ8cI3%r>Oy!4FZ&>f{pYll|(rNv2BBQKfv0eCM^StriMHR?hfbxJjf)b
z>IzTByXE`1pt&P#kct1_J0b)f-M|)s33q=S9>{R)Sb@RyJu8Km>0QsJykcNu4!0J)
z09j*r!C<R$83DFx6tvX^7HGbXSkKs_Y2?^x{jDA;gL=uRf$}g##2<s4OEihy8YDS%
zS8(x0juedLab4h;Fnm-u<Eekv5aL0)hCo#yoyDqxwM|*UCJR&r>vgJNZ%b9Mrco6f
zy#Pj-K%(b)lk+@h>O4=&iOrs;H>V1kdjVB}jUB4ZGRW&Yvso4B6X-@&@IfaG)_20B
zKb`~MiZnK?b9oEik<ep7;(bEeN|!XF#o5yHWJ9s{JWs6kX!JZ~=y`^5o+lmwa_}-@
zoEvr}<}|1{8eohYh5*J5ahV{Ng7v8b)JhDBJYifslg^O;5)7{_xv{|WUv}SLVUqSC
z7Z9{eV&65URQ(>4iyIjdwjGy}{h&|DkRjodlr%9U{LnJ2dQ9_L!ZGR&*89=nx8Cjl
z38vp~49GCQZT4OoGw3=k-@Lyw*y+&qIbmEjuhlgS1yR171vfVpn@XXkL67j$W2cPd
z3`eeJ)he<DKibCfqZ2aGH!5N#@}rLuI=sU>*s8lK8?Tj;;|^V9+6MmbBjE1^WYh~L
z6WZL$&<+V6ZuZ^?kXL<C)*zV=n+oBJAk-Z@pOOJD>Qy?M|CneaYx93VkXGqz{+%ss
ze(y$`KQox-V;;D@7CN_IFd_e&_ZKf7!6Ne~lrZ2wE%z>1h7>3x%p6c|evJK6Jk-eR
z97U2fQ>2xT(ecD!7#+`<0IbVz&bs{R$c(N=XovFcz&lmv;ny;8qC1V82n(F51Qaf<
znuB4;TnK~|tQJJ8zeNN*#*ljB2lMy_FxBf|EC`(r)-fQ<1UNn)mH_dqZG_Crb<l_}
ztor-}3$g6*aSiL(;^7=WdE@Q@qjKK;{^CP5ZQJAFJlMKt^h?49Z;Z}9i|`u0o&e}w
z7!G>%E)0k2$gK3a@LhQIzeD_-&Frt$6AeaBG!QX#V2nBx*Ah7Ehr6lX`qA~O2+C-}
z%26nnRr?mM$sN(bs`pP2x(|At<S-s<yiJo5|Eo}#3-7Ex4uv^Of%Euvt*!U?Td|Jm
z^hl^`Vf~zGvVI1<Z~Zuz>uAr|uH9K39HZ00{vYXJD>~$1li#Twb{chXLZc4O;dJl~
zoeut(^RR*Nv=6MGGrB~$Et?3xXZ^en@)sD>9;dygbvy$#g_Or&`04EQFq2f7#0C?0
zOXE^l&8mWyCGW<q8L`1u3=q>elxOi72iYon)pAFj7+{T^B3eL%9!V^2W1!oGAakH=
zE*PEAZw(>siJ>+8!w^zrm?dPFUs!*W$C~_zwWoo2qBA@3#dBt7suQqlF`ohXXEaYo
zY_OELQ+I13+ah?=lx*p?2{75Z6e$y!T|Y^u;zoiCXYsVt@%+yME+RhOA*DdS9uSR)
zj~fP|+0?9hbObG1wi|1({}sru*Ck2+49I)^U68;0mmrUAGg2Ss>RZm1bz3c1w-tS3
z3G0gLt)IP3)=$g_)=x0wY__H}yhm@H#sAqYh@DJKc$4*`Vs{|^M_!}LazDXqMBfp=
zL)Qt58G-F%qIe(U{2VT&=&c{r!Hroir-QF_G5no0{ut%o9#HX(2iFlwV&*Xho)6~M
ze~@_mPbeS2qP+PhP`)xBob*{P?vl~q06Zg_U@1k)$M!zE{lnS&=G$5M*tE>RnfVQ3
z((4oA7FS?&SuUQdF3V-zPVSKPSuRI6KE2$A{8sP#tf0~N2`T$WmfJqwI6_^L_Ls|T
z&L||%ctw8MG~u|GV`F7~rqx8`OFks>xW1s{a{BcJZu<P6Dt<JswXtSMzAb-2SEDZt
z`!-{|X5-fPg50!nazhJRQ`$iG{9vPWR!$*2R91HE0=`#Q4P|&4UT(7LIYrMHss=J*
z+GvQ+J3mJt)jAsP^vR!)KcE8}YBBmy%cK;n?P``sOl}TxH*!JlWs_*e!n5>R#t1IR
z_16cv?rkvCLgS~FJT;1jGt0FW$RJ}t^s$z0ndC;3f$t}|=&Rtef`(0UoA=!?uN{hG
zh26yBI1Xp;bF3cieXIX(wC0$G&u&(>q&4}C9!pDx(M)Svth@cw+ngvQnpW&^UWp-?
zU6<i(s0JzE3Sw$mMsnf5#d+<!PBPpwzLI!aM=Ja47CGNvC&idpzptY+v2b69C37j-
zIQ<eEZVeR(^tuF*yXiOU^DJ)dZR!88$Y~GAPq=-Z`wmmsMb1bjc3NT<CGT?XPU=Wn
zkquD_Du|8DmNbywElM84w||<+ldn5Q^$due{0J)Vs+KQ!2BEn0Jr}m5ToHNnltF<e
z{@YT)j;yyAF%gK#=&)Hm$%)Q$k7W0Ca5InF*Kr=2-o)gQO7t%db3)sY23ET!-6w%d
zw73APWunD-H!Tw_1Z(teUe>UQmVWCQS9JL0fC`Q~k<6xj9VFDv`#N}`{Ezo_{%nW&
zy?vbzSWR)h2TP~k!+8AgxkXETqQ!x~KG7OqDe14`60Hy2Lu3IbalH;x)a?gi$iq5I
zrg3e76AAjYg+HGwe+%N<{1X+=Cb-;lHB~&$jK%~v8bja@65P+x_)<!r;7&`}AAEB2
zgtWKR%PaF~bj!bYh|DB~bd4_zG&>I-L+66Vy@X1D;Urz4(7cY9xvvlC<oN`mX|nL0
zCCf169z$n>MktdRrI^v1O2O_waIMQJn0ECW+xSflxbScmdflH7d=1gir8~$8mtpix
z{ErP>yZbN$gD=(z4;jWp_)qt|2kk4MZWgQit+s4uM4Y*^ED|@W8#L`trlBG5<)YQv
ltLczJ^Nj=Rs1-#@XR{u`=3_tp9|IMn8OKgAsQtp={{hlBqA36X

literal 0
HcmV?d00001

diff --git a/tests/ts/lscpu/dumps/x86_64-el5xen.tar.gz b/tests/ts/lscpu/dumps/x86_64-el5xen.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..2ad47dd6402148564f806c282d9528f01455a875
GIT binary patch
literal 7296
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
UvW+$SCIJlDbh^J@>T`Pk14lI|F8}}l

literal 0
HcmV?d00001

-- 
1.7.4.1

