Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f169.google.com ([209.85.216.169]:53496 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbaKYQQL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 25 Nov 2014 11:16:11 -0500
Received: by mail-qc0-f169.google.com with SMTP id w7so667104qcr.28
        for <util-linux@vger.kernel.org>; Tue, 25 Nov 2014 08:16:10 -0800 (PST)
Date: Tue, 25 Nov 2014 11:16:08 -0500
From: "SGT. Garcia" <darwinskernel@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: login: <Enter>/newline acting strange
Message-ID: <20141125161608.GB3174@vpn.5665sherbrooke.house>
References: <20141125021704.GC2488@vpn.5665sherbrooke.house>
 <20141125113610.GD2610@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141125113610.GD2610@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Nov 25  12:36 +0100, Karel Zak wrote:
> On Mon, Nov 24, 2014 at 09:17:04PM -0500, SGT. Garcia wrote:
> > i can bisect this @2.24.2 on gentoo; anything after that, including
> > building from git, has the same problem. 
> > tested with fish (the shell).
> 
>  Are you talking about login(8) or agetty(8)? (It's agetty who asks for
>  username, login asks only after failed authentication.)
> 
>  I'm also not sure what does it mean <Enter>/newline. And what does it
>  mean strange?
> 
>     Karel

sorry for the poor explanation. login and agetty, both i guess. but culprit
seems to be kmscon and the way it handles unicode; had the same problem in
the past with vim. was there any change(s) regarding utf-8 with 2.24.2?
because that would explain it.
