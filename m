Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:61535 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbbBTLG6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 20 Feb 2015 06:06:58 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so2148296wib.0
        for <util-linux@vger.kernel.org>; Fri, 20 Feb 2015 03:06:57 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20150220102939.GA19430@ws.net.home>
References: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
	<20150220102939.GA19430@ws.net.home>
Date: Fri, 20 Feb 2015 11:06:56 +0000
Message-ID: <CAG27Bk0BB4pJ3rXxMzf2k0CRoYg=pgJHWOdwRAqYwGwWQzj6Ow@mail.gmail.com>
Subject: Re: [PATCH] more: fix control character display bug
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 20 February 2015 at 10:29, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Jan 30, 2015 at 09:54:10AM +0100, Sami Kerola wrote:
>>  text-utils/more.c | 59 +++++++++++++++++++++++++------------------------------
>>  1 file changed, 27 insertions(+), 32 deletions(-)
>
> Does it make sense to apply this patch? I guess the issue is already
> (also) fixed in you "more" branch at git hub, right?

Hi Karel

Please do not merge this change.

As you said I have quite some changes to more(1) in my git[1], and I
have intention to fix the issue before v2.27. The current change set
does not solve the problem,  but I will send it anyway during weekend
to flush my change buffer[2].

[1] https://github.com/kerolasa/lelux-utiliteetit/tree/more
[2] 70 changes in total. Sorry for review burden, I'm been buffering
since 2.26-rc1

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
