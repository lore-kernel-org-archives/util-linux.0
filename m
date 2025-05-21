Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF8B21B1AB
	for <util-linux@vger.kernel.org>; Wed, 21 May 2025 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747810545; cv=none; b=JplqFgqCxYiGFPWUbsEMdi86iZnXVtCx4aiBTR2BWwrtBA4r9SNaKuDmiW+j6PQYB38BqH6NavLpvVNy3+PfHd4aJLCK9ag6WwwZY+Nh4vKpbXM+nljq4DIwPaY/JNum4wjJ8+E6rOAnEpbxx6uVyBq/XFkjrx9FKCsotAxkohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747810545; c=relaxed/simple;
	bh=mB3c0mrl4Vvfub134zNFezC7zMG8HzRthXwV9LOZ1NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUCpAM+9dUbzSn06QpavJSjFYAbTz1TODiP/zIipLwRhMRHypUP19j0ogY/MQ031wMRQ8eqRbnUr+CfhEq+ZSGv3uFdEGhrMgww/3x7HDBZutWv8Lehcm3D6g+axOPVkYx5cKdbL8gNaao/kMv2rItwt/4yXbudXPfzLCt8JDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0pFRbH0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0pFRbH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747810542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Eq7PKQuR3Kqa0jfwzwxJ1IXeKIPU1MEXuOJyT5opvM=;
	b=b0pFRbH00OwlKVy29vBs+O8skfqa2AZb4aT6r/sgyxx5CLRi7OxqaXQtztAf3Q8VJOz9YK
	1AMM/yzJDT3P+CwVKCeNKgkQJIEhhDAsJrlY1OmEzRXOSoPf8LrHlOUsWdjQ5Vfvu/yJrq
	swHVHATJ1tCaEFxtcfC2q2HhfupEMq4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-oNCWzCUzOWyJ5JG9iZFGNQ-1; Wed,
 21 May 2025 02:55:38 -0400
X-MC-Unique: oNCWzCUzOWyJ5JG9iZFGNQ-1
X-Mimecast-MFC-AGG-ID: oNCWzCUzOWyJ5JG9iZFGNQ_1747810537
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87735180034E;
	Wed, 21 May 2025 06:55:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4304B19560A3;
	Wed, 21 May 2025 06:55:35 +0000 (UTC)
Date: Wed, 21 May 2025 08:55:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, Stefan Schubert <schubi@suse.de>
Subject: Re: [PATCH] libblkid: Fix crash while parsing config with libeconf
Message-ID: <3p3ennukohxmst4qpalg6t43udyyyijwj6ddbmrpb72yeehxw4@qvj3bdyj3h7h>
References: <20250516013111.1099053-1-sbrabec@suse.cz>
 <da40323d-e642-4535-9a9a-ce9054de0241@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da40323d-e642-4535-9a9a-ce9054de0241@suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, May 20, 2025 at 04:24:07PM +0200, Stanislav Brabec wrote:
> Stanislav Brabec wrote:
> > As the whhole econf_file structure is freed by econf_free(file) at the end
> 
> > of blkid_read_config, econf_file structure cannot be defined as static and
> > initialized only once. The econf_free() is not robust enough and keeps a
> > pointer to the garbage after the first call. And if /etc/blkid.conf does
> > not exist, it is called second time.
> 
> However the patch is correct and fixes the crash, there are still open questions:
> 
> - Why blkid_read_config() and econf_readConfig() are called twice with the same parameters? Is it intended behavior?

This code pattern (e.g., libblkid/src/evaluate.c):

     conf = blkid_read_config(NULL);
     ...

     cachefile = blkid_get_cache_filename(conf);
     rc = blkid_get_cache(&c, cachefile);

If blkid_get_cache_filename() returns NULL, then blkid_get_cache()
reads the configuration again. Additionally, blkid_get_cache_filename() can read the
configuration if 'conf' is NULL.

Yes, it's not elegant.

> - And finally, is a similar code in logindefs.c vulnerable to a similar type of crash?

The `logindefs` uses a global `list` variable, which should be filled only once.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

