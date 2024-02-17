Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22157E0FB
	for <util-linux@vger.kernel.org>; Sat, 17 Feb 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200077; cv=none; b=NyiLQJV1D5SyE8Js1WDWI472oDf3BwlDRdWkd0JNGqfknm9APXGEV8NBX5oCJMQtkVuyeQV+y6+sqcsQC0Agr5sJI27aAWCu0lF/PfDDCkVbEO2OeUs4dyeGiGfMlxyCDLPwAE49YoioyIVV3M2y33ib9mVbywoXgBpYNcuDBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200077; c=relaxed/simple;
	bh=cdTzkxuNjnWIX8QBiLoMxfSelGf9Mu8XpkuGU1RgZQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovFJqYwbIXn17kMETaWHd+OfRtuhmMCQR0YFkdf/m91lbGopKIw49cJfyERngp13+9cPt4tqU2BEGysPl9uu68K3FUIWBeOzYucRrjA/wt+vDVMNaNQgRxqFkZtbe+cySEZcyrr/XzHLKCL2TNVF4OElPS7Wofd40CnpoG8e87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLgVRCtg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=72CPqUyF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLgVRCtg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=72CPqUyF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLgVRCtg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="72CPqUyF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLgVRCtg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="72CPqUyF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 271EF1FD3C;
	Sat, 17 Feb 2024 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708200068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28zGYk2yAqBk/Lf60Q/0akL65YcdwVDidENYOOTipSg=;
	b=VLgVRCtgxsm1+9FivH4+eQSnDt6U+hM+f8YMIHDO5IvzF5JzYqhykgISnjouT4O2gVa3dw
	LwLqfVP+QEdJyiw0C8z8PxqG+EZNkiF0xWJuloI7d+iP8KnYTa/O/eVD+Zh0i40WqTLcFT
	XHCPWZTTyuCHJl1pOrQVbiA7wR13t00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708200068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28zGYk2yAqBk/Lf60Q/0akL65YcdwVDidENYOOTipSg=;
	b=72CPqUyF/w3WA+PzoDVcy1qJyYmy5HvFbynyycScf8oPd/H1iSlrwmzwfxnGVgvNjcUDS6
	gPkgK6QrUmVeSyBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708200068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28zGYk2yAqBk/Lf60Q/0akL65YcdwVDidENYOOTipSg=;
	b=VLgVRCtgxsm1+9FivH4+eQSnDt6U+hM+f8YMIHDO5IvzF5JzYqhykgISnjouT4O2gVa3dw
	LwLqfVP+QEdJyiw0C8z8PxqG+EZNkiF0xWJuloI7d+iP8KnYTa/O/eVD+Zh0i40WqTLcFT
	XHCPWZTTyuCHJl1pOrQVbiA7wR13t00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708200068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28zGYk2yAqBk/Lf60Q/0akL65YcdwVDidENYOOTipSg=;
	b=72CPqUyF/w3WA+PzoDVcy1qJyYmy5HvFbynyycScf8oPd/H1iSlrwmzwfxnGVgvNjcUDS6
	gPkgK6QrUmVeSyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17DFB1370C;
	Sat, 17 Feb 2024 20:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7474BIQQ0WWSBgAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Sat, 17 Feb 2024 20:01:08 +0000
Message-ID: <ed954c2e-8ae4-4133-874a-682c0c1fe20c@suse.cz>
Date: Sat, 17 Feb 2024 21:01:07 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Mention systemd implementation of fsck
Content-Language: en-US
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <adf1f630-a264-4db7-9777-d4e2de2bad3b@suse.cz>
 <20240214142342.x24dioosah2i27na@ws.net.home>
 <20240215093755.557tkkvtcnshaot4@ws.net.home>
From: Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <20240215093755.557tkkvtcnshaot4@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[18.39%];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.09

Dne 15. 02. 24 v 10:37 Karel Zak napsal(a):
> On Wed, Feb 14, 2024 at 03:23:45PM +0100, Karel Zak wrote:
>> What about:
>>
>> systemd does not invoke fsck -A to check all devices; instead, it
>> calls fsck individually for devices selected based on the logic
>> implemented in systemd-fsck.
> I had short discussion about it with Lennart, and he suggested not to
> document anywhere systemd-fsck as it's private systemd stuff. I have
> pushed to repository:
>
>    https://github.com/util-linux/util-linux/commit/9cb7b7671d903573d6c3b9d8112ec13953cdcdc6
It sound clear. I didn't want to document any details of the
implementation in the third party package and it will not need an
update in case of an systemd change.

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

