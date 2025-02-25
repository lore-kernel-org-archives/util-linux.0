Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F62BB13
	for <util-linux@vger.kernel.org>; Tue, 25 Feb 2025 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469997; cv=none; b=rshfdpq1Q1qRDts6LKIhIQNKBwEBiN0C83iKkKx7ZEcLjYksRsWDtW0w9Se/dS0LGYWwHizwmgOTPz9OW4j+zmC0EBgXiXm7SgTdD/uJkvza91I1/enoDFGXimpvD1klAK2hBsf7IIdyKuoXilHTTIhyTOx30O/XhO8aI7W3X28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469997; c=relaxed/simple;
	bh=ZnCS1idrbE5HDVmjYhvKIEeErswwY/beoEglFTyVvBA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfxIPexhLG6wUxu3nOF2wUn5zko0jrrbrn/PmKEAzkt8R0ast/PwSkpQfFTjJkxbn4nQFjh1+1KyGctKhIebycRRSz7UQz1O4mkQWuRUSj0TJiDu1+UyJ7WOMqdzDarObzvBwXO7rHfjy0q8QPQxhDFIl1VEKMMWsprMMBYTgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLCWPtR3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLCWPtR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740469994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ckzn7pw3qVKZ5xW5DTUax40WS+5ppuRUAtYDYzFLIr0=;
	b=NLCWPtR3ynVF1NEQdPdF9sRlAkHKjQ15mzPecZuEg5AXOx/dfP2jC9Rza17nnCSebI/CeZ
	zZNDB7mgEvrVhmcG0GY5vC94ezT3scbuEzPZ0hIO0+CV/EYi6a7DnlLfs3XO24BdYV6sTp
	C4GcMaLfuaZlSb01XyiE4Z3jlBSIEmk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-gOnab3fLP2yBssjykuedSg-1; Tue,
 25 Feb 2025 02:53:11 -0500
X-MC-Unique: gOnab3fLP2yBssjykuedSg-1
X-Mimecast-MFC-AGG-ID: gOnab3fLP2yBssjykuedSg_1740469990
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D666193578F;
	Tue, 25 Feb 2025 07:53:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A3791800944;
	Tue, 25 Feb 2025 07:53:08 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:53:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@aquilenet.fr>, 
	util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.41-rc1
Message-ID: <au6l4vog35odbgwqcf34uubz5bzgsxbymdxz6truaper2mexgl@hzwbck22ar6t>
References: <yjic6yol5fmaftythlppbfoafsaqhaoh77spzp6m2izd757pcg@siegv7vwz6lf>
 <Z7cPetD5HqKnWkDT@begin>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7cPetD5HqKnWkDT@begin>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Feb 20, 2025 at 12:18:18PM GMT, Samuel Thibault wrote:
> Here is a patch to fix missing references to mq_open/close.

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

