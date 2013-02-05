Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.nowcomputing.com ([54.247.101.249]:35460 "EHLO
	mail.nowcomputing.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab3BERHI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Feb 2013 12:07:08 -0500
From: Alejandro Martinez Ruiz <alex@nowcomputing.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: [PATCH 2/2] tests: add f2fs image test
Date: Tue,  5 Feb 2013 18:00:07 +0100
Message-Id: <1360083607-29885-3-git-send-email-alex@nowcomputing.com>
In-Reply-To: <1360083607-29885-1-git-send-email-alex@nowcomputing.com>
References: <1360083607-29885-1-git-send-email-alex@nowcomputing.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Alejandro Martinez Ruiz <alex@nowcomputing.com>
---
 tests/expected/blkid/low-probe-f2fs   |   7 +++++++
 tests/ts/blkid/images-fs/f2fs.img.bz2 | Bin 0 -> 695 bytes
 2 files changed, 7 insertions(+)
 create mode 100644 tests/expected/blkid/low-probe-f2fs
 create mode 100644 tests/ts/blkid/images-fs/f2fs.img.bz2

diff --git a/tests/expected/blkid/low-probe-f2fs b/tests/expected/blkid/low-probe-f2fs
new file mode 100644
index 0000000..ee32864
--- /dev/null
+++ b/tests/expected/blkid/low-probe-f2fs
@@ -0,0 +1,7 @@
+ID_FS_LABEL=test-f2fs
+ID_FS_LABEL_ENC=test-f2fs
+ID_FS_TYPE=f2fs
+ID_FS_USAGE=filesystem
+ID_FS_UUID=f6aee5b9-8cc2-4da7-9f8d-c95aac90e17d
+ID_FS_UUID_ENC=f6aee5b9-8cc2-4da7-9f8d-c95aac90e17d
+ID_FS_VERSION=1.1
diff --git a/tests/ts/blkid/images-fs/f2fs.img.bz2 b/tests/ts/blkid/images-fs/f2fs.img.bz2
new file mode 100644
index 0000000000000000000000000000000000000000..82e86013d833654bc871bd880b8b714d30681d72
GIT binary patch
literal 695
zcmV;o0!aNrT4*^jL0KkKS&byVNdN##fB*k(#Q{JfTt3Yr0T3s<-NHa8Kmd%T0J4}M
z2mm4h6AZus{OG2O2}LMrlLTOxm?3}&WND^G5C@`Z>8a`I4l-oXpfqWS$k4<vCXF!$
zBSC}!7$TykhKzxrF*E}Z21b}b13<ul0;Hy)Fo@IA0L0MH9+T2&F%2{UkO81pvZk-|
zTQhx&4Aoh@zRso2s^(^Pc7cK8USVU`oG%e>Y}A)gmQr0V^R_lRH;d;|u8AA!kS2r#
z9hMHHq9TY!0s;!GhzP2rk99zi0Qk~EL`X@)gO{~3S=VVxrI{B-1`hrBg^k7ak%dxS
zD5X^GHdYvy-L;LR?97uq#^=qspm!A+l_O13LV&7?A>LvLlSm>cil~xED2h=W3Y~>R
zH6&TK@GT|xd9cHJAcT@cXQt&JI&7uw9ox`aQ;|Y4%8>J}&>`TyDu@wOVk$l&y1R-a
zZITWou8M{t7^TxJ^e&wWhNE?KPs+I)%xP&%Yn1Y}mNnfq^L6iGdRztPwTYtQaVcgJ
zlx0}9MVJ^=J_=|U4`Ssmak)-51@=~>Nr@V3$OA*fJgVui>Kq&+5H+4h==k#nL4xSV
zjt#>GhtJ|5ssgGfIE6+p`HBk3GMdP6PZszJ{Bi&W0000%00D#oYBCi8El5-Zxrz$O
zGMda0lj{%)>z9HDzyJUd00{s906_o(gc&gcYM@M+$J_L+;#E)*)~%#e1i8$?P!jiZ
zUhj00pe6Z=3du5>$bOouKmxJL@-N6E5C8xn00962002V(00;mO0!07>fk4wkBPJkH
zluaW|pwmgFo4+>Kru};I(=nT1o^pZ$e_|@B<8IigLX&I?g(tkCp-HcN-+qsHea99)
dT>Q1?IPatGAwrY22LY$}yOJrwgo4$swCHOZEHwZC

literal 0
HcmV?d00001

-- 
1.8.1.2.422.g08c0e7f

