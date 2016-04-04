Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbcDDI1w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Apr 2016 04:27:52 -0400
Date: Mon, 4 Apr 2016 10:27:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] chrt: make --sched-* short options to require an
 argument
Message-ID: <20160404082749.tqyzkgyba2ed77kr@ws.net.home>
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
 <1459672529-2278-2-git-send-email-kerolasa@iki.fi>
 <20160404002100.eqclqk2rqbttbued@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160404002100.eqclqk2rqbttbued@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 04, 2016 at 02:21:00AM +0200, Karel Zak wrote:
> On Sun, Apr 03, 2016 at 09:35:27AM +0100, Sami Kerola wrote:
> > These options are expecting an argument, and the long options struct already
> > required them.
> 
>  Good catch, but deadline and runtime should be optional arguments (it
>  seems I have merged wrong version of my patch:-(

Sorry, didn't read the patch correctly. You're right. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
