Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37201 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab1GZJ6w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jul 2011 05:58:52 -0400
Date: Tue, 26 Jul 2011 11:58:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] scriptreplay: fscanf portability fix
Message-ID: <20110726095842.GX22568@nb.net.home>
References: <1311365740-6251-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311365740-6251-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 22, 2011 at 10:15:40PM +0200, Sami Kerola wrote:
> This is a fix to an issue with llvm clang which I reported
> earlier.
> 
> http://www.spinics.net/lists/util-linux-ng/msg04331.html
> 
> When compiling with clang fscanf format string %[\n] will not
> work. 

 Sure, read scanf man page. The %[] format expects string +
 null byte. The bug is in the scriptreplay.c code where 
 we don't have room for the null byte :-( 
 
 I really don't think that this a llvm bug.

> --- a/term-utils/scriptreplay.c
> +++ b/term-utils/scriptreplay.c
> @@ -203,7 +203,7 @@ main(int argc, char *argv[])
>  		size_t blk;
>  		char nl;
        ^^^^^^^^
>  
> -		if ((fscanf(tfile, "%lf %zd%[\n]\n", &delay, &blk, &nl) != 3) ||
> +		if ((fscanf(tfile, "%lf %zd%c\n", &delay, &blk, &nl) != 3) ||
>  							(nl != '\n')) {

 Yep, it seems usable.

 Anyway, it's usually better to use fgets() + sscanf() to read and
 parse lines from files. The fscanf() could be tricky if your format
 depends on whitespaces.

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
