Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35271 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab2HAIkn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Aug 2012 04:40:43 -0400
Date: Wed, 1 Aug 2012 10:40:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: tests: blkid/md-raid1-part fails
Message-ID: <20120801084038.GA1019@x2.net.home>
References: <501772B7.2040504@bernhard-voelker.de>
 <20120731135124.GB17896@x2.net.home>
 <5017EDFC.907@bernhard-voelker.de>
 <20120731180331.GD17896@x2.net.home>
 <5018CADB.4080300@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5018CADB.4080300@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 01, 2012 at 08:21:15AM +0200, Bernhard Voelker wrote:
> On 07/31/2012 08:03 PM, Karel Zak wrote:
> > On Tue, Jul 31, 2012 at 04:38:52PM +0200, Bernhard Voelker wrote:
> >>  tests/expected/blkid/md-raid1-part |   12 ++++++------
> >>  tests/ts/blkid/md-raid1-part       |   10 ++++++----
> >>  2 files changed, 12 insertions(+), 10 deletions(-)
> > 
> >  Applied, thanks!
> 
> Hi Karel,
> 
> I'm missing that change
> 
> >>  tests/ts/blkid/md-raid1-part       |   10 ++++++----
> 
> in commit v2.22-rc1-21-gebb8577.

 Sorry, fixed.

> What happened?

 I have applied the patch manually...

 Cannot you send the patches by 'git send-email' command?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
