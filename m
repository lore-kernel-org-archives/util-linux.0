Return-Path: util-linux-owner@vger.kernel.org
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:44665 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaAXCSa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 23 Jan 2014 21:18:30 -0500
Date: Fri, 24 Jan 2014 02:16:02 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
Cc: util-linux@vger.kernel.org
Subject: Re: drill: Make a file sparse without using extra disk space
Message-ID: <20140124021602.GA28658@sdfg.com.ar>
References: <20140123212813.GE20054@sdfg.com.ar>
 <52E1BB47.80609@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <52E1BB47.80609@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 24, 2014 at 01:00:55AM +0000, Pádraig Brady wrote:
> On 01/23/2014 09:28 PM, Rodrigo Campos wrote:
> > Hi!
> > 
> > I've written a small simple tool to make a file sparse without using extra disk
> > space, it just digs holes on the file when possible. To dig the hole uses the
> > Linux-specific fallocate(2) syscall with FALLOC_FL_PUNCH_HOLE. So, also, it only
> > works on some file-systems.
> > 
> > Do you think that util-linux would be a good place for such a simple, linux-only
> > program ? The case I see it can be useful is to use on VM images file backed (or
> > I wrote it with this in mind, at least :)).
> > 
> This functionality is useful.
> Would it be possible to just add to fallocate with --punch-hole=sparse or something?

Totally, that's an option too :)

> Also dd has the conv=sparse option, so maybe this functionality can be added there.

But how are you going to do a hole in-place in a portable fashion ? I don't know
of any

> We're currently discussing that on the GNU coreutils mailing list.

You mean the thread "making a file sparse - in-place?" started after this thread ?




Thanks a lot,
Rodrigo
