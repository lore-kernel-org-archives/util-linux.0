Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:39522 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab3ASAJZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:25 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq7so911262wib.1
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:23 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/22] tests: add utmpdump(1) check
Date: Sat, 19 Jan 2013 00:08:52 +0000
Message-Id: <1358554151-25985-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh                 |   2 ++
 tests/expected/utmpdump/to-binary | Bin 0 -> 3840 bytes
 tests/expected/utmpdump/to-text   |  10 ++++++++++
 tests/ts/utmpdump/binary          | Bin 0 -> 3840 bytes
 tests/ts/utmpdump/text            |  10 ++++++++++
 tests/ts/utmpdump/to-binary       |  23 +++++++++++++++++++++++
 tests/ts/utmpdump/to-text         |  23 +++++++++++++++++++++++
 7 files changed, 68 insertions(+)
 create mode 100644 tests/expected/utmpdump/to-binary
 create mode 100644 tests/expected/utmpdump/to-text
 create mode 100644 tests/ts/utmpdump/binary
 create mode 100644 tests/ts/utmpdump/text
 create mode 100755 tests/ts/utmpdump/to-binary
 create mode 100755 tests/ts/utmpdump/to-text

diff --git a/tests/commands.sh b/tests/commands.sh
index f1643a6..73725c9 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -64,3 +64,5 @@ TS_CMD_FINDMNT=${TS_CMD_FINDMNT-"$top_builddir/findmnt"}
 TS_CMD_FDISK=${TS_CMD_FDISK-"$top_builddir/fdisk"}
 
 TS_CMD_HEXDUMP=${TS_CMD_HEXDUMP-"$top_builddir/hexdump"}
+
+TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
diff --git a/tests/expected/utmpdump/to-binary b/tests/expected/utmpdump/to-binary
new file mode 100644
index 0000000000000000000000000000000000000000..45d35bbb0ba5f1c3db170f18b1a4da1c7f92cf61
GIT binary patch
literal 3840
zcmZQ)U|?9}#K2HcQmk(XWa9!L>Fm^^{G7z%L|kgD4D<|e$&Dm&PwVdi#QK*Vs4yrD
z68=VbGy%ikXf*us1Q3!`tqp169}G;<p!9EyWCl7DBt07b=%Iq0@A{Vb@aF&;L9Ot|
z?wXM&I+29%2bDid%SY2cHB-s)AEc#!YK1>F{V<fx+Wnuj@TXS&JCwtWnr^>AV)#?5
r{Ygzf3}v%O34c)eZ&^Ls{-<Vq2gdv$sr?_2KidAMX82FeAU^y7&E#d^

literal 0
HcmV?d00001

diff --git a/tests/expected/utmpdump/to-text b/tests/expected/utmpdump/to-text
new file mode 100644
index 0000000..02fb22d
--- /dev/null
+++ b/tests/expected/utmpdump/to-text
@@ -0,0 +1,10 @@
+[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [Wed Jan 16 23:44:09 2013 GMT]
+[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [Wed Jan 16 23:49:17 2013 GMT]
+[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 12:23:33 2013 GMT]
+[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [Thu Jan 17 12:24:49 2013 GMT]
+[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 13:12:39 2013 GMT]
+[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:19 2013 GMT]
+[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:48 2013 GMT]
+[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:48 2013 GMT]
+[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 20:17:21 2013 GMT]
+[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 21:09:39 2013 GMT]
diff --git a/tests/ts/utmpdump/binary b/tests/ts/utmpdump/binary
new file mode 100644
index 0000000000000000000000000000000000000000..45d35bbb0ba5f1c3db170f18b1a4da1c7f92cf61
GIT binary patch
literal 3840
zcmZQ)U|?9}#K2HcQmk(XWa9!L>Fm^^{G7z%L|kgD4D<|e$&Dm&PwVdi#QK*Vs4yrD
z68=VbGy%ikXf*us1Q3!`tqp169}G;<p!9EyWCl7DBt07b=%Iq0@A{Vb@aF&;L9Ot|
z?wXM&I+29%2bDid%SY2cHB-s)AEc#!YK1>F{V<fx+Wnuj@TXS&JCwtWnr^>AV)#?5
r{Ygzf3}v%O34c)eZ&^Ls{-<Vq2gdv$sr?_2KidAMX82FeAU^y7&E#d^

literal 0
HcmV?d00001

diff --git a/tests/ts/utmpdump/text b/tests/ts/utmpdump/text
new file mode 100644
index 0000000..02fb22d
--- /dev/null
+++ b/tests/ts/utmpdump/text
@@ -0,0 +1,10 @@
+[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [Wed Jan 16 23:44:09 2013 GMT]
+[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [Wed Jan 16 23:49:17 2013 GMT]
+[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 12:23:33 2013 GMT]
+[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [Thu Jan 17 12:24:49 2013 GMT]
+[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 13:12:39 2013 GMT]
+[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:19 2013 GMT]
+[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:48 2013 GMT]
+[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:48 2013 GMT]
+[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 20:17:21 2013 GMT]
+[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 21:09:39 2013 GMT]
diff --git a/tests/ts/utmpdump/to-binary b/tests/ts/utmpdump/to-binary
new file mode 100755
index 0000000..25acbf6
--- /dev/null
+++ b/tests/ts/utmpdump/to-binary
@@ -0,0 +1,23 @@
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
+TS_DESC="to-binary"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_UTMPDUMP -r $TS_SELF/text >| $TS_OUTPUT 2>/dev/null
+
+ts_finalize
diff --git a/tests/ts/utmpdump/to-text b/tests/ts/utmpdump/to-text
new file mode 100755
index 0000000..f454e5f
--- /dev/null
+++ b/tests/ts/utmpdump/to-text
@@ -0,0 +1,23 @@
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
+TS_DESC="to-text"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+$TS_CMD_UTMPDUMP $TS_SELF/binary >| $TS_OUTPUT 2>/dev/null
+
+ts_finalize
-- 
1.8.1.1

