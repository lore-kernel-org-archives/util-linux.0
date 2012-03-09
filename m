Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53672 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751825Ab2CIH4G convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Mar 2012 02:56:06 -0500
Received: by lahj13 with SMTP id j13so1381043lah.19
        for <util-linux@vger.kernel.org>; Thu, 08 Mar 2012 23:56:04 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1330984305.2953.25.camel@offbook>
References: <20120305123847.GD486@x2.net.home>
	<1330976334-10751-1-git-send-email-kerolasa@iki.fi>
	<1330976334-10751-10-git-send-email-kerolasa@iki.fi>
	<1330984305.2953.25.camel@offbook>
Date: Fri, 9 Mar 2012 08:56:04 +0100
Message-ID: <CAG27Bk2LYb6h8djj0yom17oKtAy6Vvfh85Fu2k8+M9kPQGhPZg@mail.gmail.com>
Subject: Re: [PATCH 09/17] lib: add fileutils function collection
From: Sami Kerola <kerolasa@iki.fi>
To: dave@gnu.org
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 5, 2012 at 22:51, Davidlohr Bueso <dave@gnu.org> wrote:
> On Mon, 2012-03-05 at 20:38 +0100, Sami Kerola wrote:
>>  create mode 100644 include/fileutils.h
>>  create mode 100644 lib/fileutils.c
>
> Doesn't really make much sense creating two files for just one
> function.  Couldn't xmkstemp() so somewhere else?  You might argue
> that xgetpass also does that, I just think it's an overkill...

Hi Davidlohr,

You are right, at least partially.  The reason why I added the files
is simply that non of the existing files felt correct to add this
function.  IMHO xgetpass.c would be more strange file to have
xmkstemp() than fileutils.c to contain xgetpass().

>> +/* Create open temporary file in safe way.  Please notice that the
>> + * file permissions are -rw------- by default. */
>> +FILE *xmkstemp(char **tmpname)
>
> Returning the file descriptor seems a more flexible interface
> instead of the FILE's representation; the user can always use
> fdopen on his own.

If I need temporary file I rather have stream than file descriptor.
Could you give example why flexibility is better than completeness.
With completeness I mean service that the function provides.  If
after every single occurrence of xmkstemp() there would be fdopen() I
would argue adding flexibility did not do anything good.

>> +     fd = mkstemp(localtmp);
>> +     umask(old_mode);
>> +     if (fd == -1)
>> +             goto err;
>
> the file isn't open on failure, just return NULL.

You are right. Fixed in my git.

Thank you for feedback.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
