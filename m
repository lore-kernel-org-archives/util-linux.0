Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6B370
	for <util-linux@vger.kernel.org>; Tue, 11 Jun 2024 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718064947; cv=none; b=EC2JrNyGqJRC3AcECLNHEVFEWGp2/S+wsA0H/yIoP1g/zPYDudWtK9NDgl7q89asolOmMlV/pE89WRtH6RoogtRmPBkDbUk3Ct+fzg5igtIXJcI6fjg+YE7ki0RZU1OM+A6LyZAnj4DpMq51fab+8NILW9tmIaHnCPkaFjtXnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718064947; c=relaxed/simple;
	bh=BjRzxN+aXChvJiI1rxzH4Dy0QrDLma9IOwTMKkGxWfo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qBGTKh39PYSkeukMr7USqpNlTkacAK7g0ybZ8f/A2DJ4QmoMNOV0krYCEivHIpwnJH31lwLtsTjR7bBl3PsM4x7FuoBEL4yklb1HUy+gs7hh2QBKvGeCWfsIIQAXwvFzFU3mXQzpT0mT5gKkaRoxCe04xrRu5dLW3Z2MY7prWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T+Jy1Q7V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+vbCfPtT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T+Jy1Q7V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+vbCfPtT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T+Jy1Q7V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+vbCfPtT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T+Jy1Q7V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+vbCfPtT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73D2A227E9
	for <util-linux@vger.kernel.org>; Tue, 11 Jun 2024 00:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718064937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O/pZCGnRsyD5nt8nQbO5DCfUljUC5YrWvObTaVF2T/A=;
	b=T+Jy1Q7VD8hhr7z4BRdA3R62OyCZoARfSUIrcITP5uSTndg/jPArtDiaonVOPFIQXOfbLi
	bnCCwk9jkkhEE0UA5P2hswYaafaA7f7T+rPORY3PrRqOAPgh6Ns/RZUuzNWPIpYEkL6+rU
	3lfP5LqUcwM0a6rNO8JDHQzlmIRCQ+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718064937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O/pZCGnRsyD5nt8nQbO5DCfUljUC5YrWvObTaVF2T/A=;
	b=+vbCfPtTCvcaF0fcqTbLJQ2ZDFEk04o5Yo5FzBHjt0OdIhifSQrNjH2U5791KULFKoiJMj
	WMQi4HnUzg2Ns3Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T+Jy1Q7V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+vbCfPtT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718064937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O/pZCGnRsyD5nt8nQbO5DCfUljUC5YrWvObTaVF2T/A=;
	b=T+Jy1Q7VD8hhr7z4BRdA3R62OyCZoARfSUIrcITP5uSTndg/jPArtDiaonVOPFIQXOfbLi
	bnCCwk9jkkhEE0UA5P2hswYaafaA7f7T+rPORY3PrRqOAPgh6Ns/RZUuzNWPIpYEkL6+rU
	3lfP5LqUcwM0a6rNO8JDHQzlmIRCQ+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718064937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O/pZCGnRsyD5nt8nQbO5DCfUljUC5YrWvObTaVF2T/A=;
	b=+vbCfPtTCvcaF0fcqTbLJQ2ZDFEk04o5Yo5FzBHjt0OdIhifSQrNjH2U5791KULFKoiJMj
	WMQi4HnUzg2Ns3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 652E0137DF
	for <util-linux@vger.kernel.org>; Tue, 11 Jun 2024 00:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0obCFymXZ2ZuXgAAD6G6ig
	(envelope-from <sbrabec@suse.cz>)
	for <util-linux@vger.kernel.org>; Tue, 11 Jun 2024 00:15:37 +0000
Message-ID: <8c649c26-93de-4edb-8dec-c87c243ee45d@suse.cz>
Date: Tue, 11 Jun 2024 02:15:36 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Content-Language: en-US
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] mount, losetup: Document loop destroy behavior
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 73D2A227E9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

The loop device detach runs asynchronously in the background. It can cause
unexpected errors. Document the possible existence of the loop device after
exit of losetup -d or umount and need of "udevadm settle".

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
  sys-utils/losetup.8.adoc | 2 +-
  sys-utils/umount.8.adoc  | 2 ++
  2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
index 9ea9451ce..e22e650b8 100644
--- a/sys-utils/losetup.8.adoc
+++ b/sys-utils/losetup.8.adoc
@@ -54,7 +54,7 @@ The _size_ and _offset_ arguments may be followed by 
the multiplicative suffixes
  Show the status of all loop devices. Note that not all information is 
accessible for non-root users. See also *--list*. The old output format 
(as printed without *--list*) is deprecated.

  *-d*, *--detach* _loopdev_...::
-Detach the file or device associated with the specified loop device(s). 
Note that since Linux v3.7 kernel uses "lazy device destruction". The 
detach operation does not return *EBUSY* error anymore if device is 
actively used by system, but it is marked by autoclear flag and 
destroyed later.
+Detach the file or device associated with the specified loop device(s). 
Note that since Linux v3.7 kernel uses "lazy device destruction". The 
detach operation does not return *EBUSY* error anymore if device is 
actively used by system, but it is marked by autoclear flag and 
destroyed later. Even if the device is not used, the loop device can be 
destroyed later. If you need to wait for a complete removal of the loop 
device, call *udevadm settle* after *losetup*.

  *-D*, *--detach-all*::
  Detach all associated loop devices.
diff --git a/sys-utils/umount.8.adoc b/sys-utils/umount.8.adoc
index f9b96e1ff..b9a3ff963 100644
--- a/sys-utils/umount.8.adoc
+++ b/sys-utils/umount.8.adoc
@@ -127,6 +127,8 @@ The *umount* command will automatically detach loop 
device previously initialize

  In this case the device is initialized with "autoclear" flag (see 
*losetup*(8) output for more details), otherwise it's necessary to use 
the option *--detach-loop* or call *losetup -d* _device_. The autoclear 
feature is supported since Linux 2.6.25.

+Note that since Linux v3.7 kernel uses "lazy device destruction". The 
system just marks the loop device by autoclear flag and destroys it 
later. If you need to wait for a complete removal of the loop device, 
call *udevadm settle* after *umount*.
+
  == EXIT STATUS

  *umount* has the following exit status values (the bits can be ORed):
-- 
2.45.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

