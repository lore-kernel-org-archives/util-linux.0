Return-Path: util-linux-owner@vger.kernel.org
Received: from charlotte.tuxdriver.com ([70.61.120.58]:49834 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2LTPeQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 20 Dec 2012 10:34:16 -0500
Date: Thu, 20 Dec 2012 10:34:04 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sys-tools: Add setns utility to sys-tools
Message-ID: <20121220153404.GA18398@shamino.rdu.redhat.com>
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
 <20121220092439.GA30947@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121220092439.GA30947@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 20, 2012 at 10:24:39AM +0100, Karel Zak wrote:
> On Wed, Dec 19, 2012 at 02:06:46PM -0500, Neil Horman wrote:
> > Like the unshare command, which lets a user from the command line detach from
> > specific namespaces of the parent process, and execute a command, setns provides
> > a frontend to the setns(2) syscall, which allows a user to migrate a process to
> > the namespaces of other processes, prior to calling exec on a command.
> 
> Do we really need a new command? Can't we extend unshare(1)?
> 
>  create a new namespace:
> 
>     unshare --{mount,ipc,...} <program> [<args>]
>     
>  move to already existing namespace:
> 
>     unshare --namespace <pid> --{ipc,...} <program> [<args>]
> 
> 
> From user's point of view in both cases the <program> will be unshared
> from the current namespace so the util name seems OK.
> 
> IMHO it seems better then add a new command.
> 
> 
> If you really want to support direct namespace paths (/proc/<pid>/ns/<nsname>)
> then we can use
> 
>     unshare --namespace <path> <program> [<args>]
> 
> anyway this way should be optional and not required. It's naive to
> expect that everyone remembers and understands all the /proc tricks.
> 
Ok, fair enough, I can rewrite this to extend unshare
Neil

>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 
