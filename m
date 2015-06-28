Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34945 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbbF1IaZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 04:30:25 -0400
Received: by wiga1 with SMTP id a1so47555174wig.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 01:30:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CA+jjjYSw=pO-Rk9LfyUSPqYc35kwc0xwGX2iQ5g9Z9t8cishsg@mail.gmail.com>
References: <CA+jjjYT6T0A=bY5=Kbga+WhR0FZse1LdHLmDCxFqhRspvS-gdw@mail.gmail.com>
	<alpine.LNX.2.03.1506211326540.3757@iki.fi>
	<CA+jjjYSw=pO-Rk9LfyUSPqYc35kwc0xwGX2iQ5g9Z9t8cishsg@mail.gmail.com>
Date: Sun, 28 Jun 2015 09:30:23 +0100
Message-ID: <CAG27Bk0sT6=7RT6BkbWA5os24VNT7mM8QANmE31puqFw9+1Eog@mail.gmail.com>
Subject: Re: mkfs.minix misbehaves on 4GB filesystems
From: Sami Kerola <kerolasa@iki.fi>
To: Joshua Hudson <joshudson@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 28 June 2015 at 01:11, Joshua Hudson <joshudson@gmail.com> wrote:
> +       if (BLOCKS > MINIX_MAX_INODES * BITS_PER_BLOCK)
> +               BLOCKS = MINIX_MAX_INODES * BITS_PER_BLOCK;     /*
> Utter maximum: Clip. */
>
> Adjustment was not quite correct. The limit constant here is 5 smaller
> than the multiplication would lead you to guess (boot, super, imap,
> inode, overflow).

Magic number 4 is added back to the commit.

https://github.com/kerolasa/lelux-utiliteetit/commit/20db4e07f75145c1eca7e8209efe0e246f480f51#diff-4c9bda8f12f6b5bb40a2181cb7bf0b89L794

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
