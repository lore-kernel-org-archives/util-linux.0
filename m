Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34863 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946136AbbHGWFU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Aug 2015 18:05:20 -0400
Received: by oihn130 with SMTP id n130so63197578oih.2
        for <util-linux@vger.kernel.org>; Fri, 07 Aug 2015 15:05:19 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 7 Aug 2015 15:05:18 -0700
Message-ID: <CAFG+y4GYgtnKwHW5wQfWiHVym8NXv-SzzBSmDGuPQLvdPG_OCA@mail.gmail.com>
Subject: crash in colcrt
From: Alaa Mubaied <alaamubaied@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a113e4994dad402051cbfd4c9
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--001a113e4994dad402051cbfd4c9
Content-Type: text/plain; charset=UTF-8

Hi,

I found a crash in colcrt, (filter nroff output for CRT previewing) .
- The colcrt command is part of the util-linux package and is
available from Linux Kernel Archive
http://man7.org/linux/man-pages/man1/colcrt.1.html
https://www.kernel.org/pub/linux/utils/util-linux/v2.27/

/opt/linuxtools/bin/colcrt --help

Usage:
 colcrt [options] [<file>...]
Filter nroff output for CRT previewing.
Options:
 -,  --no-underlining    suppress all underlining
 -2, --half-lines        print all half-lines
 -h, --help     display this help and exit
 -V, --version  output version information and exit
For more details see colcrt(1).


Details:

platform: Linux x86/x64
Version: colcrt from util-linux-2.27

colcrt from util-linux-2.27 and below crashes when the tool used in
the command line.

when running colcrt with the following file (attached), it crashes
because i believe when colcrt is called, it will dereferencing pointer
"cp". here is the backtrace from gdb:

-bash-4.2$ gdb /opt/linuxtools/bin/colcrt
GNU gdb (GDB) Red Hat Enterprise Linux 7.6.1-51.el7
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-redhat-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /opt/linuxtools/bin/colcrt...done.
(gdb) r file
Starting program: /opt/linuxtools/bin/colcrt file

Program received signal SIGSEGV, Segmentation fault.
216 cp[i] = c;
colcrt (f=0x62b060) at text-utils/colcrt.c:216
Missing separate debuginfos, use: debuginfo-install glibc-2.17-55.el7_0.5.x86_64
(gdb) bt full
#0  colcrt (f=0x62b060) at text-utils/colcrt.c:216
        c = <optimized out>
        cp = 0x606fe8 L""
        dp = <optimized out>
        i = 0
        w = 1
#1  0x00000000004015bc in main (argc=0, argv=0x7fffffffe5f8) at
text-utils/colcrt.c:139
        f = 0x62b060
        i = <optimized out>
        opt = <optimized out>
        longopts = {{name = 0x405d67 "no-underlining", has_arg = 0,
flag = 0x0, val = 128}, {name = 0x405d76 "half-lines", has_arg = 0,
flag = 0x0, val = 50}, {
            name = 0x405d81 "version", has_arg = 0, flag = 0x0, val =
86}, {name = 0x405d89 "help", has_arg = 0, flag = 0x0, val = 104},
{name = 0x0, has_arg = 0, flag = 0x0, val = 0}}

Thanks
Ala'a

--001a113e4994dad402051cbfd4c9
Content-Type: application/octet-stream; name=file
Content-Disposition: attachment; filename=file
Content-Transfer-Encoding: base64
X-Attachment-Id: f_id26i0cm0

XxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXABAXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcX
FxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXVxcXFxcXFxcXFxcX
FxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcX
FxcXFxcXFxcXFxcXFxcXFxcXFxcXDxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcXFxcX
FxcXFxcXFxcXFxcXFxcXFw8XFxcXFxcXFxcXFxcXX1U7X19fX1U7X19EX19mX1U7X19EX19mX19f
X0RfX2ZfX19fPl9fICBfQFdfX11+X19fS19flH4=
--001a113e4994dad402051cbfd4c9--
