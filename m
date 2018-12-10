Return-Path: <SRS0=pu0z=OT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A62FC5CFFE
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE18120821
	for <util-linux@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE18120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeLJNWf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:22:35 -0500
Received: from gardel.0pointer.net ([85.214.157.71]:59186 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbeLJNWe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 10 Dec 2018 08:22:34 -0500
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 08:22:33 EST
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id C4365E807C5;
        Mon, 10 Dec 2018 14:12:53 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 538211601FC; Mon, 10 Dec 2018 14:12:53 +0100 (CET)
Date:   Mon, 10 Dec 2018 14:12:53 +0100
From:   Lennart Poettering <lennart@poettering.net>
To:     Karel Zak <kzak@redhat.com>
Cc:     Stanislav Brabec <sbrabec@suse.cz>,
        util-linux <util-linux@vger.kernel.org>,
        systemd-devel@lists.freedesktop.org
Subject: Re: [systemd-devel] [PATCH] rfkill: Add systemd integration
Message-ID: <20181210131253.GA10304@gardel-login>
References: <0ad9b6ea-0d46-5ec5-1bfc-0e48be52dae8@suse.cz>
 <20181122103907.vwjf6uprlxzthd7e@ws.net.home>
 <81e98f5c-7c5f-1c75-cd48-45b30b516eed@suse.cz>
 <CAG27Bk2-r3E1Ae2g4VMqNAEDUWrksLrTDx-jcoYvpZtCZNM_Ww@mail.gmail.com>
 <0ce3309a-009a-7c00-3a2c-e4917b894f8c@suse.cz>
 <20181210125325.hwngj6l646cfwt2f@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210125325.hwngj6l646cfwt2f@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mo, 10.12.18 13:53, Karel Zak (kzak@redhat.com) wrote:
65;5402;1c
> On Tue, Nov 27, 2018 at 07:16:04PM +0100, Stanislav Brabec wrote:
> > Sami Kerola wrote:
> > That said,
> > > getting a clarification from Jochen would nice because otherwise we are
> > > simply guessing.
> >
> > Jochen Keil already left SUSE and I have no contact e-mail to him.
> >
> > But I got complain that it is missing after migration of rfkill to util-linux:
> > https://bugzilla.opensuse.org/show_bug.cgi?id=1092820
>
>  It seems the best would be to ask upstream systemd guys. Maybe it's
>  really Suse specific and maybe it's something we can support for more
>  distros. I don't know.
>
>  All thread:
>  https://lore.kernel.org/util-linux/0ce3309a-009a-7c00-3a2c-e4917b894f8c@suse.cz/T/#m221ad50b88792236c10c507f9163b57761c254a7

Hmm, what's the usecase for this?

I mean, "systemctl start rfkill-block@xyz.service" isn't that much
nicer to type than "rfkill block xyz", no? In fact, quite the opposite
I'd say...

Or this is about enable/disabling rfkill at subsequent boot, using
"systemctl enable rfkill-block@xyz.service"? This kinda conflicts with
the save/restore logic systemd-rfkill@.service (as shipped with
systemd) implements already. It might make sense to extend that tool
slightly, for example by defining a udev property or so to check which
can override the saved data statically. Or definining a kernel cmdline
option to override the rfkill save/restore logic globally. But I am
pretty sure that one should be careful with having two different
packages run at boot to set the initial rfkill setting, because they
will fight about it.

Lennart

--
Lennart Poettering, Red Hat
