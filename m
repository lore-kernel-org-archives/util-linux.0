Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF001144304
	for <util-linux@vger.kernel.org>; Mon, 24 Feb 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423559; cv=none; b=OQDiI4KpQBnsfJn5MoWwoqYBvyxoVTIEiVqh9+X8jWXlIvZXRKveuu+69j6S6s3+TzCPz1H1SbL7tUexZC6R3oS/t5y51XL+TcgFSV9csWrhPL8PcC4rGNh1X1iWN2kdRyUoQ4pRnmui1tS9ECA7rTG6NQMIeGK4ZwSDjy6EFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423559; c=relaxed/simple;
	bh=xhGupZpFuktmNrgxASMXf4BUjwQJbyrMuausFIlPNLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxVR/zhu/QUouqvMHdAABOMVR+OCuQFhGvzWTquvOZMoHXocwZLtqVfegc62Twu0kb4/rHzozDse49UNfwuIMkE+pZ6RtdT98IXqghOUKWp4CtL3s0WP+Y/BPiCa1DL/DdQWL9hoOCoNJpRajD+idL3P9uxcurosx2ZvBzCzFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/8v1Pfr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/8v1Pfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740423556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YoSh/t1Sjcx9ooPRJ993Aa4xfN3JD+TY8MMIOC1BMg=;
	b=L/8v1PfrKwleeTNOhb8Yd7/XfxDk/J1rcCB4fnrWu8mQBsQJIdxPT5x4EHW5nMBXevRO4m
	Y8IjzsoYSWRrocf6dVXkCDB3uuahkARJDH0ZLCqU+UG7Pw/C+U0NvkNb/ru5UltMqhZNOm
	MBijQCjdbRdSGIIW2PWCXldohu73vgc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-AD_5PJdPP-ubJ2k2n0Bm1Q-1; Mon,
 24 Feb 2025 13:59:13 -0500
X-MC-Unique: AD_5PJdPP-ubJ2k2n0Bm1Q-1
X-Mimecast-MFC-AGG-ID: AD_5PJdPP-ubJ2k2n0Bm1Q_1740423551
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD9A61800879;
	Mon, 24 Feb 2025 18:59:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3773319560A3;
	Mon, 24 Feb 2025 18:59:09 +0000 (UTC)
Date: Mon, 24 Feb 2025 19:59:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: 1098694-quiet@bugs.debian.org, Florian Bach <Leseratte10@vodafone.de>, 
	util-linux@vger.kernel.org
Subject: Re: Bug#1098694: Crash in agetty due to invalid strncmp call in
 Trixie
Message-ID: <2tlkt7g2blnq3gigedhwgnrt5w7n6k5zyr3dvpadyrl2bn5p2d@v6rhkcmaeryo>
References: <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
 <tzuam3pqfrm6g7t4hwwapmpxxux75bf4vxd42qb6iode2hqnnx@ve4h5lyd3yp6>
 <bee22700-d1e4-42a2-9fe6-9ba9d2e64538@vodafone.de>
 <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
 <4ewlrlhq7eskooeb5h7v4p5qv6r3nvm2ubmuo5546lo5yxsrta@pr2horn2sxog>
 <b5ikwzm4qjyxazwnck736kqdihgjmyjbsfuikfwntaece7fmmu@oxxt7prt45jz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ikwzm4qjyxazwnck736kqdihgjmyjbsfuikfwntaece7fmmu@oxxt7prt45jz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Feb 23, 2025 at 09:13:39PM GMT, Chris Hofstaedtler wrote:
> * Chris Hofstaedtler <zeha@debian.org> [250223 20:06]:
> > > [..] After I sent this bug report yesterday, I also found out that
> > > someone has reported what I believe is the same bug to
> > > upstream a while ago ( https://github.com/util-linux/util-linux/issues/3304
> > > ) but so far nobody has commented on that report.
> > 
> > Yeah, this seems like the same issue.
> 
> Below is a patch that works, but certainly feels dirty:
> 
> 
> From: Chris Hofstaedtler <zeha@debian.org>
> Date: Sun, 23 Feb 2025 20:10:05 +0100
> Subject: agetty: restore op->tty if getting the tty name fails
> 
> Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
> ---
>  term-utils/agetty.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index a382313..e65c985 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -929,9 +929,11 @@ static void parse_args(int argc, char **argv, struct options *op)
>  	/* resolve the tty path in case it was provided as stdin */
>  	if (strcmp(op->tty, "-") == 0) {
>  		op->tty_is_stdin = 1;
> +		const char* tty_orig = op->tty;
>  		int fd = get_terminal_name(NULL, &op->tty, NULL);
>  		if (fd < 0) {
>  			log_warn(_("could not get terminal name: %d"), fd);
> +			op->tty = tty_orig;
>  		}

 Oh, I have implemented something like this https://github.com/util-linux/util-linux/pull/3425

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

