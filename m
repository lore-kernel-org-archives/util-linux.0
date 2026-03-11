Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077722F0673
	for <util-linux@vger.kernel.org>; Wed, 11 Mar 2026 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229245; cv=none; b=b72sKqT4E7MwO0ddjmIOCRAesx2vxl+Pfs8MlTV23qHcpbZSaiHFt9GaziTWV1M3Oc9FkaWkxlVgIyDGnQxUbnaG8wAWi5UyyH3yzQwVFhDYPcXVRUp+qF6eiB4i6yXtsLIH9ScTHK+vyknM1f6xmnIu/yGPHZCCP9/PyeMHkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229245; c=relaxed/simple;
	bh=IDdiBpl6GBCpwyRUJBe8bSoyh3kUJzYnsAJ8TxHagFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckYDvqojmh7m6GqdyTsWUJAB/4MR0QuAB80mVYEup1HmTONrKOlt60Xkvde11lR2sneN5OIN1EAWvdTUKaN7dxzSwNHgVvXVs4u46JseqBs/yujaYQx7Ff6v9VnqTfaWUTscUp/50c7gy1f6uaySbklMv4DjOlVI/3nDLGxtkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkFk06Wz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkFk06Wz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773229242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BbUjEXVsjcdLPIIkShNCo29H/FInWwnrdFDRjuV95FU=;
	b=FkFk06WzdNlQhOnUD/BY4yuDRQsHOq/aAnk/YVQdj5vVnKd05gR0aC66CDhbkFbjgXHOKw
	Jl92VOXHSIqDfUpFzfqJKcshrZC2d+NnzLdybOa4s0XlgDzlA4PWIH4jMV8CzyfPXnJeDJ
	foj49+uSHeZ3WYPWLTbf2OhOm1TswdQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-uhccJR1QMD2kiYIlC5q3yQ-1; Wed,
 11 Mar 2026 07:40:41 -0400
X-MC-Unique: uhccJR1QMD2kiYIlC5q3yQ-1
X-Mimecast-MFC-AGG-ID: uhccJR1QMD2kiYIlC5q3yQ_1773229240
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BDD91956067;
	Wed, 11 Mar 2026 11:40:40 +0000 (UTC)
Received: from ws (unknown [10.45.224.202])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFB4219560B7;
	Wed, 11 Mar 2026 11:40:38 +0000 (UTC)
Date: Wed, 11 Mar 2026 12:40:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, 
	Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Re: improvements to terminal-colors.d.5.adoc were undone
Message-ID: <5pcfy3xctkt26wbexssemjevi2rfq2rpxuktl7tagjtdimyuzf@4oyzvwthm2gj>
References: <cm7cun3pymf6quqcupreoegjj6ycwv3rvbap6ezpvfidvtt4lf@rq74bm7girgz>
 <713c6323-e80e-47fc-9389-520b963a3129@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713c6323-e80e-47fc-9389-520b963a3129@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Mar 09, 2026 at 05:08:19PM +0100, Benno Schulenberg wrote:
> 
> Op 09-03-2026 om 11:51 schreef Karel Zak:
> > >   lib/terminal-colors.d.5.adoc | 24 ++++++++++--------------
> > >   1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> > Both patches have been applied. Thank you, and sorry for the delay.
> 
> The second patch was applied in commit 3252142521, but three commits
> later, merge commit d708fc7db6 undoes all the improvements I made.  :/

Fixed, see https://github.com/util-linux/util-linux/commit/e4889528b3d4d895ea8dbe60ed6b8eb82b3ddf05

Thanks!
    Karel




-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

