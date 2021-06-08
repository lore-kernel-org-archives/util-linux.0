Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D8C47082
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 18:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E0A61352
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 18:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhFHS2v (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:28:51 -0400
Received: from foss.arm.com ([217.140.110.172]:37512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhFHS2u (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 8 Jun 2021 14:28:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C6A1D6E;
        Tue,  8 Jun 2021 11:26:57 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B94C3F694;
        Tue,  8 Jun 2021 11:26:57 -0700 (PDT)
Date:   Tue, 8 Jun 2021 19:26:54 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Missing getext dependency in v2.37
Message-ID: <20210608182654.a2ggwfovdegciwsu@e107158-lin.cambridge.arm.com>
References: <20210607162249.ez6dtms5xxansg26@e107158-lin.cambridge.arm.com>
 <20210608145032.6xzlt75thp64gpo6@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608145032.6xzlt75thp64gpo6@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 06/08/21 16:50, Karel Zak wrote:
> On Mon, Jun 07, 2021 at 05:22:49PM +0100, Qais Yousef wrote:
> > While building v2.37 I hit the following build error
> > 
> > 	: --update --no-wrap --previous --lang=ca ca.po util-linux.pot
> > 	rm -f ca.gmo && : -c --statistics --verbose -o ca.gmo ca.po
> > 	mv: cannot stat 't-ca.gmo': No such file or directory
> 
> The po/ stuff is not required for "make", it's usually necessary for
> "make distcheck" or so. It seems better to keep (x)gettext binary
> installation optional for normal purpose.
> 
> There is in ./configure output:
> 
> checking whether NLS is requested... yes
> checking for msgfmt... /usr/bin/msgfmt
> checking for gmsgfmt... /usr/bin/msgfmt
> checking for xgettext... no
> checking for msgmerge... /usr/bin/msgmerge
> 
> but you're right that it would be nice to have something more verbose.
> I'll add something to ./autogen.sh.

It was just a bit of a head scratch to figure out what went wrong. Wasn't that
big of a deal really at the end, but thought it'd be good to get a better clue
of what went wrong.

> 
> > Should configure fail when it detects gettext is missing?
> 
> There is difference between what we use as developers (from git repo)
> and what get users by official tarball. The tarball already contains
> compiled .(g)mo files. I guess, as end-user, you do not need to generate
> anything in po/.

Fair enough.

Cheers

--
Qais Yousef
