Return-Path: <SRS0=xh3B=7C=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A3C433DF
	for <util-linux@archiver.kernel.org>; Wed, 20 May 2020 11:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45008207C4
	for <util-linux@archiver.kernel.org>; Wed, 20 May 2020 11:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGjFF6k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETLFu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 May 2020 07:05:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41247 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgETLFu (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 20 May 2020 07:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589972749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HqcEt6puVl0H9+60ylKGg9Mzj2YqWa4AKeX4CS5iucY=;
        b=AGjFF6k9lhPwtCqaa3XPRiNxPuyWmsofFdQQ0KCsS1YOhDqb1bhhMOvVBqP0ztKS9yeW/V
        y199pinW7fu3tekmqXCOcE40JbkfOh2jBNQGx4dxV3H2UBuAQiF/Axlw4cNid/RlGhI+9a
        BL3mKtPph6uhfRRqf/zEuSK7yeDHo4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-YoJDUS1jP4WwcB6U7cEXkw-1; Wed, 20 May 2020 07:05:45 -0400
X-MC-Unique: YoJDUS1jP4WwcB6U7cEXkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A32EB1005512;
        Wed, 20 May 2020 11:05:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2EC219C4F;
        Wed, 20 May 2020 11:05:43 +0000 (UTC)
Date:   Wed, 20 May 2020 13:05:40 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Section ordering in util-linux manual pages
Message-ID: <20200520110540.iw42lp3fdawed6gq@ws.net.home>
References: <CAKgNAkjU+HdQ2PQLtrPbVU2cyUYecOZZV3i6CSeDvWJM_OR3qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkjU+HdQ2PQLtrPbVU2cyUYecOZZV3i6CSeDvWJM_OR3qQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 20, 2020 at 08:30:55AM +0200, Michael Kerrisk (man-pages) wrote:
> However, there's quite a wild variability in the order of some of
> these sections in individual pages, which can make it a little
> difficult to find a section. I suggest that the order of sections
> should be consistently something like:
> 
> NAME
> SYNOPSIS
> CONFIGURATION
> DESCRIPTION
> OPTIONS
> EXIT STATUS
> RETURN VALUE
> ERRORS
> ENVIRONMENT
> FILES
> VERSIONS
> HISTORY
> ATTRIBUTES
> CONFORMING TO
> NOTES
> BUGS
> EXAMPLE
> AUTHORS
> COPYRIGHT
> SEE ALSO
> AVAILABILITY
>
> 
> (Note that this list does not include all the sections listed above,
> but I'll ignore those for the moment.)
> 
> Does that order sound reasonable to you. (It's an expanded version of
> the suggested order in man-pages(7), with some additions to allow for
> headings that are commonly used in util-linux manual pages.)

Looks good. 

util-linux is collection from random authors and we (mostly) invested
our effort to code consolidation and unification in last years. So,
I'm happy to see that you want to do the same with man pages.

> I'd like to send some patches to fix that ordering. I would not do
> this all at once, but rather, one or section headers at a time,
> probably starting with SEE ALSO/AVAILABILITY. Does this sound okay to
> you?

Go ahead.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

