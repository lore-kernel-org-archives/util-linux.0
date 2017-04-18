Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755382AbdDRKXM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Apr 2017 06:23:12 -0400
Date: Tue, 18 Apr 2017 12:23:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Rui Zhao <renyuneyun@gmail.com>
Subject: Re: [PATCH] scriptreplay: determine if script --quiet was used to
 create typescript
Message-ID: <20170418102305.pfzvyukxj5fb6wsx@ws.net.home>
References: <20170414203948.12295-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170414203948.12295-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 14, 2017 at 09:39:48PM +0100, Sami Kerola wrote:
> Recent commit that removed header timestamp from typescript output when
> --quiet option is defined broke scriptreplay.  Trouble was that scriptreplay
> always skipped first line of the typescript.  But --quiet makes that line to
> be part of what must be printed by scriptreplay.

This explain why I had bad feeing from the patch ;-)

> +static int
> +sfile_has_header(FILE *sfile, FILE *tfile)
> +{
> +	double delay;
> +	size_t blk, total = 0;
> +	char nl;
> +	struct stat st;
> +
> +	if (fstat(fileno(sfile), &st) < 0)
> +		return 0;
> +	while (fscanf(tfile, "%lf %zu%c\n", &delay, &blk, &nl) == 3)
> +		total += blk;
> +	fseek(sfile, 0, SEEK_SET);
> +	fseek(tfile, 0, SEEK_SET);
> +	if ((size_t)st.st_size <= total)
> +		return 0;
> +	return 1;
> +}

Not sure about it. It seems like overkill... 

I have reverted Rui's change and fixed the man page.

It seems better to keep things simple and stupid... it means keep
typescript file completely independent on the --quit option (for the
both, start and done messages).

Note that Rui also suggested to avoid strftime() for the messages due
to problems with \n (and I have suggested to use ISO times). It's
already committed.


Anyway, I don't like officially supported file formats without any
header. IMHO it would be really nice to add to the typescript:

 ### script(1) typescript; Version: util-linux v2.30; Date: 2017-04-18 12:10:43+0200

... and maybe more information. The same for timing file.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
