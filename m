Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54935 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759548Ab3ICHPS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 3 Sep 2013 03:15:18 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so5587149pdj.25
        for <util-linux@vger.kernel.org>; Tue, 03 Sep 2013 00:15:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20130902232239.GA6888@rampage>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
	<1371408836-16663-15-git-send-email-kerolasa@iki.fi>
	<20130902232239.GA6888@rampage>
Date: Tue, 3 Sep 2013 08:15:18 +0100
Message-ID: <CAG27Bk1OcVLMWaT1f5+ct2PgW3KoF5Y2R0eY94Rrcc+nNQLzHg@mail.gmail.com>
Subject: Re: [PATCH 14/15] hexdump: remove unnecessary global variables
From: Sami Kerola <kerolasa@iki.fi>
To: Sami Kerola <kerolasa@iki.fi>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 September 2013 00:22, Dave Reisner <d@falconindy.com> wrote:
> A little late to the game, but this commit breaks the return value of
> hexdump and causes it to always return 1, even on successful invocation.
> next(char**) will always return 1 for the usual (non-NULL) values of argv.

Hi Dave,

You are not late at all. Thanks to you broken hexdump was never
released to greater audience. I'll fix the issue in near future,
unless someone else is quicker.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
