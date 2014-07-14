Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33379 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412AbaGNORO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 10:17:14 -0400
Date: Mon, 14 Jul 2014 16:17:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] textual: fix the usage message of kill
Message-ID: <20140714141709.GK30288@x2.net.home>
References: <1404912550-2573-1-git-send-email-bensberg@justemail.net>
 <20140714134855.GC30288@x2.net.home>
 <1405346109.2706.141424829.357CACFE@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405346109.2706.141424829.357CACFE@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 14, 2014 at 03:55:09PM +0200, Benno Schulenberg wrote:
> 
> On Mon, Jul 14, 2014, at 15:48, Karel Zak wrote:
> > On Wed, Jul 09, 2014 at 03:29:09PM +0200, Benno Schulenberg wrote:
> > >  misc-utils/kill.c |   20 ++++++++++----------
> > >  1 files changed, 10 insertions(+), 10 deletions(-)
> > 
> >  I guess we want to merge this patch (that modifies already translated
> >  strings) after release, right?
> 
> Don't know...  Better do it now, so you can also apply Sami's patch
> and have things working correctly.  Very few people will be using
> this version of kill, so few will experience missing translations.

Well, procps version is deprecated in favour of kill(1) from u-l ;-)
(The built-in shell kill command is another story.)

> It's a pity that it invalidates already translated strings, but it
> can't be helped.  It's kind of my fault; I should have had a look
> at rc-1.

Yep, it would be nice to found a way how to solve this kind of problem
next time, almost always we have bug reports from translators, but
it's too late...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
