Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34820 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbIBCHf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 1 Sep 2015 22:07:35 -0400
Received: by pacfv12 with SMTP id fv12so14960591pac.2
        for <util-linux@vger.kernel.org>; Tue, 01 Sep 2015 19:07:35 -0700 (PDT)
Date: Tue, 1 Sep 2015 19:07:34 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk
Message-ID: <20150902020733.GB1910@newbook>
References: <55E3B640.2060606@gmail.com>
 <20150831100648.GG2726@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150831100648.GG2726@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 31, 2015 at 12:06:48PM +0200, Karel Zak wrote:
> On Sun, Aug 30, 2015 at 09:04:48PM -0500, Bruce Dubbs wrote:
> > I have a question about (or a enhancement request) running fdisk.  When
> > asking to list known partition types, I get about 70 lines of output.
> > Generally that would not be a problem, but I was running in a Debian
> > install/rescue iso that uses busybox in a 25 line terminal.  I do not have a
> > way to scroll up and thus cannot see the first 40 or so partition types.
> > 
> > Is there a way to use a pager for this?  In this situation 'more' is
> > available but 'less' is not.  Otherwise I think an automatic pause every 20
> > lines or so would be appropriate to build into the partition type listing.
> 
> We have lib/pager.c and setup_pager(), but it assumes that the pager
> is running all time and maintain stdout until parent process
> terminate.
> 
> Maybe we can implement something like
> 
>  pid = setup_temporary_pager();
>     <list partition types>
>  close_pager(pid);
> 
> as I don't think we want to use pager all time for fdisk. 
> 
> Volunteers?:-)
> 
>     Karel

I'm tempted to volunteer, but I'd like to run something by you first.

I presume that setup_temporary_pager() needs to spawn a pager, with
the pager inheriting stdout/stderr and stdout temporarily redirected
to the pipe, and then close_pager() needs to close the pipe and swap
the old stdout/stderr back in, then wait for pid to exit.

Thus, I'm thinking that the following prototypes would be better:

/* create a pipe, spawn a temporary pager,
 * dup()s fd 1 and possibly fd 2 before redirecting to the pipe
 * if an fd is not dup()'d, set the corresponding duplicate to -1
 */
pid_t setup_temporary_pager(int *dupout, int *duperr);

/* close the pipe, dup2() the saved fds back over fds 1/2,
 * close the duplicates, and wait for the temporary pager to exit
 * if either fd is -1, skip it.
 */
void close_pager(pid, int dupout, int duperr);


setup_temporary_pager will return -1 if it does not spawn the pager
(whether by failure or by PAGER=cat), or if there are problems during
the redirection dance.
It will refuse to spawn a pager if (!isatty(STDOUT_FILENO)).

Does this sound sensible?

Thanks,
Isaac Dunham
