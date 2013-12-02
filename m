Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52889 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448Ab3LBMhD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Dec 2013 07:37:03 -0500
Date: Mon, 2 Dec 2013 13:36:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: script input redirection / eof handling
Message-ID: <20131202123659.GE5572@x2.net.home>
References: <52726756.8060205@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52726756.8060205@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 31, 2013 at 10:21:10AM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I came across an old bug filed in debian about script being redirected
> from a file misbehaving. 

Do you mean something like:

   echo "ps uf" | script

.. if yes, then it's pretty unexpected usage. The code expects that
stdin is terminal. (For example it copy the current terminal
attributes the new pseudo-terminal.)

Unfortunately it does not check tcgetatt() return code so the problem 
is not visible. I'll fix it.

> It seems that when the master ( input )
> process hits eof, it exits immediately, orphaning the child ( output )
> and user processes.

Yep, I think it would be enough to add 

       kill(0, SIGTERM);

before done() in doinput() to avoid orphans.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
