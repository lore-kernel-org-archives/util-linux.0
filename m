Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F450C433EF
	for <util-linux@archiver.kernel.org>; Wed,  5 Jan 2022 15:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiAEPpn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Jan 2022 10:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241650AbiAEPpm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Jan 2022 10:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641397541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQoYttzoWwFCkMCKNxKZQQL+n/X/Ejfxx49PFOOwp40=;
        b=FbdoOFrkyJLevhNqCJrjXepI9ogVLusgdPBJhBhnrlbkKDUvfrcqzDjRr3a3RwplVh2ybZ
        NaZgRe1+m8IArzxPPSxQ/xRHMAqicjw2qaEuv8RYlcZjmRhx0qPFmvG8ktbM6FbTz31ffC
        D/hJ8wd0W7htB3outXs0BZ6kvI05X7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-bjjsVjfgNheMty_nndrvNQ-1; Wed, 05 Jan 2022 10:45:38 -0500
X-MC-Unique: bjjsVjfgNheMty_nndrvNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A05FF1006AA4;
        Wed,  5 Jan 2022 15:45:37 +0000 (UTC)
Received: from ws.net.home (ovpn-112-15.ams2.redhat.com [10.36.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C05A34EC6B;
        Wed,  5 Jan 2022 15:45:36 +0000 (UTC)
Date:   Wed, 5 Jan 2022 16:45:34 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>, 1003095@bugs.debian.org,
        util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220105154534.6es3dcg2upgzhezl@ws.net.home>
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 04, 2022 at 06:31:24PM +0100, наб wrote:
> Control: tags -1 + upstream
> 
> On Tue, Jan 04, 2022 at 05:24:54PM +0100, Chris Hofstaedtler wrote:
> > * наб <nabijaczleweli@nabijaczleweli.xyz> [220104 00:06]:
> > > (This, at least, responds to ^\, but it also seems to function
> > >  slightly differently. Also, this is a race and you're more
> > >  likely to lose it under strace. The loopy thing seems
> > >  like it's pretty good at hitting it 100% of the time.)
> As an additional note, because it's a race, if you're using bash,
>   script < some-photo.jpeg
> also hangs, because setup takes long enough.
> 
> > 1) is this Debian-specific or already present upstream?
> Debian doesn't patch script.c at all, so this is an upstream bug.
> 
> > 2) did this work with previous versions of util-linux?
> The oldest one I fould from the site at Homepage: in d/control is
> "util-linux-ng 2.13", dated 19.1.2012. It's much closer to the original
> 4.4BSD-Lite implementation and still forks twice. As expected, testing
> reveals it does not have the bug.
> 
> Performing a simple manual bisect across the versions available therein
> reveals that 2.25 is the first broken version. (Though, skimming the
> source, with a slightly different code path (select(2)?), since it still
> double-forks and is not so hard-stuck so as to be immune to ^\.)
> 
> The first version that does get hard-stuck (because it forks once
> and only uses poll) is 2.27.

Resolve the problem with the signal should be simple. Now it
ignores all when it write to the master. Something like:


diff --git a/lib/pty-session.c b/lib/pty-session.c
index 6f038e1c5..84ea33860 100644
--- a/lib/pty-session.c
+++ b/lib/pty-session.c
@@ -292,7 +292,20 @@ static int write_output(char *obuf, ssize_t bytes)
 
 static int write_to_child(struct ul_pty *pty, char *buf, size_t bufsz)
 {
-       return write_all(pty->master, buf, bufsz);
+       sigset_t set, org;
+       int rc;
+
+       sigemptyset(&set);
+       sigemptyset(&org);
+       sigaddset(&set, SIGINT);
+       sigaddset(&set, SIGTERM);
+
+       sigprocmask(SIG_UNBLOCK, &set, &org);
+
+       rc = write_all(pty->master, buf, bufsz);
+
+       sigprocmask(SIG_SETMASK, &org, NULL);
+       return rc;
 }


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

