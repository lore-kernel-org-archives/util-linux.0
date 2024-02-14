Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800E1B818
	for <util-linux@vger.kernel.org>; Wed, 14 Feb 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913070; cv=none; b=K3fthhv5viykSUDLRjkkME1eyai6WAOooMqWkFBGicbEjfsq9pkGmedut1zlGAHBMbVSjGeTa8hFeJCFfN4n65u+vU0hGqO1a2IZhnZ7vGjzIG6QMPPWH7iRczPPZkA0VCOvXeyTY8FGXUMjDVYwzdWUQDkjJR1iffILU58dQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913070; c=relaxed/simple;
	bh=P3+A9N14kTGi+DNLftnk2OVi8kUEUfm3A/CdBz93FU4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gml/QZX0s2p8rGg2bccJo5RRNEoxHCDHbAAooR2vCdcua6OhXcXB5rHoyTgZnfJpSmrG7vSDP61jH1LZLPlU385XywrujWaLyBYgSPp5EC6gV/CkBU/6+CKRboj35H5UjWrhrD9LL9aBccwnCFGbxTippULzgcLHIad90KT4y+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8mYOkiD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5BrDzAkw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L8mYOkiD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5BrDzAkw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8mYOkiD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5BrDzAkw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L8mYOkiD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5BrDzAkw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FBB41F7F8
	for <util-linux@vger.kernel.org>; Wed, 14 Feb 2024 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707913067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y85vPArAdgGPyWSWpTJ3esGzDkWQ0ADJTfUR8n4N7DE=;
	b=L8mYOkiDoU5OA1LFcjXtMQSunyy7VvIMkQQh+GJC8bAMfHiSDxbJ5qTxkMAvp9+Y95IFWV
	WqSHpFPs4Xfwls6E3QLtU+PfsVvNzWTIy6mfNQwvAswbHW4FLTo7RtcnOdcW2/kyj57Kfn
	AHfPk7W+nl7PSN+f7e6l67vUAVyT4cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707913067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y85vPArAdgGPyWSWpTJ3esGzDkWQ0ADJTfUR8n4N7DE=;
	b=5BrDzAkwNSQ0ADOIB9df6yU2G2G2Oj/b2ePGtchgCH0XrW3QZRHQl4YVciULnQp+B1iccu
	h4hYWi+iJrjuwNBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707913067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y85vPArAdgGPyWSWpTJ3esGzDkWQ0ADJTfUR8n4N7DE=;
	b=L8mYOkiDoU5OA1LFcjXtMQSunyy7VvIMkQQh+GJC8bAMfHiSDxbJ5qTxkMAvp9+Y95IFWV
	WqSHpFPs4Xfwls6E3QLtU+PfsVvNzWTIy6mfNQwvAswbHW4FLTo7RtcnOdcW2/kyj57Kfn
	AHfPk7W+nl7PSN+f7e6l67vUAVyT4cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707913067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y85vPArAdgGPyWSWpTJ3esGzDkWQ0ADJTfUR8n4N7DE=;
	b=5BrDzAkwNSQ0ADOIB9df6yU2G2G2Oj/b2ePGtchgCH0XrW3QZRHQl4YVciULnQp+B1iccu
	h4hYWi+iJrjuwNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECC6C13A72
	for <util-linux@vger.kernel.org>; Wed, 14 Feb 2024 12:17:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ln9bOGqvzGXWZgAAD6G6ig
	(envelope-from <sbrabec@suse.cz>)
	for <util-linux@vger.kernel.org>; Wed, 14 Feb 2024 12:17:46 +0000
Message-ID: <adf1f630-a264-4db7-9777-d4e2de2bad3b@suse.cz>
Date: Wed, 14 Feb 2024 13:17:46 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: util-linux@vger.kernel.org
Content-Language: en-US
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] Mention systemd implementation of fsck
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.09

systemd uses its own implementation of fsck with a slightly different
behavior (e. g. fsck -A checks noauto volumes, systemd-fsck does not).
Refer to it.

It is a complementar change to
https://github.com/systemd/systemd/commit/000680a68d.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
  disk-utils/fsck.8.adoc | 4 ++++
  sys-utils/fstab.5.adoc | 2 ++
  2 files changed, 6 insertions(+)

diff --git a/disk-utils/fsck.8.adoc b/disk-utils/fsck.8.adoc
index 976e7ff08..4ba6f4cc1 100644
--- a/disk-utils/fsck.8.adoc
+++ b/disk-utils/fsck.8.adoc
@@ -151,6 +151,9 @@ enables libmount debug output.

  _/etc/fstab_

+== NOTES
+*systemd* does not call *fsck -A*, but it has its own implementation 
*systemd-fsck*(8).
+
  == AUTHORS

  mailto:tytso@mit.edu>[Theodore Ts'o],
@@ -169,6 +172,7 @@ mailto:kzak@redhat.com[Karel Zak]
  *fsck.vfat*(8),
  *fsck.xfs*(8),
  *reiserfsck*(8)
+*systemd-fsck*(8)

  include::man-common/bugreports.adoc[]

diff --git a/sys-utils/fstab.5.adoc b/sys-utils/fstab.5.adoc
index 1b972ef3b..0f12560e3 100644
--- a/sys-utils/fstab.5.adoc
+++ b/sys-utils/fstab.5.adoc
@@ -132,6 +132,8 @@ The proper way to read records from *fstab* is to 
use the routines *getmntent*(3

  The keyword *ignore* as a filesystem type (3rd field) is no longer 
supported by the pure libmount based mount utility (since util-linux v2.22).

+This document describes handling of *fstab* by *util-linux* and 
*libmount*. For *systemd*, read *systemd* documentation. There are 
slight differences.
+
  == HISTORY

  The ancestor of this *fstab* file format appeared in 4.0BSD.
-- 
2.43.0


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)
186 00 Praha 8-Karlín
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

