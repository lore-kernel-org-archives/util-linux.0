Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37288 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbaBNLek (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 14 Feb 2014 06:34:40 -0500
Date: Fri, 14 Feb 2014 12:34:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3] fallocate: Add "--dig-holes" option
Message-ID: <20140214113432.GB28125@x2.net.home>
References: <1390747439-14086-1-git-send-email-rodrigo@sdfg.com.ar>
 <1390748810-14517-1-git-send-email-rodrigo@sdfg.com.ar>
 <20140214104756.GA28125@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140214104756.GA28125@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 14, 2014 at 11:47:56AM +0100, Karel Zak wrote:
>  I don't like all the detection algorithm. Do we really need to allocate 
>  all hole size and the buffer? 
> 
>  IMHO it would be enough to:
> 
>  * add posix_fadvise(... POSIX_FADV_SEQUENTIAL | POSIX_FADV_NOREUSE)
> 
>  * read the file in small chunks -- for example BUFSIZ and compare
>    this with small empty static buffer.
> 
>  .. it's kernel business to read from FS/device in optimal way and I
>  don't think that context switches are so critical issue when all the
>  thing is about I/O.
> 
>  I didn't test it, so maybe I'm wrong, but the current code where we
>  eat RAM seems too crazy. Comments?

 .. and another issue, the current code assumes that the holes are
 aligned to hole_size that we read from the file. If the hole starts
 within the buffer and continues in the next chunk than it's ignored.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
