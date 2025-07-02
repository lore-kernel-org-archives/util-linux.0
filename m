Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2A229B13
	for <util-linux@vger.kernel.org>; Wed,  2 Jul 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445024; cv=none; b=iyq4cV+Xdkhz+jFOGdV5fon8BbDsfbgawOZ8wG5uGIz1d4DRbr47EUKM2H6llEQ0rVMIrhtG+9IHaj1pQIua5osepzs4Lc4MX5HXG7Rry8mNPkaqa9gPaDC5jXb5iKgqf/gbU3P9EHw21KS3O0VwRZ76tgu2sec4cl7bTG0SuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445024; c=relaxed/simple;
	bh=nab70SnGjyvZLEy5L8dizR+EwVrqwaAYnycrtj34iWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4GsQcNgW2hacyls/2UKSjF8zHdhNehCypApPONReKqkNtD1Jy9gJSZ8vtBZYL1h1ZaY/qektuSQg/MxqGSnQz31LMtkZ6ARs1imd1MymnOjDP23u5DR6bNGuoY8CCU89uxNZNho4qrt69zImTinENTCdhoIitcEsD0NDSYit1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6+WwMPs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6+WwMPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751445021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TJko4uXnGlXZUta7XXWIQRvbelwPl0Ck9zhTnUysbi0=;
	b=I6+WwMPs8qRgE2u3IrPzeLQKvifPzBHCAjCKoBH99kxuBakKM/lwL9NBqVdwAtkVhpa2/L
	cOf2FXEtI4o2j0zPRpJ5UzYOB3cEAfeQTaXj2gepTmU64M2aP5SkNxxp0NtuSTfwDq5O9x
	XO0NP0nIG65vqXBAz9BxV+kuMZlSAu8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-q7wnbLz-OUCYfjZTA76hBg-1; Wed,
 02 Jul 2025 04:30:20 -0400
X-MC-Unique: q7wnbLz-OUCYfjZTA76hBg-1
X-Mimecast-MFC-AGG-ID: q7wnbLz-OUCYfjZTA76hBg_1751445019
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DDFD1800343;
	Wed,  2 Jul 2025 08:30:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2626E19560AB;
	Wed,  2 Jul 2025 08:30:17 +0000 (UTC)
Date: Wed, 2 Jul 2025 10:30:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] chrt: do not try to interpret the --pid option
 itself as a PID
Message-ID: <swqefe5qg3kdi7mjtlwn472xuwdlidpof7ygs5dpezf3bjwdlx@kk4svfpcukfs>
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-2-bensberg@telfort.nl>
 <79eaa2c0-65be-4370-b44f-2e8a1730b671@linux.ibm.com>
 <3f71b403-9c43-4d99-9d15-6d6708832a00@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f71b403-9c43-4d99-9d15-6d6708832a00@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Jul 01, 2025 at 03:34:40PM +0200, Benno Schulenberg wrote:
> I don't think that is a good idea: the current interface is already
> confusing in that _gets_ info when a single argument follows --pid,
> and that it _sets_ something when there a two arguments.  Allowing
> to set something for multiple PIDs at once while it's not possible
> to query multiple PIDs at once... is more confusing.

I agree, the schedutils UI is quite confusing. From time to time, I think  
about a new tool that will combine all the tools into one (setsched,  
lssched?) with a user-friendly interface.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

