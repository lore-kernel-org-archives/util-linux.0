Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD773A28B
	for <util-linux@vger.kernel.org>; Mon, 18 Mar 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783583; cv=none; b=D4YZjBUH+QN7gTKTE+iEFh/wVY49+KOFxWrq4P6yeYtYr8OvWlSPfrmJ94w51z7Se4mC7okIrH3mGlxWvH4HGqSbfOPcO+QvDQADrVwtdxwapK56F4sUF7IsCnu1pLwypivoCe0xtvuzfu3uF2TNaINqCC1eunab1YGkW1iu7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783583; c=relaxed/simple;
	bh=stWeLL8OuC1pqsgKGgRohGU6xwZGYbAkmLfZWahmxNM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tfvAmpaOKDw+qOdzLwzL+mz7esxv6mXyjQ06TYBwcnGg9uLygR6BzE85pkNJqQpKwejNkvjLmkAPaDs1DvTn9y2Rl1f7vPhLlUghAPzGYJZ3IXH2FuCCHngUujnWpELoDLxGF9GSKkRkUsVf7olFIWTuUFoZSbDuzQoprqT17HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JySe2bS9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fXUaw+Fq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H0gdZhMm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96BMMrFm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JySe2bS9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fXUaw+Fq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H0gdZhMm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96BMMrFm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE99E34D0E;
	Mon, 18 Mar 2024 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710783578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zxhef9sQolMd+CTqhsDbxZA0L73+WsTJJWJAei+QIcI=;
	b=JySe2bS9LPVfZxQbKpNC3rbvyU9SKvKfWp5WemqmJBbx6Tb6XuznF8/FNjxDEJrPqDyVTI
	1ZeJo8GBopMmRL1N7oMNrGJ5C7l7zQrNxD2rZf1cfZL+ToOGdOau5j4OvFpT5Gqa/CGxZT
	HCRkffymUWTdxTtn+5C2RHc2zR3KqXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710783578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zxhef9sQolMd+CTqhsDbxZA0L73+WsTJJWJAei+QIcI=;
	b=fXUaw+Fqbsh5goAqZQVWWoEucg3LG78CURU0Vem484wJtXE84TeakRU/GcSdNPw29UmrLS
	GbtAKVttCb+o4pDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710783576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zxhef9sQolMd+CTqhsDbxZA0L73+WsTJJWJAei+QIcI=;
	b=H0gdZhMmxYN959ATFSdrlmf/N+wGpVO8hM+hniwvhmDJuZplyBFHAcrG1G+M7IrBJYk+oA
	7QzOiIs3eLV/llJAz05QDJ/MtYQwSdt1CMpDYQMBGnH+PO6P/VlEVHj8qlF+rI/jH6jDR/
	CCf3Zhzi4rKsB8Bdx/K7ss1GgGncO2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710783576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zxhef9sQolMd+CTqhsDbxZA0L73+WsTJJWJAei+QIcI=;
	b=96BMMrFm0BhuzEsgMr9opwnupwUW3PbghrAQN8O4fTpZauu9HXawSXIRXlZ/LGEeQrHluH
	ZpMuUXnMA1LkGhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC9791349D;
	Mon, 18 Mar 2024 17:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ETgDKVh8+GWAfgAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Mon, 18 Mar 2024 17:39:36 +0000
Message-ID: <52efc277-463c-441e-8284-595cefa254e9@suse.cz>
Date: Mon, 18 Mar 2024 18:39:36 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Cc: Heikki Ylipiessa <heikki.ylipiessa@suse.com>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] chcpu(8): document limitations of -g
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.50
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.50 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,suse.cz:url];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H0gdZhMm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=96BMMrFm
X-Rspamd-Queue-Id: BE99E34D0E

Document that chcpu -g is not supported on IBM z/VM because the detach cpu
would CLEAR the running zVM guest memory.

References:
https://www.ibm.com/docs/en/linux-on-z?topic=mc-changing-state-1
https://www.ibm.com/docs/en/zvm/7.3?topic=commands-detach-cpu

Reported-by: Heikki Ylipiessa <heikki.ylipiessa@suse.com>
Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
  sys-utils/chcpu.8.adoc | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/sys-utils/chcpu.8.adoc b/sys-utils/chcpu.8.adoc
index c5797dfb3..5b28ef8d2 100644
--- a/sys-utils/chcpu.8.adoc
+++ b/sys-utils/chcpu.8.adoc
@@ -37,6 +37,8 @@ Enable the specified CPUs. Enabling a CPU means that 
the kernel sets it online.

  *-g*, *--deconfigure* _cpu-list_::
  Deconfigure the specified CPUs. Deconfiguring a CPU means that the 
hypervisor removes the CPU from the virtual hardware on which the Linux 
instance runs and returns it to the CPU pool. A CPU must be offline, see 
*-d*, before it can be deconfigured.
++
+*chcpu -g* is not supported on IBM z/VM, CPUs are always in a 
configured state there.

  *-p*, *--dispatch* _mode_::
  Set the CPU dispatching _mode_ (polarization). This option has an 
effect only if your hardware architecture and hypervisor support CPU 
polarization. Available _modes_ are:
-- 
2.43.0

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

