Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413926656E
	for <util-linux@vger.kernel.org>; Tue,  8 Apr 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108394; cv=none; b=BtVGN4P3d7WZxsGnNveZyMHSSTmkLAYiLlZ9Wt7lDH5S651UZZalx5Nt8oPPnnqOqmvOSUxDLAZaPAkTjOB3133TMP7yFY87dxrLL6MLYpX9sq3lNZgyTX/9uh87Vd2530v44AcpzJDUPoz12j1rQUFLrm5ovWnxzMr6vCojj1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108394; c=relaxed/simple;
	bh=Gfbr6pVJ+etYrI3abWJQ2cu7+LgeUR0+7dL1NEUftJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2sYm40cvU20nVhQ8MTlXxqh2VRc1TR9py/Qaq2n1fS8h9HLy1AuTC6ZmLIhTmbtifVoVpkMoZHymy55XhUJHRzgj1dUOeIjipunjzbS5cnWRjYHTslQ/b6rusRECGBZzHqln90QmWVySZAEI5n3yteC22BmGir8iNzKqSkyO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMSqc0HO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMSqc0HO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744108391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9ZcWmn1DJRlVbxgw+2uL0Pti+/Cscsz0NoAU0pNcko=;
	b=JMSqc0HO1wLQzj6tBCfshycwfh2u6A0oP1n6CxXRQVDd1AsQmek+gVdzPNNZQkduwdhCNO
	VQ1zNk9i/x5tkusBSFBqJHJ2akuJ5co1LC3ax41NC5lYmZhaWqPyM0Z+2SVQpSBx6I5toB
	cwtwMY9w1qJa0i15zXWm4xCP0ShNJdo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-8qAyTwksPJCnk2j6PW5rzQ-1; Tue,
 08 Apr 2025 06:33:08 -0400
X-MC-Unique: 8qAyTwksPJCnk2j6PW5rzQ-1
X-Mimecast-MFC-AGG-ID: 8qAyTwksPJCnk2j6PW5rzQ_1744108387
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B70F1800361;
	Tue,  8 Apr 2025 10:33:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4769B180B486;
	Tue,  8 Apr 2025 10:33:05 +0000 (UTC)
Date: Tue, 8 Apr 2025 12:33:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/8] setarch: (man) remove a synopsis line that
 mistakenly mentions `arch`
Message-ID: <mbag4aqfzuvn5q44cpbtem6ei7ai6jr2lz2pyzxrytsom4i3vq@7ak5vpzjgy7o>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Apr 07, 2025 at 05:14:32PM +0200, Benno Schulenberg wrote:
> -*arch* [options] [_program_ [_argument_...]]

This is not a bug. We use symlinks for setarch to support specific
architectures. It would be beneficial to describe this in the man
page in better way...

$ find /usr/bin -type l -lname 'setarch'
/usr/bin/i386
/usr/bin/linux64
/usr/bin/uname26
/usr/bin/x86_64
/usr/bin/linux32

Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

