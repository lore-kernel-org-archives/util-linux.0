Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FF3C433F5
	for <util-linux@archiver.kernel.org>; Wed, 15 Dec 2021 12:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhLOM4S (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Dec 2021 07:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhLOM4S (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Dec 2021 07:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639572977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQl2kK68K+Qt8enGSy+8RObjZQOnENGJt+vtMi9P0aA=;
        b=a2Y2l3U6FirMNeWsOPYhCypNgOp4+eJNJWeo3b6/OkN38iWcpsxAFj70Uf1DISWQ7KvMrs
        BuiXLuWQLXd51cf/XGdTevUi0CrFN8iWiIY4gRSH5IbO0k6G6tqjmdvbgpCorVIF+XcPec
        VIL6ZLx9sut3nk/mcW5RKWBwLJhgRfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-qam6U4cwOXSTHaBXqYgMhA-1; Wed, 15 Dec 2021 07:56:12 -0500
X-MC-Unique: qam6U4cwOXSTHaBXqYgMhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66EFC871802;
        Wed, 15 Dec 2021 12:56:10 +0000 (UTC)
Received: from ws.net.home (ovpn-112-15.ams2.redhat.com [10.36.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D5AC96F3A;
        Wed, 15 Dec 2021 12:56:08 +0000 (UTC)
Date:   Wed, 15 Dec 2021 13:56:05 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20211215125605.4tg7ugdnlbb3i3v7@ws.net.home>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20211214120349.kntr7gza5flma5tc@ws.net.home>
 <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Dec 14, 2021 at 05:24:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > What does it mean didn't help?
> 
> I tried it, but the bug remains as it was.. As I understand,
> dropping O_NONBLOCK by fcntl just removes this flag, to change
> further behavior of device to non-blocking. But it doesn't do any
> additional actions in driver.

Hmm ...

> > The solution based on blkid_safe_open() means that we have to modify
> > many applications. For example, systemd/udevd uses
> > 
> >      fd = open(devnode, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
> >      r = blkid_probe_set_device(pr, fd, offset, 0);
> 
> Hmm, yes, that's not very good :(
> 
> > 
> > The same is probably in many other places (mkfs-like programs, etc.).
> > 
> > What do you think?
> > 
> 
> Maybe be we can get filename from fd reading it from /proc, then do
> open() and than dup() to old fd.. But that's even more dirty to do
> in a library call.

Yes, re-open() sounds like a possible way.

The dup() is not necessary. The library already support private FD for
probing. See blkid_new_probe_from_filename() and BLKID_FL_PRIVATE_FD.

It's also often used when the library probe whole-disk device (when you
probe sda1 than it also reads data from partition table on sda). In
this case it opens a separate FD.

It's for floppies (0.001% of all cases). IMHO re-open is good enough and
better than force changes in all applications :-)

I'll try to prepare a patch and ask you for test/review. Thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

