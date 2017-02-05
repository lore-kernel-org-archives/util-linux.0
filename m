Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36414 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdBEWhb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Feb 2017 17:37:31 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so18481711wmd.3
        for <util-linux@vger.kernel.org>; Sun, 05 Feb 2017 14:37:31 -0800 (PST)
Date: Sun, 5 Feb 2017 22:37:22 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: [ping] Karel: Re: pull: hwclock 27 changes
In-Reply-To: <20170204184727.g3sticwdbzfbzg3l@ws.net.home>
Message-ID: <alpine.LNX.2.20.1702052230430.494@imuri>
References: <alpine.LNX.2.20.1701072212010.9096@imuri> <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com> <alpine.LNX.2.20.1701112055190.2589@imuri> <ede34a46-7290-c68b-1dd8-e4fc356e5caf@gmx.com> <alpine.LNX.2.20.1701140930380.2049@imuri>
 <f723104e-d23b-f8fd-e9ee-b9fc82c86fd3@gmx.com> <c88dc7ee-3e18-19ec-612e-3788551517bb@gmx.com> <alpine.LNX.2.20.1701252136160.492@imuri> <5feac9a5-e3e3-5148-60a0-fb3197a1caa8@gmx.com> <9798a869-fb09-77e7-a13a-bca002617672@gmx.com>
 <20170204184727.g3sticwdbzfbzg3l@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 4 Feb 2017, Karel Zak wrote:

> On Thu, Feb 02, 2017 at 10:04:13AM -0500, J William Piggott wrote:
> > Karel,
> > I have some work to submit that applies on top of Sami's branch:
> > 
> > git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed
> 
> I reviewed the patches 4 day ago and will merge it next week.

Good to hear.

BTW when doing various checks I noticed clang failed to link with -lm. 
Something with isnan() must be culprit, but I did not do further 
investigation, simply changing $(MATH_LIBS) to -lm seems to work fine and 
is part of my remote.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
