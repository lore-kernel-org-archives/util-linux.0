Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10551D2F4B
	for <util-linux@vger.kernel.org>; Tue,  5 Nov 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802025; cv=none; b=pZoaJV9GxR/Kk0w/IaQMebs163WvxDsp2BJxPUpR3H1P1M0LtQ7rGNUoz9hpB7CWR8tZUxeFy624kuRptZLH5nxzPwSvlhKVOUAfYFD+1k6zbAPin2SHHW37jQ5qx46Z0P7sBs6vYj+0NvOO6K3kyVmy7YIUFUsV5xspdr1UCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802025; c=relaxed/simple;
	bh=LFFvylOi9ntQqDLtCRP9nkEeJZlGBM7hjFJmd8LqZ44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOhNmbbvCbs4PbSRQxWMMv61eKpCJSGoQGuGcs9IX15zHgKrhTZptXHn71+DO667nfrK6ETOmX/Zzrh8+/olhisHa8dNbtlY923AzW6MMku+afKNEKxC91JZeFAZzZm8u2ItoZYTq3pBD01//lrkN48/XmdmpIXMZBFXDlTZDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYaFqT3y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYaFqT3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730802023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rq79wDpcJHdFgkN+yT1mr8+rtvRxdWJhlfjd8aqyu0=;
	b=YYaFqT3yaJQZQLmYcdx6q3XdHYmj2dQe2K9/6ukO/Z7FDd6KIG7fRuZQ/eDS9CRPs3PGhM
	J+jOU1TWbbnp+j+wihr6Pc7dEE7cOal2tgI3z3kM6u1CqWK+bmWhaysULj1QA2g60c2rRO
	O4IEv82d3maVAzjMwjkeQ+ujWSTgANY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-uwD6qTA0PXen4k1UfIf7LA-1; Tue,
 05 Nov 2024 05:20:18 -0500
X-MC-Unique: uwD6qTA0PXen4k1UfIf7LA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 706161956096;
	Tue,  5 Nov 2024 10:20:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.59])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CB1319560A3;
	Tue,  5 Nov 2024 10:20:15 +0000 (UTC)
Date: Tue, 5 Nov 2024 11:20:12 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] hardlink: add --list-duplicates and --zero
Message-ID: <trxxw5zf7g3lldjwthpkvqvvfljv5gxqdu4lcxh3uhoz74oifn@jyiuawny7tmy>
References: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
 <b22071e3546940d6d0fa6e1d9d03f292e18229e2.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
 <ivgbtqt2qjlpzxgh6tkdapfohjwu677heddtn7cpkpaqjyoi6g@brl4uxsj6lsv>
 <geq2cawx3udvbe3b3tjton2cuim7ccemndul2sfknvxdll22sg@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <geq2cawx3udvbe3b3tjton2cuim7ccemndul2sfknvxdll22sg@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 31, 2024 at 03:56:40PM GMT, наб wrote:
> On Thu, Oct 31, 2024 at 09:58:19AM +0100, Karel Zak wrote:
> > On Mon, Oct 28, 2024 at 07:19:30PM GMT, наб wrote:
> > > --list-duplicates codifies what everyone keeps re-implementing with
> > > find -exec b2sum or src:perforate's finddup or whatever.
> > > 
> > > hardlink already knows this, so make the data available thusly,
> > > in a format well-suited for pipeline processing
> > > (fixed-width key for uniq/cut/&c.,
> > >  tab delimiter for cut &a.,
> > >  -z for correct filename handling).
> > 
> > Why do we need a 16-byte discriminator? The list consists of absolute
> > paths, so it should be unique enough. This seems like an unusual
> > thing,
> Well, the point is to have a list of lists of files, right.
> hardlink(1) finds, within the given domain,
> a set of sets of "these files are identical"
> (or, the logical set of "these are the link names of this file"
>  for all eligible files).
> The only way to flatten this is to a single-layer list is by having a
> list of filenames discriminated by the set in which they belong, so
>   [[a, b], [c, d, e]]
> discriminated as
>   0 a
>   0 b
>   1 c
>   1 d
>   1 e
> which allows you to reconstuct the sets live while stream-processing
> (the implementation uses a unique ASLR-randomised discriminator
>  because the order isn't stable anyway I think? but same difference).
> 
> A list of just filenames is useless.

I see, thanks.

> On Thu, Oct 31, 2024 at 09:51:00AM +0100, Karel Zak wrote:
> > The new option should also be added to the "bash-completion/hardlink"
> > file. However, I can fix this after merging locally.
> I missed this. I'll include it in v2 if we get to v2 but if we don't,
> please do, thanks.

Merged and bash-completion updated.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

