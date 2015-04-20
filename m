Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36846 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbbDTH21 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 Apr 2015 03:28:27 -0400
Received: by wizk4 with SMTP id k4so87449658wiz.1
        for <util-linux@vger.kernel.org>; Mon, 20 Apr 2015 00:28:26 -0700 (PDT)
Date: Mon, 20 Apr 2015 09:28:24 +0200
From: Alexey Galakhov <agalakhov@gmail.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
Message-ID: <20150420092824.13611c6b@aga-ws-01>
In-Reply-To: <5534498B.4080803@gmx.com>
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>
	<5534498B.4080803@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello William,

Am Sun, 19 Apr 2015 20:34:19 -0400
schrieb J William Piggott <elseifthen@gmx.com>:

>  I've been advocating for the removal of the compare function. One of
> my justifications for doing so is that it has been broken from day
> one and therefore nobody can be using for anything.
> 
>  So could you tell me how you are using it, and what useful purpose
> it is serving for you?

We use it in an automated test of the Linux system time on an embedded
system. Recently we fixed a kernel bug introduced by one of the 3rd
party patches that caused a huge (0.01%-0.1%) drift of the
CLOCK_REALTIME due to incorrect PLL initialization. The corresponding
test based on hwclock's compare is now added to our automated test
system. The test runs hwclock -c forever and fails if any drift
anomality is discovered.

Looks like hwclock -c works correctly at least in our case. I think it
could be rewritten using clock_gettime() instead of gettimeofday().

Regards,
Alexey
