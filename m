Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6018F2FC
	for <util-linux@vger.kernel.org>; Tue, 29 Apr 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956491; cv=none; b=JyTRXdLWwWy/SnWeI8QtbVJGozSPPqQXkwf2cIro0VBlUiR4eaKEeaF16ajkCcl6V+vDpKSTXKiAGZSP25mai55YiT+wz1iz8EyQiATIwSuNRSWNZ6at7BEZLhxEc5VD3FuRtsgh75fisMcI10Kx2extuQU7gP3ivQ7XLWP6zTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956491; c=relaxed/simple;
	bh=RRYyhPnpGJWtyvjF3VGgc76tZKi/xkWegTgm3aKLpnQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H9vVx1iGHeJHjcjEJh5XrpPaRPCuTxlXSuR0ybxBQ5xU6vBUbUxGzw2cSW+nxaRp0pZEzj1qLXqmbtM+5tWJx+mO2mm7SMt6KMjeVFclzqngOpVoHSOVOdNPaisnOFcQAxYfiAkoJ1i/nYlVzIs+h6nUYqifArWFT5Olalj0JfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaXUbxfi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaXUbxfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745956488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X49GyhJLIz7lBSzBScXG3BCfQiKEbH029YHMEBkYZRo=;
	b=RaXUbxfi9LekrOD5Yp77PiXjvcw/64EEQz7+IgU6wrvczIsQ1x2kNcnc3Kmi3+AohX1d+Q
	HYC29xPL2azNK4ViOlbqGqXCR5R1v/T4Lz7ByAjI3rYRs1napHxX79Bc3JUZColsOhxmS1
	XMgfTbsDcr2cdX/BSDNQFFvps5X+49I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-Cwu2jnesOW-1xMCDcakulw-1; Tue,
 29 Apr 2025 15:54:46 -0400
X-MC-Unique: Cwu2jnesOW-1xMCDcakulw-1
X-Mimecast-MFC-AGG-ID: Cwu2jnesOW-1xMCDcakulw_1745956485
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBBC3180010A;
	Tue, 29 Apr 2025 19:54:45 +0000 (UTC)
Received: from localhost (unknown [10.64.240.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2485B30001A2;
	Tue, 29 Apr 2025 19:54:43 +0000 (UTC)
Date: Wed, 30 Apr 2025 04:54:41 +0900 (JST)
Message-Id: <20250430.045441.583220097476882528.yamato@redhat.com>
To: kzak@redhat.com
Cc: bensberg@telfort.nl, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/7] lsfd: improve grammar, and use angular brackets
 around placeholder word
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>
References: <20250424093237.6432-3-bensberg@telfort.nl>
	<20250424.185505.855258258029883426.yamato@redhat.com>
	<3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 3/7] lsfd: improve grammar, and use angular brackets around placeholder word
Date: Thu, 24 Apr 2025 12:05:07 +0200
> On Thu, Apr 24, 2025 at 06:55:05PM +0900, Masatake YAMATO wrote:
>> > Also, use dots instead of "(s)" to indicate possible multiple arguments,
>> > and don't use "<when>" when the possible arguments differ from "always",
>> > "never", "auto".
>> > 
>> > Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
>> > ---
>> >  lsfd-cmd/lsfd.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/lsfd-cmd/lsfd.c b/lsfd-cmd/lsfd.c
>> > index 2eb53935c..3610de8dd 100644
>> > --- a/lsfd-cmd/lsfd.c
>> > +++ b/lsfd-cmd/lsfd.c
>> > @@ -2190,14 +2190,14 @@ static void __attribute__((__noreturn__)) usage(void)
>> >  	fputs(_(" -o, --output <list>          output columns (see --list-columns)\n"), out);
>> >  	fputs(_(" -r, --raw                    use raw output format\n"), out);
>> >  	fputs(_(" -u, --notruncate             don't truncate text in columns\n"), out);
>> > -	fputs(_(" -p, --pid  <pid(s)>          collect information only specified processes\n"), out);
>> > +	fputs(_(" -p, --pid <pid>...           collect information only for specified processes\n"), out);
>> 
>> This change implies that --pid 1 2 3 works.
>> However, specifying multiple pids to one --pid doesn't work.
>> 
>>    # lsfd --pid 1 $$
>>    Try 'lsfd --help' for more information.
>> 
>> Only --pid "1 2 3"  or works. See double-quote chars.
>> 
>>    # lsfd --pid "1 $$"
> 
> It also supports comma, it means --pid 1,2,3
> 
> It would be better to not announce that space is possible to use as
> separator, and use comma in the help and man page
> 
>   fputs(_(" -p, --pid <list>           restrict to specified processes (command separated pids)\nn"), out);
> 
> or so ...

I added code supporting whitespace as a separator for combining lsfd with
pidof, as I wrote as an example in lsfd(1):

       # lsfd --pid "$(pidof firefox)"

The idea combining with pidof comes from strace.

The -p option of strace supported whitespace as a separator.
So we can run strace with pidof like:

       # strace -p "$(pidof firefox)"

I didn't know this smart feature.
So I added -S option, an option for specifying separator to pidof ago.

    $ pidof -S ' -p ' zsh
    4185021 -p 4161716 -p 4156470 -p 4155385
    $ strace -p $(pidof -S ' -p ' zsh)

https://gitlab.com/procps-ng/procps/-/commit/73492b182dc60c1605d1b0d62de651fad97807af
https://lists.strace.io/pipermail/strace-devel/2018-March/007950.html
https://lists.strace.io/pipermail/strace-devel/2018-March/007951.html
https://lists.strace.io/pipermail/strace-devel/2018-March/007952.html

That was a small thing but impressive study for me.

Simplifying the output of --help is nice
However, from the man page, I want to keep the description of -p
supporting whitespace as a separator.

Masatake YAMATO

>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 

