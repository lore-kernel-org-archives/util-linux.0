Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCA3016FC
	for <util-linux@vger.kernel.org>; Fri,  7 Nov 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510604; cv=none; b=Nbr9j9J5IGYlevl/5BsL9zfjg5YBifjYGWXeD+XMBglgeF5T3xZjzIi1rll1fjdB62SDB8AJ0PrkCfQJUhPY1KftF+EMyjU/WZAhMPbUColwdjBFvPVrLzjRjfCvDhw+L8OiNEeaXEa5CjLNjRp3Q2r6fJJQ03njEf3UG8IDbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510604; c=relaxed/simple;
	bh=NLW1DRmgpWHbGoxj7qgqb5brUE4ur60+FzGkROBC8ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7S8nxPoGGOSvSYBajfQHNfyeWsh8mRQ6DTk031avScU562iyr/saM8/e/83wd2ZB7V9+9r0TG4FOUJjJvuIOlrMU/MFQuyDLtvT9lp3E6ktWZF2isKzpieG7UxQjBHws6lKhZHMmECpFQks8oLIVXn+3U0xASCWhYLl5O1fyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHVgqX0F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHVgqX0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762510601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hy/PieoiLMJBBSSg5G7GGBhMUvn3KU2vjykJQdgBrC8=;
	b=UHVgqX0Fd21dmlw6HUmEj1MGdoUcg4f63/6yz4owanqnSp9svon5oWwE7hIPcats/VeKJQ
	wc/a1BV1w+XqsOfAy+54BYE4novzywUAuUDltftXXZ6Cfk01FlpG2bxBJ5ED+QdQ0YXKaI
	S7DeZtfyebXjvE36gojFCCpzIis4ZcA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-p1WhivVfMU62SbQVCx5JpA-1; Fri,
 07 Nov 2025 05:16:39 -0500
X-MC-Unique: p1WhivVfMU62SbQVCx5JpA-1
X-Mimecast-MFC-AGG-ID: p1WhivVfMU62SbQVCx5JpA_1762510596
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B37B81800473;
	Fri,  7 Nov 2025 10:16:35 +0000 (UTC)
Received: from ws.localdomain (unknown [10.45.242.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9332F180049F;
	Fri,  7 Nov 2025 10:16:34 +0000 (UTC)
Date: Fri, 7 Nov 2025 11:16:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
Message-ID: <pdmvdt2cdvr57pwsyz3g7eehtyni2e5zfnz76mhf5rcsjwcfmm@kf7ergmarrsi>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
 <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
 <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
 <8c27aa14-495b-42f9-8ab6-6456daa1daa4@telfort.nl>
 <dexp4ooy65b2la7ujbpnp5itphzzriwg57uz2cvkt4grn3b7bv@7nzd6wye2vjt>
 <7b928196-6485-4514-a336-5c403652a0c3@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b928196-6485-4514-a336-5c403652a0c3@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Nov 03, 2025 at 03:42:50PM +0100, Benno Schulenberg wrote:
> 
> Op 03-11-2025 om 13:49 schreef Karel Zak:
> > >    # ./losetup --remove --find --all
> > >    losetup: options --remove and --find cannot be combined
> > Implemented:
> >      https://github.com/util-linux/util-linux/pull/3835
> 
> Thanks!  However...
> 
> 	fprintf(stderr, _("%s: options "), program_invocation_short_name);
> 	ul_print_option(stderr, status[e], opts);
> 	fputs(_(" and "), stderr);
> 	ul_print_option(stderr, c, opts);
> 	fputs(_(" cannot be combined.\n"), stderr);
> 
> For translatability, the above should be like:
> 
> 	fprintf(stderr, _("%s: options %s and %s cannot be combined"), ...);
> 
> 
> See for example `info gettext prep prep`, saying that translatable strings
> should be entire sentences.

Yes, I know. The problem is that we need an extra buffer in the case
of the short-only option. I have updated the pull request to make it
more elegant. Now it uses:

    errx(OPTUTILS_EXIT_CODE,
        _("options %s%s and %s%s cannot be combined"),
        ....

so it's just one string.

    Karel




-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

