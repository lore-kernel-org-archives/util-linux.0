Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932384AbaD2Kmq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Apr 2014 06:42:46 -0400
Date: Tue, 29 Apr 2014 12:42:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Jesper Dahl Nyerup <nyerup@one.com>
Cc: =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>,
        util-linux@vger.kernel.org, Vedpal Rajera <vedpalr@one.com>,
        Martin Topholm <mph@one.com>
Subject: Re: Using script(1) to log all user sessions
Message-ID: <20140429104240.GA12056@x2.net.home>
References: <20140425082133.GA3790@one.com>
 <535D6026.1000709@zoho.com>
 <20140429100028.GA31241@one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140429100028.GA31241@one.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 29, 2014 at 12:00:28PM +0200, Jesper Dahl Nyerup wrote:
> > >1. Adding a daemon next to script(1) and scriptreplay(1), eg.
> > >scriptcollect(1), to be in the receiving end of the traffic, [...]
> > 
> > I'm unsure about this bit. It may be needed. Perhaps a transfer
> > after the session finishes also works.
> 
> We also considered that, but we keep running in to theoretical corner
> cases where this could end up being a problem - logging in on systems
> with filled up mountpoints, securing the transcript even if the system
> crashes, and so on.

You don't have to transfer the logs after finished session, but in
small segments (script(1) only add new entries to the file). The same
idea uses large databases for on-line backups
(http://www.postgresql.org/docs/8.1/static/backup-online.html)


The another (IMHO the best) possibility is to log into systemd journal, 
it supports all necessary advantages. See

  http://www.freedesktop.org/software/systemd/man/sd-journal.html

for example sd_journal_stream_fd(). I'm not sure, but it's probably
already possible to somehow mirror the journal over network or log to
remote machine.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
