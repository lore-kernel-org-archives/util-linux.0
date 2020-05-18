Return-Path: <SRS0=Ohmc=7A=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C7DC433E0
	for <util-linux@archiver.kernel.org>; Mon, 18 May 2020 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8422320674
	for <util-linux@archiver.kernel.org>; Mon, 18 May 2020 08:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDTFht7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgERI2Z (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 May 2020 04:28:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbgERI2Z (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 May 2020 04:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589790503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6k0oYumUmmkZtMOHIivThegahPNd3lqBo5A8wDl8tBw=;
        b=JDTFht7Nu2nYOcsFxQhJgge2cRRPZgytqyHRqnTOcqX7S4Kq7jDmomw3f8FV+YKL7UbUrf
        CLjvh/IsrCYLLFAKTju6vUs6cYnr79Om7owNM7GArMvWsUOj2xHxZv6fOGfUpYmdJAlCHh
        /5/n49Xglk7VrirXdWdNvWNM2c3JGk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-u70Xz2qJOYmpgiX0UhWx7Q-1; Mon, 18 May 2020 04:28:19 -0400
X-MC-Unique: u70Xz2qJOYmpgiX0UhWx7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF950474;
        Mon, 18 May 2020 08:28:18 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA467100164D;
        Mon, 18 May 2020 08:28:17 +0000 (UTC)
Date:   Mon, 18 May 2020 10:28:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org, Helge Kreutzmann <debian@helgefjell.de>
Subject: Re: Consistency fixes in util-linux man pages
Message-ID: <20200518082814.pq22ph732eiebacz@ws.net.home>
References: <4cb60e3f-0226-e7f0-0052-08a48ea9f425@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb60e3f-0226-e7f0-0052-08a48ea9f425@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, May 16, 2020 at 10:24:59AM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Karel,
> 
> Perhaps a little inspired by Helge's recent reports, I wonder about 
> submitting some wide-ranging patches to improve consistency across
> the util-linux manual pages.
> 
> As an example, there's quite a bit of variation in the order of 
> .SH sections in the manual pages (e.g., in the placement of the SEE 
> ALSO section). The pages would be more readable if the ordering was
> more consistent.
> 
> Would you entertain patches that made wide-ranging changes
> that fixed that sort of thing (without changing page content?

No problem, but it would be nice to somehow document that is expected
to avoid future changes in an opposite way. For example add some info
to Documentation/howto-man-page.txt.

BTW, I'm not sure about man pages as ideal format to maintain
documentation (because it's mostly about formatting than about
content). I think about AsciiDoc or so in future. What do you think
about this idea?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

