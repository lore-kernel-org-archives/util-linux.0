Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34433 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbcGLL4l (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 12 Jul 2016 07:56:41 -0400
Received: by mail-oi0-f67.google.com with SMTP id c199so963787oig.1
        for <util-linux@vger.kernel.org>; Tue, 12 Jul 2016 04:56:41 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <3421b4a5-023c-304b-3768-fa6f219d6300@gmx.com>
References: <20160710200242.2706-1-kerolasa@iki.fi> <3421b4a5-023c-304b-3768-fa6f219d6300@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 12 Jul 2016 12:56:40 +0100
Message-ID: <CAG27Bk2oLozR-Va_vcnNS9faDZKi5Q1tC+y2F6Ws9Ye7fGu_tw@mail.gmail.com>
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11 July 2016 at 21:23, J William Piggott <elseifthen@gmx.com> wrote:
>
> We use mktime(3) for portability.
>
> http://www.gnu.org/software/libc/manual/html_mono/libc.html#index-timegm
>
> Portability note: mktime is essentially universally available. timegm is
> rather rare. For the most portable conversion from a UTC broken-down
> time to a simple time, set the TZ environment variable to UTC, call
> mktime, then set TZ back.

I don't think hwclock(8) is portable. It has ioctl(2) calls, and such.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
