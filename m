Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59069 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbaAXJex (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jan 2014 04:34:53 -0500
Date: Fri, 24 Jan 2014 10:34:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        util-linux@vger.kernel.org
Subject: Re: drill: Make a file sparse without using extra disk space
Message-ID: <20140124093448.GA24972@x2.net.home>
References: <20140123212813.GE20054@sdfg.com.ar>
 <52E1BB47.80609@draigBrady.com>
 <20140124021602.GA28658@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140124021602.GA28658@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 24, 2014 at 02:16:02AM +0000, Rodrigo Campos wrote:
> On Fri, Jan 24, 2014 at 01:00:55AM +0000, Pádraig Brady wrote:
> > On 01/23/2014 09:28 PM, Rodrigo Campos wrote:
> > > I've written a small simple tool to make a file sparse without using extra disk
> > > space, it just digs holes on the file when possible.

 Nice idea.

> > > To dig the hole uses the
> > > Linux-specific fallocate(2) syscall with FALLOC_FL_PUNCH_HOLE. So, also, it only
> > > works on some file-systems.
> > > 
> > > Do you think that util-linux would be a good place for such a simple, linux-only
> > > program ? The case I see it can be useful is to use on VM images file backed (or
> > > I wrote it with this in mind, at least :)).
> > > 
> > This functionality is useful.
> > Would it be possible to just add to fallocate with --punch-hole=sparse or something?
> 
> Totally, that's an option too :)

 It would be the best way for util-linux, I really don't want to add
 another util for fallocate.

 Maybe we can use a new option --dig-holes [ --length <size> ] or so.

> > Also dd has the conv=sparse option, so maybe this functionality can be added there.

 IMHO would be possible to add this functionality to both places ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
