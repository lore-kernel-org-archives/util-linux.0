Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754287AbeFLKz0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 Jun 2018 06:55:26 -0400
Date: Tue, 12 Jun 2018 12:55:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Alexey Gladkov <legion@altlinux.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: hardlink util -- files de-duplication
Message-ID: <20180612105522.byg6agpta355f73x@ws.net.home>
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
 <20180601132930.GA5803@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180601132930.GA5803@altlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 01, 2018 at 04:29:30PM +0300, Dmitry V. Levin wrote:
> On Fri, Jun 01, 2018 at 01:38:07PM +0200, Karel Zak wrote:
> > For last 17 years in Red Hat based distros is available hardlink(1)
> > util, man hardlink:
> > 
> >    hardlink traverses one or more directories searching for duplicate
> >    files.  When it finds duplicate files, it uses one of them as the
> >    master.  It then removes all other duplicates and places a hardlink
> >    for each one pointing to the master file.  This allows for
> >    conservation of disk space where multiple directories on a single
> >    filesystem contain many  dupli‐ cate files.
> > 
> >    ...
> > 
> > the util is little bit orphaned, what about to add this util to
> > util-linux to make it available for another distros and keep it
> > maintained in serious way? ;-)
> > 
> >    https://src.fedoraproject.org/cgit/rpms/hardlink.git/
> > 
> > It's one .c file.
> > 
> > Comments & objections?
> 
> Better late than never.
> 
> BTW, our hardlink package has some Owl patches applied,
> please remind us to rebase and submit them. ;)

It seems there is no any strong objection against hardlink. So, I
think we can add it as *optional* (--enable-hardlink) to util-linux.
IMHO it's good idea to have such tool in basic Linux toolset.

The long term goal should be to add another new features
to make it more attractive to users who have to use another
alternatives now :-)


I won't have enough time in next two weeks to work on this task (fix
indention, reuse some lib/ stuff, etc.), so any volunteer(s)? ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
