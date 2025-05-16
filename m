Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E78462
	for <util-linux@vger.kernel.org>; Fri, 16 May 2025 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747359105; cv=none; b=IdANOqKHhw6wuMRFwLx13S2Epk5pBn6w+DRMt4UVPqE/f+k5veIlyUk1R1nycio5hO32B5S596ubPTdDiORTb9TkbatsR4CniXnQDXKo6rNn5vAZ8dYZaJ3x+STpQDPqb/khWR1a8gvJnHWIBjMXXoQyb1FHPueymO+yJ54zJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747359105; c=relaxed/simple;
	bh=OkIVQ3kvjKEhC8D2ih1muGO60BzJJl0OCibCObvHPNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMLYpKemP3OnDeEqM7eOtZ1Ag6vdKl3yfKFSEik2Bx/W6mZ+jXzu5WqBP3c4V2Xbbxy9D9/OIWNmDquXZYOPUvemJ7+7QJHbp+VSyHdKq5Qc5l+gWDinsuSSQnnnoL1/UDvPHZ1V7hX8oOTUxOuxIi6kBsNAHQblaom8QMif2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JVrWW+qM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+m6tNPvy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JVrWW+qM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+m6tNPvy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JVrWW+qM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+m6tNPvy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JVrWW+qM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+m6tNPvy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C16291F74B;
	Fri, 16 May 2025 01:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747359101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Ebf1rqFiRgn+Utw2wuzhRfRZ2qVILABg0l76VawMhM=;
	b=JVrWW+qMszE/lSRg8VQYiH283Z9o5Pl+3y4z47PY8yLHdZG6u0NwqFhFRw2rP952aJF07V
	ZtlX/WQO1ZssaGwqWUeZY4Hc+78Eb2MINZ/WMWteDs3IwKGcUJ8KVVeI+f3XWKR2TnBwXQ
	+45oOd8PmmUEy2Ycs14+KhO0a3GwwNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747359101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Ebf1rqFiRgn+Utw2wuzhRfRZ2qVILABg0l76VawMhM=;
	b=+m6tNPvyDKeB8Brj4XyG2Qmq/7i/+0Ean6kMiNckNyVlSk6UEjRdEbx/7UdMRgxZ4m0lPk
	Pj2bTsoCFlk4ULBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JVrWW+qM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+m6tNPvy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747359101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Ebf1rqFiRgn+Utw2wuzhRfRZ2qVILABg0l76VawMhM=;
	b=JVrWW+qMszE/lSRg8VQYiH283Z9o5Pl+3y4z47PY8yLHdZG6u0NwqFhFRw2rP952aJF07V
	ZtlX/WQO1ZssaGwqWUeZY4Hc+78Eb2MINZ/WMWteDs3IwKGcUJ8KVVeI+f3XWKR2TnBwXQ
	+45oOd8PmmUEy2Ycs14+KhO0a3GwwNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747359101;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Ebf1rqFiRgn+Utw2wuzhRfRZ2qVILABg0l76VawMhM=;
	b=+m6tNPvyDKeB8Brj4XyG2Qmq/7i/+0Ean6kMiNckNyVlSk6UEjRdEbx/7UdMRgxZ4m0lPk
	Pj2bTsoCFlk4ULBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8445136E3;
	Fri, 16 May 2025 01:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zcC4LH2VJmhUZwAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Fri, 16 May 2025 01:31:41 +0000
Received: by goblin.suse.cz (Postfix, from userid 10027)
	id 80C602D875CE; Fri, 16 May 2025 03:31:33 +0200 (CEST)
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>,
	Stefan Schubert <schubi@suse.de>
Subject: [PATCH] libblkid: Fix crash while parsing config with libeconf
Date: Fri, 16 May 2025 03:31:11 +0200
Message-ID: <20250516013111.1099053-1-sbrabec@suse.cz>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C16291F74B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,suse.de:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -3.00

As the whhole econf_file structure is freed by econf_free(file) at the end
of blkid_read_config, econf_file structure cannot be defined as static and
initialized only once. The econf_free() is not robust enough and keeps a
pointer to the garbage after the first call. And if /etc/blkid.conf does
not exist, it is called second time.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
Cc: Stefan Schubert <schubi@suse.de>
---
 libblkid/src/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/config.c b/libblkid/src/config.c
index 934d28d65..39024b42e 100644
--- a/libblkid/src/config.c
+++ b/libblkid/src/config.c
@@ -154,7 +154,7 @@ struct blkid_config *blkid_read_config(const char *filename)
 
 #else /* !HAVE_LIBECONF */
 
-	static econf_file *file = NULL;
+	econf_file *file = NULL;
 	char *line = NULL;
 	bool uevent = false;
 	econf_err error;
-- 
2.48.1

