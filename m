Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46503 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbbBXMMw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 07:12:52 -0500
Date: Tue, 24 Feb 2015 13:12:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/16] tailf: count last lines correctly at initial print
 out
Message-ID: <20150224121241.GN19430@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-13-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-13-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:42PM +0000, Sami Kerola wrote:
> When last lines happen to be greater than string buffer size for fgets()
> the number of printed lines resulted to too few.

 Maybe add a note about mmap() to commit message ?!

> -	if (!(str = fopen(filename, "r")))
> +	if (!(fd = open(filename, O_RDONLY)))
>  		err(EXIT_FAILURE, _("cannot open %s"), filename);
> -
> -	buf = xmalloc((lines ? lines : 1) * BUFSIZ);
> -	p = buf;
> -	while (fgets(p, BUFSIZ, str)) {
> -		if (++tail >= lines) {
> -			tail = 0;
> -			head = 1;
> +	data = mmap(0, old->st_size, PROT_READ, MAP_SHARED, fd, 0);

 It would be nice to compare this it with original implementation on
 large files. I guess mmap will be more effective and faster.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
