Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34263 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab2EaJEK convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 31 May 2012 05:04:10 -0400
Received: by wibhj8 with SMTP id hj8so4724298wib.1
        for <util-linux-ng@vger.kernel.org>; Thu, 31 May 2012 02:04:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <4FC72679.7050307@suse.de>
References: <CAG27Bk3YrUc4cwpUou5o005S165LOc4C8bPHp-EnkwAz2WsFng@mail.gmail.com>
	<4FC72679.7050307@suse.de>
Date: Thu, 31 May 2012 11:04:09 +0200
Message-ID: <CAG27Bk0E79L9Tb7zi0M6ditsxr46LKJcy6Rn1KqFi5wrxTB4pw@mail.gmail.com>
Subject: Re: [pull] su.1 manual page
From: Sami Kerola <kerolasa@iki.fi>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 31, 2012 at 10:06 AM, Ludwig Nussel <ludwig.nussel@suse.de>=
 wrote:
>> Please find from my git a su(1) manual page candidate. =A0The text i=
s
>> almost one to one copy with GNU Coreutils 'su invocation' info page,
>> so it is questionable if I "wrote" the man page. =A0To feel a little
>
> Hmm, I was about to write a man page from scratch. Should I continue =
or
> do we use the coreutils man page?

1. Continue writing from scratch, and propose your own man page candida=
te.
2. Contribute to my branch.
3. Drop the task as the proposed man page is good enough.

> PS: the section about the wheel group can be removed :)

I think keeping some sort of note about wheel group not being checked
is valid information, but does it have to be RMS story is different
question. I'll have a look of that at evening.

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
--
To unsubscribe from this list: send the line "unsubscribe util-linux" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
