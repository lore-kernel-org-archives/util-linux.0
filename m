Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59646 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbdF3Ulg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 30 Jun 2017 16:41:36 -0400
To: util-linux <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ruediger Meier <sweet_f_a@gmx.de>
From: J William Piggott <elseifthen@gmx.com>
Subject: 0b2b32e8a7 caused an unusual increase in hwclock size
Message-ID: <bbb77383-8a90-b1b1-0dfa-78cee5fb6267@gmx.com>
Date: Fri, 30 Jun 2017 16:41:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Does anyone know why this small change added 43K (+23%) to the binary?

222802 2017-06-30 15:55:54 hwclock-0b2b32e*
180175 2017-06-30 16:06:12 hwclock-9c8b9fb*


commit 0b2b32e8a7a6aed1e3ff1cfc3f63cf33361a67b8

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 5433cd0..325106a 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1326,6 +1326,8 @@ int main(int argc, char **argv)
        };
        int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
+       strutils_set_exitcode(EX_USAGE);
+
        /* Remember what time we were invoked */
        gettimeofday(&startup_time, NULL);
 

