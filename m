Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E95C2D0A3
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 16:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8FE20897
	for <util-linux@archiver.kernel.org>; Mon,  9 Nov 2020 16:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3HW8S5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgKIQXm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:23:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729791AbgKIQXm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 9 Nov 2020 11:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604939021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TjweWYF8vCCj8wQqx/w2jnC4T6URpTZ+aNZOMVS7wTs=;
        b=c3HW8S5BAKfYAcHz+TaS9Jnb/Hys/pDziS8Ew2MTTVk7CeBf+xAfnQkiKMsURGFYN8F0VB
        kW/IefwrN/INQJPsRNA+S/WNbSz1s0J9NFYLy4LGYiK/HQ6qG6GCxPnFUT3q2GYl/0oRLx
        Lqe7pvmqYzNVVwBmwQWUn6og/swRbV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-F2lf5UI-NbeYJ06zCmuYrQ-1; Mon, 09 Nov 2020 11:23:36 -0500
X-MC-Unique: F2lf5UI-NbeYJ06zCmuYrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B07D71074653;
        Mon,  9 Nov 2020 16:23:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8202119C78;
        Mon,  9 Nov 2020 16:23:34 +0000 (UTC)
Date:   Mon, 9 Nov 2020 17:23:31 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     util-linux@vger.kernel.org, jbastian@redhat.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v4 2/2] lscpu-arm: Remove hard corded model name of
 Cortex family and X-Gene
Message-ID: <20201109162331.blv7jd3gtui7es4o@ws.net.home>
References: <20201109030403.26821-1-msys.mizuma@gmail.com>
 <20201109030403.26821-2-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109030403.26821-2-msys.mizuma@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Nov 08, 2020 at 10:04:03PM -0500, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Remove hard corded model name of Cortex family and X-Gene so that
> lscpu can show the model name using Processor Version of SMBIOS Type4.

Now I see on my system (Fedora) that:

 $ll /sys/firmware/dmi/entries/4-0/raw
 -r-------- 1 root root 0 Nov  9 17:19 /sys/firmware/dmi/entries/4-0/raw

it means it's not readable for non-root users. So, I guess the
hardcoded table can be still usable as a fallback solution if we want
to provide readable information for non-root.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

