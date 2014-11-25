Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45543 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478AbaKYLgN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 25 Nov 2014 06:36:13 -0500
Date: Tue, 25 Nov 2014 12:36:10 +0100
From: Karel Zak <kzak@redhat.com>
To: "SGT. Garcia" <darwinskernel@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: login: <Enter>/newline acting strange
Message-ID: <20141125113610.GD2610@x2.net.home>
References: <20141125021704.GC2488@vpn.5665sherbrooke.house>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141125021704.GC2488@vpn.5665sherbrooke.house>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 24, 2014 at 09:17:04PM -0500, SGT. Garcia wrote:
> i can bisect this @2.24.2 on gentoo; anything after that, including
> building from git, has the same problem. 
> tested with fish (the shell).

 Are you talking about login(8) or agetty(8)? (It's agetty who asks for
 username, login asks only after failed authentication.)

 I'm also not sure what does it mean <Enter>/newline. And what does it
 mean strange?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
