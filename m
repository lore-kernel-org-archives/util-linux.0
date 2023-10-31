Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86299C4332F
	for <util-linux@archiver.kernel.org>; Tue, 31 Oct 2023 14:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjJaOIB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Oct 2023 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjJaOHx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 31 Oct 2023 10:07:53 -0400
X-Greylist: delayed 877 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 07:07:40 PDT
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522E719F
        for <util-linux@vger.kernel.org>; Tue, 31 Oct 2023 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UCRbP9F+TJq6Ssa9cUUQM5OBGOQrUjoOmvipOZpZcEc=; b=O5/GCLVLGEiuxklrBFhBVD2qUm
        HnYoJUAaoRuZOBpP8xPK5SgDmHxxRU+2wexz4/pArZiXjs7YePFW6FjYXTQ73EKoVLyKSx5sraOmz
        pwhfgS5tgxrZ+Syejwj6qpSq1RinqrQ7w6fQs0GJy+g38Z8uGBPD3sPCgUGfn3xyaJiRaEnS2WYNV
        nGqqY8kaf2zj81gsWKYLN9KFmKdV/6OMnjJNMPUhAwnNO3BOmK0bj5RdQj5cCjH5J0a2HCPiFQQZe
        LVS1lcIfXKkmSHVwr8x/xeJ0ubDpewKf49N5leXwGtVi8d8elwW6zG8jfKDBYQqvXpadNFM2hTj/Z
        +VEsTdCQ==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <zeha@debian.org>)
        id 1qxpAv-003rR6-FW; Tue, 31 Oct 2023 13:52:57 +0000
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Cc:     Chris Hofstaedtler <zeha@debian.org>,
        Emanuele Rocca <ema@debian.org>
Subject: [PATCH] setterm: avoid restoring flags from uninitialized memory
Date:   Tue, 31 Oct 2023 14:52:26 +0100
Message-Id: <20231031135226.10243-1-zeha@debian.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: zeha
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Depending on the used compiler and flags, previously either F_SETFL was called
with 0 or with a random value. Never with the intended previous flags.

Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
Tested-by: Emanuele Rocca <ema@debian.org>
---
 term-utils/setterm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 1bf9a5bb4..92bf75a46 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -846,7 +846,10 @@ static void tty_raw(struct termios *saved_attributes, int *saved_fl)
 {
 	struct termios tattr;
 
-	fcntl(STDIN_FILENO, F_GETFL, saved_fl);
+	*saved_fl = fcntl(STDIN_FILENO, F_GETFL);
+	if (*saved_fl == -1) {
+		err(EXIT_FAILURE, _("fcntl failed"));
+	}
 	tcgetattr(STDIN_FILENO, saved_attributes);
 	fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);
 	memcpy(&tattr, saved_attributes, sizeof(struct termios));
@@ -898,7 +901,7 @@ static int resizetty(void)
 	ssize_t rc;
 	struct winsize ws;
 	struct termios saved_attributes;
-	int saved_fl;
+	int saved_fl = 0;
 
 	if (!isatty(STDIN_FILENO))
 		errx(EXIT_FAILURE, _("stdin does not refer to a terminal"));
-- 
2.42.0

