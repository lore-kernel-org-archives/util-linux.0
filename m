Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38375 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbbF1ALM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Jun 2015 20:11:12 -0400
Received: by wibdq8 with SMTP id dq8so44559885wib.1
        for <util-linux@vger.kernel.org>; Sat, 27 Jun 2015 17:11:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.03.1506211326540.3757@iki.fi>
References: <CA+jjjYT6T0A=bY5=Kbga+WhR0FZse1LdHLmDCxFqhRspvS-gdw@mail.gmail.com>
	<alpine.LNX.2.03.1506211326540.3757@iki.fi>
Date: Sat, 27 Jun 2015 17:11:10 -0700
Message-ID: <CA+jjjYSw=pO-Rk9LfyUSPqYc35kwc0xwGX2iQ5g9Z9t8cishsg@mail.gmail.com>
Subject: Re: mkfs.minix misbehaves on 4GB filesystems
From: Joshua Hudson <joshudson@gmail.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

+       if (BLOCKS > MINIX_MAX_INODES * BITS_PER_BLOCK)
+               BLOCKS = MINIX_MAX_INODES * BITS_PER_BLOCK;     /*
Utter maximum: Clip. */

Adjustment was not quite correct. The limit constant here is 5 smaller
than the multiplication would lead you to guess (boot, super, imap,
inode, overflow).
