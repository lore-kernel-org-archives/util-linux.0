Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f176.google.com ([209.85.128.176]:36376 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbaEHJKY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 8 May 2014 05:10:24 -0400
Received: by mail-ve0-f176.google.com with SMTP id jz11so2853642veb.21
        for <util-linux@vger.kernel.org>; Thu, 08 May 2014 02:10:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201405072212.12680.sweet_f_a@gmx.de>
References: <1399482068-6460-1-git-send-email-kerolasa@iki.fi>
	<201405072212.12680.sweet_f_a@gmx.de>
Date: Thu, 8 May 2014 10:10:23 +0100
Message-ID: <CAG27Bk0EkS3kha5Gab+1pWDYT3n=dWCc1q=8MdSAaSHF7ouACQ@mail.gmail.com>
Subject: Re: [PATCH] tests: make kill to go-around when /proc is not available
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 7 May 2014 21:12, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> On Wednesday 07 May 2014, Sami Kerola wrote:
>> [PATCH] tests: make kill to go-around when /proc is not available
>
> Do you really want to get it work when whole /proc is not available
> or just if /proc/$pid/status is still missing?

Hi Rudi,

Right, sloppy from my side. The title should say 'if /proc/$pid/status
is missing'. Test to check availability of /proc should be in
test/functions.sh, and where /proc is missing should gracefully bail
out before starting signal helper. If /proc/$pid is available, but not
the status file then waiting is unlikely to help, and opportunistic
sleep is most likely the best option.

I'll write new change before Sunday.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
