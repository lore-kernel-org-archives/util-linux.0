Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665Ab2DWKHy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 06:07:54 -0400
Date: Mon, 23 Apr 2012 12:07:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] prlimit: remove bogus instructions
Message-ID: <20120423100750.GD8144@x2.net.home>
References: <1334397663.2564.0.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334397663.2564.0.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 14, 2012 at 12:01:03PM +0200, Davidlohr Bueso wrote:
> sys-utils/prlimit.c |    2 --
> 1 files changed, 0 insertions(+), 2 deletions(-)

 Applied, thanks.

 BTW, some (including really expensive) static analyzers have no clue
 about 'noreturn' function attribute :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
