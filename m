Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A703C433FE
	for <util-linux@archiver.kernel.org>; Tue, 25 Jan 2022 14:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388356AbiAYOgE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238034AbiAYOat (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 25 Jan 2022 09:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643121045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=94Pr/eg1WClLtTMusECj24Gt3dcpQWv4rw939TaDFVg=;
        b=cRRq5JnLTDveaCPLGZET1AkTeOBuG5Zp642xzyIVx9rVu49w8V90ZanayEAqxAWHg9FGpm
        pjEwOGRChR/6peZFtXZmh3AILzz7c8WZ+oaszORD5ehc47yZaARbuMaJForqloM/zzs3mT
        cV3jXbsjCvcAp16/o6OTqOUE/cPtY4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-QiYwOqgeNAutKsUy5ORXpQ-1; Tue, 25 Jan 2022 09:30:39 -0500
X-MC-Unique: QiYwOqgeNAutKsUy5ORXpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B91D8030D2;
        Tue, 25 Jan 2022 14:30:36 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67ED15DB88;
        Tue, 25 Jan 2022 14:30:35 +0000 (UTC)
Date:   Tue, 25 Jan 2022 15:30:32 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Ali Abdallah <ali.abdallah@suse.com>
Subject: Re: [PATCH] Whitelist libuuid clock file
Message-ID: <20220125143032.p6otx2vhvft5qwu2@ws.net.home>
References: <3f08fa1a-8efc-86d6-c492-7703f5b5ef38@suse.cz>
 <20220125105300.f3npvhr5emhvzevu@ws.net.home>
 <257bafee-3014-d3dc-ca4c-cc1f0504fca2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257bafee-3014-d3dc-ca4c-cc1f0504fca2@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 25, 2022 at 12:37:09PM +0100, Stanislav Brabec wrote:
> Karel Zak wrote:
> > 
> > OK, seems better than my solution ;-) Thanks!
> Actually, I found a very exotic failure of uuidd accessing clock.txt, which
> is not yet covered:
> 
> ls -al /var/lib/libuuid/clock.txt
> -rw-rw---- 1 root root 56 Jan 25 11:48 /var/lib/libuuid/clock.txt
> i. e. root owned clock.txt
> 
> It happens only if more conditions are met:
> - /var/lib/libuuid exists
> - uuidd is not running nor socket activated
> - uuigden --time is called as root

And vice-versa, if you stop uuidd and start uuidgen as normal user you
get EACCES for /var/lib/libuuid/clock.txt, but this use-case is
probably not so important ...

> If this happens, /var/lib/libuuid/clock.txt is written as root:root by the
> code in libuuid/src/gen_uuid.c:get_clock(). When uuidd is started later, it
> is unable to use clock.txt.
...

> So I think it should be addressed. But I am not sure how to fix it properly
> in the systemd service file.
> ExecStartPre=-/usr/bin/chown uuidd:uuidd /var/lib/libuuid/clock.txt
> does not work:
> /usr/bin/chown: changing ownership of '/var/lib/libuuid/clock.txt':
> Operation not permitted

What about to create a user specific clock state file if we cannot access
the default one due to EACCES? Something like:

 state_fd = open(LIBUUID_CLOCK_FILE, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
 if (state_fd < 0 &7 errno == EACCES) {
    snprintf(path, "%s-%d", LIBUUID_CLOCK_FILE, getuid());
    state_fd = open(path, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
 } 

so for the bad use-case:

  /var/lib/libuuid/clock.txt
  /var/lib/libuuid/clock.txt-<uuidd_uid>

in theory it means two clock queues, but if uuidd is running then
libuuid/getuuid always uses it.

The important is that in this way we can be sure uuidd is always
successful, and I guess the sensitive use-case (SAP;-) is always about
uuidd. IMHO it's more robust then depend on systemd ExecStartPre (or
so).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

