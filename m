Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32795 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcEORbQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so13504628wme.0
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/11] tests: fix utmpdump timestamps to be in iso format
Date: Sun, 15 May 2016 18:30:55 +0100
Message-Id: <1463333457-1011-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
References: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The utmpdump-circle is slightly modified to use old timestamp format as
basis of conversion and to do cyclic conversion via new format.  This is
better from test coverage point of view.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/utmp/utmpdump-totxt      | 20 ++++++++---------
 tests/expected/utmp/utmpdump-totxt-ipv6 |  4 ++--
 tests/ts/utmp/txt-a                     | 38 ++++++++++++++++-----------------
 tests/ts/utmp/txt-a-old                 | 19 +++++++++++++++++
 tests/ts/utmp/txt-b                     | 20 ++++++++---------
 tests/ts/utmp/txt-b-old                 | 10 +++++++++
 tests/ts/utmp/txt-ipv6                  |  4 ++--
 tests/ts/utmp/txt-ipv6-old              |  2 ++
 tests/ts/utmp/utmpdump-circle           |  8 ++++++-
 9 files changed, 81 insertions(+), 44 deletions(-)
 create mode 100644 tests/ts/utmp/txt-a-old
 create mode 100644 tests/ts/utmp/txt-b-old
 create mode 100644 tests/ts/utmp/txt-ipv6-old

diff --git a/tests/expected/utmp/utmpdump-totxt b/tests/expected/utmp/utmpdump-totxt
index 02fb22d..5deefde 100644
--- a/tests/expected/utmp/utmpdump-totxt
+++ b/tests/expected/utmp/utmpdump-totxt
@@ -1,10 +1,10 @@
-[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [Wed Jan 16 23:44:09 2013 GMT]
-[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [Wed Jan 16 23:49:17 2013 GMT]
-[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 12:23:33 2013 GMT]
-[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [Thu Jan 17 12:24:49 2013 GMT]
-[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 13:12:39 2013 GMT]
-[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:19 2013 GMT]
-[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:48 2013 GMT]
-[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:48 2013 GMT]
-[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 20:17:21 2013 GMT]
-[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 21:09:39 2013 GMT]
+[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:44:09,000000+0000]
+[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:49:17,000000+0000]
+[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T12:23:33,000000+0000]
+[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T12:24:49,000000+0000]
+[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T13:12:39,000000+0000]
+[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:19,000000+0000]
+[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+0000]
+[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+0000]
+[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T20:17:21,000000+0000]
+[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T21:09:39,000000+0000]
diff --git a/tests/expected/utmp/utmpdump-totxt-ipv6 b/tests/expected/utmp/utmpdump-totxt-ipv6
index 5cce150..5894144 100644
--- a/tests/expected/utmp/utmpdump-totxt-ipv6
+++ b/tests/expected/utmp/utmpdump-totxt-ipv6
@@ -1,2 +1,2 @@
-[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [Wed Aug 28 20:30:40 2013 GMT]
-[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [Wed Aug 28 20:40:50 2013 GMT]
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,000000+0000]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,000000+0000]
diff --git a/tests/ts/utmp/txt-a b/tests/ts/utmp/txt-a
index bc91d19..8501daa 100644
--- a/tests/ts/utmp/txt-a
+++ b/tests/ts/utmp/txt-a
@@ -1,19 +1,19 @@
-[9] [00009] [ts/9] [accounting] [foo         ] [nine                ] [0.0.0.0        ] [Wed Aug 28 03:00:00 2013 GMT]
-[8] [00008] [ts/8] [dead_process] [foo         ] [eight               ] [0.0.0.0        ] [Wed Aug 28 04:00:00 2013 GMT]
-[7] [00007] [ts/7] [user_process] [foo         ] [seven               ] [0.0.0.0        ] [Wed Aug 28 05:00:00 2013 GMT]
-[6] [00006] [ts/6] [login   ] [foo         ] [six                 ] [0.0.0.0        ] [Wed Aug 28 06:00:00 2013 GMT]
-[5] [00005] [ts/5] [init    ] [foo         ] [five                ] [0.0.0.0        ] [Wed Aug 28 07:00:00 2013 GMT]
-[4] [00004] [ts/4] [oldtime ] [foo         ] [four                ] [0.0.0.0        ] [Wed Aug 28 08:00:00 2013 GMT]
-[3] [00003] [ts/3] [newtime ] [foo         ] [three               ] [0.0.0.0        ] [Wed Aug 28 09:00:00 2013 GMT]
-[2] [00002] [ts/2] [sysboot ] [foo         ] [two                 ] [0.0.0.0        ] [Wed Aug 28 10:00:00 2013 GMT]
-[1] [00001] [ts/1] [runlevel] [foo         ] [one                 ] [0.0.0.0        ] [Wed Aug 28 11:00:00 2013 GMT]
-[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [Wed Aug 28 12:00:00 2013 GMT]
-[7] [00010] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [Wed Aug 28 13:00:00 2013 GMT]
-[8] [00011] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [Wed Aug 28 14:00:00 2013 GMT]
-[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [Wed Aug 28 15:00:00 2013 GMT]
-[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [Wed Aug 28 16:00:00 2013 GMT]
-[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [Wed Aug 28 17:00:00 2013 GMT]
-[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [Wed Aug 28 18:00:00 2013 GMT]
-[7] [00013] [ts/1] [torvalds] [linux       ] [hobby               ] [128.214.205.14 ] [Mon Aug 26 00:57:08 1991 GMT]
-[7] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [                            ]
-[8] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [Tue Jan 19 03:14:07 2038 GMT]
+[9] [00009] [ts/9] [accounting] [foo         ] [nine                ] [0.0.0.0        ] [2013-08-28T03:00:00,000000+0000]
+[8] [00008] [ts/8] [dead_process] [foo         ] [eight               ] [0.0.0.0        ] [2013-08-28T04:00:00,000000+0000]
+[7] [00007] [ts/7] [user_process] [foo         ] [seven               ] [0.0.0.0        ] [2013-08-28T05:00:00,000000+0000]
+[6] [00006] [ts/6] [login   ] [foo         ] [six                 ] [0.0.0.0        ] [2013-08-28T06:00:00,000000+0000]
+[5] [00005] [ts/5] [init    ] [foo         ] [five                ] [0.0.0.0        ] [2013-08-28T07:00:00,000000+0000]
+[4] [00004] [ts/4] [oldtime ] [foo         ] [four                ] [0.0.0.0        ] [2013-08-28T08:00:00,000000+0000]
+[3] [00003] [ts/3] [newtime ] [foo         ] [three               ] [0.0.0.0        ] [2013-08-28T09:00:00,000000+0000]
+[2] [00002] [ts/2] [sysboot ] [foo         ] [two                 ] [0.0.0.0        ] [2013-08-28T10:00:00,000000+0000]
+[1] [00001] [ts/1] [runlevel] [foo         ] [one                 ] [0.0.0.0        ] [2013-08-28T11:00:00,000000+0000]
+[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,000000+0000]
+[7] [00010] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [2013-08-28T13:00:00,000000+0000]
+[8] [00011] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [2013-08-28T14:00:00,000000+0000]
+[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T15:00:00,000000+0000]
+[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T16:00:00,000000+0000]
+[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T17:00:00,000000+0000]
+[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T18:00:00,000000+0000]
+[7] [00013] [ts/1] [torvalds] [linux       ] [hobby               ] [128.214.205.14 ] [1991-08-26T00:57:08,000000+0000]
+[7] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [1970-01-01T00:00:00,000000+0000]
+[8] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [2038-01-19T03:14:07,000000+0000]
diff --git a/tests/ts/utmp/txt-a-old b/tests/ts/utmp/txt-a-old
new file mode 100644
index 0000000..bc91d19
--- /dev/null
+++ b/tests/ts/utmp/txt-a-old
@@ -0,0 +1,19 @@
+[9] [00009] [ts/9] [accounting] [foo         ] [nine                ] [0.0.0.0        ] [Wed Aug 28 03:00:00 2013 GMT]
+[8] [00008] [ts/8] [dead_process] [foo         ] [eight               ] [0.0.0.0        ] [Wed Aug 28 04:00:00 2013 GMT]
+[7] [00007] [ts/7] [user_process] [foo         ] [seven               ] [0.0.0.0        ] [Wed Aug 28 05:00:00 2013 GMT]
+[6] [00006] [ts/6] [login   ] [foo         ] [six                 ] [0.0.0.0        ] [Wed Aug 28 06:00:00 2013 GMT]
+[5] [00005] [ts/5] [init    ] [foo         ] [five                ] [0.0.0.0        ] [Wed Aug 28 07:00:00 2013 GMT]
+[4] [00004] [ts/4] [oldtime ] [foo         ] [four                ] [0.0.0.0        ] [Wed Aug 28 08:00:00 2013 GMT]
+[3] [00003] [ts/3] [newtime ] [foo         ] [three               ] [0.0.0.0        ] [Wed Aug 28 09:00:00 2013 GMT]
+[2] [00002] [ts/2] [sysboot ] [foo         ] [two                 ] [0.0.0.0        ] [Wed Aug 28 10:00:00 2013 GMT]
+[1] [00001] [ts/1] [runlevel] [foo         ] [one                 ] [0.0.0.0        ] [Wed Aug 28 11:00:00 2013 GMT]
+[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [Wed Aug 28 12:00:00 2013 GMT]
+[7] [00010] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [Wed Aug 28 13:00:00 2013 GMT]
+[8] [00011] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [Wed Aug 28 14:00:00 2013 GMT]
+[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [Wed Aug 28 15:00:00 2013 GMT]
+[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [Wed Aug 28 16:00:00 2013 GMT]
+[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [Wed Aug 28 17:00:00 2013 GMT]
+[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [Wed Aug 28 18:00:00 2013 GMT]
+[7] [00013] [ts/1] [torvalds] [linux       ] [hobby               ] [128.214.205.14 ] [Mon Aug 26 00:57:08 1991 GMT]
+[7] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [                            ]
+[8] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [Tue Jan 19 03:14:07 2038 GMT]
diff --git a/tests/ts/utmp/txt-b b/tests/ts/utmp/txt-b
index 02fb22d..5deefde 100644
--- a/tests/ts/utmp/txt-b
+++ b/tests/ts/utmp/txt-b
@@ -1,10 +1,10 @@
-[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [Wed Jan 16 23:44:09 2013 GMT]
-[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [Wed Jan 16 23:49:17 2013 GMT]
-[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 12:23:33 2013 GMT]
-[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [Thu Jan 17 12:24:49 2013 GMT]
-[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 13:12:39 2013 GMT]
-[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:19 2013 GMT]
-[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:48 2013 GMT]
-[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [Thu Jan 17 13:42:48 2013 GMT]
-[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 20:17:21 2013 GMT]
-[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [Thu Jan 17 21:09:39 2013 GMT]
+[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:44:09,000000+0000]
+[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:49:17,000000+0000]
+[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T12:23:33,000000+0000]
+[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T12:24:49,000000+0000]
+[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T13:12:39,000000+0000]
+[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:19,000000+0000]
+[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+0000]
+[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+0000]
+[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T20:17:21,000000+0000]
+[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T21:09:39,000000+0000]
diff --git a/tests/ts/utmp/txt-b-old b/tests/ts/utmp/txt-b-old
new file mode 100644
index 0000000..02fb22d
--- /dev/null
+++ b/tests/ts/utmp/txt-b-old
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
diff --git a/tests/ts/utmp/txt-ipv6 b/tests/ts/utmp/txt-ipv6
index 5cce150..5894144 100644
--- a/tests/ts/utmp/txt-ipv6
+++ b/tests/ts/utmp/txt-ipv6
@@ -1,2 +1,2 @@
-[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [Wed Aug 28 20:30:40 2013 GMT]
-[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [Wed Aug 28 20:40:50 2013 GMT]
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,000000+0000]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,000000+0000]
diff --git a/tests/ts/utmp/txt-ipv6-old b/tests/ts/utmp/txt-ipv6-old
new file mode 100644
index 0000000..5cce150
--- /dev/null
+++ b/tests/ts/utmp/txt-ipv6-old
@@ -0,0 +1,2 @@
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [Wed Aug 28 20:30:40 2013 GMT]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [Wed Aug 28 20:40:50 2013 GMT]
diff --git a/tests/ts/utmp/utmpdump-circle b/tests/ts/utmp/utmpdump-circle
index cae2995..9663dba 100755
--- a/tests/ts/utmp/utmpdump-circle
+++ b/tests/ts/utmp/utmpdump-circle
@@ -27,9 +27,15 @@ OUT_BIN1=${TS_OUTDIR}/${TS_TESTNAME}.bin1
 OUT_BIN2=${TS_OUTDIR}/${TS_TESTNAME}.bin2
 OUT_TXT=${TS_OUTDIR}/${TS_TESTNAME}.txt
 
+# Files with -old extension are using timestamp format before utmpdump
+# started to use iso-8601 format.  This check is testing nothing is lost
+# when conversions performing following conversions.
+#
+# old text format -> binary -> new text format -> binary
+
 echo "no output expected" > $TS_OUTPUT
 for f in txt-a txt-b txt-ipv6; do
-	$TS_CMD_UTMPDUMP -r $TS_SELF/$f > $OUT_BIN1 2>/dev/null &&
+	$TS_CMD_UTMPDUMP -r $TS_SELF/$f-old > $OUT_BIN1 2>/dev/null &&
 	$TS_CMD_UTMPDUMP $OUT_BIN1 > $OUT_TXT 2>/dev/null &&
 	diff -u $TS_SELF/$f $OUT_TXT &&
 	$TS_CMD_UTMPDUMP -r $OUT_TXT > $OUT_BIN2 2>/dev/null &&
-- 
2.8.2

