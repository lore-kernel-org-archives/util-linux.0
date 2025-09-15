Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29872550CA
	for <util-linux@vger.kernel.org>; Mon, 15 Sep 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936891; cv=none; b=CwQou0pjPy60diffqfZcqlms9wKOJKNEiBDuEhEgngvn+fKGmzPHGbVeHc859bSqBh49p2I9NBpXm0ASub5AzGQZYACLXxOKZprRtn5K3QTIlkkujrzzwNB0Sn2AQukw47VEgAuUSEOPkYqASCx723VY9FzrOxJfIUiwSErdhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936891; c=relaxed/simple;
	bh=SVhSDzZFoTbWXTlDa6anI+D/ew5uUb2NdIOqRbyFcgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoUHJ0I5WlSe/D6c7mhGxctpwm+ZjFL609yf2Q0mgcngpP62d1PCxIKTEO1bkhgP679r9ZKb90Xs+eEZ8QyI8KKE/zTWIsC0TdOmTst+Dbc0yyEw1ICe/DKqEUQcdVPUdLz+5P0V+BNt3hvDs53KjTGLXSzol4okq0/gGKSV+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+eKnWar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+eKnWar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757936888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bd2lja+s557+hVsw3OMILw3I7hr/dIrdEU8JqpO3mC0=;
	b=Z+eKnWarb2kOVdENsJavfyzwLnhmzu281VUowjXZ2Layz4mgYR6YDtgtUN5inu5D2WWy/2
	RdptgYDCoXiC8mP0TtDQRyrRrWXk8AIeK25XnDJDXpgzG4JVgIQXFfgZ4n29P7Z9t5u5nM
	uBidENFGWnOJ1OOoau2W22cfJJ7WE1Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-8Yr9c1MaP4uMGzMHVXMDUg-1; Mon,
 15 Sep 2025 07:48:07 -0400
X-MC-Unique: 8Yr9c1MaP4uMGzMHVXMDUg-1
X-Mimecast-MFC-AGG-ID: 8Yr9c1MaP4uMGzMHVXMDUg_1757936886
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4500A19107D8;
	Mon, 15 Sep 2025 11:48:06 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.252])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B73E1800452;
	Mon, 15 Sep 2025 11:48:04 +0000 (UTC)
Date: Mon, 15 Sep 2025 13:48:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] findmnt: (usage) add a needed equals sign before an
 optional argument
Message-ID: <jjfyfortuafdoykjpzcd2ydaqtwry6nsyru3qkkuppctedsjdy@mnoyi2hipetc>
References: <20250911134807.12903-1-bensberg@telfort.nl>
 <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
 <rs4jch6hxbont2e56cnshc37hzefhprhlljy2v56xhhtjkfdbm@kgf6bctiicox>
 <14fbf910-bc2b-4bd4-89ce-dac8a4d8c970@telfort.nl>
 <cspldmiiosndipcki3zybaik2edrf2lstkpxxj27rum5xrlfdc@6a4t452pkz7l>
 <13928bd5-c3e3-4b6d-a5a0-3daf6b9e4429@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13928bd5-c3e3-4b6d-a5a0-3daf6b9e4429@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Sep 15, 2025 at 11:51:01AM +0200, Benno Schulenberg wrote:
> > and do string fixes in the next release (or next -rc). So I have
> > applied the patch to the master branch only for now. OK?
> 
> Not OK.  As said: I don't want to offer a faulty string.  Please
> apply the patch also to the 2.41 stable branch, so that I can
> announce a  better POT file (I will edit it in place -- no need
> for another rc release).

OK, done. Applied to the stable branch, you can edit it in place.

> > For a major release (e.g., v2.42), it would be best to do string
> > translations twice before the final release to allow time to fix
> > strings and finalize the translations. Maybe for the final release
> > it would be best to have
> > 
> > -rc1 ... stabilization only, no translations
> > -rc2 ... translations, string fixes from translators
> > -rc3 ... final translations
> 
> That sounds fine.
> 
> > But I'm not sure translators are ready for such repetitive work
> > (although the second update will probably be quite small).
> 
> Ideally I should catch the faulty strings before you make the rc2.

Yes, that would be best; we can avoid -rc3 and have all strings ready
for -rc2.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

