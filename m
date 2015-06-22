Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37925 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbbFVRIz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 13:08:55 -0400
Received: by wibdq8 with SMTP id dq8so81745567wib.1
        for <util-linux@vger.kernel.org>; Mon, 22 Jun 2015 10:08:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1434990185-19883-1-git-send-email-andreas@fatal.se>
References: <1434990185-19883-1-git-send-email-andreas@fatal.se>
Date: Mon, 22 Jun 2015 18:08:53 +0100
Message-ID: <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
Subject: Re: [PATCH] rename: allow full-path renames
From: Sami Kerola <kerolasa@iki.fi>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux <util-linux@vger.kernel.org>,
        Andreas Henriksson <andreas.henriksson@endian.se>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 22 June 2015 at 17:23, Andreas Henriksson <andreas@fatal.se> wrote:
> The command "touch b0;rename.ul -v ./b0 ./b1 ./b0" used to work
> before "allow renaming in subdirectories" change.
> (regression in commit bd9ced628bb86)
>
> Addresses: https://bugs.debian.org/789240
> Reported-by: gregrwm <bug-grub@whitleymott.net>
> Signed-off-by: Andreas Henriksson <andreas@fatal.se>

Hi Andreas,

Change looks good, but I would add a test to avoid same regression
happening in future.  The same change with test can be found from
my git.

https://github.com/kerolasa/lelux-utiliteetit/commit/19ef4954935c65559e7561b4b3becbe462848127

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
