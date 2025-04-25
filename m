Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922B21FF2A
	for <util-linux@vger.kernel.org>; Fri, 25 Apr 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611689; cv=none; b=lzo7Bra7cJh4F35vk5+jRuZ9QrRALAwvU5CfxlLkg2ALFJXG0LirXwGThRB+njhyIMQ3Hgby2lmYImy2q/jPjb6ZvGAXTwkvgBA+6rsLmax8f2q1EfWxGYaR7f+nK2xNsXJoY9k2IMcI+xVBCskE8hc619aCdYYW9yAfYD7IA6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611689; c=relaxed/simple;
	bh=Z4Siwz4OIsCpXur1duSZx1K3KYh9CImYthQsqaNAbzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep/I6m1tu5v7BgAeMclqp5iRybOBXWYwnilvXBwGMYpDK9zVdBHzwXRyF76DfsEms2eAZ2/Imzjfdnf4/JLP+V0INB7FzOp7YnhN0QVjxAXiwesFKt+5JLb7qNp8hjvGbqz0QOjcjQ1n59SigJdjNlE/D4E/900a+6D1HwrHO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUpzy62g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUpzy62g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745611686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aur+cbmpvPHbYZbi/1wdbstNVBsOBM3VXcbNzOnEhkg=;
	b=LUpzy62g3J2BbJf3R+GEkpNiByUkLyLfizY0GQH9Ssuxf+YiyxITngIpbu0XcbVeHKPOa8
	M9KoyJqosGuxhDXZACC01cXCoqZFRwBvJtAXyy6WkvcE4Wv4qKf8T9bdocjAYDB2pzwdEJ
	MetRMmIR4GqwpfDHEl15UmFC7OO3Kj0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-XlRBlFWvNRSw3Q4b5kShzw-1; Fri,
 25 Apr 2025 16:08:02 -0400
X-MC-Unique: XlRBlFWvNRSw3Q4b5kShzw-1
X-Mimecast-MFC-AGG-ID: XlRBlFWvNRSw3Q4b5kShzw_1745611681
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9DC9180034E;
	Fri, 25 Apr 2025 20:08:01 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.130])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3C2319560AB;
	Fri, 25 Apr 2025 20:08:00 +0000 (UTC)
Date: Fri, 25 Apr 2025 22:07:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/7] docs,usage: harmonize description of --hyperlink,
 and add 2 missing ones
Message-ID: <2hacaew77txtgorfud3xrxxtv5n4yxb34fzuvttkkazmbwvmu7@j2pesheca25z>
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-4-bensberg@telfort.nl>
 <6sucmcn7scrug4shj2lebkrfdz3yyayoj37b3akusib6mxtyjw@kapl5f3xlvzq>
 <f8faf6a3-1da6-42f7-a231-29c47f56b888@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8faf6a3-1da6-42f7-a231-29c47f56b888@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Apr 25, 2025 at 12:43:56PM +0200, Benno Schulenberg wrote:
> 
> Op 24-04-2025 om 12:08 schreef Karel Zak:
> > How about adding man-common/hyperlink and including it in the man pages?
> 
> Done.  Although there was a slight wording difference between `lsfd` on
> the one hand, and `findmnt` and `lsblk` on the other hand: the first said
> just "paths" instead of "mountpoint paths".  Probably the word "mountpoint"
> can be dropped to make the description fit for all three?

I think using "paths" for everything is sufficient.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

