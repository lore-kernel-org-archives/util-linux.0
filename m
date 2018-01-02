Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeABO7L (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Jan 2018 09:59:11 -0500
Subject: [v3 PATCH 06/11] cal: make -w accept its optional argument
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <88ccbbdb-28f2-a9e6-1918-531333c94c71@gmx.com>
Date: Tue, 2 Jan 2018 09:59:07 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


This was removed in commit af7c483 due a mailing list comment:

https://marc.info/?l=util-linux-ng&m=138116560906549&w=2
 It's generally best to avoid optional args on short args,
 as in this case -w3 is ambiguous and -wj is problematic.
 So I'd instead support an interface like -w,--week[=NUM]

cal -wj
cal: invalid week argument: 'j'

cal -w3
      January 2018
   Su Mo Tu We Th Fr Sa
 1     1  2  3  4  5  6
 2  7  8  9 10 11 12 13
 3 14 15 16 17 18 19 20
 4 21 22 23 24 25 26 27
 5 28 29 30 31

That should be an expected result for those commands.

Util-linux has many commands with optional args for short options:
ipcrm, swapon, lscpu, nsenter, dmesg, script, cfdisk, fdisk, hexdump

It seems unexpected to have an argument for long options only. I found
this because I tried to pass an argument to -w.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 2f0a6be16..02283bc04 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -354,7 +354,7 @@ int main(int argc, char **argv)
 		ctl.weekstart = (wfd + *nl_langinfo(_NL_TIME_FIRST_WEEKDAY) - 1) % DAYS_IN_WEEK;
 	}
 #endif
-	while ((ch = getopt_long(argc, argv, "13mjn:sSywYVh", longopts, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "13mjn:sSyw::YVh", longopts, NULL)) != -1) {
 
 		err_exclusive_options(ch, longopts, excl, excl_st);
 
