Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f43.google.com ([209.85.213.43]:32991 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbLFNkf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 Dec 2015 08:40:35 -0500
Received: by vkca188 with SMTP id a188so89951031vkc.0
        for <util-linux@vger.kernel.org>; Sun, 06 Dec 2015 05:40:34 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CABzuZRMr8ys9ikhnn0M3ChWythxcGNdEXY0TTktyN3PPggJspA@mail.gmail.com>
References: <20151206042923.GA6570@k3>
	<CAG27Bk1=y8+Dfyd19L1thfiaXBy6pvRxMV10EY=GeY_W+aqZXQ@mail.gmail.com>
	<CABzuZRMr8ys9ikhnn0M3ChWythxcGNdEXY0TTktyN3PPggJspA@mail.gmail.com>
Date: Sun, 6 Dec 2015 13:40:34 +0000
Message-ID: <CAG27Bk3=VnmcxBZ5FN2xB9iNNnW+VEgSjDs6t2YhK=B4r-eaOQ@mail.gmail.com>
Subject: Re: [PATCH] Add mount -P to hide pseudo filesystems
From: Sami Kerola <kerolasa@iki.fi>
To: David Wilson <dw@botanicus.net>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 December 2015 at 12:39, David Wilson <dw@botanicus.net> wrote:
> On 6 December 2015 at 10:22, Sami Kerola <kerolasa@iki.fi> wrote:
>> On 6 December 2015 at 04:29, David Wilson <dw@botanicus.net> wrote:
>>> @@ -842,6 +848,7 @@ int main(int argc, char **argv)
>>>                 { "make-rprivate", 0, 0, MOUNT_OPT_RPRIVATE },
>>>                 { "make-runbindable", 0, 0, MOUNT_OPT_RUNBINDABLE },
>>>                 { "no-canonicalize", 0, 0, 'c' },
>>> +               { "no-pseudofs", 0, 0, 'P' },
>>
>> Hi David,
>>
>> I doubt this is common enough case to assign short option.  How about
>> long-only option, see MOUNT_OPT_RUNBINDABLE for an example how to make
>> that work.
>
> I agree, although I see little value in a patch if it becomes hard to
> type. At that point copying around a wrapper script named 'mountp' is
> probably easier. :)
>
> How about some shorter spelling for --no-pseudofs, say, --real or
> --plain, or maybe it just becomes neater to extend -t. How about
> spellings of -t like:
>
> "-t [no]pseudo" -> anon_inodefs,bdev,cgroup,..,tmpfs
> "-t [no]net" -> cifs,smbfs,...,9p
> "-t [no]plain" -> nopseudo,nonet

Hi David,

Maybe you can rely gnu getops doing the right thing with '--no-p' when
typing. In scripts I recommend to use the full option. Try the
following ls(1) examples to see how the getops allows truncating long
options. I think it is unfortunate option shortening is not widely
know.

ls --h
ls --he

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
