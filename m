Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4E6C433ED
	for <util-linux@archiver.kernel.org>; Mon, 10 May 2021 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3105C61285
	for <util-linux@archiver.kernel.org>; Mon, 10 May 2021 14:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbhEJOwz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 May 2021 10:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235783AbhEJOwX (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 May 2021 10:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620658278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFbfnU2qIW6o4DQl/Mb0Vabk6JyZRfX3G7NzyX/Ok1w=;
        b=WvKR12mHlnpJe0aA1wnpMl69KiGh+EdZjf1XYtzf5D7xz23ElpeGzi3YE79ElV0hDFBPHA
        mN1Dp/SsCAWjnt1nYmu5ZRiBcLPy7wRAf/tPtlcgCZWQwOM9G9oZmPaXfJmaMTSQMvaKGG
        ta3hnhyK4v2Q5mJL6ETFhh70NecteDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-IhMPtqfCPPq3BboaWx_Zzw-1; Mon, 10 May 2021 10:51:16 -0400
X-MC-Unique: IhMPtqfCPPq3BboaWx_Zzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 399CF801B15;
        Mon, 10 May 2021 14:51:15 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86A5F2DAD6;
        Mon, 10 May 2021 14:51:14 +0000 (UTC)
Date:   Mon, 10 May 2021 16:51:11 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Werner Fink <werner@suse.de>
Subject: Re: [PATCH] sulogin: ignore not existing console devices
Message-ID: <20210510145111.x5ap5raymlfoewi5@ws.net.home>
References: <YJPK1JUPtKTuMJ1J@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJPK1JUPtKTuMJ1J@boole.suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, May 06, 2021 at 12:54:12PM +0200, Werner Fink wrote:
>  login-utils/sulogin-consoles.h |  1 +
>  login-utils/sulogin.c          | 97 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 82 insertions(+), 16 deletions(-)

Seems good, but git does not like the patch from your e-mail:

        Applying: sulogin: ignore not existing console devices
        .git/rebase-apply/patch:49: space before tab in indent.
                    con->flags |= CON_SERIAL;
        error: patch failed: login-utils/sulogin.c:775
        error: login-utils/sulogin.c: patch does not apply
        Patch failed at 0001 sulogin: ignore not existing console devices


    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

