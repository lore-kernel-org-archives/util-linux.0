Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35142 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbcATJjZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Jan 2016 04:39:25 -0500
Received: by mail-vk0-f44.google.com with SMTP id k1so1685074vkb.2
        for <util-linux@vger.kernel.org>; Wed, 20 Jan 2016 01:39:25 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20160119194443.GD14840@vapier.lan>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
	<20160119194443.GD14840@vapier.lan>
Date: Wed, 20 Jan 2016 09:39:24 +0000
Message-ID: <CAG27Bk1DyD_UPWmOjQB9bbzfqWvUK18tTUerUM-Jd_fFCH9xEw@mail.gmail.com>
Subject: Re: [PATCH] mkswap: Add warnings for insecure device permissions/owners
From: Sami Kerola <kerolasa@iki.fi>
To: "Wayne R. Roth" <wayneroth42@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 January 2016 at 19:44, Mike Frysinger <vapier@gentoo.org> wrote:
> On 19 Jan 2016 10:37, Wayne R. Roth wrote:
>> +        permMask = S_ISBLK(ctl.devstat.st_mode) ? 07007 : 07077;
>> +        if ((ctl.devstat.st_mode & permMask) != 0)
>> +                warnx(_("%s: insecure permissions %04o, %04o suggested."),
>> +                                ctl.devname, ctl.devstat.st_mode & 07777,
>> +                                ~permMask & 0666);
>> +        if (S_ISREG(ctl.devstat.st_mode) && ctl.devstat.st_uid != 0)
>> +                warnx(_("%s: insecure file owner %d, 0 (root) suggested."),
>> +                                ctl.devname, ctl.devstat.st_uid);
>
> i haven't read/tested the code, so my assumptions might be off, but this
> seems to complain even when creating files as non-root.  mkswap should
> not do that.  a perfectly reasonable use case is to create images as a
> non-root user for use with something like qemu.
>
> maybe you want to add a getuid() check in there, or scuttle it altogether.

I do not think mkswap, or mkfs of any sort, is an operation only root is
allowed or expected to run. Taking device(s) in use is different matter,
and that is already covered in swapon(8) and mount(8).

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
