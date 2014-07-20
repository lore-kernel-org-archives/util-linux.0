Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57377 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaGTOpj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jul 2014 10:45:39 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so2878899wib.11
        for <util-linux@vger.kernel.org>; Sun, 20 Jul 2014 07:45:38 -0700 (PDT)
MIME-Version: 1.0
From: Timofey Titovets <nefelim4ag@gmail.com>
Date: Sun, 20 Jul 2014 17:45:17 +0300
Message-ID: <CAGqmi77q_9HV1v-aGi21EQ96-f4C-J06GqYNb-RA9UzkMJRm-w@mail.gmail.com>
Subject: Re: [RFC] Zram handle util
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

(Sami Kerola sorry for spamming, i just can't catch this message in
mailing list)

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
