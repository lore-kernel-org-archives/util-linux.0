Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33183 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754837AbaGNOoG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 10:44:06 -0400
Message-Id: <1405349045.14846.141445537.76539913@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140714141709.GK30288@x2.net.home>
References: <1404912550-2573-1-git-send-email-bensberg@justemail.net>
 <20140714134855.GC30288@x2.net.home>
 <1405346109.2706.141424829.357CACFE@webmail.messagingengine.com>
 <20140714141709.GK30288@x2.net.home>
Subject: Re: [PATCH 1/2] textual: fix the usage message of kill
Date: Mon, 14 Jul 2014 16:44:05 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Jul 14, 2014, at 16:17, Karel Zak wrote:
> On Mon, Jul 14, 2014 at 03:55:09PM +0200, Benno Schulenberg wrote:
> > It's a pity that it invalidates already translated strings, but it
> > can't be helped.  It's kind of my fault; I should have had a look
> > at rc-1.
> 
> Yep, it would be nice to found a way how to solve this kind of problem
> next time, almost always we have bug reports from translators, but
> it's too late...

I had already kind of resolved that on the next rc1 I would
forward the POT file to a few of the more active translators,
and ask them to help look for errors and unclarities.  So with
a little luck, 2.26 will ship with several complete translations.

Benno

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own

