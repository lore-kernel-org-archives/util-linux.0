Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA58615A
	for <util-linux@vger.kernel.org>; Wed, 30 Apr 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011985; cv=none; b=KuQDICJHOvqAVweKKGVt77g+yGslZqOiRA3ahpaOIppVESVZLiCATLXTcP4zVR4/R265OYahI7ppif3646HGdCwmau0Cb3tWSVV22AP3K4VF3Wo315F6hN6nmkpUFkLw3HbSIYUbxQ1YtdRlW5wvDvQVLy9UxAar5KU7AhKIwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011985; c=relaxed/simple;
	bh=1VLnmcekf6y8cUPHRxIMN3bIRbCozyRqX9XypCMp6J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJg6wZEI/bh5RANkilpH84vlwEXNLwdKG3VUgxljmMhDyZqN2ESJaS/GYHuUyHebz/MpDtzUS5H0nzptK5IjopqdGSKh5DgJ9O2B70T4XsDwmFGrajJFmzh68uZki08+22FNRnQ2FGRog4nHSRiBjdkSHXlg9gWgrVJw1w+7uFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BruD5HPw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BruD5HPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746011981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4F8GRQC1etd0goSdodTCVRr/FvwICyglkY9nNUPwFrg=;
	b=BruD5HPwHXsbegCZ5jxX6VTefTKzhUm1ERt5wTNddpTM+zHBI4t8fqornR5XazZoCxXUki
	19WMClPKsLbgugQmIxX4zUiL1Pdp6Kl+CHv9Mlu1oLPupJU7HsiOHAqLDr4WnMQdc3mSul
	hIyTLtU2zVC10kx8cdsn7ey9xUL2qKQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-w2WIxipsP46sD6PwX8FKgg-1; Wed,
 30 Apr 2025 07:19:37 -0400
X-MC-Unique: w2WIxipsP46sD6PwX8FKgg-1
X-Mimecast-MFC-AGG-ID: w2WIxipsP46sD6PwX8FKgg_1746011975
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD9911956094;
	Wed, 30 Apr 2025 11:19:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.63])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C33A230001A2;
	Wed, 30 Apr 2025 11:19:34 +0000 (UTC)
Date: Wed, 30 Apr 2025 13:19:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] unshare: make the wording of a message identical to
 that of three others
Message-ID: <bn4gosmoti26orlcsic2zgfpxckddh3cwah5mj4mgiq47e3ack@ec6nrc7ej2nl>
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <qf3xkiasm5b5zliten36bjv4ynd4kdzj7nll5x3nq5jsasfegg@evnsrxot4x6j>
 <f3465a40-837f-42e5-934b-09f4d5551909@telfort.nl>
 <xtmcfjudjau4kuzdjbqj53mqoi5254awzu3opjtprrcvbenif2@i5jqhk5b4pe5>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xtmcfjudjau4kuzdjbqj53mqoi5254awzu3opjtprrcvbenif2@i5jqhk5b4pe5>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Apr 30, 2025 at 01:18:25PM +0200, Karel Zak wrote:
> On Tue, Apr 29, 2025 at 03:55:28PM +0200, Benno Schulenberg wrote:
> > 
> > Op 29-04-2025 om 13:11 schreef Karel Zak:
> > > Created a pull request at
> > > https://github.com/util-linux/util-linux/pull/3550 to test the patches
> > > via CI. I hope I have applied the correct versions of the patches :)
> > 
> > The last patch ("docs,usage") probably needs the attached extra diff to
> > pass the tests.
>  
> Yes, po4a.cfg needs to be updated too.

updated: https://github.com/util-linux/util-linux/pull/3550/commits/18e5242e0cb6ad8e98e89975e2553b327d169863

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

