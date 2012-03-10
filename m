Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46754 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484Ab2CJLtY convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 10 Mar 2012 06:49:24 -0500
Received: by lahj13 with SMTP id j13so2456728lah.19
        for <util-linux@vger.kernel.org>; Sat, 10 Mar 2012 03:49:21 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20120309122050.GG17711@x2.net.home>
References: <20120305123847.GD486@x2.net.home>
	<1330976334-10751-1-git-send-email-kerolasa@iki.fi>
	<1330976334-10751-10-git-send-email-kerolasa@iki.fi>
	<1330984305.2953.25.camel@offbook>
	<CAG27Bk2LYb6h8djj0yom17oKtAy6Vvfh85Fu2k8+M9kPQGhPZg@mail.gmail.com>
	<1331293735.4092.3.camel@offworld>
	<20120309122050.GG17711@x2.net.home>
Date: Sat, 10 Mar 2012 12:49:20 +0100
Message-ID: <CAG27Bk22FpeAO93hGo7o-AaPZGrH6Wj3idL=WRst1isRX8Yrhg@mail.gmail.com>
Subject: Re: [PATCH 09/17] lib: add fileutils function collection
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Davidlohr Bueso <dave@gnu.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 9, 2012 at 13:20, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Mar 09, 2012 at 12:48:55PM +0100, Davidlohr Bueso wrote:
>> I don't see how streams are more complete than descriptors - and no,
>> every call to mkstemp *does not* require a call to fdopen, that's
>> completely up to the user's use case.
>
>  Add two functions :-)
>
>    int xmkstemp()
>    FILE *xfmkstemp()
>
>  the second function might be an inline function...

Hi Karel & Davidlohr,

Done the suggested way.

https://github.com/kerolasa/lelux-utiliteetit/commit/1d2594dde3de6bf4e23a284c08dc4c8cb7c86a6f

BTW I noticed mistake in earlier change, which made file descriptors
to be preferred way of changing permissions etc. The issue was that fd
was referred after closure. That is now fixed in commit below.

https://github.com/kerolasa/lelux-utiliteetit/commit/58681bfe79ed03d2b3c39f81b14cdb4723a51b63

Assuming no more comments arrive the week 9 patches might be ready for
final maintainer review hopefully resulting to merge.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
