Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f172.google.com ([209.85.128.172]:65371 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaEETfS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 15:35:18 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so1662206veb.17
        for <util-linux@vger.kernel.org>; Mon, 05 May 2014 12:35:17 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1399317654.11780.43.camel@oct.suse.cz>
References: <1399317654.11780.43.camel@oct.suse.cz>
Date: Mon, 5 May 2014 20:35:17 +0100
Message-ID: <CAG27Bk3HocOszOVAXfzTeLUgr_6fhgpRt61_KuwVxCV4tKADYQ@mail.gmail.com>
Subject: Re: [PATCH] hwclock: Warning typo fix
From: Sami Kerola <kerolasa@iki.fi>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 5 May 2014 20:20, Stanislav Brabec <sbrabec@suse.cz> wrote:
> Trailing '\n' is missing in:
> "Not setting clock because last adjustment time is zero, so history is bad."
>
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  sys-utils/hwclock.c | 2 +-

Hi Stanislav,

The hwclock.c change is OK. The po files are not updated this way.

See also http://www.spinics.net/lists/util-linux-ng/msg09087.html

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
