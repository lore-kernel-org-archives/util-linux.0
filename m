Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbbH0IS3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Aug 2015 04:18:29 -0400
Date: Thu, 27 Aug 2015 10:18:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] libmount: handle arbitrary line length for mounts
Message-ID: <20150827081827.GD2410@ws.net.home>
References: <20150826224923.GA11884@www.outflux.net>
 <20150826233439.GC2410@ws.net.home>
 <CAGXu5jK3zxjp3rSoGxCUGC0KhOQOLFrMyhX6fvOiUMAf+5wdeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5jK3zxjp3rSoGxCUGC0KhOQOLFrMyhX6fvOiUMAf+5wdeQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 26, 2015 at 04:44:04PM -0700, Kees Cook wrote:
> On Wed, Aug 26, 2015 at 4:34 PM, Karel Zak <kzak@redhat.com> wrote:
> > On Wed, Aug 26, 2015 at 03:49:23PM -0700, Kees Cook wrote:
> >> @@ -212,6 +212,8 @@ struct libmnt_table {
> >>       int             comms;          /* enable/disable comment parsing */
> >>       char            *comm_intro;    /* First comment in file */
> >>       char            *comm_tail;     /* Last comment in file */
> >> +     char            *buf;           /* Memory for reading lines */
> >> +     size_t          buf_size;       /* Size of line-reading buffer */
> >
> > It's overkill to add the buffer to the struct, it's necessary
> > only in mnt_table_parse_next().
> 
> It seemed really inefficient to go from a stack buffer to a
> malloc-per-call of mnt_table_parse_next(). I'm fine to write it that
> way, though. What do you think is best here?

I'll try to prepare a patch with new struct libmnt_parser where we can
store another parser specific things like current line number, file
name, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
