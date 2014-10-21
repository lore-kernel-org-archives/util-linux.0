Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:44158 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415AbaJUICs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Oct 2014 04:02:48 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C159CABE6
	for <util-linux@vger.kernel.org>; Tue, 21 Oct 2014 08:02:46 +0000 (UTC)
Date: Tue, 21 Oct 2014 10:02:46 +0200
From: Robert Milasan <rmilasan@suse.com>
To: <util-linux@vger.kernel.org>
Subject: swapon: fix -d short option
Message-ID: <20141021100246.3e956b6d@viper.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/eV+7HmjwUJHW_yLMXPeOLwN"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--MP_/eV+7HmjwUJHW_yLMXPeOLwN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When -d option is used with swapon, is expected that there is an equal
'=' which at least according to the man page it doesn't make sense or
it's not properly explained.

If we use -d as we should, then swapon takes 'once' or 'pages' as an
actual device:

dhcp33:~ # swapon -p -2 -d once /dev/sdb1
swapon: stat failed once: No such file or directory

The short option -d, should be something like "swapon -d once ...." not
"swapon -d=once ...."

I've attached the patch to fix this small issue.


-- 
Robert Milasan

L3 Support Engineer
SUSE Linux (http://www.suse.com)
email: rmilasan@suse.com
GPG fingerprint: B6FE F4A8 0FA3 3040 3402  6FE7 2F64 167C 1909 6D1A

--MP_/eV+7HmjwUJHW_yLMXPeOLwN
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=swapon_fix-d-short-option.patch

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 8609ea2..20baea3 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -846,12 +846,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			discard |= SWAP_FLAG_DISCARD;
 			if (optarg) {
-				if (*optarg == '=')
-					optarg++;
-
-				if (strcmp(optarg, "once") == 0)
+				if (strncmp(optarg, "once", 4) == 0)
 					discard |= SWAP_FLAG_DISCARD_ONCE;
-				else if (strcmp(optarg, "pages") == 0)
+				else if (strncmp(optarg, "pages", 5) == 0)
 					discard |= SWAP_FLAG_DISCARD_PAGES;
 				else
 					errx(EXIT_FAILURE, _("unsupported discard policy: %s"), optarg);

--MP_/eV+7HmjwUJHW_yLMXPeOLwN--
