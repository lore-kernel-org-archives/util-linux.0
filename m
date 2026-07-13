Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309638947F
	for <util-linux@vger.kernel.org>; Mon, 13 Jul 2026 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941587; cv=none; b=BIM1Aksum9SSVRJk3flBjzr0DEwxLNiiDBgQCYWFOo6QqI/UfmB8NmHw7/aNwc2sNaNlevwyHrPvcGDuYGbswd7qd4f6sBT5yeEaLYxHlkiufW1tMNZ9dk5G7ysA/W5QUyNlX5lbuJWTBpmoqoqY14eqAx5BYIWYZFAz02ku2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941587; c=relaxed/simple;
	bh=KK8GUCvzLyXZkPZPFRnC5KFadY/n4OKQjF+orXtTBXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T711F/Q8QHt2CD1bJumd96UXN8kUy8bV2RP5bGhIxlie2e6flLml3Rfu5LyMQ3qWfjgcpuNM+7UdqyrMwnom3yHNmb0TcZF6FtXw0jrSWg8KCzdhggunYKdCk9rxDrI7mkM2Jw/L+J3Zv9A6AQQK7ZxITa82q9ze4H/FahNEj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKDipZeG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKDipZeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783941585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16NZ6aQ98etlNmUMHl5Mc84K6CJGytPIGnX1qQ6pS6I=;
	b=HKDipZeGre5E5a61+Q+TRtZSxsgSZ6J5dqJXnJ1bGRZU8VykoKA9FofBM+aX1k2A0CvkQ9
	mNQFee9iNTEwrJWaTTlXDTNI/TXbnZJIF3fRxAludys0yJIfMBVYoKMGtL9gbgR+wfGwaL
	SAav5YXKoCWJwX9Lnz5YC0cSwWXM724=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-6Qdi2CzbN3G6ikdk7lGkbw-1; Mon,
 13 Jul 2026 07:19:41 -0400
X-MC-Unique: 6Qdi2CzbN3G6ikdk7lGkbw-1
X-Mimecast-MFC-AGG-ID: 6Qdi2CzbN3G6ikdk7lGkbw_1783941580
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B452F1800A7B;
	Mon, 13 Jul 2026 11:19:39 +0000 (UTC)
Received: from ws (unknown [10.44.48.230])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 592883000B50;
	Mon, 13 Jul 2026 11:19:36 +0000 (UTC)
Date: Mon, 13 Jul 2026 13:19:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org, 
	Marc Lehmann <debian-reportbug@plan9.de>, 1141670@bugs.debian.org, 
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: Bug#1141670: util-linux: very slow code and undefined behaviour
 in handle_interrupt
Message-ID: <n7333tlqiptjevj7gkmjarerqicrev2bnme7zjeg7bxoi2qbwe@vsjsiomhkzkp>
References: <178350371646.36377.6056214111743171473.reportbug@cerebro.laendle>
 <alLEV6xOOwA1RzU_@zeha.at>
 <ghbjccr36z.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ghbjccr36z.fsf@gouders.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Jul 12, 2026 at 11:02:12AM +0200, Dirk Gouders wrote:
> Hi Chris,
> 
> On Sat, Jul 11 2026, Chris Hofstaedtler wrote:
> 
> > the following was reported to Debian, regarding the hardlink
> > utility. It appears to be an upstream issue. Maybe someone can look at
> > it. CC:ing наб who seems to have touched the relevant function last.
> 
> it seems, this regression was fixed with:
> 
> 87831fa19 (hardlink: fix performance regression (inefficient signal evaluation), 2025-04-29)
> 
> The commit message says it improved performance by factor ten.

Yes, it should be fixed in >=v2.41.1 and >=v2.42. Update :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

