Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641D8C28CF5
	for <util-linux@archiver.kernel.org>; Wed, 26 Jan 2022 15:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiAZPHm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:07:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPHm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 26 Jan 2022 10:07:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9EE1B1F3B0;
        Wed, 26 Jan 2022 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643209661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7qauYc3p+utxrRQrmsV6QFHCFmLFumxzBzq5JsWKSU=;
        b=jhidxWKqGk0BBGQ7QY0tjigqTnbU5GbjvF+XjB3Q7mKG+yDoWGEz8S/I3eyrFCJcbtLy9B
        NMdkqFAOsyF5qPiY3fyu77y4QVniscZxNahWtMHtkUZmopIJuLa+3WefmbFUtn1QKamIvq
        x+vaECJ6o1Vjdgb45an8fMqvFt/gBAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643209661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7qauYc3p+utxrRQrmsV6QFHCFmLFumxzBzq5JsWKSU=;
        b=kAdO605KmWxmPp8FGQzRPIcRY+b/D+O48EvGjrMHJYUgj0X3hIgl0MHQklF7DlYr+1YfOU
        oPn+0RUT/7m13yAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 663B213C53;
        Wed, 26 Jan 2022 15:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M1aGF71j8WEuFQAAMHmgww
        (envelope-from <sbrabec@suse.cz>); Wed, 26 Jan 2022 15:07:41 +0000
Message-ID: <aae15301-3fca-b4b7-7832-7a84f309545e@suse.cz>
Date:   Wed, 26 Jan 2022 16:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] Whitelist libuuid clock file
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Ali Abdallah <ali.abdallah@suse.com>
References: <3f08fa1a-8efc-86d6-c492-7703f5b5ef38@suse.cz>
 <20220125105300.f3npvhr5emhvzevu@ws.net.home>
 <257bafee-3014-d3dc-ca4c-cc1f0504fca2@suse.cz>
 <20220125143032.p6otx2vhvft5qwu2@ws.net.home>
From:   Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <20220125143032.p6otx2vhvft5qwu2@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel Zak wrote:
> On Tue, Jan 25, 2022 at 12:37:09PM +0100, Stanislav Brabec wrote:
>> It happens only if more conditions are met:
>> - /var/lib/libuuid exists
>> - uuidd is not running nor socket activated
>> - uuigden --time is called as root
> And vice-versa, if you stop uuidd and start uuidgen as normal user you
> get EACCES for /var/lib/libuuid/clock.txt, but this use-case is
> probably not so important ...
"service uuidd stop" keeps socket activation enabled, so uuidgen 
launches uuidd again. No problem appears.

> What about to create a user specific clock state file if we cannot access
> the default one due to EACCES? Something like:
>
>   state_fd = open(LIBUUID_CLOCK_FILE, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
>   if (state_fd < 0 &7 errno == EACCES) {
>      snprintf(path, "%s-%d", LIBUUID_CLOCK_FILE, getuid());
>      state_fd = open(path, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
>   }
>
> so for the bad use-case:
>
>    /var/lib/libuuid/clock.txt
>    /var/lib/libuuid/clock.txt-<uuidd_uid>
It would work, but:
- It either needs pre-created files or world writable directory.
- It is a predictable name. In case of world writable directory, it is 
easy to perform denial of service.

> in theory it means two clock queues, but if uuidd is running then
> libuuid/getuuid always uses it.
Two clock queues are still better than no clock queue. And once uuidd 
starts, only clock.txt-uuidd will be in use. And it sysadmin decides to 
run system without uuidd, the it is still better than the previous state 
(only root or uuidd can use clock.txt)


Another ideas:
If uid is equal to "uuidd", use /var/lib/libuuid/clock.txt (or change to 
/var/lib/uuidd/clock.txt), else use home directory, e. g. 
~/.libuuid_clock.txt.

Or a separate service file: uuidd-clock.service with:
ExecStart=chown uuidd:uuidd /var/lib/libuuid/clock.txt
(That one would be still vulnerable to race condition attack. And it 
looks ugly.)

I like the home directory solution. It would never make things worse
> The important is that in this way we can be sure uuidd is always
> successful, and I guess the sensitive use-case (SAP;-) is always about
> uuidd. IMHO it's more robust then depend on systemd ExecStartPre (or
> so).
Sure, installations without uuidd can never guarantee absolute uniqueness.

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

