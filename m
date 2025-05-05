Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E951EDA34
	for <util-linux@vger.kernel.org>; Mon,  5 May 2025 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434547; cv=none; b=GMdduyAgi21tSgu35o/Oz16c+X1jVdtBlCfbYpcul55prO0ffdZQruQ/Yjp53dDxmoR+uGEKuieptQGgKmogDyMNAL2yvw/KGH/1clYcWZGkRch5h6Hdu54y9fK547QqEwPQdKGIR+WmPEzF4xUH3g213XPnsXbV7EyDOiZiJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434547; c=relaxed/simple;
	bh=gcH35MEFlF1IA/7Ad6LH6mSfN1YNWVH8247H9YTSTsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAbqfKCy1alQ5NukO/eUOOfkL4S2patFpeu6x4g+63hdh1ndtpBaG+tTZcrgs3hA67JSkgcX/dbqozYeqjdT9d3kW3nUF629QGktlAXfVi3i5d6pLK+PbQBkXfRNo7opJ4u9V2fh3LT3Xlkpn/FfiD6gZErblVtd1v0WQtQr6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZX1jBEO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZX1jBEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746434544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqK132FtO3lQrk1i7aoBjqmUmC5OmPt/EYnLxiu+n2o=;
	b=eZX1jBEO8mDYXQW+gKntbqB05pRzQnXb9JFJV+Akpvu8o95kWUrlkIap5xx0DBH/8CIfyN
	4AiP19GMI4CRzRafLXPf96EvqJzwhSmyO8zuvKoUr5N3cjwnD0U55qaqIFML2tH5RRXbPm
	eCHAwDtMFGKr2f+qdxGxdJQwTJ37rnY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-UDzpvX48P0qJIOTP38NkIQ-1; Mon,
 05 May 2025 04:42:20 -0400
X-MC-Unique: UDzpvX48P0qJIOTP38NkIQ-1
X-Mimecast-MFC-AGG-ID: UDzpvX48P0qJIOTP38NkIQ_1746434540
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB2911809CB1;
	Mon,  5 May 2025 08:42:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3C8330001A2;
	Mon,  5 May 2025 08:42:16 +0000 (UTC)
Date: Mon, 5 May 2025 10:42:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] strutils: move an error message to where it is used,
 and improve it
Message-ID: <wzqyv5xook6ggpl3bvkw66d2cbj2kd665ko5poat2kw5rw2fs2@iid75zn77wpa>
References: <20250502122242.72961-1-bensberg@telfort.nl>
 <20250502122242.72961-2-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502122242.72961-2-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, May 02, 2025 at 02:22:42PM +0200, Benno Schulenberg wrote:
> Calling gettext() is somewhat costly: it has to find the given message
> among the more than five thousand messages in util-linux's repertoire.
> So, call gettext() only when the message actually gets printed.

I like the change. The `gettext()` argument for options parsers is a
common issue, and there may be more areas where we can improve. The
general pattern is:

    x = strtoxxx_or_err(optarg, _("invalid xxx argument"));

Perhaps we can use the command line option name as an argument and
compose the final error message within the strtoxxx_or_err()
functions.

    x = strtoxxx_or_err(optarg, "xxx");

And in strtoxxx_or_err(const char *str, const char *optname):

    errx(STRTOXX_EXIT_CODE, _("invalid %s argument: %s"), optname, str);

BTW, it's pretty common:

   $ git grep '.*_or_err' | wc -l
   399

so we can save a lot of gettext() calls and make the utils faster.

Volunteers? 😊

   Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

