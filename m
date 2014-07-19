Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:43968 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaGSWok (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 19 Jul 2014 18:44:40 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so5844355wes.11
        for <util-linux@vger.kernel.org>; Sat, 19 Jul 2014 15:44:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGqmi765JkidXDpi6bP2qUk5U7Xry5nF7y0WY4Y6M_Fq8Eiqeg@mail.gmail.com>
References: <53CAAAB6.6020607@gmail.com> <CAG27Bk3aPD6zx+t1kPsUnF-70ZjuCrEqh77SPJNpi5cDgYSN_w@mail.gmail.com>
 <CAGqmi765JkidXDpi6bP2qUk5U7Xry5nF7y0WY4Y6M_Fq8Eiqeg@mail.gmail.com>
From: Timofey Titovets <nefelim4ag@gmail.com>
Date: Sun, 20 Jul 2014 01:44:18 +0300
Message-ID: <CAGqmi74L8jDKqA-sZR4GWjnvNkBowrUNdYsVGN43ApYaJUWc5w@mail.gmail.com>
Subject: Fwd: [RFC] Zram handle util
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)@mail.corp.redhat.com
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks for comment and boilerplate.c file.

I think it can't be related to systemd or udev, because as i know zram
configure and using with using many different scripts or through udev
config files. May be in future i open discuss in systemd-devel about
zramctl but now, i try to close several things in systemd todo, like
readahead optimization.

> By glance it seems a good utility would be able to integrate with udev
> and systemd, it should have add, remove, and possibly modify method. I
> would prefer the command to list what is current status of zram
> devices when nothing else is instructed. And of course manual page is
> needed. See util-linux/Documentation/howto-man-page.txt file to get
> manual done.

Also, kernel can't add or delete zram devices on demand, it hard coded
in module. Yes, i can reload module every time, but it awkward.
I write patch for correct this https://lkml.org/lkml/2014/7/17/664 ,
but now it not merged(and will it?).

I just want to make all acceptable generic solution (i can configure
loop devices through sysfs, but i have losetup...).

zramctl have status command:
$ zramctl status
 NAME     DISKSIZE       ORIG    COMPRES  ALG  THR
 zram0  1073741824     401408              8101   lz4   4
 zram1  1073741824              0                   0   lz4   4

> Without any investigation I have no idea what should be done with
> systemd integration. The zramctl might need a systemd service file,
> and possibly some sort of configuration file to setup the devices at
> boot desired way. Or something totally different. I am sure there is
> someone who knows what should be done, and with a bit of luck the mail
> archive discussion I pointed out has an answer to this already.
> --
> Sami Kerola
> http://www.iki.fi/kerolasa/

I also have custom systemd-swap script (handle swap device, zram
swaps, file swaps), what depend on zramctl, and i think if systemd
maintainers will want to expand various swap setting inside systemd, i
implement can it.

--
Best regards,
Timofey.
