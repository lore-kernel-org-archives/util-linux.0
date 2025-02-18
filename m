Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4ED1E522
	for <util-linux@vger.kernel.org>; Tue, 18 Feb 2025 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843087; cv=none; b=rT6HnVz3QWLwpvcQz6kwmckI8x+CMrQU2tbQx0ULj54zszbb0DKtCXo6UGZxpAYxDJljZ9qnembAtwkWDNABSMyvw4gyqFiidhGDzguDaDDnmQr+xPLoepllIeggsb1Kfv5U3nISLNy/ijMCLMXjkatZFNjqMLskPEGRhPAxmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843087; c=relaxed/simple;
	bh=1mLFJpus5bLG+GdPxji1YeyPG8V3xSvPuDO0k704xVw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=p+4/yGbbupgMjFRqKPktYGl1kwid+4UOzQn9VTjzslHLh7PqwNv245EDdoKVFd+Oqh8egBiDPFcaitAEBZZn5eYFWqEXQEgSZEaKEYDfP6+SE1qwVffWMJwqWMxVkS2LQZsOMoSHVgfddWG1MdE8wzYKeHICpgeO/M/jFyjOvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqKpCsOo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXP76opH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jqKpCsOo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXP76opH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqKpCsOo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXP76opH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jqKpCsOo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXP76opH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76E1721111
	for <util-linux@vger.kernel.org>; Tue, 18 Feb 2025 01:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739843081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqUzy2w+7qZT8zT83ZWstUyyiLDD/YqPLpN3ofGS1Dk=;
	b=jqKpCsOob39kbvrd1SF56j5Rqk+vD7PM+nZrchArvQHPMLJ964EHTlGqXo+x6u+o44IHYg
	Y0Dukn8qgp1sd2utSWnEaS1yZSbVSRox9GCMMzDAKiT/qjsr6q1zb50fzXNt7CSMAhYovO
	C1SvPBlcgI9DMujHROzMZtR2iyb2mnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739843081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqUzy2w+7qZT8zT83ZWstUyyiLDD/YqPLpN3ofGS1Dk=;
	b=GXP76opHNgLHQ9vuqfVABzJ7kPgVNbh4Qqg/o7c4WGrDfWb/eGO0rKVriXWMpYRCJ/kHJW
	UCHiKXLdZl+4PaBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739843081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqUzy2w+7qZT8zT83ZWstUyyiLDD/YqPLpN3ofGS1Dk=;
	b=jqKpCsOob39kbvrd1SF56j5Rqk+vD7PM+nZrchArvQHPMLJ964EHTlGqXo+x6u+o44IHYg
	Y0Dukn8qgp1sd2utSWnEaS1yZSbVSRox9GCMMzDAKiT/qjsr6q1zb50fzXNt7CSMAhYovO
	C1SvPBlcgI9DMujHROzMZtR2iyb2mnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739843081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqUzy2w+7qZT8zT83ZWstUyyiLDD/YqPLpN3ofGS1Dk=;
	b=GXP76opHNgLHQ9vuqfVABzJ7kPgVNbh4Qqg/o7c4WGrDfWb/eGO0rKVriXWMpYRCJ/kHJW
	UCHiKXLdZl+4PaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FD2913AFD
	for <util-linux@vger.kernel.org>; Tue, 18 Feb 2025 01:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vx8cFgnms2dwaAAAD6G6ig
	(envelope-from <sbrabec@suse.cz>)
	for <util-linux@vger.kernel.org>; Tue, 18 Feb 2025 01:44:41 +0000
Message-ID: <7d0fd241-52cc-4d92-a0ce-5cdbf9b39a34@suse.cz>
Date: Tue, 18 Feb 2025 02:44:36 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [BUG?] agetty: issue printed twice
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:url,suse.cz:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi.

Depending on the config, the issue file may be printed twice. If both 
/run/issue and /etc/issue exist, both are printed. I am not sure, 
whether it is an intended behavior. And eventually it could be printed 
three times.

It is caused by:
     /* The default /etc/issue and optional /etc/issue.d directory as
      * extension to the file. The /etc/issue.d directory is ignored if
      * there is no /etc/issue file. The file may be empty or symlink.
      */
     if (access(_PATH_ISSUE, F_OK|R_OK) == 0) {
         issuefile_read(ie, _PATH_ISSUE, op, tp);
         issuedir_read(ie, _PATH_ISSUEDIR, op, tp);
     }

     /* Fallback @runstatedir (usually /run) */
     issuefile_read(ie, _PATH_RUNSTATEDIR "/" _PATH_ISSUE_FILENAME, op, tp);
     issuedir_read(ie, _PATH_RUNSTATEDIR "/" _PATH_ISSUE_DIRNAME, op, tp);

     /* Fallback @sysconfstaticdir (usually /usr/lib)*/
     issuefile_read(ie, _PATH_SYSCONFSTATICDIR "/" _PATH_ISSUE_FILENAME, 
op, tp);
     issuedir_read(ie, _PATH_SYSCONFSTATICDIR "/" _PATH_ISSUE_DIRNAME, 
op, tp);

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

