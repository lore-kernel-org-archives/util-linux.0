Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62500 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754749Ab2EBRh4 convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 May 2012 13:37:56 -0400
Received: by lahj13 with SMTP id j13so632640lah.19
        for <util-linux@vger.kernel.org>; Wed, 02 May 2012 10:37:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1334862654-32253-1-git-send-email-kerolasa@iki.fi>
References: <1334862654-32253-1-git-send-email-kerolasa@iki.fi>
Date: Wed, 2 May 2012 19:37:55 +0200
Message-ID: <CAG27Bk3B3J456tO8s+vk0mGvAVns_nVkHVH8KdAeb7nvkkc7ng@mail.gmail.com>
Subject: Re: [PATCH] wdctl: align with other util-linux commands
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 19, 2012 at 9:10 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> * Add watchdog device path to pathnames.h
> * Check output stream status at exit.
> * Adjust usage() notation to follow howto file.
> * Retire numeric return value.
>
>  include/pathnames.h |    2 ++
>  sys-utils/wdctl.c   |   10 +++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)

Hi Karel,

It's been while since I sent this to review. Perhaps it is soon time
to accept or reject the patch.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
