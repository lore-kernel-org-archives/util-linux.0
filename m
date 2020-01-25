Return-Path: <SRS0=6iEs=3O=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D6C2D0DB
	for <util-linux@archiver.kernel.org>; Sat, 25 Jan 2020 10:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B70E2071E
	for <util-linux@archiver.kernel.org>; Sat, 25 Jan 2020 10:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgYthqv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAYKvh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:51:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgAYKvh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 25 Jan 2020 05:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579949495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqFEuTpxU2pWPGTF545UEtB80eyGUAxWgMAokEVX9wE=;
        b=BgYthqv7Vgvdw2+hS6pjQEvTLj5PcZ7QOCXc8sB84aTuZo20M4LGg8YVb6mbNRfdR9N1yE
        nn1SfzlUogXi4XxjZffhf/tmIIcPNEONovSIvBBEkO7GPWrb8O6NBmmAcoP36zqJQfy/5y
        7q/dvaW3gFNtySbfD6sl5yFZodpOxTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-H-uiSdKiNR2hLbqmCuz42Q-1; Sat, 25 Jan 2020 05:51:31 -0500
X-MC-Unique: H-uiSdKiNR2hLbqmCuz42Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21341107ACC4;
        Sat, 25 Jan 2020 10:51:30 +0000 (UTC)
Received: from x2.net.home (ovpn-204-101.brq.redhat.com [10.40.204.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6968D8DC35;
        Sat, 25 Jan 2020 10:51:29 +0000 (UTC)
Date:   Sat, 25 Jan 2020 11:51:26 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <unixmania@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35
Message-ID: <20200125105126.xaopgydc7dlrpztt@x2.net.home>
References: <20200121105711.zzeeolydlivqnik7@ws.net.home>
 <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 24, 2020 at 04:16:47PM -0300, Carlos Santos wrote:

> That's a problem. It makes hwclock hard to include in embedded systems
> due to the GPLv3 restrictions.
> 
> I noticed that it comes due to sys-utils/hwclock-parse-date.y, which
> was taken from gnulib. Would it be possible to take the file from an
> previous version of gnulib that was still under GPLv2?
> 
> An alternative approach would be porting a similar code using a more
> liberal license, e.g. BSD.
> 
> What do you think?

 I have tried to export it from gnulib with v2, but it was impossible
 by official gnulib tools.  Maybe do it manually from some old
 tarball. I'll accept a patch for this if you have time do it.

 I'll like to release 2.35.1 ASAP (due to bug in sfdisk --move-data),
 so we can add this license change too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

