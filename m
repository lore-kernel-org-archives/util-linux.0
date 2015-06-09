Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58429 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbbFIJYP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Jun 2015 05:24:15 -0400
Date: Tue, 9 Jun 2015 11:24:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Martin Steigerwald <ms@teamix.de>
Cc: util-linux@vger.kernel.org
Subject: Re: chrt: inconsistency in --help
Message-ID: <20150609092412.GG1992@ws.net.home>
References: <716925135.onXIMLDpa0@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <716925135.onXIMLDpa0@merkaba>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 09, 2015 at 10:37:46AM +0200, Martin Steigerwald wrote:
> Suggestion:
> 
> 1) Either make chrt command parsing more flexible (preffered)

 Unfortunately we have to care about backward compatibility...

> 2) or or even and change set policy to
> 
> Set policy:
>   chrt [options] [-p] [<policy>] <priority> [<pid> | <command> [<arg>...]]

 Yes, I have modified --help output to this

> But well second option separates -p from pid. So maybe option 1 is the way 
> to go.

 It's not elegant, but unfortunately used for years and I don't think
 we want to make it more complex by any improvement.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
