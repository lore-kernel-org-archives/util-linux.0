Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952414430B
	for <util-linux@vger.kernel.org>; Mon, 22 Apr 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786202; cv=none; b=OEx8FEEPowhTEZG0tC/4UmIBmGGsAGmlORTFxoqMT1ekEVMeH0jC31VP4mQXv5ihMTGljbBeRSlKpeWXaBWLaGo60+uJrOkLGLhafbuvqxVEuuP3whEvIosi4bmSBl8ivGX6+026nF8crVfA/Edx9hE8AETJO7NnPy3w/7ZCAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786202; c=relaxed/simple;
	bh=gozGK8/A15si3RbToGacJj+YSIC5km5aa/gwdCvJEiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjI7CQYZOx9NuxeEuwLDTTj3QsZivoByaKOYPg1TgXVacBgFjm/QJ/dHc0PZIVCbqz7PVOn/cnnKi4I1H6jGA3jKSnk6WEpWit946sjvzmyZpxQDLTLRz+C5n1W7z2KQAslmxpGiFUmOLHjaURROWnK4WEb1F5xSc7UfMKw3XZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N98Wkyo5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N98Wkyo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713786199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Unc9ngfoTDGnMuovVIVyEYL1OEpB5E+4ITRvCuZRt2s=;
	b=N98Wkyo5RCArQ2ULRjLyv995oH54APO/nodUdP758SOI2HC1UfhNSmP4qo969rT0dtYDdj
	nb9xHcVC63R2LVGNd1K0JwCe4cGDpl5C9JAlSJ0e0ioyJMD8C58R/EuyYQyN/BXho8nSSi
	BooN537RmY1V88w7Cux0wOEkPvCfj9k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-8bgi-hlQPuuUK-CvV-8h2Q-1; Mon,
 22 Apr 2024 07:43:17 -0400
X-MC-Unique: 8bgi-hlQPuuUK-CvV-8h2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66F041C0C643;
	Mon, 22 Apr 2024 11:43:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E2BD4C13FA3;
	Mon, 22 Apr 2024 11:43:16 +0000 (UTC)
Date: Mon, 22 Apr 2024 13:43:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: util-linux@vger.kernel.org
Subject: Re: umount -r broken due to "mountinfo unnecessary"
Message-ID: <20240422114314.pu3domts67l7qzvh@ws.net.home>
References: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <315f1f43-013f-48c9-9016-474dc9d53a04@ans.pl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Thu, Apr 18, 2024 at 01:00:56AM -0700, Krzysztof Olędzki wrote:
> Clearly this is not the right fix, but perhaps something like this would be correct:
> 
> @@ -275,6 +275,7 @@
>       || mnt_context_is_lazy(cxt)
>       || mnt_context_is_nocanonicalize(cxt)
>       || mnt_context_is_loopdel(cxt)
> +     || mnt_context_is_rdonly_umount(cxt)
>       || mnt_safe_stat(tgt, &st) != 0 || !S_ISDIR(st.st_mode)
>       || has_utab_entry(cxt, tgt))
>        return 1; /* not found */
> 
> I wonder if we just missed the mnt_context_is_rdonly_umount case in https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=6a52473ecd877227f6f7da2b95da0b51593ffec1?

Yes :-)

Nice debugging work, thanks!

I will most likely use the bugfix that you have suggested. The
long-term solution should be to use the new mount API for
context_umount.c as well, as it allows for reconfiguring the
mountpoint without having to worry about the source.

  attr.attr_set = MOUNT_ATTR_RDONLY;

  fd = open_tree(AT_FDCWD, target, 0);
  mount_setattr(fd, "", AT_EMPTY_PATH, &attr, sizeof(attr));
  close(fd);

However, we need to implement it in a backwardly compatible way for
cases where there is the new API unsupported.

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

