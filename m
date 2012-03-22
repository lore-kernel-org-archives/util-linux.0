Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:53730 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab2CVL6z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 22 Mar 2012 07:58:55 -0400
Message-ID: <4F6B13F9.4020108@bernhard-voelker.de>
Date: Thu, 22 Mar 2012 12:58:49 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "Karel Zak" <kzak@redhat.com>, "Simon de Vlieger" <simon@ikanobori.jp>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] hexdump: adjust -s and -n option in the man page [was: hexsyntax.c
 using strtol on the offset parameter]
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> Fixed. The code (as well as -n) was stupid. Now it supports all
> possible suffixes (K,M,G,T,P,E,Y,Z) and the number is parsed as
> uintmax_t.

btw: it should read "...P,E,Z,Y", as Y>Z.

The man page is outdated now:

       -n length
              Interpret only length bytes of input.
       ...
       -s offset
              Skip  offset bytes from the beginning of the input.  By default,
              offset is interpreted as a decimal number.  With a leading 0x or
              0X,  offset  is  interpreted as a hexadecimal number, otherwise,
              with a leading 0, offset is  interpreted  as  an  octal  number.
              Appending  the  character  b,  k, or m to offset causes it to be
              interpreted as a multiple of  512,  1024,  or  1048576,  respec-
              tively.

The variant with 0x or 0X doesn't seem to work anyway:

$ echo 123456789abcdefghijk > /tmp/x
$ text-utils/hexdump -s 0x1 -n 1 -c /tmp/x
0000001   2
0000002

Below follows a proposal for a man page patch.

Have a nice day,
Berny

>From f546c9d7bdd52b2e57761c2c97a701e662d89bc1 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Thu, 22 Mar 2012 12:53:06 +0100
Subject: [PATCH] hexdump: adjust -s and -n option in the man page

Remove note about hexadecimal and octal interpretation of -s value.
Mention the optional suffix notation for -n and -s  like <x>B or <x>iB
with <x> in K,M,G,T,P,E,Z,Y.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 text-utils/hexdump.1 |   33 +++++++++------------------------
 1 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index cbb14fb..4a373de 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -80,7 +80,8 @@ are ignored.
 .BI \-n \ length
 Interpret only
 .I length
-bytes of input.
+.B BYTES
+of input.
 .TP
 .B \-o
 \fITwo-byte octal display\fR.  Display the input offset in hexadecimal,
@@ -90,29 +91,8 @@ quantities of input data, in octal, per line.
 .BI \-s \ offset
 Skip
 .I offset
-bytes from the beginning of the input.  By default,
-.I offset
-is interpreted as a decimal number.  With a leading
-.B 0x
-or
-.BR 0X ,
-.I offset
-is interpreted as a hexadecimal number, otherwise, with a leading
-.BR 0 ,
-.I offset
-is interpreted as an octal number.  Appending the character
-.BR b ,
-.BR k ,
-or
-.B m
-to
-.I offset
-causes it to be interpreted as a multiple of
-.IR 512 ,
-.IR 1024 ,
-or
-.IR 1048576 ,
-respectively.
+.B BYTES
+from the beginning of the input.
 .TP
 .B \-v
 The
@@ -138,6 +118,11 @@ according to the format strings specified by the
 and
 .B \-f
 options, in the order that they were specified.
+.PP
+.B BYTES
+is a decimal number and may be followed by the following multiplicative
+suffixes: KB =1000, KiB =1024, MB =1000*1000, MiB =1024*1024,
+GB =1000*1000*1000, GiB =1024*1024*1024, and so on for T, P, E, Z, Y.
 .SH FORMATS
 A format string contains any number of format units, separated by whitespace.
 A format unit contains up to three items: an iteration count, a byte count,
-- 
1.7.7




