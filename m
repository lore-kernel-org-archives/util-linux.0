Return-Path: elseifthen@gmx.com
Subject: [v2 PATCH 5/5] tests: adjust for ISO timezone colon use
To: Karel Zak <kzak@redhat.com>
References: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <287ec450-f87a-c3ba-32dc-d2a0111243f5@gmx.com>
Date: Sun, 12 Nov 2017 10:27:10 -0500
MIME-Version: 1.0
In-Reply-To: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Fix several tests broken by adding a timezone colon in the
timeutils ISO format functions.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 tests/expected/dmesg/indentation        | 10 ++++-----
 tests/expected/script/options-append    |  8 +++----
 tests/expected/script/options-force     |  8 +++----
 tests/expected/script/options-quiet     |  8 +++----
 tests/expected/script/options-return    | 16 +++++++-------
 tests/expected/utmp/last-nodns          | 30 +++++++++++++-------------
 tests/expected/utmp/utmpdump-subsecond  |  6 +++---
 tests/expected/utmp/utmpdump-totxt      | 20 ++++++++---------
 tests/expected/utmp/utmpdump-totxt-ipv6 |  4 ++--
 tests/expected/uuid/uuidparse           |  2 +-
 tests/ts/utmp/subsec                    |  6 +++---
 tests/ts/utmp/txt-a                     | 38 ++++++++++++++++-----------------
 tests/ts/utmp/txt-b                     | 20 ++++++++---------
 tests/ts/utmp/txt-ipv6                  |  4 ++--
 14 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/tests/expected/dmesg/indentation b/tests/expected/dmesg/indentation
index 0d0b6e448..e1b2770d1 100644
--- a/tests/expected/dmesg/indentation
+++ b/tests/expected/dmesg/indentation
@@ -28,8 +28,8 @@ lines
 [Fri Feb 13 23:31:32 2009] two
                            new
                            lines
-2009-02-13T23:31:31,000000+0000 new
-                                line
-2009-02-13T23:31:32,000000+0000 two
-                                new
-                                lines
+2009-02-13T23:31:31,000000+00:00 new
+                                 line
+2009-02-13T23:31:32,000000+00:00 two
+                                 new
+                                 lines
diff --git a/tests/expected/script/options-append b/tests/expected/script/options-append
index 3e8cdf81a..4e932554a 100644
--- a/tests/expected/script/options-append
+++ b/tests/expected/script/options-append
@@ -1,8 +1,8 @@
-Script started on 2015-05-24 17:43:18+0000
+Script started on 2015-05-24 17:43:18+00:00
 append1

 
-Script done on 2015-05-24 17:43:18+0000
-Script started on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
+Script started on 2015-05-24 17:43:18+00:00
 append2

 
-Script done on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
diff --git a/tests/expected/script/options-force b/tests/expected/script/options-force
index 4bfc7dc10..a0bc50bf3 100644
--- a/tests/expected/script/options-force
+++ b/tests/expected/script/options-force
@@ -2,13 +2,13 @@ test_script: output file `typescript' is a link
 Use --force if you really want to use it.
 Program not started.
 1
-Script started on 2015-05-24 17:43:18+0000
+Script started on 2015-05-24 17:43:18+00:00
 with force

 
-Script done on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
 0
-Script started on 2015-05-24 17:43:18+0000
+Script started on 2015-05-24 17:43:18+00:00
 not typescript

 
-Script done on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
 0
diff --git a/tests/expected/script/options-quiet b/tests/expected/script/options-quiet
index 83b8a2ae8..cfb2a7e16 100644
--- a/tests/expected/script/options-quiet
+++ b/tests/expected/script/options-quiet
@@ -1,8 +1,8 @@
-Script started on 2015-05-24 17:43:18+0000
+Script started on 2015-05-24 17:43:18+00:00
 quiet1

 
-Script done on 2015-05-24 17:43:18+0000
-Script started on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
+Script started on 2015-05-24 17:43:18+00:00
 quiet2

 
-Script done on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
diff --git a/tests/expected/script/options-return b/tests/expected/script/options-return
index 4a3a8cfa4..f4c606a96 100644
--- a/tests/expected/script/options-return
+++ b/tests/expected/script/options-return
@@ -1,16 +1,16 @@
-Script started on 2015-05-24 17:43:18+0000
+Script started on 2015-05-24 17:43:18+00:00
 
-Script done on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
 0
-Script started on 2015-05-24 17:43:18+0000
+Script started on 2015-05-24 17:43:18+00:00
 
-Script done on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
 0
-Script started on 2015-05-24 17:43:18+0000
+Script started on 2015-05-24 17:43:18+00:00
 
-Script done on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
 42
-Script started on 2015-05-24 17:43:18+0000
+Script started on 2015-05-24 17:43:18+00:00
 
-Script done on 2015-05-24 17:43:18+0000
+Script done on 2015-05-24 17:43:18+00:00
 127
diff --git a/tests/expected/utmp/last-nodns b/tests/expected/utmp/last-nodns
index e92366266..5b9171de3 100644
--- a/tests/expected/utmp/last-nodns
+++ b/tests/expected/utmp/last-nodns
@@ -92,22 +92,22 @@ login    foo          six                 (01:00)
 user_pro foo          seven               (01:00)
 accounti foo          nine                (01:00)
 ~~~ iso-8601 time ~~~
-rick     long         never-gonna-logout 1970-01-01T00:00:00+0000 - 2038-01-19T03:14:07+0000 (24855+03:14)
-torvalds linux        hobby            1991-08-26T00:57:08+0000   gone - no logout
-reboot   system boot  system-name      2013-08-28T18:00:00+0000   still running
-reboot   system boot  system-name      2013-08-28T16:00:00+0000 - 2013-08-28T17:00:00+0000  (01:00)
-IPv4     root         dns-server       2013-08-28T13:00:00+0000 - 2013-08-28T14:00:00+0000  (01:00)
-nonvalid foo          zero             2013-08-28T12:00:00+0000 - down                      (03:00)
-runlevel foo          one              2013-08-28T11:00:00+0000 - 2013-08-28T12:00:00+0000  (01:00)
-sysboot  foo          two              2013-08-28T10:00:00+0000 - 2013-08-28T11:00:00+0000  (01:00)
-newtime  foo          three            2013-08-28T09:00:00+0000 - 2013-08-28T10:00:00+0000  (01:00)
-oldtime  foo          four             2013-08-28T08:00:00+0000 - 2013-08-28T09:00:00+0000  (01:00)
-init     foo          five             2013-08-28T07:00:00+0000 - 2013-08-28T08:00:00+0000  (01:00)
-login    foo          six              2013-08-28T06:00:00+0000 - 2013-08-28T07:00:00+0000  (01:00)
-user_process foo          seven            2013-08-28T05:00:00+0000 - 2013-08-28T06:00:00+0000  (01:00)
-accounting foo          nine             2013-08-28T03:00:00+0000 - 2013-08-28T04:00:00+0000  (01:00)
+rick     long         never-gonna-logout 1970-01-01T00:00:00+00:00 - 2038-01-19T03:14:07+00:00 (24855+03:14)
+torvalds linux        hobby            1991-08-26T00:57:08+00:00   gone - no logout
+reboot   system boot  system-name      2013-08-28T18:00:00+00:00   still running
+reboot   system boot  system-name      2013-08-28T16:00:00+00:00 - 2013-08-28T17:00:00+00:00  (01:00)
+IPv4     root         dns-server       2013-08-28T13:00:00+00:00 - 2013-08-28T14:00:00+00:00  (01:00)
+nonvalid foo          zero             2013-08-28T12:00:00+00:00 - down                       (03:00)
+runlevel foo          one              2013-08-28T11:00:00+00:00 - 2013-08-28T12:00:00+00:00  (01:00)
+sysboot  foo          two              2013-08-28T10:00:00+00:00 - 2013-08-28T11:00:00+00:00  (01:00)
+newtime  foo          three            2013-08-28T09:00:00+00:00 - 2013-08-28T10:00:00+00:00  (01:00)
+oldtime  foo          four             2013-08-28T08:00:00+00:00 - 2013-08-28T09:00:00+00:00  (01:00)
+init     foo          five             2013-08-28T07:00:00+00:00 - 2013-08-28T08:00:00+00:00  (01:00)
+login    foo          six              2013-08-28T06:00:00+00:00 - 2013-08-28T07:00:00+00:00  (01:00)
+user_process foo          seven            2013-08-28T05:00:00+00:00 - 2013-08-28T06:00:00+00:00  (01:00)
+accounting foo          nine             2013-08-28T03:00:00+00:00 - 2013-08-28T04:00:00+00:00  (01:00)
 
-wtmp-a begins 2013-08-28T03:00:00+0000
+wtmp-a begins 2013-08-28T03:00:00+00:00
 ~~~ since and until ~~~
 oldtime  foo          four             Wed Aug 28 08:00    gone - no logout
 init     foo          five             Wed Aug 28 07:00 - 08:00  (01:00)
diff --git a/tests/expected/utmp/utmpdump-subsecond b/tests/expected/utmp/utmpdump-subsecond
index 649ab7f8c..67d2cf859 100644
--- a/tests/expected/utmp/utmpdump-subsecond
+++ b/tests/expected/utmp/utmpdump-subsecond
@@ -1,4 +1,4 @@
 last 9 is expected to disappear in conversion
-[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,123456+0000]
-[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,999999+0000]
-[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,12345678+0000]
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,123456+00:00]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,999999+00:00]
+[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,12345678+00:00]
diff --git a/tests/expected/utmp/utmpdump-totxt b/tests/expected/utmp/utmpdump-totxt
index 5deefde60..f92927336 100644
--- a/tests/expected/utmp/utmpdump-totxt
+++ b/tests/expected/utmp/utmpdump-totxt
@@ -1,10 +1,10 @@
-[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:44:09,000000+0000]
-[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:49:17,000000+0000]
-[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T12:23:33,000000+0000]
-[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T12:24:49,000000+0000]
-[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T13:12:39,000000+0000]
-[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:19,000000+0000]
-[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+0000]
-[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+0000]
-[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T20:17:21,000000+0000]
-[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T21:09:39,000000+0000]
+[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:44:09,000000+00:00]
+[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:49:17,000000+00:00]
+[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T12:23:33,000000+00:00]
+[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T12:24:49,000000+00:00]
+[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T13:12:39,000000+00:00]
+[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:19,000000+00:00]
+[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+00:00]
+[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+00:00]
+[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T20:17:21,000000+00:00]
+[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T21:09:39,000000+00:00]
diff --git a/tests/expected/utmp/utmpdump-totxt-ipv6 b/tests/expected/utmp/utmpdump-totxt-ipv6
index 589414408..cceb411bf 100644
--- a/tests/expected/utmp/utmpdump-totxt-ipv6
+++ b/tests/expected/utmp/utmpdump-totxt-ipv6
@@ -1,2 +1,2 @@
-[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,000000+0000]
-[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,000000+0000]
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,000000+00:00]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,000000+00:00]
diff --git a/tests/expected/uuid/uuidparse b/tests/expected/uuid/uuidparse
index c4959be8d..8b23a2548 100644
--- a/tests/expected/uuid/uuidparse
+++ b/tests/expected/uuid/uuidparse
@@ -26,6 +26,6 @@ UUID                                  VARIANT   TYPE       TIME
 00000000-0000-4000-f000-000000000000  other     random     
 00000000-0000-5000-f000-000000000000  other     sha1-based 
 00000000-0000-6000-f000-000000000000  other     unknown    
-9b274c46-544a-11e7-a972-00037f500001  DCE       time-based 2017-06-18 17:21:46,544647+0000
+9b274c46-544a-11e7-a972-00037f500001  DCE       time-based 2017-06-18 17:21:46,544647+00:00
 invalid-input                         invalid   invalid    invalid
 return value: 0
diff --git a/tests/ts/utmp/subsec b/tests/ts/utmp/subsec
index 4881e7cad..0fdff0577 100644
--- a/tests/ts/utmp/subsec
+++ b/tests/ts/utmp/subsec
@@ -1,3 +1,3 @@
-[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,123456+0000]
-[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,999999+0000]
-[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,123456789+0000]
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,123456+00:00]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,999999+00:00]
+[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,123456789+00:00]
diff --git a/tests/ts/utmp/txt-a b/tests/ts/utmp/txt-a
index 8501daab0..47b6fc2fc 100644
--- a/tests/ts/utmp/txt-a
+++ b/tests/ts/utmp/txt-a
@@ -1,19 +1,19 @@
-[9] [00009] [ts/9] [accounting] [foo         ] [nine                ] [0.0.0.0        ] [2013-08-28T03:00:00,000000+0000]
-[8] [00008] [ts/8] [dead_process] [foo         ] [eight               ] [0.0.0.0        ] [2013-08-28T04:00:00,000000+0000]
-[7] [00007] [ts/7] [user_process] [foo         ] [seven               ] [0.0.0.0        ] [2013-08-28T05:00:00,000000+0000]
-[6] [00006] [ts/6] [login   ] [foo         ] [six                 ] [0.0.0.0        ] [2013-08-28T06:00:00,000000+0000]
-[5] [00005] [ts/5] [init    ] [foo         ] [five                ] [0.0.0.0        ] [2013-08-28T07:00:00,000000+0000]
-[4] [00004] [ts/4] [oldtime ] [foo         ] [four                ] [0.0.0.0        ] [2013-08-28T08:00:00,000000+0000]
-[3] [00003] [ts/3] [newtime ] [foo         ] [three               ] [0.0.0.0        ] [2013-08-28T09:00:00,000000+0000]
-[2] [00002] [ts/2] [sysboot ] [foo         ] [two                 ] [0.0.0.0        ] [2013-08-28T10:00:00,000000+0000]
-[1] [00001] [ts/1] [runlevel] [foo         ] [one                 ] [0.0.0.0        ] [2013-08-28T11:00:00,000000+0000]
-[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,000000+0000]
-[7] [00010] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [2013-08-28T13:00:00,000000+0000]
-[8] [00011] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [2013-08-28T14:00:00,000000+0000]
-[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T15:00:00,000000+0000]
-[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T16:00:00,000000+0000]
-[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T17:00:00,000000+0000]
-[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T18:00:00,000000+0000]
-[7] [00013] [ts/1] [torvalds] [linux       ] [hobby               ] [128.214.205.14 ] [1991-08-26T00:57:08,000000+0000]
-[7] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [1970-01-01T00:00:00,000000+0000]
-[8] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [2038-01-19T03:14:07,000000+0000]
+[9] [00009] [ts/9] [accounting] [foo         ] [nine                ] [0.0.0.0        ] [2013-08-28T03:00:00,000000+00:00]
+[8] [00008] [ts/8] [dead_process] [foo         ] [eight               ] [0.0.0.0        ] [2013-08-28T04:00:00,000000+00:00]
+[7] [00007] [ts/7] [user_process] [foo         ] [seven               ] [0.0.0.0        ] [2013-08-28T05:00:00,000000+00:00]
+[6] [00006] [ts/6] [login   ] [foo         ] [six                 ] [0.0.0.0        ] [2013-08-28T06:00:00,000000+00:00]
+[5] [00005] [ts/5] [init    ] [foo         ] [five                ] [0.0.0.0        ] [2013-08-28T07:00:00,000000+00:00]
+[4] [00004] [ts/4] [oldtime ] [foo         ] [four                ] [0.0.0.0        ] [2013-08-28T08:00:00,000000+00:00]
+[3] [00003] [ts/3] [newtime ] [foo         ] [three               ] [0.0.0.0        ] [2013-08-28T09:00:00,000000+00:00]
+[2] [00002] [ts/2] [sysboot ] [foo         ] [two                 ] [0.0.0.0        ] [2013-08-28T10:00:00,000000+00:00]
+[1] [00001] [ts/1] [runlevel] [foo         ] [one                 ] [0.0.0.0        ] [2013-08-28T11:00:00,000000+00:00]
+[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,000000+00:00]
+[7] [00010] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [2013-08-28T13:00:00,000000+00:00]
+[8] [00011] [ipv4] [IPv4    ] [root        ] [dns-server          ] [198.41.0.4     ] [2013-08-28T14:00:00,000000+00:00]
+[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T15:00:00,000000+00:00]
+[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T16:00:00,000000+00:00]
+[1] [00012] [~~  ] [shutdown] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T17:00:00,000000+00:00]
+[2] [00012] [~~  ] [reboot  ] [~           ] [system-name         ] [0.0.0.0        ] [2013-08-28T18:00:00,000000+00:00]
+[7] [00013] [ts/1] [torvalds] [linux       ] [hobby               ] [128.214.205.14 ] [1991-08-26T00:57:08,000000+00:00]
+[7] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [1970-01-01T00:00:00,000000+00:00]
+[8] [00014] [long] [rick    ] [long        ] [never-gonna-logout  ] [0.0.0.0        ] [2038-01-19T03:14:07,000000+00:00]
diff --git a/tests/ts/utmp/txt-b b/tests/ts/utmp/txt-b
index 5deefde60..f92927336 100644
--- a/tests/ts/utmp/txt-b
+++ b/tests/ts/utmp/txt-b
@@ -1,10 +1,10 @@
-[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:44:09,000000+0000]
-[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:49:17,000000+0000]
-[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T12:23:33,000000+0000]
-[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T12:24:49,000000+0000]
-[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T13:12:39,000000+0000]
-[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:19,000000+0000]
-[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+0000]
-[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+0000]
-[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T20:17:21,000000+0000]
-[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T21:09:39,000000+0000]
+[7] [17058] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:44:09,000000+00:00]
+[7] [22098] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-16T23:49:17,000000+00:00]
+[7] [24915] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T12:23:33,000000+00:00]
+[8] [24915] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T12:24:49,000000+00:00]
+[7] [30629] [ts/3] [kerolasa] [pts/3       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T13:12:39,000000+00:00]
+[8] [30629] [ts/3] [kerolasa] [pts/3       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:19,000000+00:00]
+[8] [22098] [ts/2] [kerolasa] [pts/2       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+00:00]
+[8] [17058] [ts/1] [kerolasa] [pts/1       ] [                    ] [0.0.0.0        ] [2013-01-17T13:42:48,000000+00:00]
+[7] [31545] [ts/1] [kerolasa] [pts/1       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T20:17:21,000000+00:00]
+[7] [28496] [ts/2] [kerolasa] [pts/2       ] [:0.0                ] [0.0.0.0        ] [2013-01-17T21:09:39,000000+00:00]
diff --git a/tests/ts/utmp/txt-ipv6 b/tests/ts/utmp/txt-ipv6
index 589414408..cceb411bf 100644
--- a/tests/ts/utmp/txt-ipv6
+++ b/tests/ts/utmp/txt-ipv6
@@ -1,2 +1,2 @@
-[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,000000+0000]
-[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,000000+0000]
+[7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,000000+00:00]
+[8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,000000+00:00]
