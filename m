Return-Path: <SRS0=j1+t=VM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D69EC7618F
	for <util-linux@archiver.kernel.org>; Mon, 15 Jul 2019 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6114A2080A
	for <util-linux@archiver.kernel.org>; Mon, 15 Jul 2019 13:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfGONjY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:39:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbfGONjX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 15 Jul 2019 09:39:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74D0F30C1214;
        Mon, 15 Jul 2019 13:39:23 +0000 (UTC)
Received: from ws.net.home (ovpn-204-41.brq.redhat.com [10.40.204.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B728D5D9C6;
        Mon, 15 Jul 2019 13:39:22 +0000 (UTC)
Date:   Mon, 15 Jul 2019 15:39:20 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <unixmania@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] hwclock: define cmos_interface only if necessary
Message-ID: <20190715133920.4pimvh6efigl5njy@ws.net.home>
References: <20190623223052.3345-1-unixmania@gmail.com>
 <20190624074114.oqz6s64pxgep562a@ws.net.home>
 <CAJ4jsafyxwqqScQ-Hi9vGhEbM2WExonm77ysohZDrVtNQoB+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ4jsafyxwqqScQ-Hi9vGhEbM2WExonm77ysohZDrVtNQoB+NA@mail.gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 15 Jul 2019 13:39:23 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jul 03, 2019 at 01:37:31PM -0300, Carlos Santos wrote:
> On Mon, Jun 24, 2019 at 4:41 AM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Sun, Jun 23, 2019 at 07:30:52PM -0300, unixmania@gmail.com wrote:
> > > Make the static declaration of the cmos_interface struct and related
> > > functions conditional to i386/x86_64, preventing several "defined but
> > > not used" compiler warnings.
> >
> > I think we have to be more aggressive :-) It would be better to:
> >
> > ./configure.ac:
> >  * add --disable-hwclock-cmos
> >  * add USE_HWCLOCK_CMOS (enabled by default for i386/x86_64)
> 
> I don't know much about autoconf. How can I test the target
> architecture in config.ac.
> 
> >  * add define(USE_HWCLOCK_CMOS)
> >
> > sys-utils/Makemodule.am:
> >  * compile hwclock-cmos.c only "if USE_HWCLOCK_CMOS"
> >
> > hwclock:
> >  * remove all unnecessary #ifdefs from hwclock-cmos.c
> >  * add #ifdef USE_HWCLOCK_CMOS to hwclock.c:determine_clock_access_method()
> >
> >
> > Note that we already use the same for RTC (which is linux only).
> >
> > The result will be more readable hwclock-cmos.c and only optional cmos
> > code compilation.
> 
> I just sent a third version of the patch comprising all these changes
> except for the i386/x86_64 test.

I have applied the patch and extended the ./confiugure stuff.

https://github.com/karelzak/util-linux/commit/c7eca69d6d89262c71b6d412f6b3a469fad07d7d
https://github.com/karelzak/util-linux/commit/b1062292066e0568adbbdbb104b7afdcc5dac25f

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
