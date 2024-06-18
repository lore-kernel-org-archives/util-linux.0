Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03A155344
	for <util-linux@vger.kernel.org>; Tue, 18 Jun 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711904; cv=none; b=CagDFRlR0p2Tt2IXCSbTK4ARZNe6xOPyxjw14IFJVpzuVci3nSmB8SxlUR6XThWoSikseMDvy28wUGgiI4MG+cSzS3qNGQBdTGICPrQfb0Eqfvu93LK0FLxFh6dsLuJ3o30J7uF8fWE5flCkhFTqiqt0Qd0s5QBDs+AZLdHZPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711904; c=relaxed/simple;
	bh=PW66zmGctSB4So00sUWxMQyo5aegXn0eYvIL6obe6c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHM36m6DbHFO9bUFTtI/VFqrpVUXbGR2voUR0+Fd6TrkC5Oz/H+MF+ueHZO9Bl7lDewWk63kxtzzAaIr4VI+0WuHx3G6GWBiaH1wUYgyBAoIz+5DW5yMK8TJYn8cpPVhAF1Jc1+QlSTf9Jr1hZjOfjY7Aak422BYz0SgSMOzyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+8+yk9W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+8+yk9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718711901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RC2XLw+8XOzzSpF0jkwQZgEUDkitySo+9Ga9bhUsCZM=;
	b=X+8+yk9Wx7zDmdPJgy/Mrpxm10O/3wpSFL96c7s2oj2ec5VHXftWVr/9ywcE+SQTniLoGE
	WqZ3T8FcgiEns9CcZu5kPL0oMus7bxMgqhHQCy9eNbNygKVmDxs41ea8EZrXkl6m9Rlii0
	sseqoKjpyqqT94omlVCguipbOJjAdKM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-VXGPqSJ0Mzm9dVRHl6EkZw-1; Tue,
 18 Jun 2024 07:58:18 -0400
X-MC-Unique: VXGPqSJ0Mzm9dVRHl6EkZw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53AEA195606A;
	Tue, 18 Jun 2024 11:58:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49D511956048;
	Tue, 18 Jun 2024 11:58:16 +0000 (UTC)
Date: Tue, 18 Jun 2024 13:58:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] unshare: load binfmt_misc interpreter
Message-ID: <20240618115813.eyy5mwy25ig76wzc@ws.net.home>
References: <20240611084314.183913-1-laurent@vivier.eu>
 <20240611084314.183913-3-laurent@vivier.eu>
 <20240618095151.2vidavjn47xgbxf4@ws.net.home>
 <e875d06e-a0c5-47c3-b368-06f398e676ab@vivier.eu>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e875d06e-a0c5-47c3-b368-06f398e676ab@vivier.eu>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jun 18, 2024 at 12:13:50PM +0200, Laurent Vivier wrote:
> Le 18/06/2024 à 11:51, Karel Zak a écrit :
> > 
> >   Hi Laurent,
> > 
> 
> Hi Karel,
> 
> > On Tue, Jun 11, 2024 at 10:43:14AM +0200, Laurent Vivier wrote:
> > > +*-l*, **--load-interp=**__file__::
> > > +Load binfmt_misc definition in the namespace (implies *--mount-binfmt*).
> > 
> > Is it actually a file, or does the argument have a more complex
> > format? If there is something more that it should be described here.
> > It fine describe in the man page more about the interpreters.
> 
> Your right the format here is not actually a file, but it defines how to use
> the file provided in the parameter as an interpreter.
> 
> We provide here what we will write in /proc/sys/fs/binfmt_misc/register and
> the format is described in
> https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst:
> 
> "To actually register a new binary type, you have to set up a string looking
> like ``:name:type:offset:magic:mask:interpreter:flags``

 I guess we can use something like:

 -l*, **--load-interp=**string

 Load binfmt_misc definition in the namespace. The __string__ argument
 is ``:name:type:offset:magic:mask:interpreter:flags``. For more
 details about new binary type registration see
 https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst.


> > As an uneducated reader, I am confused by the flags. Where is the 'F'
> > flag? Perhaps you could provide more explanation to make it easier for
> > readers to understand.
> 
> I think this option should be used by educated user that is aware of binfmt_misc format.
> 
> Do you want I copy a part of the binfmt_misc documentation in the unshare documentation?

It's probably overkill copy all the text.

> I'll update the man page accordingly.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

