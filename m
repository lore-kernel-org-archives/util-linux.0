Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43589 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbbIBIB6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Sep 2015 04:01:58 -0400
Date: Wed, 2 Sep 2015 10:01:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Isaac Dunham <ibid.ag@gmail.com>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk
Message-ID: <20150902080157.GL2726@ws.net.home>
References: <55E3B640.2060606@gmail.com>
 <20150831100648.GG2726@ws.net.home>
 <20150902020733.GB1910@newbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150902020733.GB1910@newbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 01, 2015 at 07:07:34PM -0700, Isaac Dunham wrote:
> Thus, I'm thinking that the following prototypes would be better:
> 
> /* create a pipe, spawn a temporary pager,
>  * dup()s fd 1 and possibly fd 2 before redirecting to the pipe
>  * if an fd is not dup()'d, set the corresponding duplicate to -1
>  */
> pid_t setup_temporary_pager(int *dupout, int *duperr);
> 
> /* close the pipe, dup2() the saved fds back over fds 1/2,
>  * close the duplicates, and wait for the temporary pager to exit
>  * if either fd is -1, skip it.
>  */
> void close_pager(pid, int dupout, int duperr);
> 
> 
> setup_temporary_pager will return -1 if it does not spawn the pager
> (whether by failure or by PAGER=cat), or if there are problems during
> the redirection dance.
> It will refuse to spawn a pager if (!isatty(STDOUT_FILENO)).

Yes, on non-tty stdout the both functions have to do nothing.

> Does this sound sensible?

Yes, go ahead.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
