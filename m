Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54156 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbbCCLdA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Mar 2015 06:33:00 -0500
Date: Tue, 3 Mar 2015 12:32:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/16] whereis: tell when mandatory option is missing
Message-ID: <20150303113250.GP8046@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-2-git-send-email-kerolasa@iki.fi>
 <20150224094007.GE19430@ws.net.home>
 <alpine.LNX.2.03.1503011106350.822@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.03.1503011106350.822@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 01, 2015 at 11:08:29AM +0000, Sami Kerola wrote:
> On Tue, 24 Feb 2015, Karel Zak wrote:
> 
> > On Sun, Feb 22, 2015 at 02:41:31PM +0000, Sami Kerola wrote:
> > >  misc-utils/whereis.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> >  Benno is right, see construct_dirlist_from_argv(), the dir list is
> >  terminated by arbitrary option, it checks for '-'.
> > 
> >  The expected use-case is "<dirlist> <search-restriction> <pattern>",
> >  for example:
> > 
> >     whereis -M /usr/share/man/man1 -m ls
> 
> Hi Benno & Karel,
> 
> I see, most of the options has to flick the opt_f_missing. Here is updated 
> version of the change.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/ada8f7f0b253a031936519f7953629d701832444

 Did you update your "various" branch? I still see old patches on
 github. (And I'd like to "git pull" :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
