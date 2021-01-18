Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477EDC43381
	for <util-linux@archiver.kernel.org>; Mon, 18 Jan 2021 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D9622D71
	for <util-linux@archiver.kernel.org>; Mon, 18 Jan 2021 20:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437907AbhARUZO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389102AbhARKmj (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Jan 2021 05:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610966472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUvQCXmjtxbZvqJiSmORixb4++mjzgZLsPK3+JwAq7w=;
        b=I88NkN20t4x7rG4AaIxdvb4yheFkbJW9WjeFJnka97/O377RzanWP2mMP3QCAeZm1AVv6G
        WC2YK6hvZcEI1MvpjgjQvGrMEHexlVdhB2BVqXN4iYaYntzlb9ke9GBIGG738KIL6iY04+
        d4IhGSissr47Bnln5OM2JWT864/x3Jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-Qbz34eDcOgWndMDzkcLnVA-1; Mon, 18 Jan 2021 05:41:10 -0500
X-MC-Unique: Qbz34eDcOgWndMDzkcLnVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2640259;
        Mon, 18 Jan 2021 10:41:09 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECDE81F058;
        Mon, 18 Jan 2021 10:41:07 +0000 (UTC)
Date:   Mon, 18 Jan 2021 11:41:05 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc:     util-linux@vger.kernel.org, ruediger.meier@ga-group.nl,
        sbrabec@suse.com
Subject: Re: [PATCH v2] ipcs: Avoid shmall overflows
Message-ID: <20210118104105.qp3xp5lkrtr3cscf@ws.net.home>
References: <2f66f8913a6bb2d70201e46efa369b51817ea243.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f66f8913a6bb2d70201e46efa369b51817ea243.camel@suse.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 15, 2021 at 03:00:11PM +0100, Vasilis Liaskovitis wrote:
>  sys-utils/ipcs.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

