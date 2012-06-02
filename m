Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61432 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932970Ab2FBFkx convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Sat, 2 Jun 2012 01:40:53 -0400
Received: by wgbdr13 with SMTP id dr13so2507502wgb.1
        for <util-linux-ng@vger.kernel.org>; Fri, 01 Jun 2012 22:40:51 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <4FC88A00.90004@suse.de>
References: <CAG27Bk3YrUc4cwpUou5o005S165LOc4C8bPHp-EnkwAz2WsFng@mail.gmail.com>
	<4FC72679.7050307@suse.de>
	<CAG27Bk0E79L9Tb7zi0M6ditsxr46LKJcy6Rn1KqFi5wrxTB4pw@mail.gmail.com>
	<4FC88A00.90004@suse.de>
Date: Sat, 2 Jun 2012 07:40:51 +0200
Message-ID: <CAG27Bk1s96ztd-k4C9vqJqdj=_Mc7oz-VUhzYkDyWMyL2x-irw@mail.gmail.com>
Subject: Re: [pull] su.1 manual page
From: Sami Kerola <kerolasa@iki.fi>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 1, 2012 at 11:23 AM, Ludwig Nussel <ludwig.nussel@suse.de> wrote:
> Sami Kerola wrote:
>> On Thu, May 31, 2012 at 10:06 AM, Ludwig Nussel <ludwig.nussel@suse.de> wrote:
>>> Hmm, I was about to write a man page from scratch. Should I continue or
>>> do we use the coreutils man page?
>>
>> 1. Continue writing from scratch, and propose your own man page candidate.
>
> I've attached my suggestion

Hi Ludwig,

Your manual is better, so I took liberty to add it to my branch and
make few groff changes.

https://github.com/kerolasa/lelux-utiliteetit/commit/2ab15cb0c3b6fe81697713ce6dc56b85e44a00fe#login-utils/su.1

Have also a look of how the pager will show the end result.

https://raw.github.com/kerolasa/lelux-utiliteetit/su.1/login-utils/su.1

I would like to hear you are OK with that. Without other comments I
reckon the su.1 is ready to be merged.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
