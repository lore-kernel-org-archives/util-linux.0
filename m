Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909Ab2KGKBf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Nov 2012 05:01:35 -0500
Date: Wed, 7 Nov 2012 11:01:32 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 00/13] make ipcs to use proc
Message-ID: <20121107100132.GA29631@x2.net.home>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
 <20121105164251.GA3799@x2.net.home>
 <CAG27Bk2ZbPH+Zfbt0vR_GLyLuZoy7QHv-b96WtpEFm963DpD9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2ZbPH+Zfbt0vR_GLyLuZoy7QHv-b96WtpEFm963DpD9w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 07, 2012 at 09:40:16AM +0000, Sami Kerola wrote:
> On Mon, Nov 5, 2012 at 4:42 PM, Karel Zak <kzak@redhat.com> wrote:
> > On Sun, Oct 14, 2012 at 09:22:12PM +0100, Sami Kerola wrote:
> >> Sami Kerola (13):
> 
> Hi Karel and others,
> 
> >  I have created ipc branch at hithub and applied some of the patches
> >  (unfortunately with many changes).
> 
> I would not call code review unfortunate, especially when it causes
> changes to code that will make it better.
> 
> >  Unfortunately I have no more time to play with this stuff this week,
> 
> Open source is supposed to be fun. Take your time, so will I. Getting
> all IPC related fixes done will most likely take several weeks. For
> example it really bugs me that semaphore counts cannot be read from
> proc. The only way I can think of getting that fixed is change to
> kernel side.
> 
> One of the ways to solve the problem would be to add fields
> to/proc/sysvipc/sem but that would change ABI. Perhaps making msg sem
> & shm directories to proc containing subdirectories that are named
> after object id is way to go. Much like how processes are represented.
> That would make IPC info easy to extend ever needed, and quite
> intuitive to use. But before writing that sort of change I think it's
> good idea to ask advice from kernel developers. Looking git log[1] it
> seems Al Viro might have opinion whether to add field or to do greater
> change.

 Well, we don't have to real all from /proc. I think it's fine to read
 some problematic variables (shm sizes) from /proc to keep it
 32/64-bit independent, but the rest we can read by regular
 {sem,msg,shm}ctl() syscalls.

 I guess you can mix /proc and {sem,msg,shm}ctl() in many cases
 (especially if there is no enough information in /proc).

 I think many problems has been already fixed by ipc_shm_ wrappers.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
