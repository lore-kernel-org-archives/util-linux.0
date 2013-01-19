Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:65519 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab3ASAKA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:10:00 -0500
Received: by mail-we0-f170.google.com with SMTP id r1so1121761wey.15
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:59 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 18/22] tests: add isosize(1) check
Date: Sat, 19 Jan 2013 00:09:07 +0000
Message-Id: <1358554151-25985-19-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh                 |   1 +
 tests/expected/isosize/print-size |   1 +
 tests/ts/isosize/print-size       |  25 +++++++++++++++++++++++++
 tests/ts/isosize/sample.iso.gz    | Bin 0 -> 632 bytes
 4 files changed, 27 insertions(+)
 create mode 100644 tests/expected/isosize/print-size
 create mode 100755 tests/ts/isosize/print-size
 create mode 100644 tests/ts/isosize/sample.iso.gz

diff --git a/tests/commands.sh b/tests/commands.sh
index e502aeb..6c172ba 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -77,3 +77,4 @@ TS_CMD_DMESG=${TS_CMD_DMESG-"$top_builddir/dmesg"}
 TS_CMD_SETSID=${TS_CMD_SETSID-"$top_builddir/setsid"}
 TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
 TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
+TS_CMD_ISOSIZE=${TS_CMD_ISOSIZE-"$top_builddir/isosize"}
diff --git a/tests/expected/isosize/print-size b/tests/expected/isosize/print-size
new file mode 100644
index 0000000..3def437
--- /dev/null
+++ b/tests/expected/isosize/print-size
@@ -0,0 +1 @@
+515899392
diff --git a/tests/ts/isosize/print-size b/tests/ts/isosize/print-size
new file mode 100755
index 0000000..399b5b1
--- /dev/null
+++ b/tests/ts/isosize/print-size
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="print-size"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+gzip -cd $TS_SELF/sample.iso.gz > $TS_SELF/sample.iso
+$TS_CMD_ISOSIZE $TS_SELF/sample.iso >| $TS_OUTPUT 2>&1
+rm -f $TS_SELF/sample.iso
+
+ts_finalize
diff --git a/tests/ts/isosize/sample.iso.gz b/tests/ts/isosize/sample.iso.gz
new file mode 100644
index 0000000000000000000000000000000000000000..17937a260e71634b68658f02fe06e5d6b2771dbd
GIT binary patch
literal 632
zcmb2|=HSSe{u#i;T+HzHQmjXCqRjD+&tJ^&)@;4_N{jEV2+QX)+q(ry^ORjrS3Zl<
z56F6V#AWW>+=LwQS>|dg7elwlmMF)v^m<GYI<&nzR)oc=WMhYf9<%P2n#MVccWG?W
zt5V!2f6kKs`S%Zh{@d{TzkKvnUMn_6y3$NB>9zE%w>#5jU$%+be9`<<Qi@ltMpA!E
zp^wM=Jbe?1)_}*~J_fGO^^5#D!{GI_#?tp0OEL^JTe-JLKAvP4H~ZdfvGiGwm$g(H
zMAmNG`QcwlZ?);mz`Ku?%+dsIt=(Ozxm;t<CH*b4{>_{-{q!w|P~V)|P3z4!W#>Nf
zEjcJDtYoUev@jujf%>KNT>dX7?luN!Tqq9Yd-bVx!8-S<!`JTqj9Q&mz3Qoyy^HDQ
zROMAGXWf4Ba*9>=x_#Hew1Y053_rH;$%QMuQ@gfbT$mYr>7T<X$!$9B!q2j0U88P4
zzQTC%%IoX556wKa@btnB`=j4+Z7V%d7t8-Dn)lq@&i9h*vdr(C_7(|!<~~j6_x<JO
zN97APD_FD5%lXy%LVVJV@Vm3_^+j>l@0?X0!ay3>=E=8w(G3;F_XpNly*f8tV_VSC
zZ+Cy{vpz3wJu&zG&iB_QSGJy1N!xt!&BFDU+l}WpADZ*mm^(PlpwoNO!6XZ%BD?j|
z|8F|8@<i`f^*zg<oZ2-_?EA$>N%POApFMJW<yKGIu&>g;cZW{Dy>8c>qPLkpE1Z|*
z?p^-!{hR$8|1DV^QCcYzH~me)ssBsg{0%?l<u&EgrXp9t`z(*r_5SUDBHTY?M;b#5
G0|Nlecr*C`

literal 0
HcmV?d00001

-- 
1.8.1.1

