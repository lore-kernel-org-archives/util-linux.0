Return-Path: <SRS0=LdDc=O3=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C32C43387
	for <util-linux@archiver.kernel.org>; Tue, 18 Dec 2018 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BA0214C6
	for <util-linux@archiver.kernel.org>; Tue, 18 Dec 2018 09:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeLRJpV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:45:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeLRJpV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Dec 2018 04:45:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C994DC065102;
        Tue, 18 Dec 2018 09:45:20 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.118.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBDBA5D9C6;
        Tue, 18 Dec 2018 09:45:19 +0000 (UTC)
Date:   Tue, 18 Dec 2018 10:45:16 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ruediger Meier <sweet_f_a@gmx.de>
Cc:     Christian Hesse <mail@eworm.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] fstrim: add random delay to systemd timer
Message-ID: <20181218094516.spxsj72jgkbtflwe@ws.net.home>
References: <20181217124422.13334-1-mail@eworm.de>
 <201812172145.23296.sweet_f_a@gmx.de>
 <20181217221518.5a68691f@leda>
 <201812172313.35898.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812172313.35898.sweet_f_a@gmx.de>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 18 Dec 2018 09:45:20 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Dec 17, 2018 at 11:13:35PM +0100, Ruediger Meier wrote:
> Nevermind, I just wanted to rant again about why we are maintaining this 
> timer files at all. IMO the distros and/or admins should configure such 
> tasks *properly* according their needs. UL upstream is IMHO the wrong 
> place.

Well, distro still can improve upstream configuration, the files is
just the default hint. It's better to share this code than force all
distro duplicate effort. Perfect is enemy of good :-) The files are
installed (by make install), but not enabled by default -- the
activation is distro/user decision.

And according to feedback it seems people use the fstrim.timer, so why
not share it and work together on better fstrim and timer
configuration?

> BTW note that RandomizedDelaySec will produce an annoying warning on 
> sytstems where systemd is not up-to date. And to rant again, IMO it's 
> questionable whether we should bother users with such warnings or why 
> one should update the whole systemd monstrum just to achieve such 
> simple improvement which was solved already by cron 30 years ago in a 
> better way ;)

Well, I'm not systemd expert, but I guess you can define dependences
between services to avoid unwanted collisions between services.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
