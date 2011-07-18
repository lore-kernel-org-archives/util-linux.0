Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11143 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab1GRWVm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 18:21:42 -0400
Date: Tue, 19 Jul 2011 00:21:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Jon Stanley <jonstanley@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add support for books
Message-ID: <20110718222130.GF4354@nb.redhat.com>
References: <20110705112909.GA3450@osiris.boeblingen.de.ibm.com> <20110711104035.GH5214@nb.net.home> <20110713034618.GA2968@osiris.boeblingen.de.ibm.com> <20110718091017.GI3486@nb.net.home> <CALY6xnjDxrUWO5su4wqHhwR0=SmZ+bqPVZD1mEqrfRoqSQiV5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALY6xnjDxrUWO5su4wqHhwR0=SmZ+bqPVZD1mEqrfRoqSQiV5g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 18, 2011 at 11:17:24AM -0400, Jon Stanley wrote:
> On Mon, Jul 18, 2011 at 5:10 AM, Karel Zak <kzak@redhat.com> wrote:
> 
> >  I'm not sure if the currently used extra separators (,,) for the
> >  caches is a good idea. Maybe it would be better to force people to
> >  parse the last comment line where is the header for the columns.
> 
> Speaking as a user of lscpu, I think that forcing people to parse the
> last comment line is not a particularly good idea - no one is used to
> doing it, and I'm not sure of any other utility that forces you to
> parse it's "machine-readable" output. Stability of this format is key.

 Yes, -p sucks ;-)

> >  The ideal solution is to extend the "-p" functionality and allow to
> >  specify expected columns at command line, something like:
> >
> >    lscpu -p -o cpu,core,book,socket
> 
> I think that this is the only long-term supportable way to do this.
> CPU architectures (even in the x86 world that I'm interested in) ARE
> going to change and evolve. Heck, it's even possible that concepts
> like the hypervisor scheduling parameters that you mentioned on s390
> could eventually make their way down to x86 virtualization, and
> exposing stuff like that in lscpu would be nice.

 I'll try to add this functionality in next days.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
