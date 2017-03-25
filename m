Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34012 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbdCYS2H (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 25 Mar 2017 14:28:07 -0400
Received: by mail-qk0-f178.google.com with SMTP id d10so7192819qke.1
        for <util-linux@vger.kernel.org>; Sat, 25 Mar 2017 11:28:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20170321111156.i6kjcbmktj34lsvq@ws.net.home>
References: <6affdcde-0ec0-87ee-45f8-7da32ae1d1a5@gmail.com>
 <CAG27Bk3uXbmBs9cY8gK34YJuUVEY11CdGB0-ibiTQ9feXg_9og@mail.gmail.com> <20170321111156.i6kjcbmktj34lsvq@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 25 Mar 2017 18:28:00 +0000
Message-ID: <CAG27Bk1H9rHkYSmdZ8=YTrc7=yjXqf61tG+xFddNLX-GD_vzmQ@mail.gmail.com>
Subject: Re: sysfsutils, aka systool, candidate for inclusion in util-linux-ng
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 21 March 2017 at 12:14, Karel Zak <kzak@redhat.com> wrote:
> The question is if maintain it again is the right reaction to the
> current agony. Maybe death is better solution.
>
> I don't think it's widely used and IMHO it's probably used for trivial
> things like write/read from sysfs.
>
> For example we have for work with /sys/block a file lib/sysfs.c in
> utils-linux. Not sure if for something like this is necessary to have
> shared library.

I did a little bit more research what sysfsutils provides and who are
using it. 'Do not use libsysfs' in kernel documentation[1] is pretty
convincing hint this library should be left to be in state it is. Secondly
the list of projects I was able to find[2] had either migrated away
from the libsysfs or died.

I was able to find one exception,  iputils arping command. I sent
change to iputils maintainer that will remove libsysfs stuff moment
ago, so lets hope that will be sorted in future release.

TL;DR. not including sysfsutils to util-linux is the right thing.

[1] https://raw.githubusercontent.com/torvalds/linux/master/Documentation/admin-guide/sysfs-rules.rst
[2] https://www.archlinux.org/packages/core/i686/sysfsutils/

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
