Return-Path: assafgordon@gmail.com
Date: Wed, 31 May 2017 20:05:54 +0000
From: Assaf Gordon <assafgordon@gmail.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
Message-ID: <20170531200553.GB30064@gmail.com>
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home>
 <20170531091648.3eql47zhfo6sy6sd@ws.net.home>
 <20170531174139.GA30064@gmail.com>
 <201705312036.39054.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
In-Reply-To: <201705312036.39054.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 31, 2017 at 08:36:38PM +0200, Ruediger Meier wrote:

>musl supports both utmp and utmpx. We are using utmpx. Could you show us
>all your test diffs?:
>
>  find tests/diff -type f  | xargs tail -n +1

Attached.

regards,
 - assaf



--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="err.log"

==> tests/diff/column/invalid-multibyte <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/column/invalid-multibyte
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/column/invalid-multibyte
@@ -1 +1 @@
-column: read failed: Invalid or incomplete multibyte or wide character
+

==> tests/diff/getopt/options-posix_correctly <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/getopt/options-posix_correctly
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/getopt/options-posix_correctly
@@ -1,4 +1,4 @@
  -a -b '1' -c '2' --a-long --b-long '3' --c-long '' -- 'foo' 'bar' 'xyxxy' '--a-long'
 exit value: 0
- -a -b '1' -c '2' --a-long --b-long '3' --c-long '' -- 'foo' 'bar' 'xyxxy' '--a-long'
+ -a -b '1' -c '2' --a-long --b-long '3' --c-long '' --a-long -- 'foo' 'bar' 'xyxxy'
 exit value: 0

==> tests/diff/getopt/options-alternative_option_clash <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/getopt/options-alternative_option_clash
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/getopt/options-alternative_option_clash
@@ -1,2 +1,2 @@
- -a --abcde --abcde -a -c --
+ --abcde --abcde --abcde -a -c --
 exit value: 0

==> tests/diff/misc/swaplabel <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/misc/swaplabel
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/misc/swaplabel
@@ -1,7 +1,7 @@
 mkswap: error: swap area needs to be at least 10 pages
 mkswap: <swapfile>: insecure permissions <perm>, 0600 suggested.
-mkswap: Label was truncated.
 Setting up swapspace version 1, size = 9 pages (9xPGSZ bytes)
+mkswap: Label was truncated.
 LABEL=1234567890abcde, UUID=12345678-abcd-abcd-abcd-1234567890ab
 LABEL: 1234567890abcde
 UUID:  12345678-abcd-abcd-abcd-1234567890ab

==> tests/diff/fdisk/oddinput <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/fdisk/oddinput
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/fdisk/oddinput
@@ -8,4 +8,4 @@
 Nonexistent file
 fdisk: cannot open _a_file_that_does_not_exist_: No such file or directory
 Too small file
-fdisk: cannot open oddinput.toosmall: Inappropriate ioctl for device
+fdisk: cannot open oddinput.toosmall: Invalid argument

==> tests/diff/utmp/utmpdump-subsecond <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/utmp/utmpdump-subsecond
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/utmp/utmpdump-subsecond
@@ -1,5 +1,8 @@
 last 9 is expected to disappear in conversion
-3c3
-< [0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,123456789+0000]
----
-> [0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,12345678+0000]
+--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/ts/utmp/subsec
++++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/utmp/utmpdump-subsecond.txt
+@@ -1,3 +1,3 @@
+ [7] [00010] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:30:40,123456+0000]
+ [8] [00011] [ipv6] [IPv6    ] [root        ] [dns-server          ] [2001:503:ba3e::2:30] [2013-08-28T20:40:50,999999+0000]
+-[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,123456789+0000]
++[0] [00000] [ts/0] [nonvalid] [foo         ] [zero                ] [0.0.0.0        ] [2013-08-28T12:00:00,12345678+0000]

==> tests/diff/rename/exit_codes <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/rename/exit_codes
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/rename/exit_codes
@@ -2,6 +2,6 @@
 `rename_exit_codes.1' -> `rename_exit_values.1'
 `rename_exit_codes.2' -> `rename_exit_values.2'
 EXIT_SUCCESS: 0
-rename: rename_exit_values.2: rename to rename_exit_codes.2 failed: Is a directory
 `rename_exit_values.1' -> `rename_exit_codes.1'
+rename: rename_exit_values.2: rename to rename_exit_codes.2 failed: Is a directory
 RENAME_EXIT_SOMEOK: 2

==> tests/diff/colcrt/regressions-crash2 <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/colcrt/regressions-crash2
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/colcrt/regressions-crash2
@@ -1,10 +1,2 @@
-
-FGHIKIJKN\
-MN9|
-XYZRnT RnTUV|   NXP:w
-MN
-'QRnTUVWXYZQRnTU
-MN9|
-XYZ nT RnTUV|   NXP:w
-   -
-MNOP.return value: 0
+timeout: can't execute '2': No such file or directory
+return value: 127

==> tests/diff/colcrt/regressions-crash1 <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/colcrt/regressions-crash1
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/colcrt/regressions-crash1
@@ -1,2 +1,2 @@
- W U;    U;  D  f U;  D  f    D  f    >     @W  ]~   K- -  ----  -- -- -  -- -- ---- -- ---- --  -  --  --- --
-return value: 0
+timeout: can't execute '2': No such file or directory
+return value: 127

==> tests/diff/colcrt/regressions-hang1 <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/colcrt/regressions-hang1
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/colcrt/regressions-hang1
@@ -1,3 +1,2 @@
-789:;<=>=>?IABUVNXYZ[ `abcdefgg !"#$%&'()*+,-./01234)*:,-./0123456789:;[=>?1234)*:,-./0123456789:;[=>?4456789:;<=>?IABUVN`abcdefg !"
-                     -
-return value: 0
+timeout: can't execute '2': No such file or directory
+return value: 127

==> tests/diff/col/multibyte <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/col/multibyte
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/col/multibyte
@@ -1 +0,0 @@
-col: Invalid or incomplete multibyte or wide character

==> tests/diff/schedutils/chrt-non-root-batch-vs-nice <==
--- /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/expected/schedutils/chrt-non-root-batch-vs-nice
+++ /tmp/util-linux-2.30-rc2-22-3947.MJfaDm/util-linux-2.30-rc2-22-3947/tests/output/schedutils/chrt-non-root-batch-vs-nice
@@ -1,3 +1 @@
 <removed> (process ID) old priority 0, new priority 5
-SCHED_BATCH
-0


--envbJBWh7q8WU6mo--
