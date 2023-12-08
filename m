Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HUUZMcXE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="civIIzkQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HUUZMcXE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="civIIzkQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69210C0
	for <util-linux@vger.kernel.org>; Fri,  8 Dec 2023 07:07:48 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EA7A1F44E;
	Fri,  8 Dec 2023 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702048066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pavud8IuGszFd1Ee8s4L/L06Uo0Xd0aUZNBLNUXpO90=;
	b=HUUZMcXEWb2qpdmP2vee1IUQgiSKejXWZ21eaEtwqbkhQ7CAJUshP/tZKVIeIgNH6gsCJE
	SLAFmDtIfctd+v5R7gXINr8SU7dd1iAu8GyX8mPxNdsdnTfOGxDHhnX0Vhr0OOznDGmTkX
	udhqNQzdGAvLO9jzDLTJEwTZ2mDceFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702048066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pavud8IuGszFd1Ee8s4L/L06Uo0Xd0aUZNBLNUXpO90=;
	b=civIIzkQCQplyjuYH8vB43BZIXTGlCuPddThI1RkKrCglyp4gZopodKD1pV5ea05SigElO
	AEUO0yLjgw552PDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702048066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pavud8IuGszFd1Ee8s4L/L06Uo0Xd0aUZNBLNUXpO90=;
	b=HUUZMcXEWb2qpdmP2vee1IUQgiSKejXWZ21eaEtwqbkhQ7CAJUshP/tZKVIeIgNH6gsCJE
	SLAFmDtIfctd+v5R7gXINr8SU7dd1iAu8GyX8mPxNdsdnTfOGxDHhnX0Vhr0OOznDGmTkX
	udhqNQzdGAvLO9jzDLTJEwTZ2mDceFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702048066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pavud8IuGszFd1Ee8s4L/L06Uo0Xd0aUZNBLNUXpO90=;
	b=civIIzkQCQplyjuYH8vB43BZIXTGlCuPddThI1RkKrCglyp4gZopodKD1pV5ea05SigElO
	AEUO0yLjgw552PDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F2B49138FF;
	Fri,  8 Dec 2023 15:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZwPMMEExc2UXHQAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>); Fri, 08 Dec 2023 15:07:45 +0000
Date: Fri, 8 Dec 2023 09:08:48 -0600
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] more: exit if POLLHUP or POLLERR on stdin is received
Message-ID: <k46tstm6h5vosf3joft2tgz5pfvpgweu65a5yfv4pkzfqoqowy@xuvf2xhbgznk>
References: <2eb7rt74ljbdfj2t4psk7qteiwgpab45nyyuzozvy4omxt4xxe@hfbfxuqaeq3x>
 <20231208114519.5kitrxc4goqxolma@ws.net.home>
 <20231208123148.tbo36hrodsoqwln6@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208123148.tbo36hrodsoqwln6@ws.net.home>
X-Spam-Level: 
X-Spam-Score: -0.62
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.50
X-Spamd-Result: default: False [-1.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.70)[83.40%]
X-Spam-Flag: NO

On 13:31 08/12, Karel Zak wrote:
> 
>  Reverted. It seems tests/ts/more/regexp fails with the change. For
>  example: https://github.com/util-linux/util-linux/actions/runs/7140925530/job/19447184297

Oh yes, more should check for POLLERR only.

> 
>  It would be probably better to a create pull-request on GitHub to make
>  sure it passes and/or fix the test.
> 

Will do. Thanks.

-- 
Goldwyn
