Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC9C433F5
	for <util-linux@archiver.kernel.org>; Tue, 25 Jan 2022 11:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356467AbiAYLls (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 25 Jan 2022 06:41:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58146 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381357AbiAYLhZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 25 Jan 2022 06:37:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B48E21901;
        Tue, 25 Jan 2022 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643110630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/faeNMIpHYZfagH+7yYruv9kXwlRkF4kTF6tKxTsjY=;
        b=IVCHh4Q2qkhoXTVNfBYe1iaDF/aVxzWxTbOqrEHNyScBAIfg0P8GWeMR6TyXlapynT+rG7
        ejN8JgdmFEbmuG1LcxiDh8h6+Y6qCVrjWuJu9okAqUiFHCOzuLWsxF3SdaXl6QXY91joaG
        0UZWHPL6BLSu/dvcIHJSR4/RrpB3ojs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643110630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/faeNMIpHYZfagH+7yYruv9kXwlRkF4kTF6tKxTsjY=;
        b=3ZRZqRpw5YzAY6XL/8hV78A2oPvKDmr6YaRV8Mi+wd3bzcpKtPYBqDHnBWnypHdAwMdT2Q
        +wmQu9bjrVs2dmAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0F7313DC8;
        Tue, 25 Jan 2022 11:37:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DT0QNOXg72GFEAAAMHmgww
        (envelope-from <sbrabec@suse.cz>); Tue, 25 Jan 2022 11:37:09 +0000
Message-ID: <257bafee-3014-d3dc-ca4c-cc1f0504fca2@suse.cz>
Date:   Tue, 25 Jan 2022 12:37:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] Whitelist libuuid clock file
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Ali Abdallah <ali.abdallah@suse.com>
References: <3f08fa1a-8efc-86d6-c492-7703f5b5ef38@suse.cz>
 <20220125105300.f3npvhr5emhvzevu@ws.net.home>
From:   Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <20220125105300.f3npvhr5emhvzevu@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel Zak wrote:
>
> OK, seems better than my solution ;-) Thanks!
Actually, I found a very exotic failure of uuidd accessing clock.txt, 
which is not yet covered:

ls -al /var/lib/libuuid/clock.txt
-rw-rw---- 1 root root 56 Jan 25 11:48 /var/lib/libuuid/clock.txt
i. e. root owned clock.txt

It happens only if more conditions are met:
- /var/lib/libuuid exists
- uuidd is not running nor socket activated
- uuigden --time is called as root

If this happens, /var/lib/libuuid/clock.txt is written as root:root by 
the code in libuuid/src/gen_uuid.c:get_clock(). When uuidd is started 
later, it is unable to use clock.txt.

It happens only in very special cases:
- util-linux is reinstalled from --without-uuidd to --with-uuidd
- util-linux is just being installed, and daemon nor socket activation 
are active yet
- start of uuidd fails for some exotic reason (out of memory, number of 
processes exhausted)

But if it happens, the problem stays forever.

So I think it should be addressed. But I am not sure how to fix it 
properly in the systemd service file.
ExecStartPre=-/usr/bin/chown uuidd:uuidd /var/lib/libuuid/clock.txt
does not work:
/usr/bin/chown: changing ownership of '/var/lib/libuuid/clock.txt': 
Operation not permitted

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

