Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022223A987
	for <util-linux@vger.kernel.org>; Mon, 30 Jun 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285293; cv=none; b=YVOZjAcihy+Oz//4hcec5pxVFEbdMLfskpRJmPfZf74qFRQ+Nwk1Ybnly3DjNRSLjTKYrUfMAPEUqHxiOvB+TfULhi4zI28GAjOPjSxUR9S8S1gMNRNfvpW4/CsrqacK0MFfujZKK2xl3NuV1C7a+G1ZO+sns0pUhec9zphcVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285293; c=relaxed/simple;
	bh=WCkmG1a66N4ffL+d76hJkHlfxGF0LSs2sdBDUc90Yc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5MX0Dr8psTwP1Yadh6NMnglOHXccxL2KTWhBe5rIv1oinAnoL5p8NaECYf+SsmYS4OZYsrkro3qNmIA/bHKLga4GMGZYxS/I+j7nzaNSeycB48FyEPio1HNV4mdQ4pqc4SotrhvwbQXwDLItUEZM2XHAWnXWjEonDj4cS3m0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ithyk9SN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ithyk9SN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751285290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUXezkBIyMyIaQSnzA3nC9NE9Bx88PYzkeFwjKKCjf0=;
	b=ithyk9SN4k6qoPrNbqlc6Q5yCMgdiB4rP8ldGICCn//LpdzqqB5LHde0HItZWjMhGI4s6s
	YOBcrBxWpjKSWBi8PGOMrAbWWJG2DZ6hagUs9eYc7FR2C/Ngg1Bovauf/mcTehreogkK+e
	+D5MboaYlm6/ofRFQ82AjXk4XSOUOLs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-Wc6mwX5tNYWQqXsI8hBQ4A-1; Mon,
 30 Jun 2025 08:08:07 -0400
X-MC-Unique: Wc6mwX5tNYWQqXsI8hBQ4A-1
X-Mimecast-MFC-AGG-ID: Wc6mwX5tNYWQqXsI8hBQ4A_1751285286
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF44F1808985;
	Mon, 30 Jun 2025 12:08:05 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BE7718003FC;
	Mon, 30 Jun 2025 12:08:04 +0000 (UTC)
Date: Mon, 30 Jun 2025 14:08:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Subject: Re: [PATCH] rename: change "expression" to "original"
Message-ID: <fkvvnjmv7r4uchsmr3qjr23omaw4iixuphblmko3uiczdwimzb@q4gxzqfmx4ix>
References: <20250621232642.17613-2-contact@hacktivis.me>
 <00bb2e9d-cf47-489c-a881-81ab2edc2fe3@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bb2e9d-cf47-489c-a881-81ab2edc2fe3@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Jun 22, 2025 at 05:51:39PM +0200, Benno Schulenberg wrote:
> 
> Op 22-06-2025 om 01:26 schreef Haelwenn (lanodan) Monnier:
> >   == SYNOPSIS
> > -*rename* [options] _expression replacement file_...
> > +*rename* [options] _original replacement file_...

Yes, the current situation ("expression") is unreadable.

> >   == DESCRIPTION
> > -*rename* will rename the specified files by replacing the first occurrence of _expression_ in their name by _replacement_.
> > +*rename* will rename the specified files by replacing the first occurrence of the _original_ substring in their name by _replacement_.
> 
> Instead of using the word "original" (where I would first think: original
> what?), why not use "substring"?  It describes what the thing actually is,
> and fits better in the rest of the existing wording.

It seems that in documentation for replace-like functions, it's common  
to use "substring", sometimes the function itself uses "substring" in its name  
(e.g., awk gsub()).
 
Haelwenn, do you want to update the patch?

    Karel




-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

