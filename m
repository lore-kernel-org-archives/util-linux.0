Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59217 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbaFJMEp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jun 2014 08:04:45 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] build-sys: use gettext 0.18.3 if possible
Date: Tue, 10 Jun 2014 14:04:42 +0200
Cc: util-linux@vger.kernel.org
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de> <1402394931-20416-2-git-send-email-sweet_f_a@gmx.de> <20140610115208.GG30975@x2.net.home>
In-Reply-To: <20140610115208.GG30975@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406101404.42618.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 10 June 2014, Karel Zak wrote:
> On Tue, Jun 10, 2014 at 12:08:51PM +0200, Ruediger Meier wrote:
> > We add a little hack for backward compatibility on systems with
> > older gettext installed
> >
> > See 0576dbd3 and 81ed13ed.
> >
> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  autogen.sh   | 31 ++++++++++++++++++++++++++++++-
> >  configure.ac |  3 ++-
> >  2 files changed, 32 insertions(+), 2 deletions(-)
>
>  Ah, I see, it seems like another pin for our gettext voodoo doll.

Hehe.

>  Applied.

Ooops, in the cover letter I've mentioned that the new function would 
probably need some more small portability/safety fixes before final 
patch. Anyway I'll send them later.

One more thing. Since we have "0.18.3" now in configure.ac you should 
take care to release it next time on a system where at least this 
version is available. It wouldn't look nice if we ship files from 
different version.

cu,
Rudi
