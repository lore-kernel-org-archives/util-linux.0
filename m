Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:46750 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbbCMJce (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 Mar 2015 05:32:34 -0400
Received: by wiwh11 with SMTP id h11so4345435wiw.5
        for <util-linux@vger.kernel.org>; Fri, 13 Mar 2015 02:32:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201503131000.29307.sweet_f_a@gmx.de>
References: <201503131000.29307.sweet_f_a@gmx.de>
Date: Fri, 13 Mar 2015 09:32:33 +0000
Message-ID: <CAG27Bk2Z4Rb=phtyXk+Oc4uLqOEpTmaA_AH_M+JZvEVMHvibgg@mail.gmail.com>
Subject: Re: tailf, really needed?
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 13 March 2015 at 09:00, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> As far as I understood tailf's advantage over "tail -f" is that it does
> not access the file when it does not grow. But nowadays
> coreutils "tail -f" also does not seem to access the file. So do we
> really need tailf?
>
> The point is that I've noticed that our tailf fails to deal with
> filesystems where inotify is broken. For example it does not work for
> overlayfs. coreutils tail code looks quite complicated and seems to
> manage such cases. Is it worth to fix our tailf or better just remove
> it and use "tail -f"?
>
> BTW coreutils tail is much more comfortable. It has many important
> options. For example watching log files without -F or --retry does not
> make sense to me (because of logrotate).
>
> Last but not least, is anybody using tailf at all? Google does not find
> much about people who are using this.

I'm in favor slapping deprecated note to tailf. When I double tab my
bash the result is:

Display all 3227 possibilities? (y or n)

and I think that's too many. Reducing number of commands where
similar functionality is provided elsewhere should result to better
overall software quality, and a system that is earlier to learn to use.
Less really is more in this case.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
