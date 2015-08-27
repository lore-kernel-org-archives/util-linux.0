Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f173.google.com ([209.85.223.173]:34332 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbH0RID (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Aug 2015 13:08:03 -0400
Received: by iodb91 with SMTP id b91so64479542iod.1
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2015 10:08:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150827092254.GE2410@ws.net.home>
References: <20150826220141.GA8579@www.outflux.net>
	<20150827092254.GE2410@ws.net.home>
Date: Thu, 27 Aug 2015 10:08:02 -0700
Message-ID: <CAGXu5j+4LUNRb-5-KtwoM8pu7jScTFA2yKZ3KhJSLORpzCz+UQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests: add very long mount line to libmount mtab
From: Kees Cook <keescook@chromium.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 27, 2015 at 2:22 AM, Karel Zak <kzak@redhat.com> wrote:
>
>  Hi Kees,
>
> On Wed, Aug 26, 2015 at 03:01:41PM -0700, Kees Cook wrote:
>>  tests/expected/libmount/tabfiles-parse-mtab    | 7 +++++++
>>  tests/expected/libmount/tabfiles-py-parse-mtab | 7 +++++++
>>  tests/ts/libmount/files/mtab                   | 1 +
>>  3 files changed, 15 insertions(+)
>
> I have problem to apply the patch
>
> $ git am -i ...
>
> Applying: tests: add very long mount line to libmount mtab
> fatal: corrupt patch at line 28
> Patch failed at 0001 tests: add very long mount line to libmount mtab
> The copy of the patch that failed is found in:
>    /home/projects/util-linux/util-linux/.git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> ...
>
> # patch -p1 < /home/projects/util-linux/util-linux/.git/rebase-apply/patch
> patching file tests/expected/libmount/tabfiles-parse-mtab
> patch: **** malformed patch at line 18
>
>
> ... etc.
>
> It would be probably better to publish the patch on github or send it
> as gzip.

Hhehe. My test broke everything! :)

Here it is on github:
https://github.com/karelzak/util-linux/pull/217

Thanks!

-Kees

>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com



-- 
Kees Cook
Chrome OS Security
