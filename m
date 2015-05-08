Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([74.201.84.155]:22824 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbbEHW6a (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 8 May 2015 18:58:30 -0400
Message-ID: <554D3F90.2000300@zoho.com>
Date: Sat, 09 May 2015 00:58:24 +0200
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: hypsurus@mail.ru
CC: =?UTF-8?B?U3RlcGhhbiBNw7xsbGVy?= <fruktopus@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: New linux command "hexed"
References: <1431085018.447503889@m.mail.ru> <554CAC0F.5050604@gmail.com>
In-Reply-To: <554CAC0F.5050604@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040102060808080800050107"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040102060808080800050107
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/05/15 14:29, Stephan Müller wrote:
> It seems you implemented a subset of the functionality of 'od' or 'xxd'
 >from coreutils. I guess these are widely spread and there is no need for
 >another converter (albeit the cooler name). If hexed provides some extra
 >features, you can integrate those in the tools above.

xxd seems a perfect replacement for hexed :P


FWIW, I see a number of quirks in your tool, Hypsurus:
a) Options have to be provided *after* the string
Usually options always appear at the beginning (just after the program 
name) and -when _POSIXLY_CORRECT is not set- the gnu optlib then allows 
placing them at any position.

b) The program crashes if the string begins with a dash (str is NULL).


c) You program requires the string to be passed as parameter.
All programs like this have *filenames* as parameters. Consistency is 
even more important for a program like this, that mimics the interfaces 
of many other programs working the other way.
And receiving filenames makes much more sense. Do you really want to 
type the binary contents as a program parameter? Does your OS even allow 
that large? etc.

With a program that receives a filename, you can provide a string with
  echo string | hexed

with a program that receives the string, you need a construct like:
  hexed "$(</etc/passwd)"
and only if you use bash, the file is small enough to be passed as a 
parameter and it doesn't contain any NUL (which defeats the point of an 
hexer).


d) You have a number of signedness warnings, you are assgning a size_t 
to an int and, generally, it would have been much easier for 
hexed_hex_encode to work with unsigned char and hexed_hex_decode with 
chars. See attached patch.

--------------040102060808080800050107
Content-Type: text/x-patch;
 name="hexed.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hexed.diff"

--- hexed.c-original	2015-05-09 00:24:13.791707625 +0200
+++ hexed.c	2015-05-09 00:54:07.538368884 +0200
@@ -29,26 +29,29 @@
         int addx;
         int addCarray;
         int hexd;
-        unsigned char *str;
+        union {
+            char *str;
+            unsigned char *ustr;
+        };
 } hexed_t;
 
 void hexed_hex_encode(hexed_t *hexed) {
         int index = 0;
 
-        for( index = 0; hexed->str[index] != 0; index++ ) {
+        for( index = 0; hexed->ustr[index] != 0; index++ ) {
                 if ( hexed->addx )
-                        printf("\\x%x", hexed->str[index]);
+                        printf("\\x%x", hexed->ustr[index]);
                 else if ( hexed->addCarray )
-                        printf("0x%x,", hexed->str[index]);
+                        printf("0x%x,", hexed->ustr[index]);
                 else
-                        printf("%x", hexed->str[index]);
+                        printf("%x", hexed->ustr[index]);
         }
 
         putchar(0x0a);
 }
 
 void hexed_hex_decode(hexed_t *hexed) {
-        int index = 0;
+        size_t index = 0;
         short byte = 0x00;
         size_t len = strlen(hexed->str);
         

--------------040102060808080800050107--

