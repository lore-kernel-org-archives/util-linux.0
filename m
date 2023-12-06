Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D0D51
	for <util-linux@vger.kernel.org>; Wed,  6 Dec 2023 11:18:19 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 364531FD30
	for <util-linux@vger.kernel.org>; Wed,  6 Dec 2023 19:18:16 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CD32413403
	for <util-linux@vger.kernel.org>; Wed,  6 Dec 2023 19:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GvmYJ/fIcGUCXgAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>)
	for <util-linux@vger.kernel.org>; Wed, 06 Dec 2023 19:18:15 +0000
Date: Wed, 6 Dec 2023 13:19:17 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] more: exit if POLLHUP or POLLERR on stdin is received
Message-ID: <2eb7rt74ljbdfj2t4psk7qteiwgpab45nyyuzozvy4omxt4xxe@hfbfxuqaeq3x>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 364531FD30
X-Spam-Level: 
X-Spam-Score: 0.49
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 PREVIOUSLY_DELIVERED(0.00)[util-linux@vger.kernel.org];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 MID_RHS_NOT_FQDN(0.50)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of rgoldwyn@suse.de) smtp.mailfrom=rgoldwyn@suse.de
X-Rspamd-Server: rspamd1


more command continues to run in case stdin have closed the file and it
takes 100% of CPU. This is because revents on stdin send
POLLIN | POLLHUP | POLLERR once stdin is closed. more receives it even
though it is not requested in events. This is common Linux behaviour to
never mask out POLLHUP or POLLERR. The loop in more_key_command() runs
infinitely because more_poll() returns 0 and read_command() reads 0
bytes.

Steps to reproduce:
1. Setup /etc/systemd/logind.conf with KillUserProcesses=no
2. Add config "Defaults use_pty" in /etc/sudoers
3. Start an ssh session to the machine
4. # sudo su -
5. # more <big enough file>
6. kill the parent ssh process, say close the tab

At this time "more" runs with 100% CPU utilization.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/text-utils/more.c b/text-utils/more.c
index d4db3d5eb..6ab9dfe40 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1392,6 +1392,11 @@ static int more_poll(struct more_control *ctl, int timeout)
 			abort();
 		}
 	}
+
+	/* Check for POLLERR or POLLHUP in revents */
+	if (pfd[1].revents & (POLLHUP | POLLERR))
+		more_exit(ctl);
+
 	if (pfd[1].revents == 0)
 		return 1;
 	return 0;

-- 
Goldwyn
