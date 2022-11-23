Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64463C4332F
	for <util-linux@archiver.kernel.org>; Wed, 23 Nov 2022 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiKWJ7G (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Nov 2022 04:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiKWJ6R (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Nov 2022 04:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E46DFFD
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2022 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669197115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WKJ/FJNvNZSFNzymLxXE54PUj86HyWPxOnJNtjLzwv0=;
        b=E/WMsVYyPV7KGz6ajXQhLxAuNin5rRIUoR+4i0Z5oCYn7DVPQj6WsULrnxudv8iknhkLZY
        nKT1FUgw/ZWwFD6JcA9DKew9Zs/u1t+yjBpwCRm7axnMk7D+nE5AQyPEJYEnGuqpkE1mv4
        G/65nAQEnlFfWCsdpQ1cWYpsXpQumbk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-5Klehd4OOnaS-wi25Us6Zg-1; Wed, 23 Nov 2022 04:51:51 -0500
X-MC-Unique: 5Klehd4OOnaS-wi25Us6Zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 937943C01DF0;
        Wed, 23 Nov 2022 09:51:51 +0000 (UTC)
Received: from ws.net.home (ovpn-192-16.brq.redhat.com [10.40.192.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEF464EA4E;
        Wed, 23 Nov 2022 09:51:50 +0000 (UTC)
Date:   Wed, 23 Nov 2022 10:51:48 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     util-linux <util-linux@vger.kernel.org>,
        John Westerdale <jwesterd@redhat.com>, fhirtz@redhat.com
Subject: Re: [PATCH 0/2] Add ability to use autofs mount option hint to
 exclude mount table list entries
Message-ID: <20221123095148.lkeg43evzwj72m3e@ws.net.home>
References: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


Hi Ian,

On Wed, Nov 16, 2022 at 10:00:39AM +0800, Ian Kent wrote:
> There's further discussion of this in the first patch.
> 
> I started trying to do this quite a while ago, glibc, automount(8) and
> the kernel have been updated to use such a mount option but, for some
> reason, when I canme to update util-linux I thought it would cause
> problems for systemd. But when I looked at what I had done just recently
> I saw that isn't the case so I'm now continuing with this change.

It's definitely no problem if the new behavior is optional and it's    
possible to enable/disable it. So, the systemd can keep it disabled
;-)

> What I've done might not be the prefered way to do this so any comments
> are welcome so it can be done the way it fits best with util-linux.

What about findmnt(8), maybe we can add --autofs=yes/not. 

The problem is that we probably do not want to change the default
output as it's probably already used in many scripts, or is it
acceptable to hide autofs by default? It's already done for glibc, so
it may not be a big issue. Not sure.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

