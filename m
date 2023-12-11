Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ALEZaF0T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gXraRz/6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ALEZaF0T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gXraRz/6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A9C9F
	for <util-linux@vger.kernel.org>; Mon, 11 Dec 2023 13:03:08 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63ECF1FBDD
	for <util-linux@vger.kernel.org>; Mon, 11 Dec 2023 21:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702328587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=BR5w9VWG+cuuacfwhtsf7szxynEGktrck/5pjuc6234=;
	b=ALEZaF0TI+i1MoFT8C+eAWuxA9bKVerPhig7/CR89ZmXhm72sfKduZ7omRbpwbtximU2OD
	EZXkoikChLqC7Gf1sy3Bd/eNfpxTJFym1q9n1BAOYuGGOAdI7NvRJtxIycuFle5gkMjYOz
	7O6APq9OviKPPgQFEpps1KbtA/8///M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702328587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=BR5w9VWG+cuuacfwhtsf7szxynEGktrck/5pjuc6234=;
	b=gXraRz/6Sh5q3EcGXbZeG3uWOBOyWRzsaz0Of9HBUAEzncthviIfadOXgTX9zDN4gDRclC
	PphqX11H2RICqSCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702328587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=BR5w9VWG+cuuacfwhtsf7szxynEGktrck/5pjuc6234=;
	b=ALEZaF0TI+i1MoFT8C+eAWuxA9bKVerPhig7/CR89ZmXhm72sfKduZ7omRbpwbtximU2OD
	EZXkoikChLqC7Gf1sy3Bd/eNfpxTJFym1q9n1BAOYuGGOAdI7NvRJtxIycuFle5gkMjYOz
	7O6APq9OviKPPgQFEpps1KbtA/8///M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702328587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=BR5w9VWG+cuuacfwhtsf7szxynEGktrck/5pjuc6234=;
	b=gXraRz/6Sh5q3EcGXbZeG3uWOBOyWRzsaz0Of9HBUAEzncthviIfadOXgTX9zDN4gDRclC
	PphqX11H2RICqSCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E87AF134B0
	for <util-linux@vger.kernel.org>; Mon, 11 Dec 2023 21:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BgGsLAp5d2X0SgAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>)
	for <util-linux@vger.kernel.org>; Mon, 11 Dec 2023 21:03:06 +0000
Date: Mon, 11 Dec 2023 15:04:07 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: util-linux@vger.kernel.org
Subject: logger: should priority come before octet-count?
Message-ID: <qudzfymzxye6dofpgzhjsemss6zykiymyr6ujr4fmq3ah2dai6@dnb5zen5j3zd>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spam-Score: -0.31
X-Spamd-Result: default: False [-0.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	 TO_DN_NONE(0.00)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 MID_RHS_NOT_FQDN(0.50)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.09)[-0.444];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.43)[78.48%]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -0.12
Authentication-Results: smtp-out2.suse.de;
	none

Hi,

When providing --octet-count with --rfc5424, the message prefixes the
message length on the message. This however comes before priority, and
the syslog message looks like:

120 <13>1 2023-12-11T14:22:08.433695-06:00 kora root - rsyslog_dbg [timeQuality tzKnown="1" isSynced="0"] dummy goes to town

If you notice, <13> is shown in the message itself, as opposed to be
interpreted as priority by the logging process.

Command: ./logger --rfc5424 --octet-count --stderr  --socket /dev/log "dummy goes to town"

Without --octet-count, the message is fine comes out fine.

-- 
Goldwyn
