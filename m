Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE856235361
	for <util-linux@vger.kernel.org>; Tue, 18 Feb 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874754; cv=none; b=nGmvh3grkC+dZglMFRhVhiyFdMBotoN9h5bm9jXIpJtSmPwBYJpzM3Wk+ccDajfJ4V0j+mP9Rv+8fCa2cr44mHOMwsCYp30TZiGUwpn2sn3mxzjQKu9P6hTx3fKgp2vE5BOnhGIiaF/lMZP4OOl56+Gk9InY20tVn/rtZNGMZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874754; c=relaxed/simple;
	bh=jNqtPA1KD5ljcBLeDziDGDdJmbWtFZ/PRBl6kaSYSsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJO8dsiH/8F/FFHQzlBmtraSamtRPjJV2rFnRt3S2Fon1Hfl+MZfAHAGIXEHfMfe/UWFwyv9ca3YlVGKCIivTtzybVzj3i9LnNwQHJZhoe1FV9xtyzkYMfHi+FvAYXSU5GwLv0t6hdyfZuIQEyeOD/KXPONn+E3PZB3ZACKZ9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTE5USoD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTE5USoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CTky56dPbrhe87tQ+wulBI5xPE2exQdLVFd1F1q60vc=;
	b=YTE5USoDshqw1lhgjiMITrVO4ETvjY1wp9Y0vP8XE2qeVloD0Z1Gap5G9gQVXT7WIsMRwR
	Sx5mscEU4tK2yficcq6cZbHQD/akWu6L/WnfYAwapOoNTpsA6BQXzSwH6FwUdCPPB4GrkZ
	G8C1ifzHWYr30MlHox/ZM8/aLWOB0+g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-YWKlNcAWNzeoE0GGd-rbCQ-1; Tue,
 18 Feb 2025 05:32:29 -0500
X-MC-Unique: YWKlNcAWNzeoE0GGd-rbCQ-1
X-Mimecast-MFC-AGG-ID: YWKlNcAWNzeoE0GGd-rbCQ_1739874748
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88AE819039CA;
	Tue, 18 Feb 2025 10:32:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B97A3000199;
	Tue, 18 Feb 2025 10:32:27 +0000 (UTC)
Date: Tue, 18 Feb 2025 11:32:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [BUG?] agetty: issue printed twice
Message-ID: <3mv5fxvq5r2aeo5tj2kmk42ywc3yde6dkgvakn22rabg7k6ckd@rvqv2tez6jwp>
References: <7d0fd241-52cc-4d92-a0ce-5cdbf9b39a34@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0fd241-52cc-4d92-a0ce-5cdbf9b39a34@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Feb 18, 2025 at 02:44:36AM GMT, Stanislav Brabec wrote:
> Hi.
> 
> Depending on the config, the issue file may be printed twice. If both
> /run/issue and /etc/issue exist, both are printed. I am not sure, whether it
> is an intended behavior. And eventually it could be printed three times.

See 508fb0e7ac103b68531a59db2a4473897853ab52.

I made the changes to enable printing of all issue files together. This was
based on users feedback ....

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

