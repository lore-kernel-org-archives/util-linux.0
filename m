Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F39C433EF
	for <util-linux@archiver.kernel.org>; Thu,  6 Jan 2022 10:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbiAFKnH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Jan 2022 05:43:07 -0500
Received: from 5.mo575.mail-out.ovh.net ([46.105.62.179]:35875 "EHLO
        5.mo575.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiAFKnH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Jan 2022 05:43:07 -0500
X-Greylist: delayed 2382 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2022 05:43:06 EST
Received: from player730.ha.ovh.net (unknown [10.110.208.202])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id DA2F2204B9
        for <util-linux@vger.kernel.org>; Thu,  6 Jan 2022 10:03:22 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player730.ha.ovh.net (Postfix) with ESMTPSA id 7F54F25D96C6D;
        Thu,  6 Jan 2022 10:03:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G006984862f7-03c1-4535-b8bc-e79e6abcbead,
                    4C3E269A5A0DABF7B68D357C2B70A0F813977BB5) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     util-linux@vger.kernel.org
Cc:     Stephen Kitt <steve@sk2.org>
Subject: [PATCH] losetup: restore -f/loopdev alternative
Date:   Thu,  6 Jan 2022 11:03:07 +0100
Message-Id: <20220106100307.3543758-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13720779216759916166
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrudefledguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtohepuhhtihhlqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

-f and loopdev are exclusive; the old man page made this explicit, but
this was lost in the Asciidoc transition in commit 6d5b69483a58
("Asciidoc: Import sys-utils man pages, part 1").

This patch restores the lost pipe, so that the disjunction is
explicit:

        losetup ... [--show] -f|loopdev file
                               ^

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sys-utils/losetup.8.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
index 2a2577f0d..52df95bd6 100644
--- a/sys-utils/losetup.8.adoc
+++ b/sys-utils/losetup.8.adoc
@@ -30,7 +30,7 @@ Detach all associated loop devices:
 
 Set up a loop device:
 
-*losetup* [*-o* _offset_] [*--sizelimit* _size_] [*--sector-size* _size_] [*-Pr*] [*--show*] *-f* _loopdev file_
+*losetup* [*-o* _offset_] [*--sizelimit* _size_] [*--sector-size* _size_] [*-Pr*] [*--show*] *-f*|_loopdev file_
 
 Resize a loop device:
 

base-commit: 22abf6df385b524acd78542fd8a3452ee1492002
-- 
2.30.2

