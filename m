Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:42101 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab1JJJAd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 05:00:33 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9A90VQG010881
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 09:00:31 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9A90UnX2457838
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 10:00:31 +0100
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9A90QtS031014
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 03:00:27 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 4/6] lscpu: add s390 kvm test case
Date: Mon, 10 Oct 2011 10:59:42 +0200
Message-Id: <1318237184-6616-5-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 tests/expected/lscpu/lscpu-s390-kvm  |   21 +++++++++++++++++++++
 tests/ts/lscpu/dumps/s390-kvm.tar.gz |  Bin 0 -> 2275 bytes
 2 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 tests/expected/lscpu/lscpu-s390-kvm
 create mode 100644 tests/ts/lscpu/dumps/s390-kvm.tar.gz

diff --git a/tests/expected/lscpu/lscpu-s390-kvm b/tests/expected/lscpu/lscpu-s390-kvm
new file mode 100644
index 0000000..1aa42f9
--- /dev/null
+++ b/tests/expected/lscpu/lscpu-s390-kvm
@@ -0,0 +1,21 @@
+CPU op-mode(s):        32-bit, 64-bit
+CPU(s):                3
+On-line CPU(s) list:   0-2
+Thread(s) per core:    1
+Core(s) per socket:    1
+Socket(s) per book:    1
+Book(s):               3
+Vendor ID:             IBM/S390
+BogoMIPS:              14367.00
+Hypervisor:            KVM/Linux
+Hypervisor vendor:     KVM
+Virtualization type:   full
+Dispatching mode:      horizontal
+
+# The following is the parsable format, which can be fed to other
+# programs. Each different item in every column has an unique ID
+# starting from zero.
+# CPU,Core,Socket,Node
+0,0,0,
+1,1,1,
+2,2,2,
diff --git a/tests/ts/lscpu/dumps/s390-kvm.tar.gz b/tests/ts/lscpu/dumps/s390-kvm.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..340f7eabe57b1d9bfcb5f8a959013cd9d7e395f4
GIT binary patch
literal 2275
zcmZXTdo+~m9>*IJd!x}Imz)}v=%U7@MhU~Iv~x`*3PVRKJH*Z<)%K1G+pQae_Gr5d
z5xFK)#Hf*RO`D1uOrl(-He#4D^S;0H+UK&)S?8Z;t>;<4^?la&^ZouvNlHr$CK8>O
z$bY>nI9IY$lP9&1Y%%H-R`+t~`rVfO<A40Xs`qwdM~?2u`>@?ny+v-^akSj0NB_mm
zI;}nLxnCA8=NGS3G!{>ZDow1nHYL-nt%Iz+o|2BJU!aMY3Tt*Cq$j=|8T~VtKR;A%
z%T&V@rU$2grM+9}pQ-*+<)K!;xfHba3$Qfy!?_uwi-qwy9C(tWf)Z_e;Klh{`R(k6
z&bDWV+Tb%XB&qs@tO$v+9n<yUxrg?H`H5Q3IM*lbZq|nTqb1{UnT`#X=iX#h4;|KY
z46gDhbqOS_>{K<sV(t=Eh}9ns$ZvUM{Y*G*$DEqKLAsOGU&gJr+-3E~ke}gL#tqWm
z@M$JAJN34Yv%&am1(dd#yEnUfOA%LQ=>W$2xrHZYZ~5l1%Ezs@X=CZu-jXffj>Yav
z|55#}W7#=yyGcH#L;3MwOZ||ALq_Y>2&c;xiRfINspGJ8bV03FfE`=88M!#%IoU-^
zY;bvNr{E?wL-NWGQDwS}^jZrtLY&_%4!lS1t4?@tC#eodEvKBb^Q4s5D8vN5m%abY
zZdX>(4O(qp8nkBEiT|J`;ZARb$#K5;LDb!39m@Nsnn!z+c*o~?6Bnn8&b*trc*~3v
z{<4-fvVDqKQ%gH(9Q00(Yv9p?PtEdqohr;TH08p$6pAplSG3Nm+<!PO#k_quyuM}P
zvo3{2%a6FsJ@q<CV=L2@e0xXscfqfd&J64}pV-%u-dUvej44`|d~v9B^su(*IeMyI
ziA8&SCfyK!s`fXVh;<5&irn1Ry|W`b;l9BBQK}1@L`_Bhpv<4TT1w>WmbsrOW1eRi
z?z^-1MOOc~>Slv@?sKPyI?!>&h5h#k<6if$z5|LMxdHsIY1?a<ooP=70`C=7;z!3<
z<Z$R;Vm~E4>u=!1N^<*K%gxh%8*HUU*GKi;&+BK3HZY>@=}IjxwQxJ1nj+$~{5tCL
zy2;4h^+UykzU<tedC&WT2P>b{NAW~+pI6^lJ>&E%%8`0cFZZKkC}Jyr9YvI!QBKNj
z^XO&E#Da`93#2Refc15Gv~0iCiYzgwn|d7vvke)|#~Ob4xW_BY-H$_zbOYg~Lssg=
z8>^o7F`GuLFSSrwYxF!B>S%RGxV!sqq5b~Og6~UQPfibH6|HkrkeGF_R&Hwhbo`dn
zire8?8lHK#JL8%h(EWc+-^*~wJ$jO1`Cv^=ZD#A)Ti0H;rnV*NJG9;y8O=uY^b^8!
zoYUP%Cpe6*;<b4-fzQt{@{8XeQ9U3`tzhr`jud^na)94jf+da4E1_hS3&68X_)1->
z3cQI;zjw(zsfzL+Ia(j2h+4x0f=1pS47M-gfK_uP5TCPU<-<~@rM$e1WSj+r+;;FB
zVD<cb_hH-E1e`tF4ly}9L0+zY1VNoQe+v#9_koJ@S8ZTU(2Mv=i7^ad_3rw`)_*n_
zc8Tu9<KMnX>+b8NC&x3e)C;AW{#C9?-X=N8&Zya7H`Py0M3l=|mqXj(W;Msq^YbkL
zBX7g|tGw(sgaUIqo6SRFTwFoT_;r1c$2h_)<yuN+{HxB|=nPEzR1Z@N2@|9%ZueF*
z3;Z89$2IQz(hN}^4>SXg7Ox$EdTbLKhXq`ck(R26h=iHbL-kFAoDz?5YVxqx%B$5r
zzoS^W6;_yhLZ(QNLa<)}nD(rve;JDUu=n7kgydY%IEmPfjlxfi5@VW1D{66ol=#A8
zlaaORm;iHd`8dzf^Oa6g&{>lIlZg_{c45>j2U}}{);Up8!RdGFZ(^aC*3#D;epW6b
zG_??Q@fWm=7BzR)eu!snsjv!3eAo=>{wl9Hybw%radNf?B1B&Lu8(Pf+%c2O2b1(`
zHnQqKfMI*SkDCOW$4vx!kIEQ$1`Otd*oTQnCKoLkqMUvT>}`Ip#H3-WQXfPz2@CNF
zP=u%%V|6J5^8#L2A-AnaWAH4hRoKmyP}M@jlax6jhZSgUOgtDVn|J<34M_$)r7qq!
z4mWHZItm2jFd^uJmfvGccWDQFqIfSLN1}?~COL_DQ>GWYpfbmlg%PF{+64Ya3lNqj
zLo|93Ti;J$@(qS$WTi~#3VJY0wZo{dsY-7OBM!ZKr{PI3tn3CQ30QUjLGC3yPGMlY
z78qq=Ya3-qu%9_bS_`BGP>7M3B}$<Gg+2I<09Q<u+bsB(m<-DGW@o6r7}X2+UIW2B
zE<l&Sl+;J<;J+^+|AQSKi69fSuCbJ_3nA3HZ|lod;F)e>18d44h9FuDkeCTX0mR@s
z{ikezWB|lDux*^ilbgl_waK=_2oA>=1VPKjNCp@Svu(urMF@}^H-R_`HjNklq!}{<
zc$I7`bSQ-7Jq57t`27o&37Y&bkqmO;)cxL95Q|M`E5`^qwv8Bv@6m)<+hgSGLaJWH
zH_(=FLQoP8t^J=q$v8AG`|M>s0rXOOD&GBTG9T*(AP{`8MQHn5AXb2I=@L$VbFhs1
zH;n8Bs&X@X67UBc+WHarsEs=SY=m-jfwUenZp={C{=|k4%Krx&=fAOW{tp{x4ZdEB
z*pLl1iq4^L#e%A2!os}vOQ6#iBAL+(iX9M(x3W>@6Ks|P#8i-%g5HM=Qt<g^DPH+y
zDPV$KrK1R2CkN>O39_^qVOL7AOSqYxpeVN-2AZQ$^AL=T<E_}l+eXK`M|DmN^03=t
z^?~HoOc!?<14(6LG<&=osqy-aA<fN;l$|DI;CU?#9aj#N>o0Hs{)3{y`Rq4K@I6Xf
Zl--A}SGuD2%Xyh%nMwSLCEA1~{{VRm2#o*$

literal 0
HcmV?d00001

-- 
1.7.6.3

