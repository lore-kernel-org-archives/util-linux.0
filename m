Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC9C433E0
	for <util-linux@archiver.kernel.org>; Tue, 16 Feb 2021 20:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DF964DFF
	for <util-linux@archiver.kernel.org>; Tue, 16 Feb 2021 20:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBPU5Q (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:57:16 -0500
Received: from kawka.in.waw.pl ([178.62.225.244]:38856 "EHLO kawka.in.waw.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBPU5P (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 Feb 2021 15:57:15 -0500
X-Greylist: delayed 2165 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 15:57:15 EST
Received: from zbyszek by kawka.in.waw.pl with local (Exim 4.84_2)
        (envelope-from <zbyszek@in.waw.pl>)
        id 1lC6of-0007mP-Ej; Tue, 16 Feb 2021 20:19:25 +0000
Date:   Tue, 16 Feb 2021 20:19:25 +0000
From:   Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: meson build-system
Message-ID: <20210216201925.GW7348@in.waw.pl>
References: <20210216180030.a3pdnbcm3ps6dqmi@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210216180030.a3pdnbcm3ps6dqmi@ws.net.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Feb 16, 2021 at 07:00:30PM +0100, Karel Zak wrote:
> 
>  Hi all,
> 
> A year ago Zbigniew (CC:) implemented meson build-system as a second
> build system for util-linux. Today I finally updated it and pushed to
> the topic/meson branch on github. You can try it:
> 
>    git checkout -f topic/meson
>    meson build
>    ninja -C build
>    ls build/
> 
> No panic, we are going to keep autotools as our primary build-system
> for the next years :-)

Don't underestimate the dark side, Karel!
9s vs 41s (and an even bigger ratio on partial builds) is going to be
a strong pull.

> The goal is to try to provide an alternative, make it more stable,
> and maybe in future use it. The current util-linux meson configuration is 
> probably not mature enough to be used as a build-system for end-users and
> downstream distributions, but it seems as a nice alternative for
> developers, it's faster and it produces real binaries rather than
> libtool scripts.

Eh, I'd say that at this point meson (despite occasional small tweaks
required) is more stable than autotools. Right now autotools is stable
mostly because it doesn't change. With the upcoming update to
autoconf-2.71 that era is coming to an end.

>   $ git clean -xdf
>   $ time ( meson build;  ninja -C build )
>   real	0m9.093s
>   user	0m12.797s
>   sys   0m5.232s
> 
>   $ git clean -xdf
>   $ time ( ./autogen.sh; ./configure; make -j )
>   real	0m41.563s
>   user	1m52.681s
>   sys	0m30.346s
> 
> All the meson configuration is completely independent on autotools or
> another code in the package. I'll probably merge it to the master
> branch ASAP to make it easy to use for contributors.
> 
> Comments & objections?

Zbyszek
