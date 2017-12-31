Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-out.m-online.net ([212.18.0.9]:60993 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdLaJqp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 31 Dec 2017 04:46:45 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3z8b7l0qhPz1qqy5
        for <util-linux@vger.kernel.org>; Sun, 31 Dec 2017 10:46:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3z8b7l0m7Gz1qqlF
        for <util-linux@vger.kernel.org>; Sun, 31 Dec 2017 10:46:43 +0100 (CET)
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id IQftlt2DYtCv for <util-linux@vger.kernel.org>;
        Sun, 31 Dec 2017 10:46:40 +0100 (CET)
Received: from linux.local (ppp-188-174-150-251.dynamic.mnet-online.de [188.174.150.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <util-linux@vger.kernel.org>; Sun, 31 Dec 2017 10:46:40 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: util-linux@vger.kernel.org
Subject: util-linux 2.31 testsuite failures 
Date: Sun, 31 Dec 2017 10:46:36 +0100
Message-ID: <m21sjbp6v7.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

https://build.opensuse.org/package/live_build_log/openSUSE:Factory:PowerPC/util-linux/standard/ppc
https://build.opensuse.org/package/live_build_log/openSUSE:Factory:PowerPC/util-linux/standard/ppc64
https://build.opensuse.org/package/live_build_log/openSUSE:Factory:zSystems/util-linux/standard/s390x

--- /home/abuild/rpmbuild/BUILD/util-linux-2.31/tests/expected/sha1/sha1       2017-09-27 09:05:13.818360897 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.31/tests/output/sha1/sha1  2017-12-29 17:51:02.780000000 +0000
@@ -1,7 +1,7 @@
-da39a3ee5e6b4b0d3255bfef95601890afd80709
-a9993e364706816aba3e25717850c26c9cd0d89d
-da3175a32e6c1aacfd3d3f35770188ae0ab6d078
-7496226c17d4d0a770cea72eebb659c16753b956
-db50ea8b1b20567cd4d8a7fa14de8d37ce9b722c
-90e072e1df8de879ca307610d5ced675af55a4ac
-2eda696c8df17722d80518bebb33742e311a4ac1
+9844f81e1408f6ecb932137d33bed7cfdcf518a3
+14c20690f653fb16396e4f804c9dafb46e513d4f
+b39356f080492701e97317f88ca581acffae89cf
+5e7c72295e61b1f0d733e6485bac4237b17d293a
+97faba6b0f94c599ad7dd08a8801b7e7f4994b15
+08b5f5340abf513bc11f824daea8828bb00c4541
+6d49c77f9f4fbb8ef5fd4db0bd3cad4111dcf1c3
--- /home/abuild/rpmbuild/BUILD/util-linux-2.31/tests/expected/uuid/oids       2017-09-27 09:05:13.818360897 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.31/tests/output/uuid/oids  2017-12-29 17:51:03.850000000 +0000
@@ -1,4 +1,4 @@
 3d813cbb-47fb-32ba-91df-831e1593ac29
 5df41881-3aed-3515-88a7-2f4a814cf09e
-2ed6657d-e927-568b-95e1-2665a8aea6a2
-fcdc2122-78d2-59f7-91ed-041a561ef652
+1564d4d7-b332-5361-9926-c6ac4f429514
+da0eb24b-b9c9-5beb-80de-bb6e984981ab

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
