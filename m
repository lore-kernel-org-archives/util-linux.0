Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64A44C7C
	for <util-linux@vger.kernel.org>; Mon, 24 Mar 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825093; cv=none; b=Y7kDPDNjPT1bh+84kgk0zn2Ac2xSvzibj792lNNh3PaN+D1boOOgTbKZ9t+F1C76vril4TgHRJTRZKv6dqvCLMBcu5qjs0r74Rwm6NyHmSE/So2Vsf5t581DxrB/eEwroT0p3MofyQEMGpkaVruTIhoDOqItyxs5Aysbr3f4d3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825093; c=relaxed/simple;
	bh=zqVa+HpvZqkEijhVc8wnnBUAoqL4zBzlceHHagPAL6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jwno8fqU5jRezYuHmP8QTXlNZwR6eMnlglGYG/4QSEq6yjEvxZxi+vKUHJWbaqZ7zwKfP7yvAVJy/IbptQ6/AYbAjGLWwctkGEBd8T+mnAEj4KX4BvgnhxQ132dShyBNykozItzPvnip5Qwl+OxtuWRLVwsuFvx4iW7QzNUqylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVTvYHH7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVTvYHH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742825090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2IrESbX4ww0PFwVWXDLB58/5JxfCiyHzPpttzHaWpPo=;
	b=PVTvYHH7Caj4wLKXi/mI3FsCha5LD/v2PqwTMArR8m0pLiFRA44ecIZqYZTGQFAhAOKon3
	wzh8OSStjFxv57a+/l4cb30BVdFEeY7hzqilHzaciX8ayqUm9+us4wyFKguUadUOZI2nCO
	gyB9hUL8fAB9O6CUUER8WP86bbGLG9w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-xk9XAawNMHCUddVss5vOGQ-1; Mon,
 24 Mar 2025 10:04:46 -0400
X-MC-Unique: xk9XAawNMHCUddVss5vOGQ-1
X-Mimecast-MFC-AGG-ID: xk9XAawNMHCUddVss5vOGQ_1742825086
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD6C818EBE8F;
	Mon, 24 Mar 2025 14:04:45 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4C53180B485;
	Mon, 24 Mar 2025 14:04:44 +0000 (UTC)
Date: Mon, 24 Mar 2025 15:04:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Revert "hwclock-rtc.c: try the 'new' rtc class first"
Message-ID: <jrtzgsznv7iazsiqrym7czmu3xabxttg5slojilaohsrpa7yat@pdihi2dmiynq>
References: <20250319132859.455264-1-ravi@prevas.dk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319132859.455264-1-ravi@prevas.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


Sorry, I somehow missed the PR on GitHub :-(

On Wed, Mar 19, 2025 at 02:28:59PM +0100, Rasmus Villemoes wrote:
> This (effectively) reverts commit
> 1811900a91be856e794005511eac7859adb8e383.
> 
> There was no real motivation given, and it certainly makes the default
> behaviour of hwclock on current linux systems counter-intuitive: udev
> has a standard rule so that whichever rtc device is designated as the
> CONFIG_RTC_HCTOSYS_DEVICE one in the kernel configuration also becomes
> the target of the /dev/rtc symlink. People may have some other way of
> setting that symlink, but regardless, that must be considered the
> primary or default rtc for the system.

I agree that after 8 years, it's probably fine to use the /dev/rtc
symlink as the first option and assume that udevd has done its job
correctly. The current situation is somewhat messy.

Let's CC: William who is author of the original patch.

I'll apply your change.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

