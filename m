Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uCslzr24";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="92qW/zU7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36140CA
	for <util-linux@vger.kernel.org>; Wed, 29 Nov 2023 09:35:28 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AF3F1F892
	for <util-linux@vger.kernel.org>; Wed, 29 Nov 2023 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701279326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0HGtB94mgA8327BLCVl/jUNpiKyDubGKgbaEczcBXcE=;
	b=uCslzr24ZxjJYShWyGbxJscsPVG2v7NXC1w2qb4auTV1ao3eVWgoB9UbPSWPRowLckBpCh
	mcJLXfgJImmhlnwt9gy/j/WCoWGGOxPwNV8RGs5mXpbW88An+yIy8tEeD1ZW8f4Hx9DN0Z
	FTq6jo/XYdufnPSgH8S4azkjziYS8sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701279326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0HGtB94mgA8327BLCVl/jUNpiKyDubGKgbaEczcBXcE=;
	b=92qW/zU7iZIePGITK0ytRaQ+21D3llzHnOIisxEDXrWufKIziSS2JTrxcY+m8H3H+Bul2q
	Cn6eVeCgalKYlTAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AF0541376F
	for <util-linux@vger.kernel.org>; Wed, 29 Nov 2023 17:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uPhDHV12Z2VJcgAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>)
	for <util-linux@vger.kernel.org>; Wed, 29 Nov 2023 17:35:25 +0000
Date: Wed, 29 Nov 2023 11:36:23 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] increase delay for waitpid test
Message-ID: <n26ts5nhsyoj2xbpxkhwcsq3tslz2nao6ef57tkkcj6ve7zxhv@4423dzinkagw>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.60
X-Spamd-Result: default: False [-0.60 / 50.00];
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
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]

In some test executions on s390x, the waitpid test fails because 1
gets printed before 2.

[  557s] --- /home/abuild/rpmbuild/BUILD/util-linux-2.39.2/tests/expected/misc/waitpid-normal	2023-06-14 09:11:15.910887765 +0000
[  557s] +++ /home/abuild/rpmbuild/BUILD/util-linux-2.39.2/tests/output/misc/waitpid-normal	2023-11-27 23:30:30.406675022 +0000
[  557s] @@ -1,4 +1,4 @@
[  557s]  3
[  557s] -2
[  557s]  1
[  557s] +2
[  557s]  4

Increase the time to print 1, so the test numbers are printed in
expected order.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


diff --git a/tests/ts/misc/waitpid b/tests/ts/misc/waitpid
--- a/tests/ts/misc/waitpid
+++ b/tests/ts/misc/waitpid
@@ -24,7 +24,7 @@ ts_check_test_command "$TS_CMD_WAITPID"
 
 ts_init_subtest normal
 
-(sleep 0.2; echo 1 >> "$TS_OUTPUT") &
+(sleep 0.5; echo 1 >> "$TS_OUTPUT") &
 BG1="$!"
 
 (sleep 0.1; echo 2 >> "$TS_OUTPUT") &

-- 
Goldwyn
