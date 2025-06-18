Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E171C2F5305
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243537; cv=none; b=UucaUiVaB2rrCV0JwJ6CAj4sm/i8VzGXEMrmhVtIuNhJyfESlsDUm2Yod4mpAoLg8e90I3xARIwYjU5NzDiEFszFgGqsd/bEmcFzEUjjz+k3J4bgRMT7/I/tGZUbFDGLfQ6yurb3ti65/SyU3fIdshdouKksc9/hQsQ2BjQ8jgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243537; c=relaxed/simple;
	bh=0Ai4Os8yTDTnRm3cKA28vN8D9hTib7a4OvHkM1ZwKnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGPb3taPTmeb7nmYHdSR0lxICeMf0NV59QIpPznoG1nSUNtb4hQQMbEzl/2gdCgODwEIwMCKfxgm03eaPv7ClD6m6U3phCTwB2xG5JgCH6vF2idPByJjEQrOO8wqt2WOaNpyY/P0gZcHDUnnmP9n/C2594fUd98hyPIC/4H513E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsDW1HE5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsDW1HE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750243533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6tf37HOjNujvAOLxCBKT/p5OiXOecK3H1yfIJgHEu8=;
	b=bsDW1HE55RBi/hEl73jhvnupL4dCuyTrapuXIBt0s04vrqhzdGAORiGIhDeSjLYwT9pTBW
	70YoRgecEaJu40ciUWXlZaVNvh0i3dXKPgRQnJtTRWoo4Y3jKxoGQ6WY5lgXRw8w3Lryun
	dsynex4ywZSQW2dUf+BpU0ULvu3/VkA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-dzDo-oRAOZS3sLQio1u8Ww-1; Wed,
 18 Jun 2025 06:45:32 -0400
X-MC-Unique: dzDo-oRAOZS3sLQio1u8Ww-1
X-Mimecast-MFC-AGG-ID: dzDo-oRAOZS3sLQio1u8Ww_1750243531
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC116195608E;
	Wed, 18 Jun 2025 10:45:30 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B770D19560A3;
	Wed, 18 Jun 2025 10:45:29 +0000 (UTC)
Date: Wed, 18 Jun 2025 12:45:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
Message-ID: <26rikpg7jp5ygfqog6yqixtzzgq5xbf2dhtmwi4qzcviduspnv@klu34u35cnrv>
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
 <7qx4y3d3fnfjt2bfbqs4vfat7qb2imerqoalzgeiv25ejeypzk@5mp6rya3s2v2>
 <d9d6af55-e2c2-4ff9-95e6-84d5a6f76b0a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9d6af55-e2c2-4ff9-95e6-84d5a6f76b0a@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jun 18, 2025 at 03:04:40PM +0530, Madadi Vineeth Reddy wrote:
> Hi Benno, Karel
> 
> On 18/06/25 14:55, Karel Zak wrote:
> > On Wed, Jun 18, 2025 at 11:18:18AM +0200, Karel Zak wrote:
> >> On Wed, Jun 18, 2025 at 10:18:29AM +0200, Benno Schulenberg wrote:
> >>>
> >>> Op 17-06-2025 om 20:24 schreef Madadi Vineeth Reddy:
> >>>> Currently, chrt requires a priority argument even for scheduling
> >>>> policies like SCHED_OTHER and SCHED_BATCH, which ignore it.
> >>>>
> >>>> This change relaxes that requirement. Now, priority is only expected
> >>>> for SCHED_FIFO and SCHED_RR. For other policies, a default value of 0
> >>>> is set internally and no argument is required on the command line.
> >>>
> >>> Doesn't this alter the "show-the-current-policy-and-priority" behavior
> >>> when no priority is given?  Currently `./chrt --help` says (trimmed):
> >>  
> >> Very good point. The priority policy (--{other,...}) should be
> >> required to ensure that the user wants to alter the setting rather
> >> than print the current situation. Madadi, what do you think?
> > 
> > Ah, I now read Benno's note more carefully. The code just silently ignores  
> > policy when priority is not specified.
> > 
> > $ chrt --fifo --pid $$  
> > pid 994013's current scheduling policy: SCHED_OTHER  
> > pid 994013's current scheduling priority: 0
> > 
> > This is ugly. The question is how important it is to support this for  
> > backward compatibility. I'd assume that users use "chrt --pid $$" to get  
> > the current setting.
> > 
> 
> chrt --pid 20570
> pid 20570's current scheduling policy: SCHED_OTHER
> pid 20570's current scheduling priority: 0
> pid 20570's current runtime parameter: 2800000
> 
> After this patch also, we still get the current setting. Can you give it
> a try with the patch applied? Let me know if I am missing something.

Sorry for the mess. I have finally tried it (sorry for doing it the first time).

Benno's note is that "chrt --other --pid $$" changed behavior. The old version 
always just read the current setting if no priority was specified, and now it 
alters scheduling and prints nothing. I guess this is the expected behavior now.

I have found that the old version silently ignores the policy option if 
priority is not provided, and it always just displays the current setting. This 
is ugly, and with your change, it's more ugly :), because it depends on the 
specified policy.

  chrt --pid $$               # display current setting

  chrt --other --pid $$       # alter current setting
  chrt --fifo --pid $$        # display current setting (--fifo ignored)
  chrt --fifo --pid 10 $$     # alter current setting

I think with --{other,fifo,...} the command line should always be interpreted 
as a request to alter the current setting, independently of whether priority is 
specified.

  chrt --fifo --pid $$

needs to end with the error message "chrt: priority value for the policy 
required" rather than display the current setting.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

