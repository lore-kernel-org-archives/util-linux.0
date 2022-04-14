Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90403C433EF
	for <util-linux@archiver.kernel.org>; Thu, 14 Apr 2022 09:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiDNJuJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiDNJt7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 14 Apr 2022 05:49:59 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892337B123
        for <util-linux@vger.kernel.org>; Thu, 14 Apr 2022 02:47:02 -0700 (PDT)
X-UUID: f46ee464427f4f1abae9554be8ae72fb-20220414
X-CPASD-INFO: fdb16d5016dc4d9ea7fdc9a2570c6699@r7ScUWOWY2BdVqavg6eEn4FolpSTZYG
        Bd3FQk2RmZVmVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3taacUWaSZQ==
X-CLOUD-ID: fdb16d5016dc4d9ea7fdc9a2570c6699
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:186.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:132.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:13,DUF:37166,ACD:254,DCD:356,SL:0,EISP:0,AG:0,CFC:0.426,CFSR:0.055,UAT:
        0,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM
        :0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: f46ee464427f4f1abae9554be8ae72fb-20220414
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: f46ee464427f4f1abae9554be8ae72fb-20220414
X-User: lienze@kylinos.cn
Received: from fedora.. [(106.37.198.36)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1496207351; Thu, 14 Apr 2022 17:45:45 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Subject: [PATCH] eject: set CD-ROM speed to auto when xargs < 0
Date:   Thu, 14 Apr 2022 17:46:27 +0800
Message-Id: <20220414094627.2924087-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

when I execute the following command,
$ ./eject -x -1 -v

I get this output info,
eject: using default device `/dev/sr0'
eject: device name is `/dev/sr0'
eject: /dev/sr0: not mounted
eject: /dev/sr0: is whole-disk device
eject: setting CD-ROM speed to -1X
                               ^^^

Obviously the speed of the CD-ROM cannot be set to a negative number.
Let's auto-correct to auto mode when using negative number as parameter.

With this patch applied, I get this,
eject: using default device `/dev/sr0'
eject: device name is `/dev/sr0'
eject: /dev/sr0: not mounted
eject: /dev/sr0: is whole-disk device
eject: setting CD-ROM speed to auto
                               ^^^

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 sys-utils/eject.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 5cd0beab2..210d5dd66 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -831,9 +831,10 @@ static void set_device_speed(struct eject_control *ctl)
 	if (!ctl->x_option)
 		return;
 
-	if (ctl->x_arg == 0)
+	if (ctl->x_arg <= 0) {
 		verbose(ctl, _("setting CD-ROM speed to auto"));
-	else
+		ctl->x_arg = 0;
+	} else
 		verbose(ctl, _("setting CD-ROM speed to %ldX"), ctl->x_arg);
 
 	open_device(ctl);
-- 
2.35.1

