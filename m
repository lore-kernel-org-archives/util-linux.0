Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98350C433E0
	for <util-linux@archiver.kernel.org>; Fri, 19 Feb 2021 11:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E4164E67
	for <util-linux@archiver.kernel.org>; Fri, 19 Feb 2021 11:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhBSLbm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Feb 2021 06:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBSLbl (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Feb 2021 06:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613734215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWqmMAiugep/wNfmMnMlxgUHCBekulgwQQrIFsa8dOQ=;
        b=IX3TeuET+zrc+Cdzj3S804l4rIbSQH1jA4KteHEMjNZZ08CjTeVebuwxsi0Vv4AYefwNo8
        eZssZvt0pIx1mQkWgF2UOklklr1DqBRk9DuKnK6uyr4vLuamionOR7bek5Y3J3CU6lmy1/
        5fc8+lfalQ744TNia5IzBOJ0SPJOSKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-5Uxc_gfBOpu3ZbV5GgA3fA-1; Fri, 19 Feb 2021 06:30:13 -0500
X-MC-Unique: 5Uxc_gfBOpu3ZbV5GgA3fA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BED5C803F47;
        Fri, 19 Feb 2021 11:30:12 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1423919D9D;
        Fri, 19 Feb 2021 11:30:11 +0000 (UTC)
Date:   Fri, 19 Feb 2021 12:30:09 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>
Subject: Re: Suggested changes to util-linux for FHS compliance.
Message-ID: <20210219113009.mav3dis3qzofru4c@ws.net.home>
References: <cc08c08e-81d9-f3c7-ce8b-43a27bfe1c72@gmail.com>
 <20210215091625.jzaf6ephntdwmi5w@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215091625.jzaf6ephntdwmi5w@ws.net.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Feb 15, 2021 at 10:16:30AM +0100, Karel Zak wrote:
> On Fri, Feb 12, 2021 at 11:04:59AM -0600, Bruce Dubbs wrote:
> > I don't recall if this has come up before, but I suggest a couple of changes
> > to the default util-linux build configuuration:
> > 
> > 1. Change the default ADJTIME_PATH to be /var/lib/hwclock/adjtime
> 
> Good idea. I'll do that.

Hmm... I remembered now that we have in our TODO:

 hwclock
 ------
 - use /var/lib/hwclock/drift to store hw-clock drift numbers.
 - use /etc/adjtime as read-only for UTC/LOCAL information only
 - the /var/lib/hwclock/drift should be implemented backwardly compatible,
   it means use the file only if exists, otherwise follow /etc/adjtime

so maybe the best would be to keep ADJTIME_PATH=/etc/adjtime and use
it as read-only and use ${localstatedir}/lib/hwclock/drift for the
rest.

Note that ADJTIME_PATH is used by more utils, like rtcwake or systemd,
so move it is not so easy.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

