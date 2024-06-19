Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70715B13A
	for <util-linux@vger.kernel.org>; Wed, 19 Jun 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811780; cv=none; b=u8L/cmNs3dBVNPp0PERr1M2Ns3MV7iIU6WsxvlED0w5a970kqdSSgx8ZmTjsvwCXHhzMoMU2YK+XugUFTdcriICFDVOuSiiIdCd2ZjzLga74CtRc6acU958gvIM8T/IGr7oGiiQFgfL9qXKr6ORRSzXMRP21LaixylCOFNNRVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811780; c=relaxed/simple;
	bh=mOcOgOHvV9i7uF3zkUAySSNioga17KwlZ/35uoW7RwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNkaIVneuFRfR9ZzSKokt4adN/ZqBAnVjMsfG0XdS6GUSJKbgCAHa4UNLAwiDtevKcEssCKf6uOLxfayoD/O0AFsx2npXYMO2uBr7H+XRcdkp7PjkgWInOYUYkZJ4fBJMYZ3SKg2WbQ/SMxYFV+YlqThCrKQIO9xINUPmc3k8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vYMP27GR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KhyXuGyJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vYMP27GR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KhyXuGyJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vYMP27GR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KhyXuGyJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vYMP27GR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KhyXuGyJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 559BC21A91;
	Wed, 19 Jun 2024 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718811776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Vx+Ef0jg9/Bq0U1CKY3tBPC5x0hnpXkv8Xq2Sup7hY=;
	b=vYMP27GRiLr9DwIe6uvlI3ElvBKXaBgx52/aCW3mIDIKBAd8LkywmidmPKBB6I4nx84K/V
	P1TDPqQSOH5gI36M61dKItbrjh4lDUvS+7t16Ner9Mm1ZeGuDb9aZPOjm++t7ydibv+Tgl
	cZXAHOW10jzhC6aeb1cTrEPo8+oOFOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718811776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Vx+Ef0jg9/Bq0U1CKY3tBPC5x0hnpXkv8Xq2Sup7hY=;
	b=KhyXuGyJJ75x2IbZay9cY36tt7kK+V8YxixehNLoF1LafI0zrxvLmCQ4brg3ZJSB/1ZEYa
	ZkD88DFDqriMGpBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vYMP27GR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KhyXuGyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718811776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Vx+Ef0jg9/Bq0U1CKY3tBPC5x0hnpXkv8Xq2Sup7hY=;
	b=vYMP27GRiLr9DwIe6uvlI3ElvBKXaBgx52/aCW3mIDIKBAd8LkywmidmPKBB6I4nx84K/V
	P1TDPqQSOH5gI36M61dKItbrjh4lDUvS+7t16Ner9Mm1ZeGuDb9aZPOjm++t7ydibv+Tgl
	cZXAHOW10jzhC6aeb1cTrEPo8+oOFOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718811776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5Vx+Ef0jg9/Bq0U1CKY3tBPC5x0hnpXkv8Xq2Sup7hY=;
	b=KhyXuGyJJ75x2IbZay9cY36tt7kK+V8YxixehNLoF1LafI0zrxvLmCQ4brg3ZJSB/1ZEYa
	ZkD88DFDqriMGpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F3D713AAA;
	Wed, 19 Jun 2024 15:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OktVE4D8cmaVKAAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Wed, 19 Jun 2024 15:42:56 +0000
Received: by goblin.suse.cz (Postfix, from userid 10027)
	id A9D0A1DEC9AD; Wed, 19 Jun 2024 17:32:34 +0200 (CEST)
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] umount, losetup: Document loop destroy behavior
Date: Wed, 19 Jun 2024 17:31:34 +0200
Message-ID: <20240619153133.4628-2-sbrabec@suse.cz>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 559BC21A91
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

The loop device detach runs asynchronously in the background. It can cause
unexpected errors. Document the possible existence of the loop device after
exit of losetup -d or umount and need of "udevadm settle".

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.8.adoc | 2 +-
 sys-utils/umount.8.adoc  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
index 9ea9451ce..e22e650b8 100644
--- a/sys-utils/losetup.8.adoc
+++ b/sys-utils/losetup.8.adoc
@@ -54,7 +54,7 @@ The _size_ and _offset_ arguments may be followed by the multiplicative suffixes
 Show the status of all loop devices. Note that not all information is accessible for non-root users. See also *--list*. The old output format (as printed without *--list*) is deprecated.
 
 *-d*, *--detach* _loopdev_...::
-Detach the file or device associated with the specified loop device(s). Note that since Linux v3.7 kernel uses "lazy device destruction". The detach operation does not return *EBUSY* error anymore if device is actively used by system, but it is marked by autoclear flag and destroyed later.
+Detach the file or device associated with the specified loop device(s). Note that since Linux v3.7 kernel uses "lazy device destruction". The detach operation does not return *EBUSY* error anymore if device is actively used by system, but it is marked by autoclear flag and destroyed later. Even if the device is not used, the loop device can be destroyed later. If you need to wait for a complete removal of the loop device, call *udevadm settle* after *losetup*.
 
 *-D*, *--detach-all*::
 Detach all associated loop devices.
diff --git a/sys-utils/umount.8.adoc b/sys-utils/umount.8.adoc
index f9b96e1ff..b9a3ff963 100644
--- a/sys-utils/umount.8.adoc
+++ b/sys-utils/umount.8.adoc
@@ -127,6 +127,8 @@ The *umount* command will automatically detach loop device previously initialize
 
 In this case the device is initialized with "autoclear" flag (see *losetup*(8) output for more details), otherwise it's necessary to use the option *--detach-loop* or call *losetup -d* _device_. The autoclear feature is supported since Linux 2.6.25.
 
+Note that since Linux v3.7 kernel uses "lazy device destruction". The system just marks the loop device by autoclear flag and destroys it later. If you need to wait for a complete removal of the loop device, call *udevadm settle* after *umount*.
+
 == EXIT STATUS
 
 *umount* has the following exit status values (the bits can be ORed):
-- 
2.45.0

