Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43053 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab2DEIXy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Apr 2012 04:23:54 -0400
Date: Thu, 5 Apr 2012 10:23:50 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>, teg@jklm.no
Subject: Re: [PATCH 13/20] uuidd: add systemd unit files
Message-ID: <20120405082350.GB20515@x2.net.home>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-14-git-send-email-petr.uzel@suse.cz>
 <20120403140140.GK1084@x2.net.home>
 <CAG-2HqUudB4k4xGq7b7iwYGRCa-7eam0TmQGd9B35MhC3sBfKg@mail.gmail.com>
 <20120405075240.GE22664@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120405075240.GE22664@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 05, 2012 at 09:52:40AM +0200, Petr Uzel wrote:
> On Tue, Apr 03, 2012 at 04:47:00PM +0200, Tom Gundersen wrote:
> > On Tue, Apr 3, 2012 at 4:01 PM, Karel Zak <kzak@redhat.com> wrote:
> > > On Thu, Mar 29, 2012 at 06:45:21PM +0200, Petr Uzel wrote:
> > >> +AC_ARG_WITH([systemdsystemunitdir],
> > >> +  AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [directory for systemd service files]),
> > >
> > >  systemdsystemunitdir ???
> > 
> > This is the variable name most other projcts use for this purpos. The
> > reason being that it is suggested here:
> > <http://0pointer.de/public/systemd-man/daemon.html>.
> 
> I'd prefer to stick with what systemd doc recommends (^^) and what
> other projects use, even if it might be unnecessarily long. Karel, OK
> with you to keep this?

 OK

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
