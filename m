Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB61DF260
	for <util-linux@vger.kernel.org>; Mon,  6 Jan 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184690; cv=none; b=FNxCWYPKopdCw9gUDJCQtxGjQgeJPjbavX0b8kOLdQuK/vuy2UG87W7GzaZkGifLnvCmfrEs29nwJZthNrynPWgN1QzfNhqo8o3BA5F4TKKwV7ObPJZ6L5QJtuqKayMgXHcJOrhmHTKMD1hT5RWMU1T7vue65jKhdzShV1MWX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184690; c=relaxed/simple;
	bh=RoxwciumWHWGd7Lh2JppIA3Kf3Lb06u5DzW+s8xutyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVLG7aZJ3nmSeUzxCjkJdXHutednHshqJgzRVfysRLLpaLJOTwV1fusOmKJ6yljwtl0o4nGBL02OKRyzQ2jXlYGTs//yA7Jg1LJpy0GmVpNUz8PHliEBungnS+yE6alldOTIZ6Zgo0sDdW+hMVYpPhLqgB7OkNd8h4XKhSo83x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcK2psE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcK2psE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736184684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H+L9JqgaTba8DySEv2tuJ+7cJXFFrozRuJKMF4t7ujM=;
	b=ZcK2psE5/J17Cot/qCfztKGh5G99nLXnmGSztQp1WRSE8fKFN+YK69hYT6P7XAHga3yh6o
	0vgC2cKqQn9HANAwT2amhEGtGwfuSzmxjaX67LNRLAgMHb0eYxIEwdAQtADl+ebII2m2qs
	13fbxIEiSxFUMDclmi5gEUhjQ++RBb4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-xRExRjp-ONu1cGFkY4gwmg-1; Mon,
 06 Jan 2025 12:31:23 -0500
X-MC-Unique: xRExRjp-ONu1cGFkY4gwmg-1
X-Mimecast-MFC-AGG-ID: xRExRjp-ONu1cGFkY4gwmg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3FBB19560B0;
	Mon,  6 Jan 2025 17:31:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DB80195605F;
	Mon,  6 Jan 2025 17:31:19 +0000 (UTC)
Date: Mon, 6 Jan 2025 18:31:16 +0100
From: Karel Zak <kzak@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: v2.40.3 plan
Message-ID: <kofda2vds2wvl3uku2luaqgry2s5rhccnqn4bbdeioaw3l5ecz@mme24v37dhku>
References: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
 <e0544e22-d8a3-4e13-908b-97a07cbff40b@suse.cz>
 <ewc6glghupyk4koka764ymyjzuedczl4uknucujc6vlj3ohgpb@rw5jgn5dxzqe>
 <aa437ab7756dad03aa6b6d774acfd82e67bdbdb2.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa437ab7756dad03aa6b6d774acfd82e67bdbdb2.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jan 06, 2025 at 04:02:28PM GMT, John Paul Adrian Glaubitz wrote:
> Hi Karel,
> 
> On Mon, 2025-01-06 at 15:58 +0100, Karel Zak wrote:
> > Looks good, all three have been backported to the v2.40 branch.
> 
> Could you also backport these two which fix testsuite issues on alpha?
> 
> commit a0ce085c261a1d981bfa0acd4272b6ba77bfa3be
> Author: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date:   Wed Dec 25 16:21:13 2024 +0100
> 
>     fincore: Use correct syscall number for cachestat on alpha
>     
>     Fixes #3331, #3333
>     
>     Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> commit 851a168e82a1264e2693acba5746ec30eee0c43b
> Author: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Date:   Wed Dec 25 14:08:32 2024 +0100
> 
>     tests: fdisk/bsd: Update expected output for alpha
>     
>     Fixes #3332
>     
>     Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Both have already been merged :)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

