Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbaBQKcx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 05:32:53 -0500
Date: Mon, 17 Feb 2014 11:32:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3] fallocate: Add "--dig-holes" option
Message-ID: <20140217103248.GA2254@x2.net.home>
References: <1390747439-14086-1-git-send-email-rodrigo@sdfg.com.ar>
 <1390748810-14517-1-git-send-email-rodrigo@sdfg.com.ar>
 <20140214104756.GA28125@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140214104756.GA28125@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 14, 2014 at 11:47:56AM +0100, Karel Zak wrote:
> On Sun, Jan 26, 2014 at 03:06:50PM +0000, Rodrigo Campos wrote:
> >  bash-completion/fallocate |   2 +-
> >  sys-utils/fallocate.1     |  19 +++++++-
> >  sys-utils/fallocate.c     | 114 ++++++++++++++++++++++++++++++++++++++++------
> >  3 files changed, 120 insertions(+), 15 deletions(-)
> 
>  Applied with some changes and I believe that the code still need some
>  improvements, see below


 OK, I did some changes to the code:

 The minimal hole size is based on filesystem blocksize (st_blksize) and 
 --length is no more used for this thing. I think it's better to use
 buffer size which "just works" than expect any input from users. It
 also dramatically simplify the code and the command semantic.

 The original 32K is too large, I guess that we prefer optimal sparse
 files rather than --dig-hole speed. (And it isn't so slow with 4KiB
 chunks.)

 Now the --offset and --length options are used as usually to specify
 an area with in the file.


$ ls -lash yyy
1.1G -rw-rw-r-- 1 kzak kzak 1.0G Feb 17 11:09 yyy
^^^^

$ time ./fallocate --dig-holes yyy
real    0m0.393s
user    0m0.045s
sys     0m0.345s

$ ls -lash yyy
28K -rw-rw-r-- 1 kzak kzak 1.0G Feb 17 11:10 yyy
^^^

  .. so from 1GiB to 28K in 0.4 second.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
