Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2E24677D
	for <util-linux@vger.kernel.org>; Tue, 20 May 2025 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751056; cv=none; b=fRnMnNUr1w5TvvD5mcyYcdggWoCdBe0PhmNtg7nuw2/fyMq9xZ0pZ1I6LNJhPri8lLAokquAP5NpTbi9DE8hMJRAF2OL2MKgQNIq+wn+CmYwJLaneP8T34DEqsh1ObGTqOq8kU3DaPZ/+g1Yl6XlAmNU2yVZIoPTQhw6QIJGyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751056; c=relaxed/simple;
	bh=IejTjLGwrJODrK7NG4f3C7QLKtLP77aucN3wXee5Ukk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxsqvE1pIM4/ucJmVd+cGcOr6ROuP4U9yxcemg3Bdg+qroFbVUC8MwxPW87EdA9W3zJGT+0Xt+XFr853xqJAmr/Li1XnD8B1AJnbfEz5BRtviMyPM0eC7NsUPBz6YBBuTGk6U8ETpiwJxfJuL43e384gorYsKBcI5+OgO3V0AhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFAGEUKE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LsYG+ioC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFAGEUKE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LsYG+ioC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFAGEUKE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LsYG+ioC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFAGEUKE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LsYG+ioC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0035D20741;
	Tue, 20 May 2025 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747751053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCS3aaYAfOu9ICDRpWZds7zkxmccSqfx/4TJGzsH1oo=;
	b=aFAGEUKELoLQ9ZbUi+OBaczwFEvY5Ium17iYdOhYDDoSZHJnEr79tyQbRhkLiiyRjbZbWX
	zaVewDIMSNViPgpJ0EMqW9bhN3ue+9YLGOyEU5R+TI5VHaS5msRONVR5ly/RYF5EPTOOAY
	Jmw8iDJogB7LVBrPE/H8KAwFZiCHHNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747751053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCS3aaYAfOu9ICDRpWZds7zkxmccSqfx/4TJGzsH1oo=;
	b=LsYG+ioC2oF6NpIUyV5dMNE2J3ayo06mYpKOA6xUkGrWynsANvsF2+sTg2gqRw9NOklwF3
	aCDsXI7+ZAcji/DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aFAGEUKE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LsYG+ioC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747751053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCS3aaYAfOu9ICDRpWZds7zkxmccSqfx/4TJGzsH1oo=;
	b=aFAGEUKELoLQ9ZbUi+OBaczwFEvY5Ium17iYdOhYDDoSZHJnEr79tyQbRhkLiiyRjbZbWX
	zaVewDIMSNViPgpJ0EMqW9bhN3ue+9YLGOyEU5R+TI5VHaS5msRONVR5ly/RYF5EPTOOAY
	Jmw8iDJogB7LVBrPE/H8KAwFZiCHHNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747751053;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xCS3aaYAfOu9ICDRpWZds7zkxmccSqfx/4TJGzsH1oo=;
	b=LsYG+ioC2oF6NpIUyV5dMNE2J3ayo06mYpKOA6xUkGrWynsANvsF2+sTg2gqRw9NOklwF3
	aCDsXI7+ZAcji/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2CBD13888;
	Tue, 20 May 2025 14:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J0I0MoyQLGi+IwAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Tue, 20 May 2025 14:24:12 +0000
Message-ID: <da40323d-e642-4535-9a9a-ce9054de0241@suse.cz>
Date: Tue, 20 May 2025 16:24:07 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libblkid: Fix crash while parsing config with libeconf
To: util-linux@vger.kernel.org
Cc: Stefan Schubert <schubi@suse.de>
References: <20250516013111.1099053-1-sbrabec@suse.cz>
Content-Language: en-US
From: Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <20250516013111.1099053-1-sbrabec@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 0035D20741
X-Spam-Level: 
X-Spam-Flag: NO

Stanislav Brabec wrote:
>As the whhole econf_file structure is freed by econf_free(file) at the end

> of blkid_read_config, econf_file structure cannot be defined as static and
> initialized only once. The econf_free() is not robust enough and keeps a
> pointer to the garbage after the first call. And if /etc/blkid.conf does
> not exist, it is called second time.

However the patch is correct and fixes the crash, there are still open questions:

- Why blkid_read_config() and econf_readConfig() are called twice with the same parameters? Is it intended behavior?

- If yes, why we don't recycle the configuration and call econf_free()?
- If not, why it happens?
- And finally, is a similar code in logindefs.c vulnerable to a similar type of crash?


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

