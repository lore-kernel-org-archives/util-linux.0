Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f182.google.com ([209.85.223.182]:33644 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeFGJfx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 7 Jun 2018 05:35:53 -0400
Received: by mail-io0-f182.google.com with SMTP id d185-v6so11069722ioe.0
        for <util-linux@vger.kernel.org>; Thu, 07 Jun 2018 02:35:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <9d6d94f3-cb99-45e6-4170-2bb744f5878b@suse.de>
References: <9d6d94f3-cb99-45e6-4170-2bb744f5878b@suse.de>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 7 Jun 2018 10:35:52 +0100
Message-ID: <CAG27Bk3dTjXhcsoBpWTORRsdJk8A7ZiO=jF0B8BkdJd-YwAWag@mail.gmail.com>
Subject: Re: Bug: "blkid -o list" output formating is broken
To: Dominik Heidler <dheidler@suse.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 June 2018 at 15:50, Dominik Heidler <dheidler@suse.de> wrote:
> when I run "blkid -o list" on a terminal with width >= 178 chars
> the output will be broken:
> https://paste.opensuse.org/view/raw/84899108
>
> It will shift the table output and create longer lines than the
> terminal width generating linebreaks and breaking the readability of
> the table.
>
> I was able to reproduce this issue with util-linux-2.32.

Hi Dominik,

>From bklid(8) manual page:

  It is recommended to use lsblk(8) command to get information about block
  devices, or lsblk --fs to get an overview of filesystems, or findmnt(8) to
  search in already mounted filesystems.

  lsblk(8) provides more information, better control on output formatting,
  easy to use in scripts and it does not require root permissions to get
  actual information. <and so on>

Notice that the manual page also has marked --output=list deprecated
in favour of the lsblk(8) command. So it is _very_ unlikely changes to
that output format are accepted by Karel who maintains the project.
That basically means bugs in that format are now features.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
