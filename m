Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:56771 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381AbbLJWuk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Dec 2015 17:50:40 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Yoss@gmx.net
Subject: Re: bug in "mount --bind" for hashed tree indexed directories
Date: Thu, 10 Dec 2015 23:50:36 +0100
Cc: util-linux@vger.kernel.org
References: <trinity-01dc6d15-b86a-49f7-bd1c-6b0c22554b9d-1449786251438@3capp-gmx-bs27>
In-Reply-To: <trinity-01dc6d15-b86a-49f7-bd1c-6b0c22554b9d-1449786251438@3capp-gmx-bs27>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201512102350.37175.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 10 December 2015, Yoss@gmx.net wrote:
> Hello,
>
> summary:
> 'mount --bind oldfile newfile'  doesn't implement some changes in
> "newfile" if "oldfile" is situated in a hashed tree indexed directory
> (attribute I).
>
> Example:
> > lsattr /
>
>  ----------I--e- /etc
>
> > touch /etc/testa
> > touch /tmp/testa
> > mount --bind /etc/testa /tmp/testa
> > vi /etc/testa (add some characters)
> > ls -al /etc/testa
> > ls -al /tmp/testa
>
> Only the file /etc/testa contains the added characters.

This seems to be a problem of "vi". Looks like it moves the 
file /etc/testa to /etc/testa~ and then opens a newly created copy.

You can reproduce it even without mount --bind:
$ touch bla
$ tail -f bla
$ vi bla   # add some lines and safe 

tail will not show you the add lines.

> The problem seem to be more complex, because if a 'echo "test" >>
> /etc/testa' is used, it works.

Other editors may work by default. I guess vim would do what you want if 
you play around with settings like
:set noswapfile
:set backupcopy=no

cu,
Rudi
