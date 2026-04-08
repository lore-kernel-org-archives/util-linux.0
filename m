Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2739EF23
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637545; cv=none; b=s8eKLP8OcOoUrP2u7d3IAb+qLRBDtT00LszBZ+cqZynxEkqMwnDHw8dIYovYQ82W8YxFF8ptoYQ3j3bS+4y5uexCq0X2PMi2vh9S4Ry58NWXbFPG1tyHO2uLh/9l3uqgEn0JeLCBUpRJH1sB6I0pKjt5HEoc6kaqrd/1Ta7EuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637545; c=relaxed/simple;
	bh=cxx5yjgJZvK15elaUVmZ74AodyCaTJ7rDJKxGAm+ShE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ+8Sgs1lWBmDBLj1vH5sBg2vyMylMWjQKvaGu9mAdN3zR3c3fVYzjh8sj90/hyL5lBBWsUeA1dCyTwOOmKM+aqRwNOFRaOIwcvBO700/nMNIaRocI2uniaacM92jqmaLcU1WrfTusLZMoLRQsUsZJS+d6AEmAX8Kf4Zp0X02dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNMlIbVO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNMlIbVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775637543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+xYPI6xxNgfwzLT2f4itXNGhii3iTYM0pKw74AoRL2s=;
	b=cNMlIbVOdwWkVLn82wxmFkKyST1w0XGgRKVTMscgXUxBRxibQK3m8xz6wyraCgde9eMQ0z
	5FD3dkXkuqY7T7qAAfmuSRtqGJUJ/SflrpFm6FlIC1taFcbqqQDJnmLAWVCitoJ1SbwDXC
	3W3k3RhcSBl762cs9yUoTYHesxzW7lc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-7wC59uvsM9-LHgxyuzBp3A-1; Wed,
 08 Apr 2026 04:39:01 -0400
X-MC-Unique: 7wC59uvsM9-LHgxyuzBp3A-1
X-Mimecast-MFC-AGG-ID: 7wC59uvsM9-LHgxyuzBp3A_1775637541
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94A5319560B6;
	Wed,  8 Apr 2026 08:39:00 +0000 (UTC)
Received: from ws (unknown [10.44.49.192])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78617180035F;
	Wed,  8 Apr 2026 08:38:58 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:38:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Util-Linux <util-linux@vger.kernel.org>, 
	Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Re: the bad effect of tables on msgids
Message-ID: <dseehzodgm5vt2bmqewjf5oilq2vgfjno3ty6svabzf5q5ulo7@obi2pce56mfh>
References: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>
 <8de6593e-f696-4b6a-a431-a09dccc4263a@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de6593e-f696-4b6a-a431-a09dccc4263a@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Apr 02, 2026 at 03:38:39PM +0200, Benno Schulenberg wrote:
> 
> Op 24-03-2026 om 16:49 schreef Benno Schulenberg:
> > [...]  changing simple lists to tables 1) more than triples the space that
> > the information takes up on the manpage, making it less easily digestible,
> > AND 2) makes it harder to translate.  I don't see any advantages to using
> > tables.  If there are any, please enlighten me.
> 
> Ping?

I have no strong opinion about it. For me, as a user, it is important
to have data in man pages structured and easy to navigate without
reading large paragraphs.

As a maintainer, I'd like to keep translators happy, which means
having text in chunks that are readable and in an easy-to-manage
format to avoid formatting bugs during translations.

> > If there are no advantages to using tables instead of lists, please
> > revert to using lists for simple "tabular" listings of information.

If you see a way to make things usable for others with a list, go ahead.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

