Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB523CD98C0
	for <util-linux@archiver.kernel.org>; Tue, 10 Oct 2023 23:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjJJXIo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Oct 2023 19:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjJJXIn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Oct 2023 19:08:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35598
        for <util-linux@vger.kernel.org>; Tue, 10 Oct 2023 16:08:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 40CA71F6E6
        for <util-linux@vger.kernel.org>; Tue, 10 Oct 2023 23:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696979291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=KpIQkIS/U9/Gsa6pc2CFYbCiZebYpN4vRyC6rRYNpR0=;
        b=toZisXGKln5/ARfqvsfAhgXz/4bx9IOiilWL8jl2WQH8dPSEY74vfrS1vIWe7yECGBXXOW
        e5syb6hVgUVR3cVejGYQJhzgNS5fqUOuLLE1Ue+Ph99V7Pyvx04c1a2Xvp4TsIUPZl1Rwa
        2hGaQyEi54jXr/mSp53vHri3s/Lx9Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696979291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=KpIQkIS/U9/Gsa6pc2CFYbCiZebYpN4vRyC6rRYNpR0=;
        b=zs5EZEfM5+RSTIUslv7bYAxESxmmKTGP6/CwNvSXBvCaUCZY8b1D58Y+ZxxFN7Z7sUkp7s
        U5B70MCcD4YRS4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBB791358F
        for <util-linux@vger.kernel.org>; Tue, 10 Oct 2023 23:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WpFAJVrZJWVePQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>)
        for <util-linux@vger.kernel.org>; Tue, 10 Oct 2023 23:08:10 +0000
Date:   Tue, 10 Oct 2023 18:08:59 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     util-linux@vger.kernel.org
Subject: [PATCH] libuuid: avoid truncate clocks.txt to improve performance
Message-ID: <i4fuwkw2hvj6gge3uhuy3jlq5gg4ls7djibygcb5duxhumvllx@cernuqwwl7pi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Instead of explicitly truncating clocks.txt file, pad with
whitespaces in the end of file.
This is done to improve performance of libuuid on xfs
filesystems. Instead of truncating the file, pad it with whitespaces.
This is anyways used as a failsafe method in case truncate fails.

The reason why this regression was introduced was because of:
869ae85dae64 ("xfs: flush new eof page on truncate to avoid post-eof corruption")

An attempt to move the clocks.txt to /run (tmpfs) has been attempted before
[1] and with commit ab2e7dd17 ("libuuid: move clock state file from
/var/lib to /var/run"). The latter was reverted.

[1] https://www.spinics.net/lists/util-linux-ng/msg17331.html

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

---
 libuuid/src/gen_uuid.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 619ef0131..97e2dec4e 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -229,7 +229,6 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 	struct timeval			tv;
 	uint64_t			clock_reg;
 	mode_t				save_umask;
-	int				len;
 	int				ret = 0;
 
 	if (state_fd == -1)
@@ -324,14 +323,10 @@ try_again:
 
 	if (state_fd >= 0) {
 		rewind(state_f);
-		len = fprintf(state_f,
-			      "clock: %04x tv: %016ld %08ld adj: %08d\n",
+		fprintf(state_f,
+			      "clock: %04x tv: %016ld %08ld adj: %08d                   \n",
 			      clock_seq, (long)last.tv_sec, (long)last.tv_usec, adjustment);
 		fflush(state_f);
-		if (ftruncate(state_fd, len) < 0) {
-			fprintf(state_f, "                   \n");
-			fflush(state_f);
-		}
 		rewind(state_f);
 		flock(state_fd, LOCK_UN);
 	}
-- 
2.42.0


-- 
Goldwyn
