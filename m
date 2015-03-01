Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sun, 1 Mar 2015 11:55:27 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 11/16] tailf: check printing criteria more carefully
In-Reply-To: <20150224115322.GM19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011149370.822@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi> <1424616106-580-12-git-send-email-kerolasa@iki.fi> <20150224115322.GM19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:41:41PM +0000, Sami Kerola wrote:
> > -	if (lseek(fd, *size, SEEK_SET) != (off_t)-1) {
> > +	if (st.st_ino != old->st_ino || st.st_dev != old->st_dev
> > +	    || (old->st_mtime < st.st_mtime && st.st_size <= old->st_size))
> > +		old->st_size = 0;
> 
>  So.. if I remove (truncate) last line from 1GiB file then tailf will 
>  print all the file *again*? Would be better to reset to st.st_size if the
>  size is smaller than old->st_size?
> 
>  Or maybe if you want to support "echo 1 >| file" use case than add a
>  new option (--rewind) or so.

Thanks Karel,

The 1GiB file last line truncation is such strong argument against the 
change that I removed it from my remote branch. Maybe the tailf.1 manual 
page should mention truncations are not handled always correctly, and 
that's as good the command is ever going to be.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
