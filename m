Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEC29C321
	for <util-linux@vger.kernel.org>; Wed, 17 Dec 2025 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765969256; cv=none; b=ZicjE/j9auITngKjPKNZ9fEKdhHJJ+c9U+d8KR+UlawSCT4C6ryA9KEuyFV6aD3qzAWH3UyESzfEopN3T0sKCMqL7HqxUsArV4JXH72LxLgIdSPxrYITeohDjv3WkwnApwVvulIYuPOFHV6+ypVj5YFzZCWSLFaOpvnkG8clICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765969256; c=relaxed/simple;
	bh=7O7JVCdmgUUaIfCygRbAFec/oCaK7xd3sXqOEvX3IFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2h/A+LBwxbkTe5xHjjDNu6ctK+e/huVNlT2PnZ6O+bjrdWnw0Ed7rAHw6q07PbcN6AC3PSbWX0quzgcmv/f9CWvkGCn6XaCIVelqyar3RoPSDXe2zODARJBc4w1BG2rnS4/DtEJ0e/4q+MokicxmQ/qawVnxUVX0dOQm1OWYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjVODpYO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjVODpYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765969253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ia5yJYgaDukVQGPtg2TgEUY7lZ/6IHWl2EI4f/kOrZ4=;
	b=fjVODpYO6PIrDVD6SsHzXlWGuRQBXwuhqVP/rrGuw1Izd3qu23OBMlPym13Q34mLeoxoJN
	Lq9ljSGFCiiHuujnvV8rux3jy30zQX5Il/1vv5l6650lN0zdqTMtM6MMxPOfjxE8RjJC3w
	tDhJSr8peI8xUKRbN8xWuyyWe0rlzm8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-0N2R_3Y1NmqTPOoxCmrTXA-1; Wed,
 17 Dec 2025 06:00:50 -0500
X-MC-Unique: 0N2R_3Y1NmqTPOoxCmrTXA-1
X-Mimecast-MFC-AGG-ID: 0N2R_3Y1NmqTPOoxCmrTXA_1765969249
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3962180899F;
	Wed, 17 Dec 2025 11:00:48 +0000 (UTC)
Received: from ws (unknown [10.45.242.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3EAC1956056;
	Wed, 17 Dec 2025 11:00:47 +0000 (UTC)
Date: Wed, 17 Dec 2025 12:00:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] losetup: snip --verbose from bash-completion, and
 'v' from options string
Message-ID: <6zqviy7rkkjvfubrunegtw5poeyq4tstg7wltnca36tnul3w2x@hs2oxaatxptl>
References: <20251209150222.50981-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209150222.50981-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Dec 09, 2025 at 04:02:20PM +0100, Benno Schulenberg wrote:
>  bash-completion/losetup | 1 -
>  sys-utils/losetup.c     | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Submitted as a pull request to https://github.com/util-linux/util-linux/pull/3910
for CI testing.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

