Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECA31195B
	for <util-linux@vger.kernel.org>; Mon,  3 Nov 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174811; cv=none; b=VWYllU8wCFM7lsM8hYcp1QNoVb9PNL08hVg9NePDuDd9HNKU7NVKiyeFR/sOV5ECdIpFok7pqG26SXYiKQwHLlN8BkRzGlBVKF0chvmtqsyiq3nCdxx5dMcJsx03GMmYUCKBTSATgoqjdm0HmD7LbPAd+eOdVzY9e+gPnTdlG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174811; c=relaxed/simple;
	bh=YXw1BUKU4KZmmlZ6QXb2WJVVEfZ1mJ0MG/6LkkF7GkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDl4BDV5RP70WuqsV6NISbmr74jza+xIpl9Ei8E4+mYMP8ucEbX+iSFNyhzlFTKI61NIDJT+fw1+iIDRef7TpqMcLFXMi16o5G9ASHZiAo8+8vXz1OC97PWRRmWwyp9GIIkj5RW2/0y0LyoZo3Pizr+ch4Xug5fvfW9QemkafFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/8ihInE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/8ihInE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762174808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YjxKVgcO6PM89toay6uObzBzf7EXUfxtRtCoVu5mTkI=;
	b=C/8ihInEH3NZYYURxqJ5CSFWU2OaF2rf1fUk7kXXXCdeXOyRMeDkHBJjnycdhVrEejHQPv
	NBuyoQlJJnzgijSGQL3VSxJZzh4KWSmMvCQ/26V7KWx7ygu6u7df1+JQkF8XQOiP22KVfM
	eKiI5bOuBywxmBTYi6SHXd6hvYHu6BA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-MLoTqLefM_OG-IeqIapaTA-1; Mon,
 03 Nov 2025 08:00:05 -0500
X-MC-Unique: MLoTqLefM_OG-IeqIapaTA-1
X-Mimecast-MFC-AGG-ID: MLoTqLefM_OG-IeqIapaTA_1762174804
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 961C41800D83;
	Mon,  3 Nov 2025 13:00:04 +0000 (UTC)
Received: from ws.localdomain (unknown [10.45.242.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8389D19540EA;
	Mon,  3 Nov 2025 13:00:03 +0000 (UTC)
Date: Mon, 3 Nov 2025 13:59:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] losetup: remove the --verbose flag, as it doesn't
 actually do anything
Message-ID: <a5oti2fgqcprehz75yailkgyniwvu4iuexorzvomllivqazua6@2kmw3vyn6urm>
References: <20251029110358.18170-1-bensberg@telfort.nl>
 <20251029110358.18170-2-bensberg@telfort.nl>
 <65268166-345b-45af-961c-43e9778fcb50@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65268166-345b-45af-961c-43e9778fcb50@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Oct 29, 2025 at 12:07:03PM +0100, Benno Schulenberg wrote:
> Or, instead of removing it, make it again do something?  Like
> reporting which devices were detached when option -D is used?

You can turn on debug output if you need really detailed info.

Not sure if keeping verbose output is necessary. I think people
usually just run "losetup" (without any options) or "lsblk" to check
things. Everyone does that ;-)

I'll apply your patches; it's good enough for now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

