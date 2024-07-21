Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98E7E792
	for <util-linux@vger.kernel.org>; Sun, 21 Jul 2024 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721566930; cv=none; b=MazVd30ycwqbo1trjzfK1kERty5TXg/yWJuNqIBHzIH+R3zDi0jyQnIHUyQWoA1eKE+S7yA5M3ZOca8V01mGqhIvacJx4gxxZl3aU4ZLS96+k9gXhxwAjF4dC72yyFOU8YmQb59itiTI7MwCXFtPvGDwsN5ClDBIJmHDsqURRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721566930; c=relaxed/simple;
	bh=6bJ5lWC/uYXkfRuRyT6qXiYyLtZQ3YUKr7c9VycBVX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcFFxhUKB7sW22AyVezNnvXm30cOdpZFp8U8FAvvdgqRdxCCRmvotsUmafQMjCCI7cB5NvyIEHjU2jr4Mom9VwkmCABOo+QqnoMeFRVOBBOPu1Rwe9/2WGSlSws5JzC0CzPgm6jzASug9NV7glmR93wal5ynm+8WCRfiWN/wa0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/qva0Cj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zraubsFm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kHinI1A3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ECn+0P+M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/qva0Cj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zraubsFm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kHinI1A3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ECn+0P+M"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61F951F6E6;
	Sun, 21 Jul 2024 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721566926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PPJph2Wv0z0jybN+s/eeqO9W+H+dcCTMhePG1R1lW60=;
	b=w/qva0CjNyaj9/4LZe7ykQJmyojP0qdOIpYwcGzE6hY/LnjXNPmc4Tbd2urwcXu+30rc5u
	1cGeWQ2+YHPVuRqsUF0vcq9WbSTEKDEyJxLAyez/8fLdJrwRUS/4H9oOuKUsG4sseTKy+7
	NnGvn5piWqKKwQA0chCL9nsV2CGhNN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721566926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PPJph2Wv0z0jybN+s/eeqO9W+H+dcCTMhePG1R1lW60=;
	b=zraubsFmDaaaVcMzhrxMzHhL1ysWHqymoH9pQNLC6zqzsZYY6pBRDvuAHPbsYwbdv2OaiT
	bgZncBWVxKrrWHCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kHinI1A3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ECn+0P+M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721566925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PPJph2Wv0z0jybN+s/eeqO9W+H+dcCTMhePG1R1lW60=;
	b=kHinI1A3+oGAvtaGLDpfwqdWStli0hVTiOr0TVaNbGpXknG/uUZIu3hcu3y8sLQSZMudOz
	k6k9MGg7/EQ14dgXf6oUDE72iKP2lF1aRGP4VpouaPh94QutQjZutm29u0sLe9Cfu26/TG
	3weV6u0BlBB4ncOlLGVUckRL+onJxxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721566925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PPJph2Wv0z0jybN+s/eeqO9W+H+dcCTMhePG1R1lW60=;
	b=ECn+0P+MW4tyrobEH/JJQjhkCxGOql2ynjd7irIlMbN11ZmFApWON3Rq+Uvg7dgitzfOUb
	JrqjiStsjY8/6wAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AB09132CB;
	Sun, 21 Jul 2024 13:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X+f9Ec0GnWYVVwAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Sun, 21 Jul 2024 13:02:05 +0000
Received: by goblin.suse.cz (Postfix, from userid 10027)
	id 1172E1EABA42; Sun, 21 Jul 2024 15:01:57 +0200 (CEST)
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] agetty: Prevent cursor escape
Date: Sun, 21 Jul 2024 15:01:42 +0200
Message-ID: <20240721130142.468136-1-sbrabec@suse.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.19 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 61F951F6E6
X-Spam-Score: 0.19
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /

Starting with 5de97519, it is possible to escape the login dialog on the
screen by arrow characters or using escape sequences.

Since full processing of escape sequences and ignore them would be
complicated, use a work around: instead of sending ESC to output, send a
printable character.

It could cause a rendering regression in a very obscure condition: compiled
without IUTF8, encoding is ISO-11548-1 and BRAILLE PATTERN DOTS-1245 is
part of login name. I believe that it is out of supported combinations.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 term-utils/agetty.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 275c59362..e20e7a454 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -2286,7 +2286,14 @@ static char *get_logname(struct issue *ie, struct options *op, struct termios *t
 				if ((size_t)(bp - logname) >= sizeof(logname) - 1)
 					log_err(_("%s: input overrun"), op->tty);
 				if ((tp->c_lflag & ECHO) == 0)
-					write_all(1, &c, 1);	/* echo the character */
+					/* Visualize escape sequence instead of its execution */
+					if (ascval == CTL('['))
+						/* Ideally it should be "\xe2\x90\x9b"
+						 * if (op->flags & (F_UTF8)),
+						 * but only some fonts contain it */
+						write_all(1, "^[", 2);
+					else
+						write_all(1, &c, 1);	/* echo the character */
 				*bp++ = ascval;			/* and store it */
 				break;
 			}
-- 
2.45.2

