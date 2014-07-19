Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f169.google.com ([209.85.192.169]:57128 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaGSTMu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 19 Jul 2014 15:12:50 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so6842585pdj.28
        for <util-linux@vger.kernel.org>; Sat, 19 Jul 2014 12:12:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <53CAAAB6.6020607@gmail.com>
References: <53CAAAB6.6020607@gmail.com>
Date: Sat, 19 Jul 2014 20:12:49 +0100
Message-ID: <CAG27Bk3aPD6zx+t1kPsUnF-70ZjuCrEqh77SPJNpi5cDgYSN_w@mail.gmail.com>
Subject: Re: [RFC] Zram handle util
From: Sami Kerola <kerolasa@iki.fi>
To: Timofey Titovets <nefelim4ag@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 July 2014 18:28, Timofey Titovets <nefelim4ag@gmail.com> wrote:

Hi Timofey,

I'm not the util-linux maintainer, but since I've done few
contributions perhaps I can give couple hints how to proceed.

> I want hear your opinions.
> Several days ago, i writed zramctl util (on C++) for have useful app for
> setup zrams..

Sounds potentially useful.

> Code hosted her: https://github.com/Nefelim4ag/zramctl
>
> Examples:
> zramctl find # return name of first free device (zram0)
> zramctl find 1024M lz4 4 # (i not implement -? options now)
>                          # 4 - threads
>                          # setup and return name of device (zram1)
> zramctl reset zram0 zram1 ...
>
> I want to port it on C and try include it in util-linux, like losetup.
> It has a sense? What do you think?

There are all sorts of small things each command in this package is
expected to do. Good way to get introduced with them is to take the
sample code below, and modify it to be the new command.

https://github.com/karelzak/util-linux/blob/master/Documentation/boilerplate.c

But before getting too excited about writing new tool it might be
worth while to investigate related discussion.

https://www.mail-archive.com/systemd-devel@lists.freedesktop.org/msg16342.html

By glance it seems a good utility would be able to integrate with udev
and systemd, it should have add, remove, and possibly modify method. I
would prefer the command to list what is current status of zram
devices when nothing else is instructed. And of course manual page is
needed. See util-linux/Documentation/howto-man-page.txt file to get
manual done.

Without any investigation I have no idea what should be done with
systemd integration. The zramctl might need a systemd service file,
and possibly some sort of configuration file to setup the devices at
boot desired way. Or something totally different. I am sure there is
someone who knows what should be done, and with a bit of luck the mail
archive discussion I pointed out has an answer to this already.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
