Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58780 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754947AbaGNNzK (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 09:55:10 -0400
Message-Id: <1405346109.2706.141424829.357CACFE@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 1/2] textual: fix the usage message of kill
Date: Mon, 14 Jul 2014 15:55:09 +0200
In-Reply-To: <20140714134855.GC30288@x2.net.home>
References: <1404912550-2573-1-git-send-email-bensberg@justemail.net>
 <20140714134855.GC30288@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Jul 14, 2014, at 15:48, Karel Zak wrote:
> On Wed, Jul 09, 2014 at 03:29:09PM +0200, Benno Schulenberg wrote:
> >  misc-utils/kill.c |   20 ++++++++++----------
> >  1 files changed, 10 insertions(+), 10 deletions(-)
> 
>  I guess we want to merge this patch (that modifies already translated
>  strings) after release, right?

Don't know...  Better do it now, so you can also apply Sami's patch
and have things working correctly.  Very few people will be using
this version of kill, so few will experience missing translations.

It's a pity that it invalidates already translated strings, but it
can't be helped.  It's kind of my fault; I should have had a look
at rc-1.

Benno

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow

