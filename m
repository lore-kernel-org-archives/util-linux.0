Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84E2FDC40
	for <util-linux@vger.kernel.org>; Fri, 12 Sep 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683097; cv=none; b=Uk5qNtGg9U9wyF3RRO64E72fU2bk2BbKAoAwXR3zEBQ3nulypL7hhy+VLjDO+mQloSR8CbOtYuajFfrO2G+JLynqUru2f6k3DciG0HbjP/bGn7oM2xZuDr6L77ImtAS8GD2e0aovNtwE0TFT3M6T2pOgXpfPuFal2EqdSLU3O6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683097; c=relaxed/simple;
	bh=gDGFcoSjPe2tQ9n61JFFiBe/YQTeKKn5Hdy5oT+SLAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJAeDVVT6UQvkakooFNkDKKKpj0O1aiS4n2LhwSwj1OQcpxjJCHjr9g3ZiC/pgDZ4oLersZoTisdQDrB/+gUWKjwfmUgoxqGysjHDkKnSccAjVOlWrf2IePVDvSZnJOMM9ymjUcDNQxTprvIEGMZDzP6xPkkYoy18QnTO9VtjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwGJKCX1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwGJKCX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757683094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgUeqM0xbBl2J+UN9dDj8klkaACeTIscY5T+5d5fQjA=;
	b=BwGJKCX1SiXpYvewbNXyH2t+eESs9rjvG269bFxZO9ApRNGAtanEpyxAuv9LLAksG64xaS
	huHb1/8qJnApulQRaMEzZ9iaQbSgnq7Hem++7KPr8J+RY3UsxOlktyeMxLboqoLeVAU/hF
	vRmJCGgxhrJPSNDrjT+gYtX1sc77vvo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ZX4A_acEPGiLoVM72j4rbw-1; Fri,
 12 Sep 2025 09:18:13 -0400
X-MC-Unique: ZX4A_acEPGiLoVM72j4rbw-1
X-Mimecast-MFC-AGG-ID: ZX4A_acEPGiLoVM72j4rbw_1757683092
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E900A1800451;
	Fri, 12 Sep 2025 13:18:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC5B119560BD;
	Fri, 12 Sep 2025 13:18:10 +0000 (UTC)
Date: Fri, 12 Sep 2025 15:18:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] findmnt: (usage) add a needed equals sign before an
 optional argument
Message-ID: <rs4jch6hxbont2e56cnshc37hzefhprhlljy2v56xhhtjkfdbm@kgf6bctiicox>
References: <20250911134807.12903-1-bensberg@telfort.nl>
 <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Sep 11, 2025 at 03:51:48PM +0200, Benno Schulenberg wrote:
> 
> Op 11-09-2025 om 15:48 schreef Benno Schulenberg:
> > -	fputs(_(" -k                     alias to '--kernel mountinfo'\n"), out);
> > -	fputs(_(" --kernel[=<method>]    search in kernel mount table (default)\n"
> > +	fputs(_(" -k                     an alias for '--kernel=mountinfo'\n"), out);
> > +	fputs(_(" --kernel[=<method>]    search in kernel mount table (default behavior);\n"
> 
> Karel, do you want to roll an rc2, or shall I just make these changes in
> rc1 POT file for the TP?

I think RC1 is sufficient for translations for stable releases; we
don’t need as long a stabilization period as for major releases.
That’s why I asked for an update on TP.

Or do you think including stable release updates on TP is overkill?

We haven’t done this in recent years, but the number of translated
strings is growing, so updating more often might be better, and x.y.2
releases are usually the last for the branch.

I’m open to advices; I don’t have a strong opinion on this.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

