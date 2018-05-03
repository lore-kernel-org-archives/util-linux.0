Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751075AbeECI15 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 3 May 2018 04:27:57 -0400
Date: Thu, 3 May 2018 10:27:54 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Subject: Re: configure output seems confusing in util-linux-2.32
Message-ID: <20180503082754.n3ktyq5xxvzkyykp@ws.net.home>
References: <5AE908A7.2010900@tlinx.org>
 <0a977638-61e0-2ffc-8b3e-e4c9dcbaea2a@gmail.com>
 <5AE9319E.6050105@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5AE9319E.6050105@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 01, 2018 at 08:33:50PM -0700, L A Walsh wrote:
>    That's a workaround to suppress the message.  Even without
> the '--without-systemdsystemunitdir', systemd appears to be
> disabled.  Under the summary of options, it had:
> 
>  Bash completions:  /usr/share/bash-completion
>  Systemd support:   no
>  Btrfs support:     yes
>  Wide-char support: yes
> 
>    It seems like it is more confusing than
> an actual problem.  Though, IMO, "--without-systemd"
> should disable any processing for the systemd unit dir as well,
> no? 

Fixed by commits:
https://github.com/karelzak/util-linux/commit/7a95313c31dcf95002dfb1d6e4fd8ed77c2adaf1

> And going with standard meanings, if the switch to toggle
> default behavior is the one listed in "configure --help", wouldn't
> the default have been --without-systemdsystemunitdir (boy that's
> a mouthful of a switch name)?

and --with and --without mess is fixed by commit:
https://github.com/karelzak/util-linux/commit/95a89bd3131cbce47055b5f1c15fb8c82a945502

Thanks for your report!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
