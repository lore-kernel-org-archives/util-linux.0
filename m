Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D301ACEAC
	for <util-linux@vger.kernel.org>; Thu, 29 May 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533406; cv=none; b=Lf3FmPm6sZMhPiKlipiLfWSw5mVuluTu5T7gS32Yyh2RjuDUN6BQxyVUWCzYlUo5zdKVTF1HoOeXb6ArIeUiLNxbIivThHumaobP2NPP9t5jsN40V/YcQdecVGcp6Edlxjooap1yulGOOM/tUQ2m4f5naiGc0tQK5Y/iukRvt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533406; c=relaxed/simple;
	bh=086sxcmANqoiiSoXQRoAyFisJjPz36whP8Uwkpwb64g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzC0Tdr95DvytrJrVs1zzawhP4fZ5qpixVE9ZJiUKi217C8XIxo6rkehgs7Tl3zFgJpeUADlfeMgp2CYE11gNZu/b4odwl/MJKjoj038CDZXScOjJc/4ESoI8h5Q0wxtbFrMICC2R5Hrz3yP6ISdSVMN2vpeTh8+aO8Un7nAcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIwtQB+n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4VYsIUEB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIwtQB+n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4VYsIUEB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIwtQB+n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4VYsIUEB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIwtQB+n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4VYsIUEB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CB4F219E8;
	Thu, 29 May 2025 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748533403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sAJceglWdK2n/TMyr1l4jbxCMUr8KJeqWrAtMuJwfU=;
	b=CIwtQB+ndRBkI3/Jo5WYN/tjAYUaCn4E+kjax0Uj3XO5stVMf/AtaPn2sdBIakiyA1c4ty
	gaS/kTGQ9qTUngCGcYcik8VWR++k+S1+NhsMN8qQnGLop6KnN6zspBuhI/fNw8DABO3H+2
	NawOPoq3M9oDwC7aH7Z1/qJVjStRGWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748533403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sAJceglWdK2n/TMyr1l4jbxCMUr8KJeqWrAtMuJwfU=;
	b=4VYsIUEBaEMiUUfPn7smXgX1KypiStwgjoYcWvnY5Wrc0PHibsb3Yiqq/0xI//OA75z3kn
	bQmdWV48rRhBWRAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CIwtQB+n;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4VYsIUEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748533403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sAJceglWdK2n/TMyr1l4jbxCMUr8KJeqWrAtMuJwfU=;
	b=CIwtQB+ndRBkI3/Jo5WYN/tjAYUaCn4E+kjax0Uj3XO5stVMf/AtaPn2sdBIakiyA1c4ty
	gaS/kTGQ9qTUngCGcYcik8VWR++k+S1+NhsMN8qQnGLop6KnN6zspBuhI/fNw8DABO3H+2
	NawOPoq3M9oDwC7aH7Z1/qJVjStRGWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748533403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sAJceglWdK2n/TMyr1l4jbxCMUr8KJeqWrAtMuJwfU=;
	b=4VYsIUEBaEMiUUfPn7smXgX1KypiStwgjoYcWvnY5Wrc0PHibsb3Yiqq/0xI//OA75z3kn
	bQmdWV48rRhBWRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE37E13325;
	Thu, 29 May 2025 15:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pir6MpqAOGjlWQAAD6G6ig
	(envelope-from <sbrabec@suse.cz>); Thu, 29 May 2025 15:43:22 +0000
Message-ID: <052ba29a-6796-4a83-9ad4-8f25d45279f3@suse.cz>
Date: Thu, 29 May 2025 17:43:13 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: util-linux-2.41 breaks static build of btrfs-progs
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <ddfd6167-e88f-4505-8768-a9d8e1d5cc92@suse.cz>
 <hu24dycwyxog44t6ttqidg5nkiczrufq3r3gy6slkgdubt55p4@7b6blpi2xciu>
Content-Language: en-US
From: Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <hu24dycwyxog44t6ttqidg5nkiczrufq3r3gy6slkgdubt55p4@7b6blpi2xciu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:url,suse.cz:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0CB4F219E8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

Karel Zak wrote:
> On Sun, Apr 20, 2025 at 09:24:43PM +0200, Stanislav Brabec wrote:
>> The question is:
>> Should be this fixed by util-linux by prefixing of ul_ to all symbols that
>> are not declared as static?
> I have added the "ul_" prefix to some functions to make the names less
> generic: https://github.com/util-linux/util-linux/pull/3569
>
> I'm going to backport it to stable/v2.41 too.
Done:
https://github.com/util-linux/util-linux/pull/3603
btrfs-progs-v6.14 static build works again out of the box.

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

