Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39124262A6
	for <util-linux@vger.kernel.org>; Sun, 20 Apr 2025 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177104; cv=none; b=Xx4vGoE914/g73GTRdzJPKp0j9pjLneYwHZ9AjT2sUIQX1wi+xDWP2YSzjAmJ8aqDt2ubFy8CIeDhOx16nUB3o9I2X4GjdEiD58xwfnifsURVEyo1aioXCYNoIE8Dup7etn1v4R7uHfBTUIKNWU+PZXHn6phpEQ7pUz0kmiKjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177104; c=relaxed/simple;
	bh=e5lDOZX5uoLolL7NqLRoW4+3H42zBQBtVUs0L9kxC/E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Wtr3L8FtDe/LL2DGUf40vAtqYr3Vh3CZ4NIM1xoEofrWZNmtH483JmsZ4FFH/y9yhx7nkB0nAj9CdA06YHQSX/DXzGM2gerBqWGWHpeX/N8fGl4RfOOdD3lWGPDH1p472MJn2sN6Q775NDNeXy3EjxhGGl3PzzWmpc+uGy/oj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R0q/7Nvn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Loyjen0x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XF4KvIjH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bscv3kul; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R0q/7Nvn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Loyjen0x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XF4KvIjH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bscv3kul"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB5B0211CD
	for <util-linux@vger.kernel.org>; Sun, 20 Apr 2025 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745177100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UuiXbSlt22E4x2xJ7lxfmhrQQOHc4qW8PyLZS3JTEYk=;
	b=R0q/7NvnrMKHlngoASmaJdH1UmPtW7IUq0DkMs31Ml1NUF0Q+IrsAYOlaaYsJVQEAE10jP
	cBAsHhRCfbBFmN8J5Zsz7/7eSEduXdB9Le/7sCyEP7rJkV2Cy4PwibafGPyGGNRCNL5/5j
	pKt8CYhfy56OHo2yoD9FayeqL9PaETw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745177100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UuiXbSlt22E4x2xJ7lxfmhrQQOHc4qW8PyLZS3JTEYk=;
	b=Loyjen0xIcdZVeh9iZaBgCsU4yvTU9i8tLSLVo2ArgJxspv5Ei0tgNnxUbVND2CKIDX1US
	P4Ok+pUNjGmnLVAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XF4KvIjH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bscv3kul
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745177099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UuiXbSlt22E4x2xJ7lxfmhrQQOHc4qW8PyLZS3JTEYk=;
	b=XF4KvIjHjc4VxStRZUDNCzTb2W/+x/yRGA2BBYPytzSyuDN9BAtGmy+GHww63eW7gkF6BN
	2StdnGU3VDjKXrtAZEmPrgJX5ldemrZsGPutrwWChOhsuqnUv5T+wNX4zu+oy6yG7PGn7h
	MIGdtCu1heoQpxpLraWk/UgDH9aHm1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745177099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UuiXbSlt22E4x2xJ7lxfmhrQQOHc4qW8PyLZS3JTEYk=;
	b=bscv3kul6dJPXtnnh5omUeyJtUKYV5Q2N2xktWKKPukk9MYWVTfcZIrYyTEsDuijudS7F6
	1+0oT7UzmEm1NIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDF9F13A6A
	for <util-linux@vger.kernel.org>; Sun, 20 Apr 2025 19:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rz1xLwtKBWgQMQAAD6G6ig
	(envelope-from <sbrabec@suse.cz>)
	for <util-linux@vger.kernel.org>; Sun, 20 Apr 2025 19:24:59 +0000
Message-ID: <ddfd6167-e88f-4505-8768-a9d8e1d5cc92@suse.cz>
Date: Sun, 20 Apr 2025 21:24:43 +0200
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
Subject: util-linux-2.41 breaks static build of btrfs-progs
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB5B0211CD
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Static build of btrfs-progs fails with util-linux-2.41 with a simple 
problem:
Symbol parse_range becomes visible in libblkid.a, breaking parse-utils.c 
in btrfs-progs, using the same symbol.

The question is:
Should be this fixed by util-linux by prefixing of ul_ to all symbols 
that are not declared as static?
Or should it be fixed by btrfs-progs?
Or could there be applied any type of symbol hiding in the static library?

/usr/lib64/gcc/x86_64-suse-linux/14/../../../../x86_64-suse-linux/bin/ld: 
/usr/lib64/gcc/x86_64-suse-linux/14/../../../../lib64/libblkid.a(libcommon_la-strutils.o): 
in function `parse_range':
[   29s] 
/home/abuild/rpmbuild/BUILD/util-linux-2.41-build/util-linux-2.41/lib/strutils.c:867: 
multiple definition of `parse_range'; common/parse-utils.static.o 
(symbol from plugin):(.text+0x0): first defined here

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

