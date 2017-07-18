Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbdGRKk4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jul 2017 06:40:56 -0400
Date: Tue, 18 Jul 2017 12:40:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: uuidparse: test fails on 32bit machines
Message-ID: <20170718104052.hhtwgjnlleahthmf@ws.net.home>
References: <201707122115.01476.ruediger.meier@ga-group.nl>
 <20170718080709.s6fra6bgxkxd6f23@ws.net.home>
 <201707181152.36773.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201707181152.36773.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 18, 2017 at 11:52:36AM +0200, Ruediger Meier wrote:
> On Tuesday 18 July 2017, Karel Zak wrote:
> > I have removed this dates from the test. The things are internally
> > based on time_t (=long) and uint32_t. It does not make sense to use
> > it for huge numbers.
> 
> 
> FYI I have created two travis testing branches in my private github 
> repo: https://travis-ci.org/rudimeier/util-linux/builds
> 
>   travis-cc-test
>      - testing many different compilers versions, even using -Werror
>      - gcc 4.6, 4.8, 5, 6 and 7
>      - clang 3.4, 3.5, 3.9, 4.0 and 5.0
>      - OSX xcode 6.4, 7.3, 8.3
> 
>   travis-cc-test
>      - testing 32bit build, -m32 -Werror

Would be possible to enable build by date? I would be nice to run
basic builds tests for each commit and enable some additional
expensive builds for example every 10 days (or/and trigger the build
by git tags, e.g. -rcN).

> Note, my both branches above include open pull request #486:
> https://github.com/karelzak/util-linux/pull/486

 Merged. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
