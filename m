Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBAC8CE
	for <util-linux@vger.kernel.org>; Thu,  7 May 2026 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778112852; cv=none; b=D1e4xJUeQdTCE68rCBI3B54f0gP4nu+qjfHGuYiXf8ochtUYcxjWbknqFpeP0cq8BZaRN6K5sh/p1wubMI7FDOiuwLR9ulMooK4nm40fdTPw7mBwqcu2gFeeAZgnW43/4QJyONp7bMpkSKmYdgeXf5Yne5yvLxjJW8MkanjeYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778112852; c=relaxed/simple;
	bh=2LmOTSDwRPC7Kv0A1f+oYq1uU17RJ8aDGe+WfVMo830=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aWkrHmnhu1Vhq7MWLdG5SljvuyGLSe5OA3DdI3AsR8WPAm/VNQBlh/tMwA5Fw/cX0tbmvIlYHvnbiTglYBPOHgt5/MFBn3FcmYuE1YreDYzI4ZOH7lJofchErVmbUu0PZ1KzUOVxJ23CDIcPsQcLaKPizHE6oERBF8oVCr2gtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWh5LBto; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ufVWbb/m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWh5LBto; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ufVWbb/m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWh5LBto";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ufVWbb/m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWh5LBto";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ufVWbb/m"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A51E66BD2C
	for <util-linux@vger.kernel.org>; Thu,  7 May 2026 00:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778112848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bAcIX1lrdGQgSU2NS0S7zx4+bYOyJRgXEPu0wRYQldU=;
	b=IWh5LBtogBihQgeZ1JlPvwA/QscaKkDwmM2M6K2nNAX7lOgfoYBPDe2/x2VZMqW/qCofzc
	Owm+crWb1f2nalb+fRLCBNrnnmRhR/wVbh3A/NJnD/v2JDmlxdS4WyyyZ64M7qSc8NmOZv
	JuL48X7+3Orn1d744a/6lwwyicJogpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778112848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bAcIX1lrdGQgSU2NS0S7zx4+bYOyJRgXEPu0wRYQldU=;
	b=ufVWbb/mjTeS3KatWQ35ZafDVzSX0vqV7GjMN80IgBz+s5ud92E+3PsQX12wk4Uht218Pl
	UfqXg/vCJwwy9XCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IWh5LBto;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ufVWbb/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778112848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bAcIX1lrdGQgSU2NS0S7zx4+bYOyJRgXEPu0wRYQldU=;
	b=IWh5LBtogBihQgeZ1JlPvwA/QscaKkDwmM2M6K2nNAX7lOgfoYBPDe2/x2VZMqW/qCofzc
	Owm+crWb1f2nalb+fRLCBNrnnmRhR/wVbh3A/NJnD/v2JDmlxdS4WyyyZ64M7qSc8NmOZv
	JuL48X7+3Orn1d744a/6lwwyicJogpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778112848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bAcIX1lrdGQgSU2NS0S7zx4+bYOyJRgXEPu0wRYQldU=;
	b=ufVWbb/mjTeS3KatWQ35ZafDVzSX0vqV7GjMN80IgBz+s5ud92E+3PsQX12wk4Uht218Pl
	UfqXg/vCJwwy9XCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E5E7593A7
	for <util-linux@vger.kernel.org>; Thu,  7 May 2026 00:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XAK0HFDZ+2lCZgAAD6G6ig
	(envelope-from <sbrabec@suse.cz>)
	for <util-linux@vger.kernel.org>; Thu, 07 May 2026 00:14:08 +0000
Message-ID: <b823a85e-79c0-4511-8a10-6ea8b8bf731e@suse.cz>
Date: Thu, 7 May 2026 02:14:05 +0200
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
Subject: strange falures of lsfd checks
Organization: SUSE Linux
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A51E66BD2C
X-Spam-Level: 

Hi.

I am just preparing util-linux-2.42 for the next SUSE product: Leap and 
SUSE Linux Enterprise 16.1.

I experienced a strange failures of several lsfd checks when running 
inside a qemu virtual machine and building in chroot. Surprisingly, 
problems are not consistently reproducible. It seems that parallel 
checksuite is more vulnerable to the failures. And the problem appears 
only in some build environments.

I cannot cleanly say it is a regression, as 2.41.2 fails on some build 
machines as well.

Did anybody experience similar problems?

Failing tests:

tests/ts/lsfd/option-hyperlink: Leaves a running task (tee?) and never 
finishes.

tests/ts/lsfd/option-inet:  Leaves a running task (tee?) and never finishes.

Note that the build environment is limited and does not support UDP 
networking.

-- Stanislav Brabec

