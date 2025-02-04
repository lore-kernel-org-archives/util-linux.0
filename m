Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFD207A01
	for <util-linux@vger.kernel.org>; Tue,  4 Feb 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738660105; cv=none; b=kIDRPu+45zZSY0OlFNI26Fbv1WyRtZJNdT0zb0u/lLrHRTO8d+tPI8on/uz0cg1swKP9fpsF1ctRdcgsFc5VhiYF+c9rzIRBlGA6qND/1g1HZAwZd8yN+RPcdUx5IiiUI0ZHRvVr27YZi9pm9NaNv83ZNA2+VyKMMwMnJVjtZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738660105; c=relaxed/simple;
	bh=q/0M+amk33v83wF0jrzZn+cvM0ssKnlAE/mv2SKEfn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3v3nbEfnBgjqc+KEl+r5RskuhMey+lOdbj+sph8enZgeGPOz5v4zxTv2ieBRlIZKNqbCJLFajwPz2ZNZIfJlBkgkxLtlGIxWCD1SRaQLg7utlL514dRDHx3x+tLDYHt309TRQZePxxLv5VSaanVhunD5yd7KIbpP5i6isyZe3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6BlBjWW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6BlBjWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738660102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWBGNsD248OtV8vJ1GMfZ2i994bUtAlyNlGINPq8GjM=;
	b=J6BlBjWWmGMsuGBrNS7Fg2ehCf/AR/HRvPUI1vaCe3oLBvz1p3Fv8sSoiXTQuN036ioCYn
	ilOTXtn4ntad427OTU5IqRZ1x+0VF/QsfUQYyxBBA5zilNf93cRvBSQfKI+kiaTo6cxKt2
	9LdRQtsgtterKlRZ4jnR217EoBiUUTM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-eN243KLvNUuHbNWn_tgDow-1; Tue,
 04 Feb 2025 04:08:20 -0500
X-MC-Unique: eN243KLvNUuHbNWn_tgDow-1
X-Mimecast-MFC-AGG-ID: eN243KLvNUuHbNWn_tgDow
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 994AF1801F18;
	Tue,  4 Feb 2025 09:08:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.152])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C30C1800268;
	Tue,  4 Feb 2025 09:08:18 +0000 (UTC)
Date: Tue, 4 Feb 2025 10:08:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] logger: grammarize the description of --socket-errors in
 the man page
Message-ID: <fwnncenuqqz4q57toc7p5yf5hzcwkzv2fvwteyryrdqlflrzfc@2fpmjmkbhzq5>
References: <20250130141124.29440-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130141124.29440-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jan 30, 2025 at 03:11:24PM GMT, Benno Schulenberg wrote:
>  misc-utils/logger.1.adoc | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

 All your 5 patches applied. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

