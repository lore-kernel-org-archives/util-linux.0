Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f48.google.com ([74.125.83.48]:65407 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756175Ab3H2SLI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Aug 2013 14:11:08 -0400
Received: by mail-ee0-f48.google.com with SMTP id l10so417991eei.7
        for <util-linux@vger.kernel.org>; Thu, 29 Aug 2013 11:11:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 26/26] tests: check last(1) and utmpdump(1) IPv6 functionality
Date: Thu, 29 Aug 2013 19:10:52 +0100
Message-Id: <1377799852-28461-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377799852-28461-1-git-send-email-kerolasa@iki.fi>
References: <1377799852-28461-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/last/ipv6          |  20 +++++++++++++++++++
 tests/expected/utmpdump/ipv6tobin | Bin 0 -> 768 bytes
 tests/expected/utmpdump/ipv6totxt |   2 ++
 tests/ts/last/ipv6                |  41 ++++++++++++++++++++++++++++++++++++++
 tests/ts/last/ipv6-input          | Bin 0 -> 768 bytes
 tests/ts/utmpdump/ipv6bin         | Bin 0 -> 768 bytes
 tests/ts/utmpdump/ipv6tobin       |  25 +++++++++++++++++++++++
 tests/ts/utmpdump/ipv6totxt       |  25 +++++++++++++++++++++++
 tests/ts/utmpdump/ipv6txt         |   2 ++
 9 files changed, 115 insertions(+)
 create mode 100644 tests/expected/last/ipv6
 create mode 100644 tests/expected/utmpdump/ipv6tobin
 create mode 100644 tests/expected/utmpdump/ipv6totxt
 create mode 100755 tests/ts/last/ipv6
 create mode 100644 tests/ts/last/ipv6-input
 create mode 100644 tests/ts/utmpdump/ipv6bin
 create mode 100755 tests/ts/utmpdump/ipv6tobin
 create mode 100755 tests/ts/utmpdump/ipv6totxt
 create mode 100644 tests/ts/utmpdump/ipv6txt

diff --git a/tests/expected/last/ipv6 b/tests/expected/last/ipv6
new file mode 100644
index 0000000..0fa234c
--- /dev/null
+++ b/tests/expected/last/ipv6
@@ -0,0 +1,20 @@
+~~~ dns short ~~~
+IPv6     root         a.root-servers.n Wed Aug 28 20:30 - 20:40  (00:10)
+
+ipv6-input begins Wed Aug 28 20:30:40 2013
+~~~ dns long ~~~
+IPv6     root         a.root-servers.net Wed Aug 28 20:30 - 20:40  (00:10)
+
+ipv6-input begins Wed Aug 28 20:30:40 2013
+~~~ dns host last ~~~
+IPv6     root         Wed Aug 28 20:30 - 20:40  (00:10)     a.root-servers.net
+
+ipv6-input begins Wed Aug 28 20:30:40 2013
+~~~ show ip ~~~
+IPv6     root         2001:503:ba3e::2 Wed Aug 28 20:30 - 20:40  (00:10)
+
+ipv6-input begins Wed Aug 28 20:30:40 2013
+~~~ show ip last ~~~
+IPv6     root         Wed Aug 28 20:30 - 20:40  (00:10)     2001:503:ba3e::2:30
+
+ipv6-input begins Wed Aug 28 20:30:40 2013
diff --git a/tests/expected/utmpdump/ipv6tobin b/tests/expected/utmpdump/ipv6tobin
new file mode 100644
index 0000000000000000000000000000000000000000..342553bb945bdd4b575c6cb6511c949d8c1bb87a
GIT binary patch
literal 768
zcmZQ)U|`?^;-dWg5+H>WWEPZ}c?Oi3;Zy*WNXaYKElw>eOD)2uYWT~2h?NTh`BH(A
hm3fyP)W1v&2H1Sg0Tkp0;?eNO7CPjK1tkz4{s6-b7T5p)

literal 0
HcmV?d00001

diff --git a/tests/expected/utmpdump/ipv6totxt b/tests/expected/utmpdump/ipv6totxt
new file mode 100644
index 0000000..5cce150
--- /dev/null
+++ b/tests/expected/utmpdump/ipv6totxt
@@ -0,0 +1,2 @@
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [Wed Aug 28 20:30:40 2013 GMT]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [Wed Aug 28 20:40:50 2013 GMT]
diff --git a/tests/ts/last/ipv6 b/tests/ts/last/ipv6
new file mode 100755
index 0000000..8e2b01e
--- /dev/null
+++ b/tests/ts/last/ipv6
@@ -0,0 +1,41 @@
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
+TS_DESC="last ipv6"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+export LANG=C
+export TZ=GMT
+
+>| $TS_OUTPUT
+
+ts_log "~~~ dns short ~~~"
+$TS_CMD_LAST -f $TS_SELF/ipv6-input -d >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ dns long ~~~"
+$TS_CMD_LAST -f $TS_SELF/ipv6-input -d -w >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ dns host last ~~~"
+$TS_CMD_LAST -f $TS_SELF/ipv6-input -d -a >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ show ip ~~~"
+$TS_CMD_LAST -f $TS_SELF/ipv6-input -i >> $TS_OUTPUT 2>/dev/null
+
+ts_log "~~~ show ip last ~~~"
+$TS_CMD_LAST -f $TS_SELF/ipv6-input -i -a >> $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/last/ipv6-input b/tests/ts/last/ipv6-input
new file mode 100644
index 0000000000000000000000000000000000000000..342553bb945bdd4b575c6cb6511c949d8c1bb87a
GIT binary patch
literal 768
zcmZQ)U|`?^;-dWg5+H>WWEPZ}c?Oi3;Zy*WNXaYKElw>eOD)2uYWT~2h?NTh`BH(A
hm3fyP)W1v&2H1Sg0Tkp0;?eNO7CPjK1tkz4{s6-b7T5p)

literal 0
HcmV?d00001

diff --git a/tests/ts/utmpdump/ipv6bin b/tests/ts/utmpdump/ipv6bin
new file mode 100644
index 0000000000000000000000000000000000000000..342553bb945bdd4b575c6cb6511c949d8c1bb87a
GIT binary patch
literal 768
zcmZQ)U|`?^;-dWg5+H>WWEPZ}c?Oi3;Zy*WNXaYKElw>eOD)2uYWT~2h?NTh`BH(A
hm3fyP)W1v&2H1Sg0Tkp0;?eNO7CPjK1tkz4{s6-b7T5p)

literal 0
HcmV?d00001

diff --git a/tests/ts/utmpdump/ipv6tobin b/tests/ts/utmpdump/ipv6tobin
new file mode 100755
index 0000000..6de99ad
--- /dev/null
+++ b/tests/ts/utmpdump/ipv6tobin
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
+TS_DESC="IPv6 to binary"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+export LANG=C
+export TZ=GMT
+$TS_CMD_UTMPDUMP -r $TS_SELF/ipv6txt >| $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/utmpdump/ipv6totxt b/tests/ts/utmpdump/ipv6totxt
new file mode 100755
index 0000000..fb81f39
--- /dev/null
+++ b/tests/ts/utmpdump/ipv6totxt
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
+TS_DESC="IPv6 to text"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+export LANG=C
+export TZ=GMT
+$TS_CMD_UTMPDUMP $TS_SELF/ipv6bin >| $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/utmpdump/ipv6txt b/tests/ts/utmpdump/ipv6txt
new file mode 100644
index 0000000..fb428d5
--- /dev/null
+++ b/tests/ts/utmpdump/ipv6txt
@@ -0,0 +1,2 @@
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30     ] [Wed Aug 28 20:30:40 2013 BST]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30     ] [Wed Aug 28 20:40:50 2013 BST]
-- 
1.8.4

