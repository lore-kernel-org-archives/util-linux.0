Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f51.google.com ([74.125.83.51]:56425 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab3H1Szp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Aug 2013 14:55:45 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so3122641eek.38
        for <util-linux@vger.kernel.org>; Wed, 28 Aug 2013 11:55:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 19/21] tests: add last(1) test
Date: Wed, 28 Aug 2013 19:55:22 +0100
Message-Id: <1377716124-12491-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377716124-12491-1-git-send-email-kerolasa@iki.fi>
References: <1377716124-12491-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh        |   1 +
 tests/expected/last/last | 121 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/ts/last/last       |  62 ++++++++++++++++++++++++
 tests/ts/last/wtmp       | Bin 0 -> 7296 bytes
 4 files changed, 184 insertions(+)
 create mode 100644 tests/expected/last/last
 create mode 100755 tests/ts/last/last
 create mode 100644 tests/ts/last/wtmp

diff --git a/tests/commands.sh b/tests/commands.sh
index 84da400..fcd74dc 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -47,6 +47,7 @@ TS_CMD_IPCMK=${TS_CMD_IPCMK-"$top_builddir/ipcmk"}
 TS_CMD_IPCRM=${TS_CMD_IPCRM-"$top_builddir/ipcrm"}
 TS_CMD_IPCS=${TS_CMD_IPCS:-"$top_builddir/ipcs"}
 TS_CMD_ISOSIZE=${TS_CMD_ISOSIZE-"$top_builddir/isosize"}
+TS_CMD_LAST=${TS_CMD_LAST-"$top_builddir/last"}
 TS_CMD_LINE=${TS_CMD_LINE-"$top_builddir/line"}
 TS_CMD_LOOK=${TS_CMD_LOOK-"$top_builddir/look"}
 TS_CMD_LOSETUP=${TS_CMD_LOSETUP:-"$top_builddir/losetup"}
diff --git a/tests/expected/last/last b/tests/expected/last/last
new file mode 100644
index 0000000..772a738
--- /dev/null
+++ b/tests/expected/last/last
@@ -0,0 +1,121 @@
+~~~ basic output ~~~
+rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855+03:14)
+torvalds linux        hobby            Mon Aug 26 00:57   still logged in
+reboot   system boot  system-name      Wed Aug 28 18:00 - 18:50  (00:50)
+reboot   system boot  system-name      Wed Aug 28 16:00 - 17:00  (01:00)
+IPv4     root         dns-server       Wed Aug 28 13:00 - 14:00  (01:00)
+nonvalid foo          zero             Wed Aug 28 12:00 - down   (03:00)
+runlevel foo          one              Wed Aug 28 11:00 - 12:00  (01:00)
+sysboot  foo          two              Wed Aug 28 10:00 - 11:00  (01:00)
+newtime  foo          three            Wed Aug 28 09:00 - 10:00  (01:00)
+oldtime  foo          four             Wed Aug 28 08:00 - 09:00  (01:00)
+init     foo          five             Wed Aug 28 07:00 - 08:00  (01:00)
+login    foo          six              Wed Aug 28 06:00 - 07:00  (01:00)
+user_pro foo          seven            Wed Aug 28 05:00 - 06:00  (01:00)
+accounti foo          nine             Wed Aug 28 03:00 - 04:00  (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ include system ~~~
+rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855+03:14)
+torvalds linux        hobby            Mon Aug 26 00:57   still logged in
+reboot   system boot  system-name      Wed Aug 28 18:00 - 18:50  (00:50)
+shutdown system down  system-name      Wed Aug 28 17:00 - 18:00  (01:00)
+reboot   system boot  system-name      Wed Aug 28 16:00 - 17:00  (01:00)
+shutdown system down  system-name      Wed Aug 28 15:00 - 16:00  (01:00)
+IPv4     root         dns-server       Wed Aug 28 13:00 - 14:00  (01:00)
+nonvalid foo          zero             Wed Aug 28 12:00 - down   (03:00)
+runlevel foo          one              Wed Aug 28 11:00 - 12:00  (01:00)
+sysboot  foo          two              Wed Aug 28 10:00 - 11:00  (01:00)
+newtime  foo          three            Wed Aug 28 09:00 - 10:00  (01:00)
+oldtime  foo          four             Wed Aug 28 08:00 - 09:00  (01:00)
+init     foo          five             Wed Aug 28 07:00 - 08:00  (01:00)
+login    foo          six              Wed Aug 28 06:00 - 07:00  (01:00)
+user_pro foo          seven            Wed Aug 28 05:00 - 06:00  (01:00)
+accounti foo          nine             Wed Aug 28 03:00 - 04:00  (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ dns short ~~~
+IPv4     root         a.root-servers.n Wed Aug 28 13:00 - 14:00  (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ dns long ~~~
+IPv4     root         a.root-servers.net Wed Aug 28 13:00 - 14:00  (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ dns host last ~~~
+IPv4     root         Wed Aug 28 13:00 - 14:00  (01:00)     a.root-servers.net
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ show ip ~~~
+torvalds linux        128.214.205.14   Mon Aug 26 00:57   still logged in
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ no host ~~~
+torvalds linux        Mon Aug 26 00:57   still logged in
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ full times ~~~
+rick     long         never-gonna-logo Thu Jan  1 00:00:00 1970 - Tue Jan 19 03:14:07 2038 (24855+03:14)
+torvalds linux        hobby            Mon Aug 26 00:57:08 1991   still logged in          
+reboot   system boot  system-name      Wed Aug 28 18:00:00 2013 - Wed Aug 28 18:50:27 2013  (00:50)
+reboot   system boot  system-name      Wed Aug 28 16:00:00 2013 - Wed Aug 28 17:00:00 2013  (01:00)
+IPv4     root         dns-server       Wed Aug 28 13:00:00 2013 - Wed Aug 28 14:00:00 2013  (01:00)
+nonvalid foo          zero             Wed Aug 28 12:00:00 2013 - down                      (03:00)
+runlevel foo          one              Wed Aug 28 11:00:00 2013 - Wed Aug 28 12:00:00 2013  (01:00)
+sysboot  foo          two              Wed Aug 28 10:00:00 2013 - Wed Aug 28 11:00:00 2013  (01:00)
+newtime  foo          three            Wed Aug 28 09:00:00 2013 - Wed Aug 28 10:00:00 2013  (01:00)
+oldtime  foo          four             Wed Aug 28 08:00:00 2013 - Wed Aug 28 09:00:00 2013  (01:00)
+init     foo          five             Wed Aug 28 07:00:00 2013 - Wed Aug 28 08:00:00 2013  (01:00)
+login    foo          six              Wed Aug 28 06:00:00 2013 - Wed Aug 28 07:00:00 2013  (01:00)
+user_pro foo          seven            Wed Aug 28 05:00:00 2013 - Wed Aug 28 06:00:00 2013  (01:00)
+accounti foo          nine             Wed Aug 28 03:00:00 2013 - Wed Aug 28 04:00:00 2013  (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ no time ~~~
+rick     long         never-gonna-logo   (24855+03:14)
+torvalds linux        hobby              logged in
+reboot   system boot  system-name         (00:50)
+reboot   system boot  system-name         (01:00)
+IPv4     root         dns-server          (01:00)
+nonvalid foo          zero                (03:00)
+runlevel foo          one                 (01:00)
+sysboot  foo          two                 (01:00)
+newtime  foo          three               (01:00)
+oldtime  foo          four                (01:00)
+init     foo          five                (01:00)
+login    foo          six                 (01:00)
+user_pro foo          seven               (01:00)
+accounti foo          nine                (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ iso-8601 time ~~~
+rick     long         never-gonna-logout 1970-01-01T00:00:00+0000 - 2038-01-19T03:14:07+0000 (24855+03:14)
+torvalds linux        hobby            1991-08-26T00:57:08+0000   still logged in          
+reboot   system boot  system-name      2013-08-28T18:00:00+0000 - 2013-08-28T18:50:27+0000  (00:50)
+reboot   system boot  system-name      2013-08-28T16:00:00+0000 - 2013-08-28T17:00:00+0000  (01:00)
+IPv4     root         dns-server       2013-08-28T13:00:00+0000 - 2013-08-28T14:00:00+0000  (01:00)
+nonvalid foo          zero             2013-08-28T12:00:00+0000 - down                      (03:00)
+runlevel foo          one              2013-08-28T11:00:00+0000 - 2013-08-28T12:00:00+0000  (01:00)
+sysboot  foo          two              2013-08-28T10:00:00+0000 - 2013-08-28T11:00:00+0000  (01:00)
+newtime  foo          three            2013-08-28T09:00:00+0000 - 2013-08-28T10:00:00+0000  (01:00)
+oldtime  foo          four             2013-08-28T08:00:00+0000 - 2013-08-28T09:00:00+0000  (01:00)
+init     foo          five             2013-08-28T07:00:00+0000 - 2013-08-28T08:00:00+0000  (01:00)
+login    foo          six              2013-08-28T06:00:00+0000 - 2013-08-28T07:00:00+0000  (01:00)
+user_process foo          seven            2013-08-28T05:00:00+0000 - 2013-08-28T06:00:00+0000  (01:00)
+accounting foo          nine             2013-08-28T03:00:00+0000 - 2013-08-28T04:00:00+0000  (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ since and until ~~~
+oldtime  foo          four             Wed Aug 28 08:00    gone - no logout
+init     foo          five             Wed Aug 28 07:00 - 08:00  (01:00)
+login    foo          six              Wed Aug 28 06:00 - 07:00  (01:00)
+user_pro foo          seven            Wed Aug 28 05:00 - 06:00  (01:00)
+accounti foo          nine             Wed Aug 28 03:00 - 04:00  (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
+~~~ present ~~~
+rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855+03:14)
+torvalds linux        hobby            Mon Aug 26 00:57   still logged in
+runlevel foo          one              Wed Aug 28 11:00 - 12:00  (01:00)
+
+wtmp begins Wed Aug 28 03:00:00 2013
diff --git a/tests/ts/last/last b/tests/ts/last/last
new file mode 100755
index 0000000..4ad38cb
--- /dev/null
+++ b/tests/ts/last/last
@@ -0,0 +1,62 @@
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
+TS_DESC="last"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+export LANG=C
+export TZ=GMT
+
+>| $TS_OUTPUT
+
+ts_log "~~~ basic output ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ include system ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -x >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ dns short ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -d root >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ dns long ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -w -d root >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ dns host last ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -a -d root >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ show ip ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -i torvalds >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ no host ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -R torvalds >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ full times ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -F >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ no time ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp --time-format=notime >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ iso-8601 time ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp --time-format=iso -w >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ since and until ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -s "2013-08-28 02:20" -t "2013-08-28 08:20" >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ present ~~~"
+$TS_CMD_LAST -f $TS_SELF/wtmp -p "2013-08-28 11:20" >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/last/wtmp b/tests/ts/last/wtmp
new file mode 100644
index 0000000000000000000000000000000000000000..f66bb20a101790e61ee4a09a2da9bdede96f73d6
GIT binary patch
literal 7296
zcmeI1y-pl45XUd%3-TpiAn3|O$|*oD;iF1R2YG>H@7A|xW$~PB?;cPbNW1_%0eJ#M
zNkKuCB2uJOh%!Z#Iz{@+%$;bWwQrE9ur2-fR-U=p_0L}K*gI3J)n-r~06e;jHLq8a
zb{h(1rOK-PlvJYH5?1X=_WT34#nb3WV(?#1MUsB(X=n>$s^SZob#0X)u)6bt&;KE^
zAu;$b6-H<ue<Mnv0%Kj(+#maV{tqw!iNXI}4w>}vHFB%!c7m(>dC2E~AL)=7{NG9?
zz0*ramT~?^mVb`;{O_SZiNU`Kd1~dR8*v8;jiF*W=JUUcv`7s8Z<OeJ`P;4*?%oNf
zTV~Jr{HG8LiNSx-Y?~H<dkV6Be-0Z;57fW$`QJe(BnJNlU8o#WoZQ6`V){QqGk?kF
zf5no)e_nwqlU$}(|M~xSN9gzfAe8sN`TQyOe}vM$i3RPlS2owy%O;*WOR7u*mk6Z@
z{4Koxcg+9m%Ta3M<V6Nr`#wfR{zT(u%BQKh(f$L6Kh6D5P=g7V9t`Sr(=BWYediJk
z-_KTTHdNxtQ72sHR+xLUWB#1RQ0~L!uZ1`LsYU){;(K#^{&D<sM(Oo@4qoy3$MJtX
zwjA#-t9<^H|2#$IQWd`4Gu;1Qu%I#jOe^=E>At$qYHia=;N{oG=?g-zck%t%BoxG-
yoN{n|RT)PhyO!<GzIX~3XS$JrQb_~%N}+Hsm3?7?vQhpS`QL1p4~N5DZp44z^2EFV

literal 0
HcmV?d00001

-- 
1.8.4

