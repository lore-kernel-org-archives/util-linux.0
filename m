Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8EF16D9D0
	for <util-linux@vger.kernel.org>; Wed, 12 Jun 2024 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186668; cv=none; b=F8jSkLO5GHufsVi1o7Stt8085b31BWsv+CRmniIxHbiHcX5jYc53H7ws222Tf9D/k1kov5FlbSegyqirGb5eXz2c3WIETPEKHYSg4Hp18bB5qZR9UMbj1ABB1Dc9Hl50jR26O+MyuxQPOokyodKJPibLRe2nlE7RNX0NasjIS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186668; c=relaxed/simple;
	bh=Rk9i8fjWfT3Sle3gIYmZ3uq5e2/uRH6UEpEJcsQQ5EU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VBHX7Ou4xaO3Evf0dmdnfK5TvsUiRdYDLS+UkTz9aPW8XKmXFMEQDA8ncfyVKQcS9SGd19JHPVA07F9LtG+6M64YHxoYMIQz19lLTemR8DFGDln+YJtGGrGwzGbQ/2C2U9Fg+uLzeFftPcPvLAa02Bf4xk251JqBmI2Dshbp3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pr1cZC1l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/8wWOIJL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pr1cZC1l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/8wWOIJL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pr1cZC1l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/8wWOIJL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pr1cZC1l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/8wWOIJL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 728723413B
	for <util-linux@vger.kernel.org>; Wed, 12 Jun 2024 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718186662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtNfj8QbzXEvnVHHSUvWepwvTzU2tlcafGftc7LVNqs=;
	b=Pr1cZC1lJB0dIS1keQCG//TjFFhxJGK+rx30c5lgmV3L9iyTwNVgO93a1LB3ZsxLb6X2Wq
	f7dAFXVGn+Qcq9qdWUG4VzBdcXXOWHJDHwR9leUuyoQprLjtr5UGIOZYD8u6OzQif1QTOh
	rYhvhqttx3UYKmpdOf8qf1YMb/j/ND0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718186662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtNfj8QbzXEvnVHHSUvWepwvTzU2tlcafGftc7LVNqs=;
	b=/8wWOIJLarg+WbY8uLe6k6l/sTfp9feZaa4/BX6mOPIctgFsF8rzGtsl3UGhwUiJGffcDa
	LeYMgyJZovnwdBDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Pr1cZC1l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/8wWOIJL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718186662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtNfj8QbzXEvnVHHSUvWepwvTzU2tlcafGftc7LVNqs=;
	b=Pr1cZC1lJB0dIS1keQCG//TjFFhxJGK+rx30c5lgmV3L9iyTwNVgO93a1LB3ZsxLb6X2Wq
	f7dAFXVGn+Qcq9qdWUG4VzBdcXXOWHJDHwR9leUuyoQprLjtr5UGIOZYD8u6OzQif1QTOh
	rYhvhqttx3UYKmpdOf8qf1YMb/j/ND0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718186662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtNfj8QbzXEvnVHHSUvWepwvTzU2tlcafGftc7LVNqs=;
	b=/8wWOIJLarg+WbY8uLe6k6l/sTfp9feZaa4/BX6mOPIctgFsF8rzGtsl3UGhwUiJGffcDa
	LeYMgyJZovnwdBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65A851372E
	for <util-linux@vger.kernel.org>; Wed, 12 Jun 2024 10:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fzaHF6ZyaWb1eAAAD6G6ig
	(envelope-from <sbrabec@suse.cz>)
	for <util-linux@vger.kernel.org>; Wed, 12 Jun 2024 10:04:22 +0000
Message-ID: <70cdae6f-3b7d-41db-822a-9b3007fb7a05@suse.cz>
Date: Wed, 12 Jun 2024 12:04:21 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mount, losetup: Document loop destroy behavior
From: Stanislav Brabec <sbrabec@suse.cz>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <8c649c26-93de-4edb-8dec-c87c243ee45d@suse.cz>
Content-Language: en-US
Organization: SUSE Linux, s. r. o.
In-Reply-To: <8c649c26-93de-4edb-8dec-c87c243ee45d@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:url,suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 728723413B
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

It should be [PATCH] umount, losetup: Document loop destroy behavior.

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

