Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F051EDA31
	for <util-linux@vger.kernel.org>; Mon, 24 Mar 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825285; cv=none; b=ikzq2vtrieNEE+r5zWZqgnix2/0y8c2s+TI/YWyu3Yge/2HPFSXYplPar+vhsfOYhJlkPLhKrTr+1yYreivZ5v+dwwtBPby4EE9iOCO9NKr+zp5naCb7bpzZxZRx5+v5jjtT4kIUBLZv5F4fbq4ngo46XPRBLORUg0MZDs0gAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825285; c=relaxed/simple;
	bh=sUsvt1iC3zGTSjuG5xVnMIn0Y6NiL6QxtFdqTliUxQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOQYQsohYM3z2scDOIXW9paxACLr2q3VGKozUSpopveYNYMD5ej9C9UXwjINjaHw5SVLSjoeEJcldmAJhAJI3x7HP3XLGyKirtGtWW1gWGmwTfYcHg7GwfxIEWSQ6sH4JkaCXfFpCiQjqks3W65wfWufTnDlsy5wjEDfAm993CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ko7Kjssg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ko7Kjssg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742825282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S+BzvvRqkh+SH6vpsd0Od545wUtrN3Y5Ei83l1b68mU=;
	b=Ko7KjssgX8/ntznjfKof9a9ELDCy1468pSccFuSl5e3BYBB4wvUuqRxgqZ+75CRCYKN7b9
	k2djO0LZgoz5wC2aGU+qA4xxV3+TseDflPgxz5KibD+NBPGXqAXorjqhzdi+GvO2qD1znW
	XrNwUidE/mTC4wANBpIa15/kuHstiic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-o0liejXmNUq-J1J9MgLc_Q-1; Mon,
 24 Mar 2025 10:07:56 -0400
X-MC-Unique: o0liejXmNUq-J1J9MgLc_Q-1
X-Mimecast-MFC-AGG-ID: o0liejXmNUq-J1J9MgLc_Q_1742825275
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B09CE180899B;
	Mon, 24 Mar 2025 14:07:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73AD41956095;
	Mon, 24 Mar 2025 14:07:54 +0000 (UTC)
Date: Mon, 24 Mar 2025 15:07:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: util-linux@vger.kernel.org, J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH] Revert "hwclock-rtc.c: try the 'new' rtc class first"
Message-ID: <4cmotj2ocggd47627b4he7zs345dqi6zii7hfokvwscc43pwo7@sy4cmplnxk7d>
References: <20250319132859.455264-1-ravi@prevas.dk>
 <jrtzgsznv7iazsiqrym7czmu3xabxttg5slojilaohsrpa7yat@pdihi2dmiynq>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jrtzgsznv7iazsiqrym7czmu3xabxttg5slojilaohsrpa7yat@pdihi2dmiynq>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Mar 24, 2025 at 03:04:45PM +0100, Karel Zak wrote:
> 
> Sorry, I somehow missed the PR on GitHub :-(
> 
> On Wed, Mar 19, 2025 at 02:28:59PM +0100, Rasmus Villemoes wrote:
> > This (effectively) reverts commit
> > 1811900a91be856e794005511eac7859adb8e383.
> > 
> > There was no real motivation given, and it certainly makes the default
> > behaviour of hwclock on current linux systems counter-intuitive: udev
> > has a standard rule so that whichever rtc device is designated as the
> > CONFIG_RTC_HCTOSYS_DEVICE one in the kernel configuration also becomes
> > the target of the /dev/rtc symlink. People may have some other way of
> > setting that symlink, but regardless, that must be considered the
> > primary or default rtc for the system.
> 
> I agree that after 8 years, it's probably fine to use the /dev/rtc
> symlink as the first option and assume that udevd has done its job
> correctly. The current situation is somewhat messy.
> 
> Let's CC: William who is author of the original patch.

Forgot the CC, fixed now,

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

