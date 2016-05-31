Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35283 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbcEaVoa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 May 2016 17:44:30 -0400
Received: by mail-lf0-f46.google.com with SMTP id w16so410939lfd.2
        for <util-linux@vger.kernel.org>; Tue, 31 May 2016 14:44:29 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20160531163751.hllsomrqkechhtfz@ws.net.home>
References: <20160531163751.hllsomrqkechhtfz@ws.net.home>
Date: Tue, 31 May 2016 22:44:28 +0100
Message-ID: <CAG27Bk08pwJLWd8bfJyKyZNCbGEtvNUoUJf+yDrVg4rH_Ua+rw@mail.gmail.com>
Subject: Re: cal(1) changes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 31 May 2016 at 17:37, Karel Zak <kzak@redhat.com> wrote:
>  I have committed two changes:
>
>  * make it possible to specify month by name (according to locales)
>
>     $ cal May 2017
>
>  * accept timestamps / relative date
>
>     $ cal '2 weeks ago'
>
>     $ cal '+1year'
>
>     $ cal 'tomorrow'
>
>  We already have function to parse timestamps and I love it when use
>  'git log --since', so why not use it for cal? (Note that timestamps
>  are based on English and I think it's right thing (for KISS)).
>
>  Comments?

Sounds fitting. I am in favour.

I wonder if various time, calendar, interval expressions such as
examples above, and timestamp printers & parsers could be turned
into a libtime. If such library would exist the good question is if
anyone would want to use shared resource like this.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
