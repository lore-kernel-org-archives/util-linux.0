Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41235 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429AbcCROih (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Mar 2016 10:38:37 -0400
Date: Fri, 18 Mar 2016 15:38:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] ipcs: more robust and compatible /proc parsing
Message-ID: <20160318143835.t67nryjbrdn5nz4s@ws.net.home>
References: <1458301758-21853-1-git-send-email-sweet_f_a@gmx.de>
 <20160318134822.hx2f5byqrocdoysn@ws.net.home>
 <201603181503.32657.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603181503.32657.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 18, 2016 at 03:03:32PM +0100, Ruediger Meier wrote:
> On Friday 18 March 2016, Karel Zak wrote:
> > On Fri, Mar 18, 2016 at 12:49:16PM +0100, Ruediger Meier wrote:
> > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > >
> > > If this looks ok for shm then we could also add similar patches for
> > > sem and msg.
> >
> > Seems good, I'll wait for complete set of the patches, ok?
> 
> For msg and sem we don't have compatibility problems or bugs in real 
> life but only these _potential_ fscanf issues. Not so important for 
> 2.28.
> 
> I would like to do that later in a project wide scanf review but without 
> hurry.

 OK, Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
