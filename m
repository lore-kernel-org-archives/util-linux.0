Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA422A1E2
	for <util-linux@vger.kernel.org>; Fri, 16 May 2025 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382004; cv=none; b=Ggrgbr4Z6tkaAgw02nX8N1lZONqkvkQw1JKmO3jHw+Z0Qdjmq3CxS+fTe7fdZMAWzOJw1re5jrexl7Pz9o9ePsaDcuPAOPgbFGfBBZKJ5BPWotFTPNQg295qNdOc4+Czh7Av7Q4RVCVCa3lXyFLXZNODME/YkgMMnboKqYVKMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382004; c=relaxed/simple;
	bh=AJEuH4lbSbasRVtKddwRLEk6BPzVAPatTnRh7qXGNMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lb2tXuwTTa6lk8H0ejZdqom7ZBrUO8jHqsraKoLtT1QBPo/dmjAtXaXJoVerrGWwPir+VHTO4Vk9ytTWZzkIVSR9SNL8J4GWDr/5740h1ihrrJXn4DL/psh8oE8UvTjE2qsIOB8Gv0ucuOPK1bNAmQKZDc9meUwBPwYaRbTCbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMIrg56E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6E3XQWUf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMIrg56E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6E3XQWUf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMIrg56E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6E3XQWUf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMIrg56E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6E3XQWUf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B253D219BC;
	Fri, 16 May 2025 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747382000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJEuH4lbSbasRVtKddwRLEk6BPzVAPatTnRh7qXGNMk=;
	b=MMIrg56E37T9eSoLaI55j4sUn9Tt3uh6jcVuq7C713bZVbRXladZxxvO/efVZ7Q9f/l8N1
	OF7VdAeErrdnSODV066DEs6wwp9LeVz2Dt1QF8kZPYD6rngOKo7QtVT3BuQKDiScFJ1aBp
	UUuHEMW9nnS/XiocOS/VaeXExq5gomQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747382000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJEuH4lbSbasRVtKddwRLEk6BPzVAPatTnRh7qXGNMk=;
	b=6E3XQWUfD7W/LA+/Ip6Ucemi+S+TQ7rsVrjDfcUm6O5LqlxY5gQlGt2e+Bki/PCZHhR7HS
	oCPIlIewOE3sdvAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MMIrg56E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6E3XQWUf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747382000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJEuH4lbSbasRVtKddwRLEk6BPzVAPatTnRh7qXGNMk=;
	b=MMIrg56E37T9eSoLaI55j4sUn9Tt3uh6jcVuq7C713bZVbRXladZxxvO/efVZ7Q9f/l8N1
	OF7VdAeErrdnSODV066DEs6wwp9LeVz2Dt1QF8kZPYD6rngOKo7QtVT3BuQKDiScFJ1aBp
	UUuHEMW9nnS/XiocOS/VaeXExq5gomQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747382000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJEuH4lbSbasRVtKddwRLEk6BPzVAPatTnRh7qXGNMk=;
	b=6E3XQWUfD7W/LA+/Ip6Ucemi+S+TQ7rsVrjDfcUm6O5LqlxY5gQlGt2e+Bki/PCZHhR7HS
	oCPIlIewOE3sdvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A07F13977;
	Fri, 16 May 2025 07:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOe+JPDuJmjvSwAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Fri, 16 May 2025 07:53:20 +0000
Message-ID: <837b1cbe-8e14-46df-91b2-53a23cab3c75@suse.cz>
Date: Fri, 16 May 2025 09:53:19 +0200
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
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B253D219BC
X-Spam-Flag: NO
X-Spam-Score: -4.41
X-Spam-Level: 
X-Spamd-Result: default: False [-4.41 / 50.00];
	BAYES_HAM(-2.90)[99.59%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action

I forgot to mention:
https://bugzilla.opensuse.org/show_bug.cgi?id=1242705

with a full reproducer and backtrace

