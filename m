Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3483CAC
	for <util-linux@vger.kernel.org>; Wed, 21 Feb 2024 17:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536667; cv=none; b=nWDUXRfB79RlPFT1TY+QFNCVqzRnNfT14S7Lr5+lciaI4XT7bK9n6r3W+9QLLGGEMx3Bh0ACOdKogAOLFb7fmpvX/Rrf638fOHeR12lz5rm77zvgwamQDKngmkQxNcsp5Nr4QrXJeeT8yCquIX8kN862FEpbdrp6k8YldK+6QYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536667; c=relaxed/simple;
	bh=Fi/ZQWUCTrbtctWlbj5Lwp4Jg0QpZ4JEzW5nI5nO1fI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kh0vsX3ML8w+Q/2yeZ+n4Qj09Oscbb8ISLY01afZUj3nedy0LUWvcDChOR4hMLIOnJNIhenLfutdeWB4JoEO85bV8XDv+8COnbbUZ9XrpsLl5tYtmAX/JyrVN+tKeERZEadFkxjfYpi+qvZP/riDsBI/ECHQvod0EL7MOB81Ry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/fMKJLJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJYFhIE3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/fMKJLJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJYFhIE3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/fMKJLJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJYFhIE3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/fMKJLJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJYFhIE3"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17B0C220B0;
	Wed, 21 Feb 2024 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708536662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MONjShUZNKqFfzYloScrNV41SDApwDvx6XR+rV/Uhv0=;
	b=S/fMKJLJaszo4hJ7QYzjE/i9ffBVMbPiAq301EZbn8vtSqFU9rpVuBBTS6IqW1FzZMj1rY
	3L/Hcc4C37Z+a49ZSmH5IH+rxsUZDGY5qgE/1YpncmUGYIUvWrgZrKKUCTe6l6+vEkfyvk
	stCUPeeobqGc8XG6Vmb+EvfeM9WwGso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708536662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MONjShUZNKqFfzYloScrNV41SDApwDvx6XR+rV/Uhv0=;
	b=tJYFhIE3ozdFdbU9mt8VYLMUUcg6L5c0jdEtpP5k6/4gEiZb0vKdHz9Z8yQf8vx5YTwoeB
	zjBE2iYphqutuBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708536662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MONjShUZNKqFfzYloScrNV41SDApwDvx6XR+rV/Uhv0=;
	b=S/fMKJLJaszo4hJ7QYzjE/i9ffBVMbPiAq301EZbn8vtSqFU9rpVuBBTS6IqW1FzZMj1rY
	3L/Hcc4C37Z+a49ZSmH5IH+rxsUZDGY5qgE/1YpncmUGYIUvWrgZrKKUCTe6l6+vEkfyvk
	stCUPeeobqGc8XG6Vmb+EvfeM9WwGso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708536662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MONjShUZNKqFfzYloScrNV41SDApwDvx6XR+rV/Uhv0=;
	b=tJYFhIE3ozdFdbU9mt8VYLMUUcg6L5c0jdEtpP5k6/4gEiZb0vKdHz9Z8yQf8vx5YTwoeB
	zjBE2iYphqutuBBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F2B5F13A25;
	Wed, 21 Feb 2024 17:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id O+3yOlUz1mXXcwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 17:31:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84784A0807; Wed, 21 Feb 2024 18:30:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: util-linux@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] libmount: don't hold write fd to mounted device
Date: Wed, 21 Feb 2024 18:30:50 +0100
Message-Id: <20240221173050.21970-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="S/fMKJLJ";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tJYFhIE3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 17B0C220B0
X-Spam-Flag: NO

Avoid holding writeable fd to a loop device that is being mounted. In
the hardened configurations (CONFIG_BLK_DEV_WRITE_MOUNTED = n) the
kernel wants to make sure nobody else has the block device writeably
open when mounting so this makes the mount fail.

Reported-by: JunChao Sun <sunjunchao2870@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 libmount/src/hook_loopdev.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/libmount/src/hook_loopdev.c b/libmount/src/hook_loopdev.c
index 8c8f7f218732..e2114b0cbebe 100644
--- a/libmount/src/hook_loopdev.c
+++ b/libmount/src/hook_loopdev.c
@@ -356,15 +356,19 @@ success:
 			 */
 			mnt_optlist_append_flags(ol, MS_RDONLY, cxt->map_linux);
 
-		/* we have to keep the device open until mount(1),
-		 * otherwise it will be auto-cleared by kernel
+		/*
+		 * We have to keep the device open until mount(1), otherwise it
+		 * will be auto-cleared by kernel. However we don't want to
+		 * keep writeable fd as kernel wants to block all writers to
+		 * the device being mounted (in the more hardened
+		 * configurations). So grab read-only fd instead.
 		 */
-		hd->loopdev_fd = loopcxt_get_fd(&lc);
+		hd->loopdev_fd = open(lc.device, O_RDONLY | O_CLOEXEC);
 		if (hd->loopdev_fd < 0) {
-			DBG(LOOP, ul_debugobj(cxt, "failed to get loopdev FD"));
+			DBG(LOOP,
+			    ul_debugobj(cxt, "failed to reopen loopdev FD"));
 			rc = -errno;
-		} else
-			loopcxt_set_fd(&lc, -1, 0);
+		}
 	}
 done:
 	loopcxt_deinit(&lc);
-- 
2.35.3

