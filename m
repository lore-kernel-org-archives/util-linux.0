Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f170.google.com ([209.85.128.170]:46178 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbaEHIqy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 8 May 2014 04:46:54 -0400
Received: by mail-ve0-f170.google.com with SMTP id db11so2891076veb.1
        for <util-linux@vger.kernel.org>; Thu, 08 May 2014 01:46:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201405071631.53729.sweet_f_a@gmx.de>
References: <201405071631.53729.sweet_f_a@gmx.de>
Date: Thu, 8 May 2014 09:46:53 +0100
Message-ID: <CAG27Bk0fWizWdEhQQUxQNVHp+SsM71qZwqgXgXbhVKxBZkmY+g@mail.gmail.com>
Subject: Re: last: please review -F and --time-format
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 7 May 2014 15:31, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> IMO -F and --time-format=xxx need some review/cleanup regarding
> logout times "still running" and "gone - no logout".
>
> Is there any reason why -F and --time-format=full
> look different? --time-format=notime looks ugly too.
>
> See the all the cases here:
> ------------
> for opt in -F --time-format=full --time-format=iso --time-format=short --time-format=notime; do
>     echo "### $opt ###"
>     ./last  -f ../tests/ts/last/wtmp.LE  $opt  | grep "running\| no logout"
> done
>
> ### -F ###
> torvalds linux        hobby            Mon Aug 26 02:57:08 1991   gone - no logout
> reboot   system boot  system-name      Wed Aug 28 20:00:00 2013   still running
> ### --time-format=full ###
> torvalds linux        hobby            Mon Aug 26 02:57:08 1991    gone                    - no logout
> reboot   system boot  system-name      Wed Aug 28 20:00:00 2013   still                    running
> ### --time-format=iso ###
> torvalds linux        hobby            1991-08-26T02:57:08+0200   gone - no logout
> reboot   system boot  system-name      2013-08-28T20:00:00+0200   still running
> ### --time-format=short ###
> torvalds linux        hobby            Mon Aug 26 02:57    gone - no logout
> reboot   system boot  system-name      Wed Aug 28 20:00   still running
> ### --time-format=notime ###
> torvalds linux        hobby              - no logout
> reboot   system boot  system-name        running

Hi Ruediger,

The alignment makes sense when you look the printout where there are
sessions  that are still present, no logout, and logged out. In
--time-format=full the hyphen in front of 'no logout' does look a bit
silly. If it really bothers you send a patch.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
