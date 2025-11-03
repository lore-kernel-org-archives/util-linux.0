Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0442F8BF7
	for <util-linux@vger.kernel.org>; Mon,  3 Nov 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174152; cv=none; b=lYzc4tksIoOuqd6izILq51ecQqE3RN9x3Y7OqvNJafeGW8leX99ahs/NhDI2WoqAjaMKxa4/T1kajKkGRXgOaCTR+0brv8j6XivypPz4RNqnBAa0tDR5/n06W7lTX+V8m9pSv/L+kc74Cztmipj7jatB7LbrCSXh9+hHY04a9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174152; c=relaxed/simple;
	bh=PItJCbVpQHsmBm2HJgLs9zebk8647MXv4Zh6lvE2H/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFGCsOFnFqxUZZcqb3Znh1HuBpb/LBsVGuEY929hYYyGiYBcYOmBijtot8oCF0UbeYoyos7QLRp0APTL9k5t3rnCSpkKE2CSmH1jAZhuD75izxjO70d7xMoV44tjlLTGJqfIVgdjeimvWvayhFtKta40D8Vlm53nf78TqwFyo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ja/ub4rU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ja/ub4rU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762174149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=da+9/344Bn06KyZuX49EhNPXyBEN2zPl4bcSW2ndQSc=;
	b=Ja/ub4rUP2209Wtby8A1lhT6Sd3fLFkJ4Qr4tPZVWHL+3V2/RnG833EYM4zz9vmijCeClY
	x/QKRH6IwLT1iIrfSg3pJvAiQnq03SVueYK7qd/YZrAHmNP0s4o+WSqHIteSeL7RWzeXCZ
	7Ni/CMj8NBFw/yiBpTo2biWZ1AAt/v0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-q5MF-tmrNdeBFoVugCLYoA-1; Mon,
 03 Nov 2025 07:49:08 -0500
X-MC-Unique: q5MF-tmrNdeBFoVugCLYoA-1
X-Mimecast-MFC-AGG-ID: q5MF-tmrNdeBFoVugCLYoA_1762174147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9CCD195605A;
	Mon,  3 Nov 2025 12:49:07 +0000 (UTC)
Received: from ws.localdomain (unknown [10.45.242.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4D1630001A1;
	Mon,  3 Nov 2025 12:49:06 +0000 (UTC)
Date: Mon, 3 Nov 2025 13:49:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
Message-ID: <dexp4ooy65b2la7ujbpnp5itphzzriwg57uz2cvkt4grn3b7bv@7nzd6wye2vjt>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
 <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
 <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
 <8c27aa14-495b-42f9-8ab6-6456daa1daa4@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c27aa14-495b-42f9-8ab6-6456daa1daa4@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Oct 21, 2025 at 03:49:01PM +0200, Benno Schulenberg wrote:
> >   # ./losetup --remove --detach loop0
> >   losetup: mutually exclusive arguments: --detach-all --all --set-capacity --detach --find --associated --remove
> 
> Nnn...  My next report was going to be about this.  :) 

 :-)

> About too verbose
> and therefore confusing feedback.  The user did not specify --detach-all,
> nor --all, nor --set-capacity, nor --find, nor --associated.  Thus it is
> confusing to see them mentioned in the error message.
> 
> It would be much nicer if the routine that checks for conflicting options
> would just print the first two incompatible ones of the options that were
> actually given.  For example:
> 
>   # ./losetup --remove --find --all
>   losetup: options --remove and --find cannot be combined
 
Implemented:
    https://github.com/util-linux/util-linux/pull/3835


   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

