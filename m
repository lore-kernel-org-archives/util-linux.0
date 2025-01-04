Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0149211C
	for <util-linux@vger.kernel.org>; Sat,  4 Jan 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736008130; cv=none; b=Tv8RiHO9QV24xyCWFFVvYsq+Sd65XQz6Gr6tIJnVZECGKI3HCQm3dZMtOGbOSIAxp3qmHHemAgCrnvPqc4r/p1OO3dYFhyIDa4Qu0HL/NqnlpN4yPZTIHdGqHhSeyHWULPj7RTDuQ4t0w8sBugODV5pokEwfD64RB2V5kJGdGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736008130; c=relaxed/simple;
	bh=XMnOrqcLiAXHN654S0YG+pL5dgi+fuSk7o5pioSsiRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tiAA+5FXfJs596QKkQiL9zERNXiCpZ0FRdO1I526h8MSxSEh8+7CXEkoveKdjOoxFTJQ/tXouFoJoQyMRdWooYNfsZ5nG2eLGkDF+lswdLGFEefJqzNbiI5omwKmxBP1TY+mrkcjBZD1qDejUbRE+GXcPGwY34XCEm9BLAZXAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GFj2T9Zx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hVlk5Sm2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GFj2T9Zx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hVlk5Sm2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GFj2T9Zx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hVlk5Sm2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GFj2T9Zx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hVlk5Sm2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C59E421153;
	Sat,  4 Jan 2025 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736008126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqnFnpKn4bXeWSgF583hEMWeiGbGsrRsvsv8hSpAPWA=;
	b=GFj2T9ZxyWW/mb8/KvZAGu8CeYA5SLUvF1tl8p6G+uVs5JYI8f0ycuouQD9S+cMX9yTtWS
	jm5WZImEs6yphldE9k5qxVIh9Md4Zavdk3xZ2AKkXuVVktQoMzjAbPOjohTSQ/WFBQmdLM
	1082a75sMZpasW8PV31lLXLika6jG/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736008126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqnFnpKn4bXeWSgF583hEMWeiGbGsrRsvsv8hSpAPWA=;
	b=hVlk5Sm2i7M+SjUoMCxfHR1cpdzGMcaaaiZ3AtEufriVExSUi5tiZ9bi66holia9+ozA44
	nXyLmhTX7ztrSFAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736008126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqnFnpKn4bXeWSgF583hEMWeiGbGsrRsvsv8hSpAPWA=;
	b=GFj2T9ZxyWW/mb8/KvZAGu8CeYA5SLUvF1tl8p6G+uVs5JYI8f0ycuouQD9S+cMX9yTtWS
	jm5WZImEs6yphldE9k5qxVIh9Md4Zavdk3xZ2AKkXuVVktQoMzjAbPOjohTSQ/WFBQmdLM
	1082a75sMZpasW8PV31lLXLika6jG/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736008126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqnFnpKn4bXeWSgF583hEMWeiGbGsrRsvsv8hSpAPWA=;
	b=hVlk5Sm2i7M+SjUoMCxfHR1cpdzGMcaaaiZ3AtEufriVExSUi5tiZ9bi66holia9+ozA44
	nXyLmhTX7ztrSFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1084137CF;
	Sat,  4 Jan 2025 16:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gUSAKr5heWclOAAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Sat, 04 Jan 2025 16:28:46 +0000
Message-ID: <c75c5f33-823e-497d-86be-5d62907e8439@suse.cz>
Date: Sat, 4 Jan 2025 17:28:46 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2.40.3 plan
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
Content-Language: en-US
From: Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Karel Zak wrote:
> If there is anything missing or if you would like to add something to
> the release, please let me know.

These would be nice iin 2.40 branch:


Merge branch 'PR/libmount-vfs-ro' that makes mountfd usable in most 
cases (but still not fully compatible):
4095c5bb6757b506acbe47a8bc60d8ebd04ba8a5
libmount: implement ro[=vfs,fs]
and
03b2e73ae649a957a4f695df4f44c2cbce8d5f92
libmount: improving readability

20b405c0fea29675e1fb54b894eb1c18459f9d50
agetty: Prevent cursor escape
Cosmetic fix, but visible.

50a3efab6d126b28fcdcc28f1a0cd5cd596ae357
lscpu: Skip aarch64 decode path for rest of the architectures
Ensures proper lscpu behavior.

fc67f18be51f57ee9a59a0f8f7ad16f284a24a3e
umount, losetup: Document loop destroy behavior
Just a doc update that explains unexpected behavior.

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

